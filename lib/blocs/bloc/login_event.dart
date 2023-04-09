part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object> get props => [];
}

class AddUser extends LoginEvent {
  final User user;
  const AddUser({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class LoginUser extends LoginEvent {
  final User user;
  const LoginUser({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}
