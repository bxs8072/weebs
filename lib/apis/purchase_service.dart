import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freeforweebs/models/payment.dart';

class PurchaseService {
  Future<void> deleteAllExpiredPayment() async {
    await FirebaseFirestore.instance
        .collection("Payment")
        .where("expiredAt", isLessThan: Timestamp.now())
        .get()
        .then((qDoc) {
      for (QueryDocumentSnapshot doc in qDoc.docs) {
        doc.reference.delete();
      }
    });
  }

  Future<void> deleteSinglePurchase(String docId) async {
    await FirebaseFirestore.instance.collection("Payment").doc(docId).delete();
  }

  Future<void> addPurchase(String docId, Payment payment) async {
    await FirebaseFirestore.instance.collection("Payment").doc(docId).set(
          payment.toMap,
        );
  }

  Future<void> editPurchase(String docId, Payment payment) async {
    await FirebaseFirestore.instance.collection("Payment").doc(docId).update(
          payment.toMap,
        );
  }
}

final PurchaseService purchaseService = PurchaseService();
