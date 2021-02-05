import 'dart:math';
import 'package:e_shop_test/screens/detail_product_screen.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../product_model.dart';

class ListViewWidgetCustom extends StatelessWidget {
  final List<ProductModel> productList;

  ListViewWidgetCustom({
    Key key,
    this.productList,
  }) : super(key: key);

  final ProductModel productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        String imageProduct = productModel.getImageProd(productList, index);
        String nameProduct = productModel.getNameProd(productList, index);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailProductScreen(
                    dataProduct: productList[index],
                  );
                },
              ),
            );
          },
          child: Card(
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    imageProduct,
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
                        nameProduct,
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
                        itemBuilder: (context, i) => Icon(
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
          ),
        );
      },
    );
  }
}

rateRandom() {
  Random rnd = new Random();
  return 1 + rnd.nextDouble() * 4;
}
