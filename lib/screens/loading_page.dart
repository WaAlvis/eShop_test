import 'package:e_shop_test/services/get_networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: product.fetchProducts(http.Client()),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
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
    ),);
  }


  void getProductsData(BuildContext context) async {
    ProductModel product = ProductModel('https://winkels-strapi.herokuapp.com/products');


    Future<List<ProductModel>> productsFetch = product.fetchProducts(http.Client());
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage(dataProducts: ,);
    }
    ));
  }
}
