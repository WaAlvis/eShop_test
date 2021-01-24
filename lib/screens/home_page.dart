import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Future<Album> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_futureAlbum == null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Enter Title'),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Create Data'),
                    onPressed: () {
                      setState(() {
                        _futureAlbum = createAlbum(nameProduct: _controller.text);
                      });
                    },
                  ),
                ],
              )
            : FutureBuilder<Album>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.nameProduct);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}

Future<Album> createAlbum({String nameProduct}) async {
  final http.Response response = await http.post(
    'https://winkels-strapi.herokuapp.com/products',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': nameProduct,
      // 'description': descriptionProduct,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String nameProduct;
  final String descriptionProduct;

  // final String image;

  Album({this.nameProduct, this.descriptionProduct});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      nameProduct: json['name'],
      descriptionProduct: json['description'],
    );
  }
}
