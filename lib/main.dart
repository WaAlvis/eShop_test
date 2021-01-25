import 'package:e_shop_test/screens/detail_product_screen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        DetailProductScreen.id: (contex) => DetailProductScreen(),
        // TestPostPage.id: (context) => TestPostPage(), //Page for POST Example
        // TestGetPage.id: (context) => TestGetPage(), //Page for GET Example
        // LoadingScreen.id:(context)=>LoadingScreen(),
      },
    );
  }
}
