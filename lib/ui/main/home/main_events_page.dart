import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/model/event.dart';
import 'package:flutter_rhine/common/providers/auth_bloc.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
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

class _MainEventsPageState extends State<MainEventsPage>
    with AutomaticKeepAliveClientMixin {
  MainEventsModel _mainEventsModel = MainEventsModel();
  GlobalUserModel _globalUserModel;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _globalUserModel = Provider.of<GlobalUserModel>(context);

    _mainEventsModel.fetchEvents(_globalUserModel.user.login);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: _mainEventsModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          automaticallyImplyLeading: false, // 隐藏返回键
        ),
        body: _eventList(),
      ),
    );
  }

  /// 渲染列表
  Widget _eventList() {
    return Consumer<MainEventsModel>(
      builder: (context, MainEventsModel model, child) {
        if (model.eventPagedList.length > 0) {
          return _initExistDataList(model.eventPagedList);
        } else {
          return Center(
            child: ProgressBar(visibility: _mainEventsModel.isLoading ?? false),
          );
        }
      },
    );
  }

  /// 有数据时的列表
  /// [renders] 事件列表
  Widget _initExistDataList(final List<Event> renders) {
    return EasyRefresh(
      refreshFooter: GlobalHideFooter(_footerKey),
      child: ListView.builder(
        itemCount: renders.length,
        itemBuilder: (context, index) {
          return MainEventItem(
            event: renders[index],
            observer: (EventItemAction action) {
              if (action.isActorAction) {
                // 用户名点击事件
                Fluttertoast.showToast(
                  msg: '用户： ' + action.url,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                // repo点击事件
                Fluttertoast.showToast(
                  msg: '被点击的Repo： ' + action.url,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              }
            },
          );
        },
      ),
      autoLoad: true,
      loadMore: () async {
        await _mainEventsModel.fetchEvents(_globalUserModel.user.login);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
