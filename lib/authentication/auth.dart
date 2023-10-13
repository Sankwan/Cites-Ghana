class Auth {
   int id;
   String fullname;
   String email;
   String country;
   String password;

  Auth({required this.id, required this.fullname, required this.email, required this.country, required this.password });

  factory Auth.fromJson(Map<String, dynamic> json){
    return Auth(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      password: json['password'] as String,
    );
  }
}