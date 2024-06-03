class User {
  final int id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final int age;
  final String gender;
  final String role;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.role,
      required this.phone,
      required this.age,
      required this.gender});
}
