import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AppRepository repository;

  String username = "";
  String password = "";
  String confirm = "";

  RegisterBloc(this.repository) : super(RegisterInitial()) {
    on<RegisterUsernameChanged>((event, emit) {
      username = event.username;
    });

    on<RegisterPasswordChanged>((event, emit) {
      password = event.password;
    });

    on<RegisterConfirmPasswordChanged>((event, emit) {
      confirm = event.confirm;
    });

    on<RegisterSubmitted>(_register);
  }

  Future<void> _register(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    if (username.isEmpty || password.isEmpty || confirm.isEmpty) {
      emit(RegisterFailure("Please fill in all fields"));
      return;
    }

    if (password != confirm) {
      emit(RegisterFailure("Passwords do not match"));
      return;
    }

    emit(RegisterLoading());

    final error = await repository.register(username.trim(), password);

    if (error != null) {
      emit(RegisterFailure(error));
    } else {
      emit(RegisterSuccess());
    }
  }
}
