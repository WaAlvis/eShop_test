import 'package:e_shop_test/screens/detail_product_screen.dart';
import 'package:flutter/material.dart';

import '../product_model.dart';

class GridViewWidgetCustom extends StatelessWidget {
  GridViewWidgetCustom({
    this.productList,
    Key key,
  }) : super(key: key);

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) {
        String imageUrl = getImageProd(productList: productList, i: index);
        String nameUrl = getNameProd(productList: productList, i: index);

        if (productList.elementAt(index)?.nameProduct == null) {
          nameUrl = 'Nombre del Producto';
        }

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
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    productList[index].nameProduct ?? nameUrl,
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
