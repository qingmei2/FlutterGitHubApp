import 'package:flutter/material.dart';
import 'package:flutter_rhine/ui/main/issues/main_issues_model.dart';
import 'package:provider/provider.dart';

class MainIssuesPage extends StatefulWidget {
  @override
  _MainIssuesPageState createState() => _MainIssuesPageState();
}

class _MainIssuesPageState extends State<MainIssuesPage>
    with AutomaticKeepAliveClientMixin {
  MainIssuesModel _mainIssuesModel = MainIssuesModel();

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
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
