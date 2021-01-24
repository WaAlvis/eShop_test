import 'package:e_shop_test/services/get_networking.dart';
import 'package:flutter/material.dart';

class GridViewCustom extends StatelessWidget {
  GridViewCustom({
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
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  dataUrl.data[Index].image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  dataUrl.data[Index].productName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  maxLines: 2,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
