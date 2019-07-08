import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/main/main.dart';

//final mainProfileReducer = combineReducers<MainPageState>([
//  TypedReducer<MainPageState, MainProfileInitialAction>(_initialReducer),
//]);

MainPageState mainProfilePageInitialReducer(
    MainPageState preState, MainProfileInitialAction action) {
  final preProfileState = preState.profileState;
  final newProfileState = preProfileState.copyWith(user: action.user);
  return preState.copyWith(profileState: newProfileState);
}
