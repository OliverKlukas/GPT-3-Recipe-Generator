import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:recipe_generator/services/assistedCooking.dart';

class Message {
  String text;
  bool byMe;
  Message(this.text, this.byMe);
}
/// Main page of our app, containing a scrollable chat history and a text field
class ChatPage extends StatefulWidget {
  String recipeTitle;

  ChatPage({Key? key, required this.recipeTitle}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  var textEditingController = TextEditingController();

  String prompt = "";

  @override
  void initState() {
    super.initState();
  }

  /// The history of chat messages sent
  List<Message> messages = [];
  /// Construct a prompt for OpenAI with the new message and store the response
  void sendMessage(String message) async {
    if (message == "") {
      return;
    }

    if (messages.isEmpty) {
      prompt = await getFullAssistantPrompt(widget.recipeTitle);
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
    String text = "";

    await Future.wait([fetchAssistantResponse(prompt)]).then((values) => {
      text += values[0]
    });

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
        title: Text(widget.recipeTitle),
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