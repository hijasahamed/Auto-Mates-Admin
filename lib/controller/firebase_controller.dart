import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> streamAllSellers() {
    return _db.collection('sellerSignupData').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> streamAllUsers() {
    final userSignupDataStream = FirebaseFirestore.instance
        .collection('userSignupData')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());

    final blockedUsersStream = FirebaseFirestore.instance
        .collection('blocked_users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());

    return CombineLatestStream.list([userSignupDataStream, blockedUsersStream])
        .map((streams) {
      final List<Map<String, dynamic>> allUsers = [];
      for (var stream in streams) {
        allUsers.addAll(stream);
      }
      return allUsers;
    });
  }

  addUserToblockedList({user}){
    _db.collection('blocked_users').doc(user['id']).set({
          'userId': user['id'],
          'userName': user['userName'],
          'email' : user['email'],
          'location' : user['location'],
          'mobile' : user['mobile'],
          'userProfile' : user['userProfile'],
          'blockedAt': Timestamp.now(),
        });
  }

  Future<void> blockAndRemoveUser({docId,})async{
    _db.collection('userSignupData').doc(docId).delete();
  }

  addBlockedUserToUserList({user}){
    _db.collection('userSignupData').doc(user['id']).set({
          'userName': user['userName'],
          'email' : user['email'],
          'location' : user['location'],
          'mobile' : user['mobile'],
          'userProfile' : user['userProfile'],
        });
  }

  Future<void> removeBlockedUser({docId,})async{
    _db.collection('blocked_users').doc(docId).delete();
  }

}