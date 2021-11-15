import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkir/models/review.dart';
import 'package:parkir/models/user.dart';
import 'package:parkir/services/tools.dart';

class DatabaseService {
  DatabaseService();

  // collection reference
  final CollectionReference bannersCollection =
      FirebaseFirestore.instance.collection('banners');

  final CollectionReference locationsCollection =
      FirebaseFirestore.instance.collection('locations');

  final CollectionReference globalCollection =
      FirebaseFirestore.instance.collection('global');

  Stream<DocumentSnapshot> getLocationStream(String id) =>
      locationsCollection.doc(id).snapshots();

  Stream<QuerySnapshot> getLocationsStream() => locationsCollection.snapshots();

  Stream<DocumentSnapshot> getReviews({required String id}) =>
      locationsCollection.doc(id).collection('data').doc('reviews').snapshots();

  Future<List> getBannersCollection() async {
    QuerySnapshot snapshot = await bannersCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<DocumentSnapshot> getBannersStream() =>
      globalCollection.doc('banners').snapshots();

  Future<List> getLocationsCollection() async {
    QuerySnapshot snapshot = await locationsCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Future<List> getNewLocationsCollection() async {
  //   QuerySnapshot snapshot = await locationsCollection
  //       .orderBy('date', descending: true)
  //       .limit(3)
  //       .get();
  //   return snapshot.docs.map((doc) => doc.data()).toList();
  // }

  Future<DocumentSnapshot<Map<String, dynamic>>> getLocationPosts(
      {required String id}) {
    return locationsCollection.doc(id).collection('data').doc('posts').get();
  }

  Future updateRating(
      {required String id, required double rate, required Map rates}) async {
    locationsCollection.doc(id).update({'rate': rate, 'rates': rates});
  }

  // Future setReviews(
  //     {required String id,
  //     required MyUser user,
  //     required double currentRate,
  //     required double rate,
  //     required Map rates,
  //     required String review}) async {
  //   DateTime now = DateTime.now();

  //   await locationsCollection.doc(id).collection('reviews').doc().set({
  //     'name': user.name,
  //     'email': user.email,
  //     'photoURL': user.photoURL,
  //     'date': DateTime.now().millisecondsSinceEpoch,
  //     'rate': rate,
  //     'review': review,
  //   }).then((value) {
  //     rates[rate.toStringAsFixed(0)]++;
  //     double newRate = Tools.ratesAverage(rates: rates);

  //     updateRating(id: id, rate: newRate, rates: rates);
  //   });
  // }

  Future setReviews({
    required String id,
    required Review review,
    required Map rates,
  }) async {
    await locationsCollection.doc(id).collection('data').doc('reviews').set({
      review.id: {
        'name': review.name,
        'email': review.email,
        'photo_url': review.photoURL,
        'date': review.date,
        'rate': review.rate,
        'review': review.review,
      }
    }, SetOptions(merge: true)).then((value) {
      rates[review.rate.toStringAsFixed(0)]++;
      double newRate = Tools.ratesAverage(rates: rates);

      updateRating(id: id, rate: newRate, rates: rates);
    });
  }

  Future deleteReviews({
    required String id,
    required Review review,
    required Map rates,
  }) async {
    await locationsCollection
        .doc(id)
        .collection('data')
        .doc('reviews')
        .set({review.id: FieldValue.delete()}, SetOptions(merge: true)).then(
            (value) {
      rates[review.rate.toStringAsFixed(0)]--;
      double newRate = Tools.ratesAverage(rates: rates);

      updateRating(id: id, rate: newRate, rates: rates);
    });
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
