abstract class LoginState {
  final String username;
  final String password;
  final bool isLoading;

  LoginState(this.username, this.password, this.isLoading);

  static LoginState initial() => LoginNormal(username: '', password: '');
}

class LoginNormal extends LoginState {
  LoginNormal({String username, String password})
      : super(username, password, false);
}

class LoginLoading extends LoginState {
  LoginLoading({String username, String password})
      : super(username, password, true);
}

class LoginSuccess extends LoginState {
  LoginSuccess(String username, String password)
      : super(username, password, false);
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(String username, String password, this.errorMessage)
      : super(username, password, false);
}
