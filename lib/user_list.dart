import 'package:flutter/material.dart';
import 'package:hive_demo_app/models/user_model.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    User.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: User.listOfUser.length,
        itemBuilder: (context, index) => UserTile(user: User.listOfUser[index]),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Id :- ${user.id}"),
          const SizedBox(height: 10),
          Text("Name :- ${user.username}"),
          const SizedBox(height: 10),
          Text("Address :- ${user.address}"),
          const SizedBox(height: 10),
          Text("customData :- ${user.customData}"),
        ],
      ),
    );
  }
}
