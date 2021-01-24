import 'package:flutter/material.dart';
import 'package:e_shop_test/services/get_networking.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  static String id = 'home_screen';

  Future<List<Product>> getProductsData() async {
    return await fetchProducts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductsData(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int Index) {
                  return Image.network(snapshot.data[Index].image);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
