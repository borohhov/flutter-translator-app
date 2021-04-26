import 'package:flutter/material.dart';
import 'package:flutter_translation_app/TranslationObject.dart';
import 'package:flutter_translation_app/translateApi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UT Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String inputText = "";
  String outputLanguage;
  TranslationObject translation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UT translator"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (input) {
                  inputText = input;
                },
                decoration: InputDecoration(labelText: "Enter the text to translate"),
              ),
              DropdownButton<String>(
                  value: outputLanguage ?? 'et',
                  onChanged: (lang) {
                    setState(() {
                      outputLanguage = lang;
                    });
                  },
                  items: <String>['et', 'lv', 'lt', 'en', 'de'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              ElevatedButton(
                child: Text("Translate"),
                onPressed: () async {

                  translation = (await fetchTranslation(inputText, language: outputLanguage ?? 'et'));
                  setState(() {});
                },
              ),
              Text(translation?.result ?? "")
            ],
          ),
        ),
      ),
    );
  }
}
