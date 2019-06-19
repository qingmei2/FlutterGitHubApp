import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static final String path = 'main_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
      ),
      body: Container(
        child: Text('body'),
      ),
    );
  }
}
