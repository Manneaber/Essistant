import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentAttachmentData.dart';
import 'package:essistant/repository/data/AssignmentAttachmentType.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('Assignment Repository', () {
    AssignmentRepository repo;

    testWidgets('Init', (WidgetTester tester) async {
      repo = AssignmentRepository();
      await repo.init(clean: true, path: '');
    });

    testWidgets('Insert assignment record into table',
        (WidgetTester tester) async {
      SubjectData subject1 = SubjectData(
        id: 0,
        title: 'Test Subject',
        teacher: 'Dinodorinna',
      );

      AssignmentData data = AssignmentData(
        id: 0,
        title: 'Flutter project',
        desc: 'Build flutter project for term project',
        color: Colors.red,
        subject: subject1,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [
          AssignmentAttachmentData(
            id: 'acb',
            title: 'Test Image',
            type: AssignmentAttachmentType.IMAGE,
          ),
        ],
      );

      expect(await repo.insert(data), true);
    });

    testWidgets('Find value of assignment in table',
        (WidgetTester tester) async {
      AssignmentData result = await repo.findAssignmentByID(0);
      expect(result.title, 'Flutter project');
      expect(result.subject.title, 'Test Subject');
      expect(result.attachments[0].id, 'acb');
    });

    testWidgets('Update value of assignment in table',
        (WidgetTester tester) async {
      AssignmentData data = AssignmentData(title: 'Flutter project1');

      bool updated = await repo.updateAssignmentByID(0, data);
      expect(updated, true);

      AssignmentData result = await repo.findAssignmentByID(0);
      expect(result.title, 'Flutter project1');
    });

    testWidgets('Remove assignment record from table',
        (WidgetTester tester) async {
      expect(await repo.removeAssignmentByID(0), true);

      AssignmentData result = await repo.findAssignmentByID(0);
      expect(result, null);
    });
  });
}
