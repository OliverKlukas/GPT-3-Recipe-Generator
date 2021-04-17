import 'package:flutter/material.dart';

class RecipesList extends StatefulWidget{
  String name;
  String imageURL;
  RecipesList({required this.name,required this.imageURL});
  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  Widget build(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Back"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    return GestureDetector(
      onTap: (){
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
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageURL),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}