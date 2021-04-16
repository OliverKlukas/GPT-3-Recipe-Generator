import 'dart:convert';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Run your app with 'flutter run --dart-define=OPENAI_KEY=YOUR_API_KEY_HERE
const OPENAI_KEY = String.fromEnvironment("OPENAI_KEY");

/// Dataclass to store a single message,
/// either from you or the AI
class Message {
  String text;
  bool byMe;

  Message(this.text, this.byMe);
}

/// Main page of our app, containing a scrollable chat history and a text field
class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var textEditingController = TextEditingController();

  /// The initial promt given to OpenAI
  String prompt =
      "The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n"
      "Human: Hello, who are you?\n"
      "AI: I am an AI created by OpenAI. How can I help you today?";

  /// The history of chat messages sent
  List<Message> messages = [];

  /// Construct a prompt for OpenAI with the new message and store the response
  void sendMessage(String message) async {
    if (message == "") {
      return;
    }

    /// Store the message itself
    setState(() {
      messages.add(Message(message, true));
    });

    /// Reset the text input
    textEditingController.text = "";

    /// Continue the prompt template
    prompt += "\n"
        "Human: $message\n"
        "AI:";

    /// Make the api request to OpenAI
    /// See available api parameters here: https://beta.openai.com/docs/api-reference/completions/create
    var result = await http.post(
      Uri.parse("https://api.openai.com/v1/engines/davinci/completions"),
      headers: {
        "Authorization": "Bearer $OPENAI_KEY",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "prompt": prompt,
        "max_tokens": 100,
        "temperature": 0,
        "top_p": 1,
        "stop": "\n",
      }),
    );

    /// Decode the body and select the first choice
    var body = jsonDecode(result.body);
    var text = body["choices"][0]["text"];

    prompt += text;

    /// Store the response message
    setState(() {
      messages.add(Message(text.trim(), false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// The top app bar with title
      appBar: AppBar(
        title: Text("Cooking Companion"),
      ),
      body: Column(
        children: [
          /// The chat history
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              reverse: true, // makes it 'stick' to the bottom when sending new messages
              children: messages.reversed.map((message) {
                return Bubble(
                  child: Text(message.text),
                  color: message.byMe ? Colors.blue : Colors.white,
                  nip: message.byMe ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                  alignment: message.byMe ? Alignment.topRight : Alignment.topLeft,
                  margin: BubbleEdges.symmetric(vertical: 5),
                );
              }).toList(),
            ),
          ),

          /// The bottom text field
          Container(
            color: Colors.grey.shade700,
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    onSubmitted: (text) {
                      sendMessage(text);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    sendMessage(textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
