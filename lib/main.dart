import 'package:e_shop_test/getData/get_data_products_Example.dart';
import 'package:e_shop_test/getData/post_data_product_example.dart';
import 'package:e_shop_test/screens/home_page.dart';
import 'package:e_shop_test/screens/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoadingPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LoadingPage.id: (context) => LoadingPage(),
        TestPostPage.id: (context) => TestPostPage(), //Page for POST Example
        TestGetPage.id: (context) => TestGetPage(), //Page for GET Example
        // LoadingScreen.id:(context)=>LoadingScreen(),
      },
    );
  }
}
