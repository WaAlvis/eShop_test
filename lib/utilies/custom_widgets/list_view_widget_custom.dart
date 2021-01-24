import 'dart:math';

import 'package:e_shop_test/services/get_networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListViewWidgetCustom extends StatelessWidget {
  final AsyncSnapshot<List<ProductModel>> dataUrl;

  ListViewWidgetCustom({
    Key key,
    this.dataUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataUrl.data.length,
      itemBuilder: (BuildContext ctxt, int Index) {
        return Card(
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  dataUrl.data[Index].image,
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
                      dataUrl.data[Index].productName,
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
  }
}

rateRandom() {
  Random rnd = new Random();
  return 1 + rnd.nextDouble() * 4;
}
