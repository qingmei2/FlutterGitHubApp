import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rhine/app/app.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/model/issue.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';

import 'main_issues.dart';
import 'main_issues_item.dart';

class MainIssuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Issues'),
          automaticallyImplyLeading: false,
        ),
        body: MainIssuesForm(),
      ),
    );
  }
}

class MainIssuesForm extends StatefulWidget {
  @override
  _MainIssuesFormState createState() => _MainIssuesFormState();
}

class _MainIssuesFormState extends State<MainIssuesForm>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshFooterState> _footerKey =
      GlobalKey<RefreshFooterState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    store.dispatch(MainIssuesInitialAction());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, MainIssuesState>(
      converter: (store) => store.state.mainState.issueState,
      builder: (context, final MainIssuesState state) {
        final Exception error = state.error;
        if (error is EmptyListException) {
          return Center(child: Text('Empty page.'));
        } else if (error is NetworkRequestException) {
          return Center(child: Text('网络错误'));
        } else if (error is Exception) {
          return Center(child: Text(error.toString()));
        }

        if (state.isLoading) {
          return Center(
            child: ProgressBar(visibility: true),
          );
        }

        final List<Issue> issues = [];
        if (state.issues.length > 0) {
          issues.addAll(state.issues);
        }

        return Container(
          child: EasyRefresh(
            refreshFooter: GlobalHideFooter(_footerKey),
            child: ListView.builder(
                itemCount: issues.length,
                itemBuilder: (_, index) =>
                    MainIssuesItem(issue: issues[index])),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
