import 'package:flutter/material.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';

import 'main_profile.dart';

class MainProfilePage extends StatelessWidget {
  MainProfilePage();

  @override
  Widget build(BuildContext context) {
    return MainProfileForm();
  }
}

class MainProfileForm extends StatefulWidget {
  MainProfileForm();

  @override
  State<StatefulWidget> createState() => _MainProfileFormState();
}

class _MainProfileFormState extends State<MainProfileForm>
    with AutomaticKeepAliveClientMixin {
  _MainProfileFormState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final store = StoreProvider.of<AppState>(context);
    final currentUser = store.state.appUser.user;
    store.dispatch(MainProfileInitialAction(currentUser));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, User>(
      converter: (Store<AppState> store) => store.state.appUser.user,
      builder: (context, final User user) => Container(
            width: double.infinity,
            height: double.infinity,
            color: colorPrimary,
            child: Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.ltr,
              fit: StackFit.loose,
              children: <Widget>[
                MainProfileUserInfoLayer(user),
              ],
            ),
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 用户信息层
class MainProfileUserInfoLayer extends StatelessWidget {
  final User user;

  MainProfileUserInfoLayer(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.down,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          child: Image(
            width: 70.0,
            height: 70.0,
            image: NetworkImage(user?.avatarUrl ?? ''),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            user?.login ?? "unknown",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            user?.bio ?? "no description.",
            style: TextStyle(
              fontSize: 14.0,
              color: colorSecondaryTextGray,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                width: 15.0,
                height: 15.0,
                image: AssetImage(mineLocationIcon),
              ),
              Text(
                user?.location ?? 'no address.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: colorSecondaryTextGray,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
