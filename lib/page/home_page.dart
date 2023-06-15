import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/services/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Text('Firebase CRUD', textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        //Variable
                        final name = snapshot.data?[index]['name'];
                        final uid = snapshot.data?[index]['uid'];

                        return Dismissible(
                          key: Key(snapshot.data?[index]['uid']),
                          onDismissed: (direction) async {
                            await deleteUser(uid);
                            // Remove current length
                            snapshot.data?.removeAt(index);
                          },
                          confirmDismiss: (direction) async {
                            bool result = false;
                            result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        '¿Are you sure you want to delete $name?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, false);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, true);
                                        },
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  );
                                });
                            return result;
                          },
                          background: Container(
                            color: Colors.redAccent,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          child: ListTile(
                            title: Text(name),
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                "/put",
                                arguments: {
                                  "name": name,
                                  "uid": uid,
                                },
                              );
                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/post');
          setState(() {});
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
