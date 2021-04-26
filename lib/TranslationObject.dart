
class TranslationObject {
  String result;

  TranslationObject.fromJson(Map<String, dynamic> responseBody) {
    result = responseBody['result'];
  }
}