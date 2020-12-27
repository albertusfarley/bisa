import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('data');

  final DocumentReference geopointDocument =
      FirebaseFirestore.instance.collection('data').doc('geopoint');

  final DocumentReference locationDocument =
      FirebaseFirestore.instance.collection('data').doc('location_list');

  final DocumentReference statusDocument =
      FirebaseFirestore.instance.collection('data').doc('status');

  final DocumentReference placementDocument =
      FirebaseFirestore.instance.collection('data').doc('placement');

  Stream<QuerySnapshot> get data {
    return dataCollection.snapshots();
  }

  Stream<DocumentSnapshot> get geopoint {
    return geopointDocument.snapshots();
  }

  Stream<DocumentSnapshot> get location {
    return locationDocument.snapshots();
  }

  Stream<DocumentSnapshot> get status {
    return statusDocument.snapshots();
  }

  Stream<DocumentSnapshot> get placement {
    return placementDocument.snapshots();
  }
}
