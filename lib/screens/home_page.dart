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

  Future<List<Product>> getProductsData() async {
    return await fetchProducts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarCustom(
            onPressed: changeShowElement,
          )),
      body: FutureBuilder(
        future: getProductsData(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return viewList == true
                ? GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int Index) {
                      return Image.network(snapshot.data[Index].image);
                    },
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
