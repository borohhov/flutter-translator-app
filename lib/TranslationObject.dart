
class TranslationObject {
  String input;
  String result;

  TranslationObject.fromJson(Map<String, dynamic> responseBody) {
    input = responseBody['input'];
    result = responseBody['result'];
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> json = Map();
    json['input'] = input;
    json['result'] = result;
    return json;
  }


}