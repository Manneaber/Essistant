import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/repository/data/SubjectData.dart';
import 'package:essistant/routes/widgets/animated_floating_button.dart';
import 'package:essistant/routes/widgets/overview_feed_maker.dart';
import 'package:essistant/routes/widgets/overview_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            Map<int, List<AssignmentData>> assignmentMap = Map();

            final now = DateTime.now();
            for (var elem in data) {
              if (elem.dueDate != null) {
                var date = DateTime.fromMillisecondsSinceEpoch(elem.dueDate);
                var diff = DateTime(date.year, date.month, date.day)
                    .difference(DateTime(now.year, now.month, now.day))
                    .inDays;

                if (assignmentMap.containsKey(diff)) {
                  assignmentMap[diff].add(elem);
                } else {
                  assignmentMap[diff] = [elem];
                }
              }
            }

            var newMap = Map.fromEntries(assignmentMap.entries.toList()
              ..sort(
                  (e1, e2) => e1.key.compareTo(e2.key)));

            List<Widget> lists = [];
            for (int key in newMap.keys) {
              String keyStr;
              switch (key) {
                case 0:
                  keyStr = "งานในวันนี้";
                  break;
                case 1:
                  keyStr = "งานในวันพรุ่งนี้";
                  break;
                case 2:
                  keyStr = "งานในมะรืน";
                  break;
                default:
                  if (key >= 3) {
                    keyStr = DateFormat("dd MMMM yyyy", 'th_TH').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            assignmentMap[key][0].dueDate));
                  } else {
                    keyStr = "งานที่เลยกำหนด";
                  }
                  break;
              }

              lists.add(widget.maker
                  .create(title: keyStr, assignments: assignmentMap[key]));
            }

            return Column(
              children: lists,
            );
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
