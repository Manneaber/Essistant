import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data/AssignmentData.dart';

class AssignmentRepository {
  Database _db;

  Future<Database> init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'assignment_database.db'),
      onCreate: (db, version) async {
        String s = 'CREATE TABLE subject(';
        s += 'id INTEGER PRIMARY KEY AUTOINCREMENT, ';
        s += 'title TEXT, ';
        s += 'teacher TEXT';
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
        s += 'FOREIGN KEY(subject) REFERENCES subject(id)';
        s += ')';
        await db.execute(s);

        s = 'CREATE TABLE assignment_attachment(';
        s += 'id TEXT PRIMARY KEY, ';
        s += 'assid INTEGER, ';
        s += 'title TEXT, ';
        s += 'type INTEGER, ';
        s += 'FOREIGN KEY(assid) REFERENCES assignment(id)';
        s += ')';
        await db.execute(s);
      },
      version: 1,
    );

    return _db;
  }

  void cleanDatabase() {
    _db.transaction((txn) async {
      var batch = txn.batch();
      batch.delete('assignment_attachment');
      batch.delete('assignment');
      batch.delete('subject');
      batch.commit();
    });
  }

  Future<bool> insert(AssignmentData data) async {
    try {
      _db.transaction((txn) async {
        // check subject exists
        // if no add new one
        final List<Map<String, dynamic>> subjectMap = await txn
            .query('subject', where: 'id = ?', whereArgs: [data.subject.id]);

        int subjectID = data.subject.id;
        if (subjectMap.length == 0) {
          subjectID = await txn.insert(
            'subject',
            data.subject.toMap(),
            conflictAlgorithm: ConflictAlgorithm.fail,
          );
        }

        // insert into assignment
        var assmData = data.toMap();
        assmData['subject'] = subjectID;
        assmData.remove('attachments');
        int assignmentID = await txn.insert(
          'assignment',
          assmData,
          conflictAlgorithm: ConflictAlgorithm.fail,
        );

        // loop insert assignment attachments
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
      });
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }

  Future<AssignmentData> findAssignmentByID(int id) async {
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
        attachments: maps[0]['attachments']);
  }

  updateAssignmentByID(int id, AssignmentData data) {}

  Future<AssignmentData> removeAssignmentByID(int id) {
    return null;
  }
}
