import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService();

  // collection reference
  final CollectionReference bannersCollection =
      FirebaseFirestore.instance.collection('banners');

  final CollectionReference locationsCollection =
      FirebaseFirestore.instance.collection('locations');

  Future<List> getBannersCollection() async {
    QuerySnapshot snapshot = await bannersCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List> getLocationsCollection() async {
    QuerySnapshot snapshot = await locationsCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List> getNewLocationsCollection() async {
    QuerySnapshot snapshot = await locationsCollection
        .orderBy('date', descending: true)
        .limit(3)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Future getRecruitmentsDocument(String documentID) async {
  //   DocumentSnapshot doc = await recruitmentsCollection.doc(documentID).get();
  //   return doc;
  // }

  // Future getRanksCollection() async {
  //   QuerySnapshot snapshot = await ranksCollection.get();
  //   return snapshot.docs.map((doc) => doc.data()).toList();
  // }

  // Future updateUserData(
  //     String uid, String name, String email, String photoURL) async {
  //   return await userCollection
  //       .doc(uid)
  //       .set({'uid': uid, 'name': name, 'email': email, 'photoURL': photoURL});
  // }

  // Future deleteAccount(String uid) async {
  //   return userCollection.doc(uid).delete();
  // }
}
