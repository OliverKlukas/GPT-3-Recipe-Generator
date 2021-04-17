import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const OPENAI_KEY = String.fromEnvironment("OPENAI_KEY");
const OPENAI_FILE_ID = String.fromEnvironment("OPENAI_FILE_ID");

Future<String> fetchCompletion(
    String prompt,
    String engine,
    Object configuration) async {
  var result = await http.post(
      Uri.parse("https://api.openai.com/v1/engines/$engine/completions"),
      headers: {
        "Authorization": "Bearer $OPENAI_KEY",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(configuration)
  );
  /// Decode the body and select the first choice
  var body = jsonDecode(result.body);
  var text = body["choices"][0]["text"];
  return text;
}