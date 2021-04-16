import 'package:flutter/material.dart';

class InspirationApp extends StatefulWidget {
  @override
  _InspirationAppState createState() => _InspirationAppState();
}

class _InspirationAppState extends State<InspirationApp> {
  Color _color = Colors.deepPurple;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(250.0);

  @override
  Widget build(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Back"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    return AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: _borderRadius,
        ),
        // Define how long the animation should take.
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        child: Center(
          child: TextButton(
            child: const Text(
              'Feeling\nhungry\n🍔🍟',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white
              ),
            ),
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('Alert!'),
                    content: Text("This is my message."),
                    actions: [
                      okButton,
                    ],
                  );
                },
              )
          },
          )
        ));
  }
}
