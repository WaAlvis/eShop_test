import 'package:e_shop_test/screens/detail_product_screen.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter/material.dart';

import '../product_model.dart';

class GridViewWidgetCustom extends StatelessWidget {
  GridViewWidgetCustom({
    this.dataUrl,
    Key key,
  }) : super(key: key);

  final AsyncSnapshot<List<ProductModel>> dataUrl;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: dataUrl.data.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int Index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailProductScreen(
                    dataProduct: dataUrl.data[Index],
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
                    dataUrl.data[Index].imageProduct,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataUrl.data[Index].nameProduct,
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
