import 'dart:convert';

import 'package:hive/hive.dart';

class User<T> {
  int id;
  String username;
  String address;
  T customData;

  static List<User> listOfUser = [];

  User({
    required this.id,
    required this.username,
    required this.address,
    required this.customData,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      address: json['address'] as String,
      customData: json['customData'], // Assuming customData can be of any type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'address': address,
      'customData': customData,
    };
  }

  String toEncodedString() {
    final data = this.toJson();
    return jsonEncode(data);
  }

  Future<void> storeUserInDatabase() async {
    var box = await Hive.openBox('UsersBox');
    await box.put(username, toEncodedString());
  }

  static Future<User?> getUserFromDatabase(String username) async {
    var box = await Hive.openBox('UsersBox');
    final encodedUser = await box.get(username);
    if (encodedUser != null && encodedUser.runtimeType == String) {
      return jsonDecode(encodedUser);
    }
    return null;
  }

  static Future<void> getAllUsers() async {
    Box<dynamic> box = await Hive.openBox("UsersBox");
    List<User> temporaryList = [];
    for (var i in box.values) {
      temporaryList.add(User.fromJson(jsonDecode(i)));
    }
    listOfUser = temporaryList;
  }
}
