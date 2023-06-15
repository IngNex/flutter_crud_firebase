import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/services/firebase_service.dart';

class PutUser extends StatefulWidget {
  const PutUser({super.key});

  @override
  State<PutUser> createState() => _PutUserState();
}

class _PutUserState extends State<PutUser> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Put User'),
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
                  hintText: 'edit name',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Se ejecuta la Funcion then(entonces)
                  await putUser(arguments['uid'], nameController.text)
                      .then((_) {
                    Navigator.pop(context);
                  });
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
