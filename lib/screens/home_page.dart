import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    createAlbum()
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hla mundo'),
      ),
    );
  }
}

Future<http.Response> createAlbum({String nameProduct, String descriptionProduct}) {
  return http.post(
    'https://winkels-strapi.herokuapp.com/products',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': nameProduct,
      'description': descriptionProduct,
    }),
  );
}

class Album {
  final String productName;
  final String descriptionProduct;
  final String imageProductURL;

  Album({this.productName, this.descriptionProduct, this.imageProductURL});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      productName: json['name'],
      descriptionProduct: json['description'],
      imageProductURL: json['image']['name'],
    );
  }
}
