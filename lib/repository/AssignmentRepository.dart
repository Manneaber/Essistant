import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/painting.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'data/AssignmentData.dart';

class AssignmentRepository {
  static Database _db;

  static Future init({bool clean = false, String path}) async {
    String dbPath;
    if (path == null) {
      dbPath = p.join(await getDatabasesPath(), 'assignment_database.db');
    } else {
      dbPath = path;
    }

    if (clean) await deleteDatabase(dbPath);

    _db = await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        String s = 'CREATE TABLE subject(';
        s += 'id INTEGER PRIMARY KEY AUTOINCREMENT, ';
        s += 'title TEXT, ';
        s += 'teacher TEXT,';
        s += 'year TEXT';
        s += ')';
        await db.execute(s);

        s = 'CREATE TABLE assignment(';
        s += 'id INTEGER PRIMARY KEY AUTOINCREMENT, ';
        s += 'title TEXT, ';
        s += 'desc TEXT, ';
        s += 'color INTEGER, ';
        s += 'subject INTEGER, ';
        s += 'timestamp INTEGER, ';
        s += 'duedate INTEGER, ';
        s += 'status INTEGER, ';
        s += 'FOREIGN KEY(subject) REFERENCES subject(id)';
        s += ')';
        await db.execute(s);

        s = 'CREATE TABLE assignment_attachment(';
        s += 'id TEXT PRIMARY KEY, ';
        s += 'assid INTEGER, ';
        s += 'url TEXT, ';
        s += 'type INTEGER, ';
        s += 'FOREIGN KEY(assid) REFERENCES assignment(id)';
        s += ')';
        await db.execute(s);
      },
      version: 1,
    );
  }

  static Future<bool> insertAssignment(AssignmentData data) async {
    if (_db == null) await init();

    try {
      _db.transaction((txn) async {
        // insert into assignment
        var assmData = data.toMap();
        assmData['subject'] = data.subject.id;
        assmData.remove('attachments');
        int assignmentID = await txn.insert(
          'assignment',
          assmData,
          conflictAlgorithm: ConflictAlgorithm.fail,
        );

        // loop insert assignment attachments
        if (data.attachments.length > 0) {
          var batch = txn.batch();
          for (var atm in data.attachments) {
            var nAtm = atm.toMap();
            nAtm['assid'] = assignmentID;
            batch.insert(
              'assignment_attachment',
              nAtm,
              conflictAlgorithm: ConflictAlgorithm.fail,
            );
          }
          await batch.commit();
        }
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }

  static Future<AssignmentData> findAssignmentByID(int id) async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> maps = await _db.query(
      'assignment',
      where: 'id = ?',
      whereArgs: [id],
    );

    return AssignmentData(
        id: maps[0]['id'],
        title: maps[0]['title'],
        desc: maps[0]['desc'],
        color: maps[0]['color'],
        subject: maps[0]['subject'],
        timestamp: maps[0]['timestamp'],
        dueDate: maps[0]['duedate'],
        status: maps[0]['status'],
        attachments: maps[0]['attachments']);
  }

  static Future<List<AssignmentData>> getAllAssignments() async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> maps = await _db.query(
      'assignment',
    );

    List<AssignmentData> lists = [];
    for (var elem in maps) {
      lists.add(
        AssignmentData(
          id: elem['id'],
          title: elem['title'],
          desc: elem['desc'],
          color: Color(elem['color']),
          subject: await findSubjectByID(elem['subject']),
          timestamp: elem['timestamp'],
          dueDate: elem['duedate'],
          status: elem['status'],
          attachments: [],
        ),
      );
    }

    return lists;
  }

  static Future<List<AssignmentData>> getAllAssignmentsInSubject(int subID) async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> maps = await _db.query(
      'assignment',
      where: 'subject = ?',
      whereArgs: [subID],
    );

    List<AssignmentData> lists = [];
    for (var elem in maps) {
      lists.add(
        AssignmentData(
          id: elem['id'],
          title: elem['title'],
          desc: elem['desc'],
          color: Color(elem['color']),
          subject: await findSubjectByID(elem['subject']),
          timestamp: elem['timestamp'],
          dueDate: elem['duedate'],
          status: elem['status'],
          attachments: [],
        ),
      );
    }

    return lists;
  }

  static Future<void> updateAssignmentByID(int id, AssignmentData data) async {
    if (_db == null) await init();
  }

  static Future<AssignmentData> removeAssignmentByID(int id) async {
    if (_db == null) await init();
    return null;
  }

  static Future<List<SubjectData>> getAllSubject() async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> maps = await _db.query(
      'subject',
    );

    List<SubjectData> lists = [];
    for (var elem in maps) {
      lists.add(
        SubjectData(
          id: elem['id'],
          title: elem['title'],
          teacher: elem['teacher'],
          year: elem['year'],
        ),
      );
    }

    return lists;
  }

  static Future<SubjectData> findSubjectByID(int id) async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> maps = await _db.query(
      'subject',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return SubjectData(
        id: maps[0]['id'],
        title: maps[0]['title'],
        teacher: maps[0]['teacher'],
        year: maps[0]['year'],
      );
    } else {
      return SubjectData(id: id);
    }
  }

  static Future<bool> insertSubject(SubjectData data) async {
    if (_db == null) await init();

    try {
      _db.transaction((txn) async {
        // insert into assignment
        var subjData = data.toMap();
        await txn.insert(
          'subject',
          subjData,
          conflictAlgorithm: ConflictAlgorithm.fail,
        );
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }
}
