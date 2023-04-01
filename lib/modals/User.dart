class User {
  String email;
  String password;
  String confirmPassword;
  String gender;
  String chosenValue;

  User({
    this.email = '',
    this.gender = 'Male',
    this.chosenValue = 'Once a week',
    this.password = '',
    this.confirmPassword = '',
  });
}
