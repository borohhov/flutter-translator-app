import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translation_app/TranslationObject.dart';
import 'package:flutter_translation_app/firestore_api.dart';
import 'package:flutter_translation_app/persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Previous translations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: FirestoreApi().readAllData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data.map((firebaseTranslation) {
                    TranslationObject tr = TranslationObject.fromJson(firebaseTranslation);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('input: ' + (tr.input ?? '')),
                          Text('output: ' + (tr.result ?? ''))
                        ],
                      ),
                    );

                  }).toList(),);
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
