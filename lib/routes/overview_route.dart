import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:essistant/routes/widgets/animated_floating_button.dart';
import 'package:essistant/routes/widgets/overview_feed_maker.dart';
import 'package:essistant/routes/widgets/overview_top_widget.dart';
import 'package:flutter/material.dart';

class OverviewRoute extends StatefulWidget {
  final FeedMaker maker = FeedMaker();

  @override
  State<StatefulWidget> createState() => _OverviewRouteState();
}

class _OverviewRouteState extends State<OverviewRoute> {
  Widget _getTask() {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData) {
          /*return widget.maker
            .create(title: "งานในวันนี้", assignments: snap.data);*/

          List<AssignmentData> data = snap.data;

          if (data.length == 0) {
            return Container(
              margin: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  'ดีใจจัง ไม่มีงานเลย',
                  style: TextStyle(fontSize: 17, color: Colors.black45),
                ),
              ),
            );
          } else {
            return widget.maker.create(title: "งานในวันนี้", assignments: data);
          }
        } else {
          return Container(
            margin: EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                'กำลังโหลดข้อมูล...',
                style: TextStyle(fontSize: 17, color: Colors.black45),
              ),
            ),
          );
        }
      },
      future: AssignmentRepository.getAllAssignments(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingButton(),
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          OverviewTop(),
          _getTask(),
          /*widget.maker.create(title: "งานในวันนี้", assignments: _fakeData1),
          widget.maker
              .create(title: "งานในวันพรุ่งนี้", assignments: _fakeData2),
          widget.maker.create(title: "งานในวันมะรืน", assignments: _fakeData3),*/
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
