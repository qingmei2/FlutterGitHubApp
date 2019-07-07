import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final MainEventsBloc _mainEventsBloc = MainEventsBloc();

  MainEventsPage({@required this.userRepository})
      : assert(userRepository != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // 隐藏返回键
      ),
      body: BlocProvider(
        builder: (_) => _mainEventsBloc,
        child: MainEventForm(
          userRepository: userRepository,
        ),
      ),
    );
  }
}

class MainEventForm extends StatefulWidget {
  final UserRepository userRepository;

  MainEventForm({@required this.userRepository})
      : assert(userRepository != null);

  @override
  State<StatefulWidget> createState() {
    return _MainEventsFormState(userRepository);
  }
}

class _MainEventsFormState extends State<MainEventForm>
    with AutomaticKeepAliveClientMixin {
  final UserRepository userRepository;

  _MainEventsFormState(this.userRepository);

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    BlocProvider.of<MainEventsBloc>(context)
//        .dispatch(MainEventsInitialEvent(username: userRepository.user.login));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bloc = BlocProvider.of<MainEventsBloc>(context);
    return BlocListener<MainEventsEvent, MainEventsState>(
      bloc: bloc,
      listener: (context, MainEventsState state) {},
      child: _eventList(),
    );
  }

  /// 渲染列表
  Widget _eventList() {
    final bloc = BlocProvider.of<MainEventsBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is MainEventsFirstLoading) {
          return Center(
            child: ProgressBar(visibility: true),
          );
        }

        if (state is MainEventsPageLoadSuccess) {
          return _initExistDataList(state.events);
        }

        if (state is MainEventPageLoadFailure) {
          return _initExistDataList(state.events);
        }

        if (state is MainEventsEmptyState) {
          return Center(
            child: Text('Empty Page.'),
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
//        BlocProvider.of<MainEventsBloc>(context).dispatch(
//            MainEventLoadNextPageEvent(username: userRepository.user.login));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
