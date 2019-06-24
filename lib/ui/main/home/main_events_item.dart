import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/common/model/event.dart';

class MainEventItem extends StatelessWidget {
  final Event event;

  MainEventItem({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = _transformEventTitle(event);
    final String timeLine = _transformEventTime(event.createdAt);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.0, top: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 主要内容
          Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 头像
              Container(
                margin: EdgeInsets.only(top: 4.0),
                child: ClipOval(
                  child: Image(
                    width: 40.0,
                    height: 40.0,
                    image: NetworkImage(event.actor.avatarUrl),
                  ),
                ),
              ),
              // 详细事件和时间
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          title,
                          style: TextStyle(color: colorPrimary, fontSize: 14.0),
                        ),
                      ),
                      Text(
                        timeLine,
                        style: TextStyle(
                            color: colorSecondaryTextGray, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16.0),
                child: Image(
                  width: 20.0,
                  height: 20.0,
                  image: AssetImage(eventsStarChecked),
                ),
              ),
            ],
          ),
          // 分割线
          Container(
            margin: EdgeInsets.only(top: 8.0,right: 12.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  String _transformEventTitle(final Event event) {
    final String actor = event.actor.displayLogin;
    final String repo = event.repo.name;

    String eventType = event.type;
    switch (event.type) {
      case 'WatchEvent':
        eventType = 'starred';
        break;
      case 'CreateEvent':
        eventType = 'created';
        break;
      case 'ForkEvent':
        eventType = 'forked';
        break;
      case 'PushEvent':
        eventType = 'pushed';
        break;
    }

    return '$actor $eventType $repo';
  }

  String _transformEventTime(final String createAt) {
    final int formatTimes = DateTime.parse(createAt).millisecondsSinceEpoch;

    setLocaleInfo('zh_normal', ZhInfo());

    final int now = DateTime.now().millisecondsSinceEpoch;
    final String timeLine = TimelineUtil.format(formatTimes,
        locTimeMillis: now, locale: 'zh_normal', dayFormat: DayFormat.Full);

    return timeLine;
  }
}
