import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_rhine/common/model/issue.dart';
import 'package:flutter_rhine/common/widget/global_hide_footer.dart';
import 'package:flutter_rhine/common/widget/global_progress_bar.dart';

import 'main_issues.dart';
import 'main_issues_item.dart';

class MainIssuesPage extends StatelessWidget {
  final MainIssuesBloc _mainIssuesBloc = MainIssuesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainIssuesBloc>(
      builder: (_) => _mainIssuesBloc,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Issues (开发中)'),
            automaticallyImplyLeading: false,
          ),
          body: MainIssuesForm(),
        ),
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
    BlocProvider.of<MainIssuesBloc>(context).dispatch(MainIssuesInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final MainIssuesBloc bloc = BlocProvider.of<MainIssuesBloc>(context);
    return BlocBuilder<MainIssuesEvent, MainIssuesState>(
      bloc: bloc,
      builder: (_, state) {
        if (state is MainIssuesEmptyState) {
          return Center(
            child: Text('Empty page.'),
          );
        }
        if (state is MainIssuesFirstLoading) {
          return Center(
            child: ProgressBar(visibility: true),
          );
        }

        final List<Issue> issues = [];
        if (state is MainIssuesPageLoadSuccess ||
            state is MainIssuesPageLoadFailure) {
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
