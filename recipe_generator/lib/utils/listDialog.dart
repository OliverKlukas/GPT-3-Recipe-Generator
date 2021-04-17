import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:recipe_generator/views/chat.dart';
import 'package:recipe_generator/utils/constants.dart';

class ListDialogBox extends StatefulWidget {
  String recipeName;
  String imageURL;

  ListDialogBox({
    Key? key,
    required this.recipeName,
    required this.imageURL
  }) : super(key: key);

  @override
  _ListDialogBoxState createState() => _ListDialogBoxState();
}

class _ListDialogBoxState extends State<ListDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: Constants.padding,
                  top: Constants.avatarRadius + Constants.padding,
                  right: Constants.padding,
                  bottom: Constants.padding),
              margin: EdgeInsets.only(top: Constants.avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Looks Good! 🎉\nLet's Start Cooking 🥳",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.recipeName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return RecipeDetailApp(recipeTitle: widget.recipeName);
                            }));
                          },
                          child: Text(
                            "Recipe",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                    Spacer()
                  ]),
                  Row(children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ChatPage(recipeTitle: widget.recipeName);
                                }));
                          },
                          child: Text(
                            "Assistant",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ])
                ],
              ),
            ),
            Positioned(
              left: Constants.padding,
              right: Constants.padding,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: Constants.avatarRadius,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.avatarRadius)),
                    child: Image.network(widget.imageURL)),
              ),
            ),
          ],
        ));
  }
}