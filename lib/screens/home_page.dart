import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchPhotos(http.Client()),
        builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.data is List<Photo>) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return Text(snapshot.data[Index].description);
                });
          } else {
            return Center(
              child: Text('Error no hay informacion'),
            );
          }
        },
      ),
    );
  }
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('https://winkels-strapi.herokuapp.com/products');

  return compute(parsePhotos, response.body);
}

class Photo {
  final String name;
  final String description;

  Photo({ this.name, this.description});

  factory Photo.fromJson(Map<String, String> json) {
    String imageUrl;
    var imagesJson = json['image'] as Map<String, dynamic>;

    if (imagesJson != null) {
      imageUrl = imagesJson['name'] as String;
    } else {
      imageUrl = 'https://saveabandonedbabies.org/wp-content/uploads/2015/08/default.png';
    }

    return Photo(
      // image: imageUrl,
      name: json['name'],
      description: json['description'],
    );
  }
}
