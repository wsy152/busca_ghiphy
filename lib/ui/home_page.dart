import 'dart:convert';
import 'package:curso_giphy/ui/constates.dart';
import 'package:curso_giphy/ui/gridview.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _busca;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_busca == null)
      response = await http.get(
          'https://api.giphy.com/v1/gifs/trending?api_key=UQQGApk385jPXlosRHTZP1WtgJTe224r&limit=40&rating=g');
    else
      response = await http.get(
          'https://api.giphy.com/v1/gifs/search?api_key=UQQGApk385jPXlosRHTZP1WtgJTe224r&q=$_busca&limit=39&offset=0&rating=g&lang=pt');

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(url),
        centerTitle: false,
      ),
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Giphy',
                labelStyle: TextStyle(color: Colors.red),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _busca = text;
                });
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _getGifs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return Container();
                  else
                    return createGifTable(context, snapshot);
              }
            },
          ))
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_busca == null) {
      return data.length;
    }
  }
}
