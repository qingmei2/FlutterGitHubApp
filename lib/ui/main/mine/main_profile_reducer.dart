import 'package:flutter_rhine/common/common.dart';
import 'package:flutter_rhine/ui/main/main.dart';

final mainProfileReducer = combineReducers<MainProfileState>([
  TypedReducer<MainProfileState, MainProfileInitialAction>(_initialReducer),
]);

MainProfileState _initialReducer(
    MainProfileState preState, MainProfileInitialAction action) {
  return preState.copyWith(user: action.user);
}
