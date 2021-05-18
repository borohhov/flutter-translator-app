
class TranslationObject {
  String input;
  String result;
  String userId;

  TranslationObject.fromJson(Map<String, dynamic> responseBody) {
    input = responseBody['input'];
    result = responseBody['result'];
    userId = responseBody['userId'];
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> json = Map();
    json['input'] = input;
    json['result'] = result;
    json['userId'] = userId;
    return json;
  }


}