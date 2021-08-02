import 'data_service.dart';
import 'package:flutter/material.dart';

import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Weather Report'),
            
            elevation: 20.0,
          ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
                colors: [
                    Color(0xFFB2EBF2),
                    Color(0xFF26C6DA),
                    Color(0xFF1DE9B6),
                    Color(0xFF00E676),
                ],
                

          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_response != null)
                Column(
                  children: [
                    Image.network(_response.iconUrl),
                    Text(
                      '${_response.tempInfo.temperature}° F',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(_response.weatherInfo.description)
                  ],
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(labelText: 'City'),
                      textAlign: TextAlign.center),
                ),
              ),
              RaisedButton(
                 color: Colors.blue,
                 onPressed: _search,
                 child: Text('Search'),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
             /* ElevatedButton(onPressed: _search, 
              child: Text('Search'),
              color: Color
              ),*/
            ],
          ),
        ),
      ),
    ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}