import 'package:essistant/repository/AssignmentRepository.dart';
import 'package:essistant/repository/data/AssignmentData.dart';
import 'package:essistant/routes/widgets/overview_feed_maker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

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
              } else {
                if (assignmentMap.containsKey(999)) {
                  assignmentMap[999].add(elem);
                } else {
                  assignmentMap[999] = [elem];
                }
              }
            }

            var newMap = Map.fromEntries(assignmentMap.entries.toList()
              ..sort((e1, e2) => e1.key.compareTo(e2.key)));

            List<Widget> lists = [];
            List<AssignmentData> overdues = [];
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
                  keyStr = "งานในวันมะรืน";
                  break;
                case 999:
                  keyStr = "งานไม่มีกำหนดส่ง";
                  break;
                default:
                  if (key >= 3) {
                    keyStr = DateFormat("dd MMMM yyyy", 'th_TH').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            assignmentMap[key][0].dueDate));
                  } else {
                    overdues.addAll(newMap[key]);
                    continue;
                  }
                  break;
              }

              lists.add(widget.maker
                  .create(title: keyStr, assignments: assignmentMap[key]));
            }
            if (overdues.length > 0)
              lists.insert(
                  0,
                  widget.maker.create(
                      title: 'งานที่เลยกำหนดส่ง', assignments: overdues));

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
      future: AssignmentRepository.getAllNotFinishedAssignments(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ภาพรวมงาน'),
        elevation: 0.5,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigationKey.currentState.pushNamed('/addtask');
        },
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          _getTask(),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
