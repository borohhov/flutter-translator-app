import 'package:flutter/material.dart';
import 'package:flutter_translation_app/HistoryPage.dart';
import 'package:flutter_translation_app/TranslationObject.dart';
import 'package:flutter_translation_app/persistence.dart';
import 'package:flutter_translation_app/translateApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UT Translator',
      routes: {
        '/history': (context) => HistoryPage(),
      },
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
  TranslationObject translationObject;
  List<TranslationObject> previousTranslations = [];
  SharedPreferences prefs;

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
                  translationObject = (await fetchTranslation(inputText, language: outputLanguage ?? 'et'));
                  translationObject.input = inputText;
                  prefs.setString(DateTime.now().toString(), translationObject.result);
                  setState(() {
                    previousTranslations.add(translationObject);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(translationObject?.result ?? ""),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),
              ElevatedButton(child: Text('History'), onPressed: () {
                Navigator.of(context).pushNamed('/history');
              },)

            ],
          ),
        ),
      ),
    );
  }
}

class TranslationHistoryWidget extends StatelessWidget {
  final TranslationObject translationObject;

  const TranslationHistoryWidget({Key key, @required this.translationObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Text(
            'Input: ${translationObject.input}',
            style: TextStyle(fontSize: 12),
          ),
          Text('Translation: ${translationObject.result}')
        ],
      ),
    );
  }
}
