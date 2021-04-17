import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const OPENAI_KEY = String.fromEnvironment("OPENAI_KEY");

Future<String> fetchRecipe(String prompt, Object configuration) async {
  var result = await http.post(
    Uri.parse("https://api.openai.com/v1/engines/davinci/completions"),
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

Future<String> fetchReliableRecipe() async {
  String prompt = "Write a list of totally different recipes:\n\n"
      "1. Lemon Chicken with Asparagus\n"
      "2."
  ;
  Object configuration = {
    "prompt": prompt,
    "max_tokens": 16,
    "temperature": 0.7,
    "top_p": 0.5,
    "stop": "\n",
  };
  return fetchRecipe(prompt, configuration);
}
