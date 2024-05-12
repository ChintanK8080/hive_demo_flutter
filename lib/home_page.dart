import 'package:flutter/material.dart';
import 'package:hive_demo_app/models/user_model.dart';
import 'package:hive_demo_app/user_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final customDataController = TextEditingController();
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
                    await User(
                      id: int.tryParse(idController.text) ?? 0,
                      username: nameController.text,
                      address: addressController.text,
                      customData: customDataController.text,
                    ).storeUserInDatabase();
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
                  child: const Text("Users List")),
            ],
          ),
        ),
      ),
    );
  }
}
