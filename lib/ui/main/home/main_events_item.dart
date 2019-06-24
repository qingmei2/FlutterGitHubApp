import 'package:common_utils/common_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/common/model/event.dart';

class MainEventItem extends StatelessWidget {
  final Event event;

  final EventItemActionObserver observer;

  MainEventItem({Key key, @required this.event, this.observer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String timeLine = _transformEventTime(event.createdAt);
    final String imageAsset = _fetchEventImage(event);

    return Container(
      width: double.infinity,
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
                margin: EdgeInsets.only(top: 16.0, left: 16.0),
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
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  height: 60.0,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: _transformEventTitle(event),
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
                  image: AssetImage(imageAsset),
                ),
              ),
            ],
          ),
          // 分割线
          Container(
            margin: EdgeInsets.only(left: 16.0, top: 12.0, right: 12.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _transformEventTitle(final Event event) {
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

    final TapGestureRecognizer recognizerActor = TapGestureRecognizer();
    recognizerActor.onTap = () {
      observer(EventItemAction(true, event.actor.url));
    };
    final TapGestureRecognizer recognizerRepo = TapGestureRecognizer();
    recognizerRepo.onTap = () {
      observer(EventItemAction(false, event.repo.url));
    };

    return RichText(
      text: TextSpan(
        text: '',
        children: [
          TextSpan(
            text: actor,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: colorPrimaryText,
            ),
            recognizer: recognizerActor,
          ),
          TextSpan(
            text: ' ' + eventType + ' ',
            style: TextStyle(
              color: colorPrimaryText,
            ),
          ),
          TextSpan(
            text: repo,
            style: TextStyle(
              color: colorPrimaryText,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: recognizerRepo,
          ),
        ],
      ),
    );
  }

  String _transformEventTime(final String createAt) {
    final int formatTimes = DateTime.parse(createAt).millisecondsSinceEpoch;

    setLocaleInfo('zh_normal', ZhInfo());

    final int now = DateTime.now().millisecondsSinceEpoch;
    final String timeLine = TimelineUtil.format(formatTimes,
        locTimeMillis: now, locale: 'zh_normal', dayFormat: DayFormat.Full);

    return timeLine;
  }

  String _fetchEventImage(final Event event) {
    String asset = eventsForkChecked;
    switch (event.type) {
      case 'WatchEvent':
        asset = eventsStarChecked;
        break;
      default:
        asset = eventsForkChecked;
        break;
    }
    return asset;
  }
}

class EventItemAction {
  final bool isActorAction;
  final String url;

  EventItemAction(this.isActorAction, this.url);
}

typedef void EventItemActionObserver(EventItemAction action);
