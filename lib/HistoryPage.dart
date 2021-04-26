import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translation_app/persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'Previous translations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FutureBuilder<SharedPreferences>(
            future: Persistence.init(),
            builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              List<String> values = snapshot.data.getKeys().map<String>((key) => snapshot.data.get(key)).toList();
              return Column(
                children: values.map<Widget>((result) => Text(result)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
