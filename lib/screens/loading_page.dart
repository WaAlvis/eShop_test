import 'package:e_shop_test/services/get_networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class LoadingPage extends StatefulWidget {
  static String id = 'loading_screen';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getProductsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getProductsData() async {
    var  productsData = await ProductModel().fetchProducts(http.Client());
    print(productsData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage(
        dataProducts: productsData,
      );
    }));
  }
}
