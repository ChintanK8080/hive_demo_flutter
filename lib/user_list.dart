import 'package:flutter/material.dart';
import 'package:hive_demo_app/models/user_model.dart';
import 'package:hive_demo_app/update_page.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    initialSetup();
    super.initState();
  }

  initialSetup() async {
    await User.getAllUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: User.listOfUser.length,
        itemBuilder: (context, index) => UserTile(
          user: User.listOfUser[index],
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdatePage(
                  user: User.listOfUser[index],
                ),
              ),
            );
            setState(() {});
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user, required this.onTap});
  final User user;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
          GestureDetector(onTap: onTap, child: Icon(Icons.edit))
        ],
      ),
    );
  }
}
