class User<T> {
  int id;
  String username;
  String address;
  T customData;

  User({
    required this.id,
    required this.username,
    required this.address,
    required this.customData,
  });
}
