import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<List> getUser() async {
  List user = [];

  // CollectionReference collectionReferenceUser = database.collection('user');

  // QuerySnapshot queryUser = await collectionReferenceUser.get();

  // queryUser.docs.forEach(
  //   (document) {
  //     user.add(
  //       document.data(),
  //     );
  //   },
  // );

  QuerySnapshot querySnapshot = await database.collection('user').get();

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name": data['name'],
      "uid": doc.id,
    };

    user.add(person);
  }

  return user;
}

// Save in User
Future<void> postUser(String name) async {
  await database.collection('user').add(
    {
      'name': name,
    },
  );
}

//Put in User name
Future<void> putUser(String uid, String newName) async {
  await database.collection('user').doc(uid).set({
    'name': newName,
  });
}

//Delete in User name
Future<void> deleteUser(String uid) async {
  await database.collection('user').doc(uid).delete();
}
