
class User {
  int id;
  String name;
  String email;
  String password;
  String address;

  User({this.id, this.name, this.email, this.password, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    return data;
  }

  bool validEmailType(){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool validSignUpUserProperty(){
    return id.toString().isNotEmpty && name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && address.isNotEmpty && validEmailType();
  }

  bool validSignInUserProperty(){
    return email.isNotEmpty && validEmailType() && password.isNotEmpty;
  }
}