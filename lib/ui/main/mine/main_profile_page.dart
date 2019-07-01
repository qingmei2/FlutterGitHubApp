import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/common/constants/assets.dart';
import 'package:flutter_rhine/common/constants/colors.dart';
import 'package:flutter_rhine/repository/repository.dart';

import 'main_profile.dart';

class MainProfilePage extends StatelessWidget {
  final UserRepository userRepository;
  final MainProfileBloc _profileBloc = MainProfileBloc();

  MainProfilePage({@required this.userRepository})
      : assert(userRepository != null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (_) => _profileBloc,
      child: MainProfileForm(
        userRepository: userRepository,
      ),
    );
  }
}

class MainProfileForm extends StatefulWidget {
  final UserRepository userRepository;

  MainProfileForm({@required this.userRepository})
      : assert(userRepository != null);

  @override
  State<StatefulWidget> createState() =>
      _MainProfileFormState(userRepository: userRepository);
}

class _MainProfileFormState extends State<MainProfileForm>
    with AutomaticKeepAliveClientMixin {
  final UserRepository userRepository;

  _MainProfileFormState({this.userRepository}) : assert(userRepository != null);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<MainProfileBloc>(context)
        .dispatch(MainProfileInitialEvent(userRepository.user));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorPrimary,
      child: Stack(
        alignment: Alignment.center,
        textDirection: TextDirection.ltr,
        fit: StackFit.loose,
        children: <Widget>[
          BlocBuilder(
            bloc: BlocProvider.of<MainProfileBloc>(context),
            builder: (context, MainProfileState state) {
              return MainProfileUserInfoLayer(state.user);
            },
          ),
        ],
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
