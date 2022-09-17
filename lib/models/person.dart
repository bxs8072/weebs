// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String uid;
  final String photoURL;
  final String email;

  Person({
    required this.uid,
    required this.photoURL,
    required this.email,
  });

  Map<String, dynamic> get toMap => {
        "uid": uid,
        "photoURL": photoURL,
        "email": email,
      };

  factory Person.fromDocumentSnapshot(DocumentSnapshot data) => Person(
        email: data["email"],
        photoURL: data['photoURL'],
        uid: data['uid'],
      );

  factory Person.fromMap(Map<String, dynamic> data) => Person(
        email: data["email"],
        photoURL: data['photoURL'],
        uid: data['uid'],
      );
}
