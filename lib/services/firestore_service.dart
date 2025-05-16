import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/data_bocor.dart';

class FirestoreService {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('data_bocor');

  Future<void> addData(DataBocor data) {
    return _ref.add(data.toMap());
  }

  Stream<List<DataBocor>> getData() {
    return _ref.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => DataBocor.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> updateData(DataBocor data) {
    return _ref.doc(data.id).update(data.toMap());
  }

  Future<void> deleteData(String id) {
    return _ref.doc(id).delete();
  }
}
