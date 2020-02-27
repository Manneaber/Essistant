import 'package:flutter/material.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final TextEditingController _searchText = new TextEditingController();
  List<Widget> _serchAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: _serchAction,
        title: SizedBox(
          height: 45,
          child: TextField(
            controller: _searchText,
            onTap: () {
              setState(() {
                _serchAction = [
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _serchAction = null;
                        _searchText.clear(); // clear text
                        FocusScope.of(context).unfocus(); //hide keybord
                      });
                    },
                    child: Text(
                      "ยกเลิก",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ];
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              hintText: "ค้นหาอะไรก็ได้ แค่พิมพ์ที่นี่...",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
