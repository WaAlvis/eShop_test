import 'dart:io';

import 'package:e_shop_test/services/get_networking.dart';
import 'package:flutter/material.dart';

class DetailProductScreen extends StatefulWidget {
  static String id = 'detail_screen';
  final ProductModel dataProduct;


  const DetailProductScreen({Key key, this.dataProduct}) : super(key: key);



  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Detalles del producto'),
            Spacer(),
            Builder(
              builder: (context) => GestureDetector(
                  child: isFavorite == false ? Icon(Icons.star_border) : Icon(Icons.star),
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: isFavorite == false
                          ? Row(
                        children: [
                          Icon(Icons.star),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Agregado a Favoritos!!')
                        ],
                      )
                          : Text('Quitado de las lista de Favoritos'),
                    ));
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  }),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30, bottom: 20),
                child: Text(
                  'Lista de productos',
                  style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              widget.dataProduct.imageProduct,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.dataProduct.descriptionProduct,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.dataProduct.nameProduct,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}
