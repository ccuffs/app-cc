class User {
  User();

  factory User.fromJson(Map<String, dynamic> data) {
    final User user = User();
    user.username = data['username'];
    user.uid = data['uid'][0];
    user.email = data['mail'][0];
    user.personId = data['pessoa_id'][0];
    user.name = data['cn'][0];
    user.cpf = data['employeeNumber'][0];
    user.authenticated = true;
    return user;
  }

  String username;
  String uid;
  String email;
  String personId;
  String name;
  String cpf;
  String tokenId;
  bool authenticated;
}