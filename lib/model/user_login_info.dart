class UserLoginInfo {
  String userName;

  String get getUserName {
    return userName;
  }

  void set setUserName(String userName) {
    this.userName = userName;
  }

  // We can also eliminate the setter and just use a getter.
  //int get age {
  //  return DateTime.now().year - manufactureYear;
  //}

  UserLoginInfo({this.userName,});
}