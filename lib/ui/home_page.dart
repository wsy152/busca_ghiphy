import 'dart:convert';
import 'package:curso_giphy/ui/constates.dart';
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
          'https://api.giphy.com/v1/gifs/search?api_key=UQQGApk385jPXlosRHTZP1WtgJTe224r&q=$_busca&limit=40&offset=0&rating=g&lang=pt');

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
        centerTitle: true,
      ),
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Procurar',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}
