import 'package:e_shop_test/getData/post_data_product.dart';
import 'package:e_shop_test/screens/home_page.dart';
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
      initialRoute: TestPostPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        TestPostPage.id: (context) => TestPostPage(), //Page for Post Example
        // LoadingScreen.id:(context)=>LoadingScreen(),
      },
    );
  }
}
