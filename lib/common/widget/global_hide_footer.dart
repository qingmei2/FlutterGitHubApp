import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 不可见的footer
class GlobalHideFooter extends RefreshFooter {
  @override
  State<StatefulWidget> createState() {
    return _GlobalHideFooterState();
  }

  GlobalHideFooter(
    GlobalKey<RefreshFooterState> key,
  ) : super(key: key);
}

class _GlobalHideFooterState extends RefreshFooterState<GlobalHideFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: .0,
      height: .0,
    );
  }
}
