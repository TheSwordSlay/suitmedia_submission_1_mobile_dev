class User{
  String? id, email, first_name, last_name, avatar;

  User(this.id, this.email, this.first_name, this.last_name, this.avatar);

  factory User.fromJson(Map<String, dynamic> json) {
    return User( 
      json['id'].toString(),
      json['email'].toString(),
      json['first_name'].toString(),
      json['last_name'].toString(),
      json['avatar'].toString()
    );
  }

  String get getFullName {
    return (first_name != null && last_name != null) ? "$first_name $last_name" : "";
  }
}