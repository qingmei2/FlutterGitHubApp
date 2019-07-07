import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/model/repo.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main_repo.dart';

class MainReposPage extends StatelessWidget {
  final UserRepository userRepository;
  final MainReposBloc _mainReposBloc = MainReposBloc();

  MainReposPage({@required this.userRepository})
      : assert(userRepository != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => _mainReposBloc,
      child: MainReposForm(userRepository: userRepository),
    );
  }
}

class MainReposForm extends StatefulWidget {
  final UserRepository userRepository;

  MainReposForm({@required this.userRepository})
      : assert(userRepository != null);

  @override
  State<StatefulWidget> createState() {
    return _MainReposFormState(userRepository: userRepository);
  }
}

class _MainReposFormState extends State<MainReposForm>
    with AutomaticKeepAliveClientMixin {
  final UserRepository userRepository;

  _MainReposFormState({this.userRepository}) : assert(userRepository != null);

  final GlobalKey<RefreshFooterState> _footerKey =
      GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    BlocProvider.of<MainReposBloc>(context)
//        .dispatch(MainReposInitialEvent(username: userRepository.user.login));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final MainReposBloc bloc = BlocProvider.of<MainReposBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (context, MainReposStates state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Repos'),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (newValue) {
                  // 更新排序条件，刷新ui
                  bloc.dispatch(MainReposChangeFilterEvent(
//                    username: userRepository.user.login,
                    sortType: newValue,
                  ));
                },
                itemBuilder: (context) => <PopupMenuItem<String>>[
                      PopupMenuItem(
                        value: UserRepoRepository.SORT_UPDATED,
                        child: Text('Sort by Update'),
                      ),
                      PopupMenuItem(
                        value: UserRepoRepository.SORT_CREATED,
                        child: Text('Sort by Created'),
                      ),
                      PopupMenuItem(
                        value: UserRepoRepository.SORT_LETTER,
                        child: Text('Sort by FullName'),
                      ),
                    ],
              ),
            ],
          ),
          body: _repoList(),
        );
      },
    );
  }

  Widget _repoList() {
    final MainReposBloc bloc = BlocProvider.of<MainReposBloc>(context);

    return BlocBuilder<MainReposEvent, MainReposStates>(
      bloc: bloc,
      builder: (context, MainReposStates state) {
        if (state is MainReposFirstLoading) {
          return Center(
            child: ProgressBar(visibility: true),
          );
        }

        if (state is MainReposEmptyState) {
          return Center(
            child: Text('Empty page.'),
          );
        }

        if (state is MainReposPageLoadSuccess ||
            state is MainReposPageLoadFailure) {
          return _initExistDataList(state.repos);
        }
      },
    );
  }

  /// 有数据时的列表
  /// [renders] 事件列表
  Widget _initExistDataList(final List<Repo> renders) {
    final MainReposBloc bloc = BlocProvider.of<MainReposBloc>(context);
    return EasyRefresh(
      refreshFooter: GlobalHideFooter(_footerKey),
      child: ListView.builder(
        itemCount: renders.length,
        itemBuilder: (context, index) {
          return MainRepoPagedItem(
            repo: renders[index],
            observer: (MainRepoAction action) {
              // repo的点击事件
              Fluttertoast.showToast(
                  msg: '被点击的Repo: ${action.repoUrl}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM);
            },
          );
        },
      ),
      autoLoad: true,
      loadMore: () async {
//        bloc.dispatch(
//            MainReposLoadNextPageEvent(username: userRepository.user.login));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
