
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_translation_app/services/authentication.dart';
import 'package:flutter_translation_app/services/services.dart' as services;
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
    String userId = (await services.Authentication.anonymousLoginOrGetUser()).userId;
    QuerySnapshot snapshot = await firestore.collection('translations').where('userId', isEqualTo: userId).get();
    List<Map<String, dynamic>> translations = snapshot.docs.map((e) => e.data()).toList();
    return translations;

  }

}