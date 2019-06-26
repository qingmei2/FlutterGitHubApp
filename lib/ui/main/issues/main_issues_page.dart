import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/model/issue.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/ui/main/issues/main_issues_model.dart';
import 'package:provider/provider.dart';

import 'main_issues_item.dart';

class MainIssuesPage extends StatefulWidget {
  @override
  _MainIssuesPageState createState() => _MainIssuesPageState();
}

class _MainIssuesPageState extends State<MainIssuesPage>
    with AutomaticKeepAliveClientMixin {
  MainIssuesModel _mainIssuesModel = MainIssuesModel();

  final GlobalKey<RefreshFooterState> _footerKey =
      GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mainIssuesModel.fetchIssues();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: _mainIssuesModel,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Issues'),
            automaticallyImplyLeading: false,
          ),
          body: _issuesPageBody(),
        ),
      ),
    );
  }

  Widget _issuesPageBody() {
    return Consumer<MainIssuesModel>(
      builder: (context, MainIssuesModel model, child) {
        final List<Issue> issues = model.issues;
        if (issues.isEmpty) {
          return Container(
            child: Text('Empty'),
          );
        }
        return Container(
          child: EasyRefresh(
            refreshFooter: GlobalHideFooter(_footerKey),
            child: ListView.builder(
                itemCount: issues.length,
                itemBuilder: (_, index) =>
                    MainIssuesItem(_footerKey, issues[index])),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
