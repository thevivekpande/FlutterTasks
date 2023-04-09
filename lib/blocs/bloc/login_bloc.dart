import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../modals/User.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<AddUser>(_onAddUser);
    on<LoginUser>(_onLoginUser);
  }

  void _onAddUser(AddUser event, Emitter<LoginState> emitter) {
    final state = this.state;
    emit(
      LoginState(
        allUser: List.from(state.allUser)..add(event.user),
        loginUser: state.loginUser,
      ),
    );
  }

  void _onLoginUser(LoginUser event, Emitter<LoginState> emitter) {
    final state = this.state;
    List<User> loginUser =
        state.allUser.where((e) => (e.email) == (event.user.email)).toList();
    emit(
      LoginState(
        allUser: state.allUser,
        loginUser: loginUser,
      ),
    );
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    return LoginState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return state.toMap();
  }
}
