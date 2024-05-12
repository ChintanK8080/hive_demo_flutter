import 'package:flutter/material.dart';
import 'package:hive_demo_app/models/user_model.dart';
import 'package:hive_demo_app/user_list.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.user});
  final User user;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final customDataController = TextEditingController();

  @override
  void initState() {
    idController.text = widget.user.id.toString();
    nameController.text = widget.user.username;
    addressController.text = widget.user.address;
    customDataController.text = widget.user.customData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              const Text("Id"),
              TextField(controller: idController),
              const SizedBox(height: 10),
              const Text("Name"),
              TextField(controller: nameController),
              const SizedBox(height: 10),
              const Text("Address"),
              TextField(controller: addressController),
              const SizedBox(height: 10),
              const Text("Custom Data"),
              TextField(controller: customDataController),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () async {
                    await User.updateUserFromDatabase(
                      id: int.tryParse(idController.text) ?? 0,
                      username: nameController.text,
                      address: addressController.text,
                      customData: customDataController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Submit")),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UsersList(),
                    ),
                  );
                },
                child: const Text("Users List"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
