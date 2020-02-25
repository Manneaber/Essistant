import 'package:essistant/routes/widgets/animated_floating_button.dart';
import 'package:essistant/routes/widgets/overview_chart.dart';
import 'package:flutter/material.dart';

class OverviewRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OverviewRouteState();
}

class _OverviewRouteState extends State<OverviewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedFloatingButton(),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.fromLTRB(
                15, 15 + MediaQuery.of(context).padding.top, 15, 15),
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: OverviewChart.withSampleData(),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "สรุปงานในสัปดาห์นี้",
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "งานที่ต้องส่งในวันนี้ 3 งาน",
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "งานที่ต้องส่งในสัปดาห์นี้ 6 งาน",
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "งานที่ทำเสร็จแล้ว 3 งาน",
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
