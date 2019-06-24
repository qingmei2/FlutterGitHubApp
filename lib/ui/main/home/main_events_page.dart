import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/model/event.dart';
import 'package:flutter_rhine/common/providers/global_user_model.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
import 'package:flutter_rhine/dao/dao_result.dart';
import 'package:flutter_rhine/ui/main/home/main_events_item.dart';
import 'package:flutter_rhine/ui/main/home/main_events_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainEventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainEventsPageState();
  }
}

class _MainEventsPageState extends State<MainEventsPage> {
  MainEventsModel _mainEventsModel = MainEventsModel();
  GlobalUserModel _globalUserModel;

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _globalUserModel = Provider.of<GlobalUserModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // 隐藏返回键
      ),
      body: _eventList(),
    );
  }

  /// 渲染列表
  Widget _eventList() {
    return FutureBuilder(
      future: _mainEventsModel.fetchEvents(_globalUserModel.user.login),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is DataResult && snapshot.data.data.length > 0) {
            final List<Event> renders = snapshot.data.data;
            return _initExistDataList(renders);
          } else {
            return Center(
              child: Text('空空如也'),
            );
          }
        } else {
          return Center(
            child: ProgressBar(visibility: _mainEventsModel.isLoading),
          );
        }
      },
    );
  }

  /// 有数据时的列表
  /// [renders] 事件列表
  Widget _initExistDataList(final List<Event> renders) {
    return EasyRefresh(
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        loadedText: '加载中...',
        noMoreText: '没有更多了',
        showMore: true,
      ),
      child: ListView.builder(
        itemCount: renders.length,
        itemBuilder: (context, index) {
          return MainEventItem(
            event: renders[index],
            observer: (EventItemAction action) {
              if (action.isActorAction) {
                // 用户名点击事件
                Fluttertoast.showToast(
                  msg: 'user: ' + action.url,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                // repo点击事件
                Fluttertoast.showToast(
                  msg: 'repo: ' + action.url,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              }
            },
          );
        },
      ),
    );
  }
}
