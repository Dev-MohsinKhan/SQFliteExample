class Person {
  String _fname;
  String _username;
  String _phone;
  String _password;
  String _lname;
  String _address;
  String _gender;
  String _dob;
  String _picture;
  // String _flaglogged;
  Person(
    this._fname,
    this._lname,
    this._username,
    this._password,
    this._phone,
    this._address,
    this._gender,
    this._dob,
    this._picture,
  );
  // User(this._name, this._username, this._password, this._phone);

  Person.map(dynamic obj) {
    this._fname = obj['fname'];
    this._lname = obj['lname'];
    this._username = obj['username'];
    this._password = obj['pass'];
    this._phone = obj['phone'];
    this._address = obj['address'];
    this._gender = obj['gender'];
    this._dob = obj['dob'];
    this._picture = obj['picture'];
    // this._ = obj['name'];
    // this._username = obj['username'];
    // this._password = obj['password'];
    // this._phone = obj['phone'];
  }
  String get fname => _fname;
  String get username => _username;
  String get phone => _phone;
  String get password => _password;
  String get lname => _lname;
  String get address => _address;
  String get gender => _gender;
  String get dob => _dob;
  String get picture => _picture;
  // String get name => _name;
  // String get username => _username;
  // String get password => _password;
  // String get phone => _phone;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["fname"] = _fname;
    map["username"] = _username;
    map["lname"] = _lname;
    map["password"] = _password;
    map["phone"] = _phone;
    map["address"] = _address;
    map["gender"] = _gender;
    map["dob"] = _dob;
    map["picture"] = _picture;
    // map["username"] = _username;
    // map["username"] = _username;
    // map["password"] = _password;
    // map["phone"] = _phone;
    return map;
  }
}
