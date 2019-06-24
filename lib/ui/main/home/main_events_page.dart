import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/providers/global_user_model.dart';
import 'package:flutter_rhine/ui/main/home/main_events_model.dart';
import 'package:provider/provider.dart';

class MainEventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainEventsPageState();
  }
}

class _MainEventsPageState extends State<MainEventsPage> {
  MainEventsModel _mainEventsModel = MainEventsModel();
  GlobalUserModel _globalUserModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _globalUserModel = Provider.of<GlobalUserModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // 隐藏返回键
      ),
      body: _eventList(),
    );
  }

  Widget _eventList() {
    return FutureBuilder(
      future: _mainEventsModel.fetchEvents(_globalUserModel.user.login),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Text('加载完成'),
          );
        } else {
          return Center(
            child: Text('加载中'),
          );
        }
      },
    );
  }
}
