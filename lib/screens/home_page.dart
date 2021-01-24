import 'package:e_shop_test/utilies/custom_widgets/GridViewCustom.dart';
import 'package:e_shop_test/utilies/custom_widgets/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_test/services/get_networking.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool viewList = false;

  void changeShowElement() {
    setState(() {
      viewList = !viewList;
    });
  }

  Future<List<ProductModel>> getProductsData() async {
    return await fetchProducts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarCustom(
          onPressed: changeShowElement,
        ),
      ),
      body: FutureBuilder(
        future: getProductsData(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return viewList == true
                ? GridViewCustom(
                    dataUrl: snapshot,
                  )
                : Center(child: Text('data'));
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
