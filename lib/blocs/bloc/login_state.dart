part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final List<User> allUser;
  final List<User> loginUser;

  const LoginState({
    this.allUser = const <User>[],
    this.loginUser = const <User>[],
  });
  @override
  List<Object?> get props => [allUser, loginUser];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'allUser': allUser.map((x) => x.toMap()).toList()});
    result.addAll({'loginUser': loginUser.map((x) => x.toMap()).toList()});

    return result;
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      allUser: List<User>.from(map['allUser']?.map((x) => User.fromMap(x))),
      loginUser: List<User>.from(map['loginUser']?.map((x) => User.fromMap(x))),
    );
  }
}

class LoginInitial extends LoginState {}
