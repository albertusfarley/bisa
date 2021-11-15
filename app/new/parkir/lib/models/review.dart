import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  late String id;
  late String email;
  late String name;
  late String photoURL;
  late int date;
  late double rate;
  late String review;

  Review({required String reviewID, required Map raw}) {
    id = reviewID;
    email = raw['email'];
    name = raw['name'];
    photoURL = raw['photo_url'];
    date = raw['date'];
    rate = raw['rate'];
    review = raw['review'];
  }
}
