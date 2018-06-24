import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() async {

  final List _data = await getJson();
  runApp(MaterialApp(
    title: "Intro Parse",
    home: Scaffold(
      appBar: AppBar(
        title: Text("JSON Parse"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(14.5),
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.5,),
                  ListTile(
                    title: Text("${_data[position]['title']}",
                      style: TextStyle(
                        fontSize: 17.9,
                      ),),
                    subtitle: Text("${_data[position]['body']}",
                        style: TextStyle(
                          fontSize: 13.9,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic
                        ),),
                    leading: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text("${_data[position]['body'][0]}",
                        style: TextStyle(fontSize: 13.4,
                        color: Colors.orangeAccent),),
                    ),
                    onTap:() => _showOnTapMessage(context, _data[position]['body']),
                  )
                ],
              );
            })
      ),
    )
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("My App"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(child: Text("OK"), onPressed: () {
        Navigator.pop(context);
      },)
    ],
  );
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(url);

  return json.decode(response.body); // returns a list type
}
