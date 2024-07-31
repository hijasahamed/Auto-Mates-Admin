import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> streamAllSellers() {
    final sellerSignupDataStream = _db
        .collection('sellerSignupData')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());

    final blockedSellersStream = _db
        .collection('blocked_sellers')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());

    return CombineLatestStream.list([sellerSignupDataStream, blockedSellersStream])
        .map((streams) {
      final List<Map<String, dynamic>> allSellers = [];
      for (var stream in streams) {
        allSellers.addAll(stream);
      }
      allSellers.sort((a, b) => (a['companyName'] ?? '').compareTo(b['companyName'] ?? ''));
      return allSellers;
    });
  }

  Stream<List<Map<String, dynamic>>> streamAllUsers() {
    final userSignupDataStream = _db
        .collection('userSignupData')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              return data;
            }).toList());

    final blockedUsersStream = _db
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
      allUsers.sort((a, b) => (a['userName'] ?? '').compareTo(b['userName'] ?? ''));
      return allUsers;
    });
  }

  Stream<int> streamAllUsersCount() {
  final userSignupDataStream = _db
      .collection('userSignupData')
      .snapshots()
      .map((snapshot) => snapshot.docs.length);

  final blockedUsersStream = _db
      .collection('blocked_users')
      .snapshots()
      .map((snapshot) => snapshot.docs.length);

  return CombineLatestStream.list([userSignupDataStream, blockedUsersStream])
      .map((streams) {
    final totalCount = streams.fold<int>(0, (previousValue, element) => previousValue + element);
    return totalCount;
  });
}

// user blocking services
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


// seller blocking services  
 Future<void> addSellerToBlockedList({seller})async{
    _db.collection('blocked_sellers').doc(seller['id']).set({
          'sellerId': seller['id'],
          'companyName': seller['companyName'],
          'location' : seller['location'],
          'mobile' : seller['mobile'],
          'sellerProfile' : seller['sellerProfile'],
          'mapLocation' : seller['mapLocation'],
          'rating' : seller['rating'],
          'blockedAt': Timestamp.now(),
        });
  }

  Future<void> blockAndRemoveSeller({docId,})async{
    _db.collection('sellerSignupData').doc(docId).delete();
  }

  addBlockedSellersToSellersList({seller}){
    _db.collection('sellerSignupData').doc(seller['id']).set({
          'companyName': seller['companyName'],
          'location' : seller['location'],
          'mobile' : seller['mobile'],
          'sellerProfile' : seller['sellerProfile'],
          'mapLocation' : seller['mapLocation'],
          'rating' : seller['rating'],
        });
  }

  Future<void> removeBlockedSellers({docId,})async{
    _db.collection('blocked_sellers').doc(docId).delete();
  }

}