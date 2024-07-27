import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> streamAllSellers() {
    return _db.collection('sellerSignupData').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> streamAllUsers() {
    return _db.collection('userSignupData').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        },).toList());
  }

  Future<void> blockAndRemoveUser({docId,})async{
    _db.collection('userSignupData').doc(docId).delete();
  }

}