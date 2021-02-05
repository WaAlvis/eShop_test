import 'package:e_shop_test/screens/detail_product_screen.dart';
import 'package:flutter/material.dart';

import '../product_model.dart';

class GridViewWidgetCustom extends StatelessWidget {
  GridViewWidgetCustom({
    this.productList,
    Key key,
  }) : super(key: key);

  final ProductModel productModel = ProductModel();

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    imageProduct,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    productList[index].nameProduct ?? nameProduct,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
