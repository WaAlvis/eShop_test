import 'package:dio/dio.dart';
import 'package:e_shop_test/utilies/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductRepository{
ProductRepository(this.client);

final Dio client;

Future<ProductModel> createProduct({String nameProduct, String descriptionProduct}) async {
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
  if (response.statusCode == 201 || response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return ProductModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

List<ProductModel> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
}

Future<List<ProductModel>> fetchProducts(http.Client client) async {
  final response = await client.get('https://winkels-strapi.herokuapp.com/products');

  return compute(parseProducts, response.body);
}}