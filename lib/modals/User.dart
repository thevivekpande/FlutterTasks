import 'package:equatable/equatable.dart';

class User extends Equatable {
  String email;
  String password;
  String gender;
  String chosenValue;

  User(
      {this.email = '',
      this.gender = 'Male',
      this.chosenValue = 'Once a week',
      this.password = ''});

  User copyWith({
    String? email,
    String? password,
    String? gender,
    String? chosenValue,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      chosenValue: chosenValue ?? this.chosenValue,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'gender': gender});
    result.addAll({'chosenValue': chosenValue});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      gender: map['gender'] ?? 'Male',
      chosenValue: map['chosenValue'] ?? 'Once a week',
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        gender,
        chosenValue,
      ];
}
