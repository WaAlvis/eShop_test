import 'package:flutter/material.dart';
import 'package:e_shop_test/services/get_networking.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  static String id = 'home_screen';

  Future<List<Product>> getProductsData() async {
    return await fetchProducts(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            // child: viewList == false ? Icon(Icons.list) : Icon(Icons.grid_view),
            // onTap: () {
            //   viewList = !viewList;
            //   changeMode();
            // }
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('e-Shop'),
            Spacer(),
            Icon(Icons.shopping_cart_rounded),
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
      body: FutureBuilder(
        future: getProductsData(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return
              GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                ),
                itemBuilder: (BuildContext context, int Index){
                  return Image.network(snapshot.data[Index].image);
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
