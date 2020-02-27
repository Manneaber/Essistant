import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:essistant/routes/widgets/animated_floating_button.dart';
import 'package:essistant/routes/widgets/overview_feed_maker.dart';
import 'package:essistant/routes/widgets/overview_top_widget.dart';
import 'package:flutter/material.dart';

class OverviewRoute extends StatefulWidget {
  FeedMaker maker = FeedMaker();

  @override
  State<StatefulWidget> createState() => _OverviewRouteState();
}

class _OverviewRouteState extends State<OverviewRoute> {
  SubjectData subject1 = SubjectData(
    id: 0,
    title: 'Test Subject',
    teacher: 'Dinodorinna',
  );

  List<AssignmentData> _fakeData1;
  List<AssignmentData> _fakeData2;
  List<AssignmentData> _fakeData3;

  _OverviewRouteState() {
    _fakeData1 = [
      AssignmentData(
        title: 'โปรเกสงาน Android Term Project',
        desc:
            'นำเสนอหน้าตาของตัวโปรแกรม ฟังก์ชันที่ใช้งานได้แล้ว นำเสนอเป็น ppt',
        color: Colors.indigo,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [],
        subject: subject1,
      ),
    ];

    _fakeData2 = [
      AssignmentData(
        title: 'โปรเกสงาน Android Term Project',
        desc:
            'นำเสนอหน้าตาของตัวโปรแกรม ฟังก์ชันที่ใช้งานได้แล้ว นำเสนอเป็น ppt',
        color: Colors.indigo,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [],
        subject: subject1,
      ),
      AssignmentData(
        title: 'โปรเกสงาน Android Term Project',
        desc:
            'นำเสนอหน้าตาของตัวโปรแกรม ฟังก์ชันที่ใช้งานได้แล้ว นำเสนอเป็น ppt',
        color: Colors.indigo,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [],
        subject: subject1,
      ),
    ];

    _fakeData3 = [
      AssignmentData(
        title: 'โปรเกสงาน Android Term Project',
        desc:
            'นำเสนอหน้าตาของตัวโปรแกรม ฟังก์ชันที่ใช้งานได้แล้ว นำเสนอเป็น ppt',
        color: Colors.indigo,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [],
        subject: subject1,
      ),
      AssignmentData(
        title: 'โปรเกสงาน Android Term Project',
        desc:
            'นำเสนอหน้าตาของตัวโปรแกรม ฟังก์ชันที่ใช้งานได้แล้ว นำเสนอเป็น ppt',
        color: Colors.indigo,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [],
        subject: subject1,
      ),
      AssignmentData(
        title: 'โปรเกสงาน Android Term Project',
        desc:
            'นำเสนอหน้าตาของตัวโปรแกรม ฟังก์ชันที่ใช้งานได้แล้ว นำเสนอเป็น ppt',
        color: Colors.indigo,
        timestamp: DateTime.now(),
        dueDate: DateTime.now(),
        attachments: [],
        subject: subject1,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OverviewTop(),
      floatingActionButton: AnimatedFloatingButton(),
      body: ListView(
        children: [
          widget.maker.create(title: "วันนี้", assignments: _fakeData1),
          widget.maker.create(title: "พรุ่งนี้", assignments: _fakeData2),
          widget.maker.create(title: "มะรืน", assignments: _fakeData3),
        ],
      ),
    );
  }
}
