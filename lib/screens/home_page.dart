import 'package:dio/dio.dart';
import 'package:e_shop_test/utilies/custom_widgets/grid_view_widget_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/app_bar_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/list_view_widget_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/pop_up_package.dart';
import 'package:e_shop_test/utilies/product_model.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool viewList = false;
  bool productCreated = false;

  void changeShowElement() {
    setState(() {
      viewList = !viewList;
    });
  }

  Future<List<ProductModel>> getProductsData() async {

    ProductRepository productRepository = ProductRepository(Dio());
    return await productRepository.fetchProducts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarCustom(
          viewList: viewList,
          onPressed: changeShowElement,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openPopup(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getProductsData(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return viewList == true
                ? GridViewWidgetCustom(
                    dataUrl: snapshot,
                  )
                : ListViewWidgetCustom(
                    dataUrl: snapshot,
                  );
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
