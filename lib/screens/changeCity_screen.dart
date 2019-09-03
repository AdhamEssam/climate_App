import 'package:flutter/material.dart';
import 'package:weather_app/const.dart';

class ChangeCity extends StatelessWidget {

  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Change City",
          style: cityStyle(),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: new Stack(
        children: <Widget>[

          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage('images/second.jpg'),
                    fit: BoxFit.cover
                )
            ),
          ),

          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Enter City",
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                    onPressed: (){
                      Navigator.pop(context,{
                        'enter ': _cityFieldController.text
                      });
                    },
                    color: Colors.redAccent,
                    textColor: Colors.white70,
                    child: new Text("Get Weather")),
              )
            ],
          )
        ],
      ),
    );
  }
}