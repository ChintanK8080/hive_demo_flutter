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
      customData: json['customData'],
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

  static Future<void> updateUserFromDatabase({
    int? id,
    required String username,
    String? address,
    String? customData,
  }) async {
    var box = await Hive.openBox('UsersBox');
    final encodedUser = await box.get(username);
    if (encodedUser != null && encodedUser.runtimeType == String) {
      final collectedUser = User.fromJson(jsonDecode(encodedUser));
      await User(
              username: username,
              id: id ?? collectedUser.id,
              address: address ?? collectedUser.address,
              customData: customData ?? collectedUser.customData)
          .storeUserInDatabase();
    }
  }

  static Future<void> deleteUserFromDatabase({
    required String username,
  }) async {
    var box = await Hive.openBox('UsersBox');
    await box.delete(username);
  }

  static Future<void> getAllUsers() async {
    Box<dynamic> box = await Hive.openBox("UsersBox");
    List<User> temporaryList = [];
    for (var i in box.values) {
      temporaryList.add(
        User.fromJson(
          jsonDecode(i),
        ),
      );
    }
    listOfUser = temporaryList;
  }
}
