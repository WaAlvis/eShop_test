import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ProductModel {
  final String productName;
  String descriptionProduct;
  final String image;


  List<ProductModel> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> fetchProducts(http.Client client) async {
    final response = await client.get('https://winkels-strapi.herokuapp.com/products');

    return compute(parseProducts, response.body);
  }

  ProductModel({this.image, this.productName, this.descriptionProduct});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String imageUrl;
    Map<String, dynamic> imageJson = json['image'] as Map<String, dynamic>;

    if (imageJson != null) {
      imageUrl = imageJson['name'] as String;
    } else {
      imageUrl = 'https://bubbleerp.sysfosolutions.com/img/default-pro.jpg';
    }

    return ProductModel(
      image: imageUrl,
      productName: json['name'] as String,
      descriptionProduct: json['description'] as String ?? 'La descripcion de este producto no se encuentra temporalmente',
    );
  }
}
