import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/services/firebase_service.dart';

class PostUser extends StatefulWidget {
  const PostUser({super.key});

  @override
  State<PostUser> createState() => _PostUserState();
}

class _PostUserState extends State<PostUser> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'add name',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Se ejecuta la Funcion then(entonces)
                  await postUser(nameController.text).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
