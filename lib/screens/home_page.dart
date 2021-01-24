import 'package:flutter/material.dart';
import 'package:e_shop_test/services/get_networking.dart';


class HomePage extends StatelessWidget {
   final dataProducts;
  static String id = 'home_screen';

  const HomePage({Key key, this.dataProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dataProducts,
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
      ),
    );
  }
}
