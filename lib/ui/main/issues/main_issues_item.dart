import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/model/issue.dart';

/// issue界面的Item
class MainIssuesItem extends StatelessWidget {
  final Issue issue;

  MainIssuesItem(Key key, this.issue) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(issue.title),
        ],
      ),
    );
  }
}
