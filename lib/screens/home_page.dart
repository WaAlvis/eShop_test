import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
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

  // final String image;

  Album({this.productName, this.descriptionProduct});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      productName: json['name'],
      descriptionProduct: json['description'],
    );
  }
}
