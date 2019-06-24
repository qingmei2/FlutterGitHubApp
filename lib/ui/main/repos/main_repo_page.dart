import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/providers/global_user_model.dart';
import 'package:flutter_rhine/ui/main/repos/main_repo_model.dart';
import 'package:provider/provider.dart';

class MainReposPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainReposPageState();
  }
}

class _MainReposPageState extends State<MainReposPage> {
  GlobalUserModel _globalUserModel;

  MainRepoModel _mainRepoModel = MainRepoModel();

  @override
  void initState() {
    super.initState();
    _globalUserModel = Provider.of<GlobalUserModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _mainRepoModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Repos'),
          automaticallyImplyLeading: false,
        ),
        body: Text('Repos'),
      ),
    );
  }
}
