import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      if (event.username.isEmpty || event.password.isEmpty) {
        emit(LoginFailure("Please fill in all fields"));
        return;
      }

      emit(LoginLoading());

      final error = await repository.login(
        event.username.trim(),
        event.password,
      );

      if (error != null) {
        emit(LoginFailure(error));
      } else {
        emit(LoginSuccess());
      }
    });
  }
}
