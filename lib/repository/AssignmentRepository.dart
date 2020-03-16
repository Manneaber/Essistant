import 'dart:io';

import 'package:essistant/repository/data/AssignmentAttachmentData.dart';
import 'package:essistant/repository/data/AssignmentAttachmentType.dart';
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
        s += 'teacher TEXT, ';
        s += 'year TEXT, ';
        s += 'color INTEGER';
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
        s += 'id INTEGER PRIMARY KEY AUTOINCREMENT, ';
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

  static Future<void> clearAll() async {
    if (_db == null) await init();

    try {
      var attcms = await _db.query('assignment_attachment');
      for (var elem in attcms) {
        File(elem['url']).delete();
      }

      await _db.delete('assignment_attachment');
      await _db.delete('assignment');
      await _db.delete('subject');
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertAssignment(AssignmentData data) async {
    if (_db == null) await init();

    try {
      int assignmentID;
      await _db.transaction((txn) async {
        // insert into assignment
        var assmData = data.toMap();
        assmData['subject'] = data.subject.id;
        assmData.remove('attachments');
        assignmentID = await txn.insert(
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
      return assignmentID;
    } catch (e) {
      print(e);

      return -1;
    }
  }

  static Future<List<AssignmentData>> findAssignmentByKeyword(
      String keyword) async {
    if (_db == null) await init();

    if (keyword == "") return null;

    try {
      var query = await _db.rawQuery(
          "SELECT * FROM assignment WHERE title LIKE '%$keyword%' OR desc LIKE '%$keyword%'");

      List<AssignmentData> assignments = [];
      for (var elem in query) {
        assignments.add(
          AssignmentData(
            id: elem['id'],
            title: elem['title'],
            desc: elem['desc'],
            color: Color(elem['color']),
            subject:
                await AssignmentRepository.findSubjectByID(elem['subject']),
            timestamp: elem['timestamp'],
            dueDate: elem['duedate'],
            status: elem['status'],
            attachments: [],
          ),
        );
      }

      return assignments;
    } catch (e) {
      print(e);

      return null;
    }
  }

  static Future<bool> updateAssignmentByID(int id, AssignmentData data) async {
    if (_db == null) await init();

    try {
      _db.transaction((txn) async {
        // update new data into assignment
        await txn.update(
          'assignment',
          {
            'title': data.title,
            'desc': data.desc,
            'color': data.color.value,
            'duedate': data.dueDate,
          },
          where: 'id = ?',
          whereArgs: [id],
          conflictAlgorithm: ConflictAlgorithm.fail,
        );

        // query attachment
        final List<Map<String, dynamic>> attachmentMap = await txn.query(
          'assignment_attachment',
          where: 'assid = ?',
          whereArgs: [id],
        );

        // check for change -> remove or insert if needed
        List<AssignmentAttachmentData> insertList = [];
        List<int> removeList = [];
        for (var elem in data.attachments) {
          if (elem.id == null) {
            insertList.add(elem);
          } else {
            bool goingToRemove = true;
            for (var elem2 in attachmentMap) {
              if (elem2['id'] == elem.id) {
                goingToRemove = false;
                break;
              }
            }
            if (goingToRemove) removeList.add(elem.id);
          }
        }

        print(insertList);
        print(removeList);

        var batch = txn.batch();
        for (var e in insertList) {
          var x = e.toMap();
          x['assid'] = id;
          batch.insert('assignment_attachment', x);
        }
        for (var e in removeList) {
          batch.delete(
            'assignment_attachment',
            where: 'id = ?',
            whereArgs: [e],
          );
        }
        batch.commit();
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }

  static Future<bool> updateAssignmentStatusByID(int id, int status) async {
    if (_db == null) await init();

    try {
      _db.transaction((txn) async {
        txn.update('assignment', {'status': status},
            where: 'id = ?',
            whereArgs: [id],
            conflictAlgorithm: ConflictAlgorithm.fail);
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }

  static Future<bool> removeAssignmentByID(int id) async {
    if (_db == null) await init();

    try {
      _db.transaction((txn) async {
        // Query attachment
        final List<Map<String, dynamic>> attachmentMap = await txn.query(
          'assignment_attachment',
          where: 'assid = ?',
          whereArgs: [id],
        );

        // Remove File then remove in db
        var batch = txn.batch();
        for (var file in attachmentMap) {
          File(file['url']).delete();
          batch.delete(
            'assignment_attachment',
            where: "id = ?",
            whereArgs: [file['id']],
          );
        }

        // remove assignment
        batch.delete(
          'assignment',
          where: 'id = ?',
          whereArgs: [id],
        );
        batch.commit();
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }

  static Future<bool> removeSubjectByID(int id) async {
    if (_db == null) await init();

    try {
      _db.transaction((txn) async {
        // query assignment in subject
        final List<Map<String, dynamic>> assignmentMap = await txn.query(
          'assignment',
          where: 'subject = ?',
          whereArgs: [id],
        );

        // loop to remove it
        for (var e in assignmentMap) {
          await removeAssignmentByID(e['id']);
        }
        // remove own
        txn.delete('subject', where: 'id = ?', whereArgs: [id]);
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }

  static Future<AssignmentData> findAssignmentByID(int id) async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> assignmentMap = await _db.query(
      'assignment',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (assignmentMap.length == 0) return null;

    final List<Map<String, dynamic>> attachmentMap = await _db.query(
      'assignment_attachment',
      where: 'assid = ?',
      whereArgs: [assignmentMap[0]['id']],
    );

    List<AssignmentAttachmentData> attachments = [];
    for (var elem in attachmentMap) {
      AssignmentAttachmentType type;
      switch (elem['type']) {
        case 0:
          type = AssignmentAttachmentType.UNDEFINED;
          break;
        case 1:
          type = AssignmentAttachmentType.IMAGE;
          break;
        case 2:
          type = AssignmentAttachmentType.VOICE;
          break;
        case 3:
          type = AssignmentAttachmentType.VIDEO;
          break;
        case 4:
          type = AssignmentAttachmentType.PDF;
          break;
      }

      attachments.add(AssignmentAttachmentData(
        id: elem['id'],
        assid: elem['assid'],
        url: elem['url'],
        type: type,
      ));
    }

    return AssignmentData(
        id: assignmentMap[0]['id'],
        title: assignmentMap[0]['title'],
        desc: assignmentMap[0]['desc'],
        color: Color(assignmentMap[0]['color']),
        subject: await AssignmentRepository.findSubjectByID(
            assignmentMap[0]['subject']),
        timestamp: assignmentMap[0]['timestamp'],
        dueDate: assignmentMap[0]['duedate'],
        status: assignmentMap[0]['status'],
        attachments: attachments);
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
        ),
      );
    }

    return lists;
  }

  static Future<List<AssignmentData>> getAllNotFinishedAssignments() async {
    if (_db == null) await init();

    final List<Map<String, dynamic>> maps = await _db.query(
      'assignment',
      where: 'status IS NOT ?',
      whereArgs: [1],
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
        ),
      );
    }

    return lists;
  }

  static Future<List<AssignmentData>> getAllAssignmentsInSubject(
      int subID) async {
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
          color: Color(elem['color']),
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
        color: Color(maps[0]['color']),
        year: maps[0]['year'],
      );
    } else {
      return null;
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
