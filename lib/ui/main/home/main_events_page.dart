import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/model/event.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/ui/main/home/main_events_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main_events.dart';

class MainEventsPage extends StatelessWidget {
  final UserRepository userRepository;

  MainEventsPage({@required this.userRepository})
      : assert(userRepository != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // 隐藏返回键
      ),
      body: MainEventForm(),
    );
  }
}

class MainEventForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainEventsFormState();
  }
}

class _MainEventsFormState extends State<MainEventForm>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final currentState = store.state;
    store.dispatch(
        MainEventsInitialAction(username: currentState.appUser.user.login));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, MainEventsState>(
      converter: (store) => store.state.mainState.eventState,
      builder: (context, MainEventsState state) {
        if (state.isLoading) {
          return Center(
            child: ProgressBar(visibility: true),
          );
        }

        final Exception error = state.error;
        if (error != null) {
          if (error is EmptyListException) {
            return Center(
              child: Text('内容为空'),
            );
          } else if (error is NetworkRequestException) {
            return Center(
              child: Text('网络错误'),
            );
          }
        }

        return _initExistDataList(state.events);
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
        final Store<AppState> store = StoreProvider.of<AppState>(context);
        final currentState = store.state;
        store.dispatch(MainEventLoadNextPageAction(
          username: currentState.appUser.user.login,
          currentPage: currentState.mainState.eventState.currentPage,
          previousList: currentState.mainState.eventState.events,
        ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
