import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestPostPage extends StatefulWidget {
  static String id = 'test_Post_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TestPostPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  Future<Product> _futureAlbum;

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
              child: Column(
                children: [
                  TextField(
                    controller: _controllerName,
                    decoration: InputDecoration(hintText: 'Enter Name'),
                  ),
                  TextField(
                    controller: _controllerDescription,
                    decoration: InputDecoration(hintText: 'Enter Description'),
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Create Data'),
              onPressed: () {
                setState(() {
                  _futureAlbum =
                      createProduct(nameProduct: _controllerName.text, descriptionProduct: _controllerDescription.text);
                });
              },
            ),
          ],
        )
            : FutureBuilder<Product>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(snapshot.data.nameProduct),
                  Text(snapshot.data.descriptionProduct),
                ],
              );
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




Future<Product> createProduct({String nameProduct, String descriptionProduct}) async {
  final http.Response response = await http.post(
    'https://winkels-strapi.herokuapp.com/products',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': nameProduct,
      'description': descriptionProduct,
    }),
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Product {
  final String nameProduct;
  final String descriptionProduct;

  // final String image;

  Product({this.nameProduct, this.descriptionProduct});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nameProduct: json['name'],
      descriptionProduct: json['description'],
    );
  }
}