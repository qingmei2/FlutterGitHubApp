import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
import 'package:flutter_rhine/repository/repository.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main_repo.dart';

class MainReposPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainReposPageState();
  }
}

class _MainReposPageState extends State<MainReposPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshFooterState> _footerKey =
      GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    store.dispatch(
        MainReposInitialAction(username: store.state.appUser.user.login));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, appState) => Scaffold(
            appBar: AppBar(
              title: Text('Repos'),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (newValue) {
                    // 更新排序条件，刷新ui
                    final Store<AppState> store =
                        StoreProvider.of<AppState>(context);
                    store.dispatch(MainReposChangeFilterAction(
                      username: store.state.appUser.user.login,
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
          ),
    );
  }

  Widget _repoList() {
    return StoreConnector<AppState, MainReposState>(
      converter: (store) => store.state.mainState.repoState,
      builder: (context, MainReposState state) {
        final error = state.error;
        if (error is NetworkRequestException && state.currentPage <= 1) {
          return Center(
            child: Text('网络错误'),
          );
        } else if (error is EmptyListException) {
          return Center(
            child: Text('Empty page.'),
          );
        }

        if (state.isLoading) {
          return Center(
            child: ProgressBar(visibility: true),
          );
        }

        return _initExistDataList(state.repos);
      },
    );
  }

  /// 有数据时的列表
  /// [renders] 事件列表
  Widget _initExistDataList(final List<Repo> renders) {
    final store = StoreProvider.of<AppState>(context);
    final username = store.state.appUser.user.login;
    final preState = store.state.mainState.repoState;
    final preList = preState.repos;
    final prePageIndex = preState.currentPage;
    final preSort = preState.sortType;

    return EasyRefresh(
      refreshFooter: GlobalHideFooter(_footerKey),
      child: ListView.builder(
        itemCount: renders.length,
        itemBuilder: (context, index) {
          return MainRepoPagedItem(
            repo: renders[index],
            observer: (MainRepoItemsAction action) {
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
        store.dispatch(MainReposLoadNextPageAction(
            username: username,
            currentPageIndex: prePageIndex,
            preList: preList,
            sortType: preSort));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
