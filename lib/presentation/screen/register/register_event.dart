abstract class RegisterEvent {}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  RegisterUsernameChanged(this.username);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged(this.password);
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirm;
  RegisterConfirmPasswordChanged(this.confirm);
}

class RegisterSubmitted extends RegisterEvent {}
