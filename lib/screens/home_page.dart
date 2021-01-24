import 'dart:math';

import 'package:e_shop_test/utilies/custom_widgets/GridViewCustom.dart';
import 'package:e_shop_test/utilies/custom_widgets/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_test/services/get_networking.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctxt, int Index) {
                      return Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                snapshot.data[Index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    snapshot.data[Index].productName,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Free Shoping'),
                                  Align(
                                    child: Text(
                                      '\$ 2.323',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  RatingBarIndicator(
                                    rating: rateRandom(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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

rateRandom() {
  Random rnd = new Random();
  return 1 + rnd.nextDouble() * 4;
}
