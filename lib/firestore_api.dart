
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {

  FirebaseFirestore firestore;

  init() {
   firestore = FirebaseFirestore.instance;
  }

  Future<DocumentReference> addData(Map<String, dynamic> data) async {
    init();
    DocumentReference ref = await firestore.collection('translations').add(data);
    return ref;
  }

  Future<List<Map<String, dynamic>>> readAllData() async {
    init();
    QuerySnapshot snapshot = await firestore.collection('translations').get();
    List<Map<String, dynamic>> translations = snapshot.docs.map((e) => e.data()).toList();
    return translations;

  }

}