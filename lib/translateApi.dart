import 'dart:convert';

import 'package:flutter_translation_app/TranslationObject.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const String endpointServer = 'api.tartunlp.ai';
const String endpointParam = '/translation/v2';

Future<TranslationObject> fetchTranslation(String inputText, {String language = 'et'}) async {
  Response response = await http.post(Uri.https(endpointServer, endpointParam),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'text': inputText,
        'tgt': language,
        'domain': "inf"
      }));
  print(response.body);
  return TranslationObject.fromJson(jsonDecode(response.body));
}
