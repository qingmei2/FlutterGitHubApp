import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/model/repo.dart';
import 'package:flutter_rhine/common/providers/auth_bloc.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_item.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainReposPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainReposPageState();
  }
}

class _MainReposPageState extends State<MainReposPage> with AutomaticKeepAliveClientMixin {
  GlobalUserModel _globalUserModel;
  MainRepoModel _mainRepoModel = MainRepoModel();

  final GlobalKey<RefreshFooterState> _footerKey =
      GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _globalUserModel = Provider.of<GlobalUserModel>(context);
    _mainRepoModel.fetchRepos(_globalUserModel.user.login);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: _mainRepoModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Repos'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (newValue) {
                // 更新排序条件，刷新ui
                _mainRepoModel.fetchRepos(_globalUserModel.user.login,
                    sort: newValue);
              },
              itemBuilder: (context) => <PopupMenuItem<String>>[
                    PopupMenuItem(
                      value: 'updated',
                      child: Text('Sort by Update'),
                    ),
                    PopupMenuItem(
                      value: 'created',
                      child: Text('Sort by Created'),
                    ),
                    PopupMenuItem(
                      value: 'full_name',
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
    return Consumer<MainRepoModel>(
      builder: (context, MainRepoModel model, child) {
        if (model.repoPagedList.length > 0) {
          return _initExistDataList(model.repoPagedList);
        } else {
          return Center(
            child: ProgressBar(visibility: _mainRepoModel.isLoading ?? false),
          );
        }
      },
    );
  }

  /// 有数据时的列表
  /// [renders] 事件列表
  Widget _initExistDataList(final List<Repo> renders) {
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
        await _mainRepoModel.fetchRepos(_globalUserModel.user.login);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
