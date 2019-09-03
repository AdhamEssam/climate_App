import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weather_app/screens/changeCity_screen.dart';
import 'package:weather_app/const.dart';
import 'dart:convert';
import 'package:weather_app/widgets/apikey.dart';
import 'package:http/http.dart' as http;

class ClimateScreen extends StatefulWidget {
  @override
  _ClimateScreenState createState() => _ClimateScreenState();
}

class _ClimateScreenState extends State<ClimateScreen> {

  String _cityEntered;

  Future _goToNextScreen (BuildContext context) async {
    Map results = await Navigator.of(context).push(
        new MaterialPageRoute<Map>(
            builder: (BuildContext context){
              return  ChangeCity();
            }));

    if (results != null && results.containsKey('enter')){
      //print(results['enter'].toString());
      _cityEntered = results['enter'];
    }
  }

  void showStuff() async {
    Map data = await getWeather(appId, defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Klimatic app",
          style: new TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold
          ),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        titleSpacing: 1.0,
        actions: <Widget>[
          new  IconButton(
              icon: new Icon(Icons.menu),
              color: Colors.black,
              onPressed: (){_goToNextScreen(context);}
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,


      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/snow.jpg'),
                      fit: BoxFit.cover)
              ),
            ),
          ),

          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 20.9, 0.0),
            child: new Text("${_cityEntered == null ? defaultCity : _cityEntered}",
              style: cityStyle(),),

          ),

          new Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
            child: new Image.asset('images/icon.png',
              width: 150.0,
              height: 120.0,),
          ),

          new Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0.0, 300.0, 120.0, 100.0),

              child: updateTempWidget('${_cityEntered == null ? defaultCity : _cityEntered}')
          )
        ],
      ),

    );
  }
}

Future<Map> getWeather(String apiId, String city) async {
  String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=metric";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

Widget updateTempWidget(String city){
  return new FutureBuilder(
      future: getWeather(appId, city == null ? defaultCity : city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData){
          Map content = snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(content['main']['temp'].toString()+"°C",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.9,
                        fontStyle: FontStyle.italic,
                        color: Colors.black
                    ),),
                  subtitle: new ListTile(
                    title: new Text(
                      "Humidity: ${content['main']['humidity'].toString()}\n"
                          'Min: ${content['main']['temp_min'].toString()}\n'
                          'Max: ${content['main']['temp_max'].toString()}',
                      style: extraData(),
                    ),
                  ),
                )
              ],
            ),
          );
        }else {
          return new Container();
        }
      });
}


