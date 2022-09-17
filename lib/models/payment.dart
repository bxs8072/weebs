import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String id;
  final String email;
  final int type;
  final double amount;
  final Timestamp createdAt, expiredAt;

  Payment({
    required this.id,
    required this.email,
    required this.type,
    required this.amount,
    required this.createdAt,
    required this.expiredAt,
  });

  Map<String, dynamic> get toMap => {
        "id": id,
        "email": email,
        "type": type,
        "amount": amount,
        "createdAt": createdAt,
        "expiredAt": expiredAt,
      };

  factory Payment.fromDocumentSnapshot(DocumentSnapshot data) => Payment(
        id: data["id"],
        email: data["email"],
        type: data["type"],
        amount: data["amount"].toDouble(),
        createdAt: data["createdAt"],
        expiredAt: data["expiredAt"],
      );

  factory Payment.fromMap(Map<String, dynamic> data) => Payment(
        id: data["id"],
        email: data["email"],
        type: data["type"],
        amount: data["amount"].toDouble(),
        createdAt: data["createdAt"],
        expiredAt: data["expiredAt"],
      );
}
