import 'package:e_shop_test/utilies/custom_widgets/grid_view_widget_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/app_bar_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/list_view_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_test/services/get_networking.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  Future<ProductModel> _futureAlbum;
  bool viewList = false;

  void changeShowElement() {
    setState(() {
      viewList = !viewList;
    });
  }

  Future<List<ProductModel>> getProductsData() async {
    return await fetchProducts(http.Client());
  }

  postProductData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarCustom(
          onPressed: changeShowElement,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showMyDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: getProductsData(),
            builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return viewList == true
                    ? GridViewWidgetCustom(
                        dataUrl: snapshot,
                      )
                    : ListViewWidgetCustom(
                        dataUrl: snapshot,
                      );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
            color: Colors.orange,
            child: _futureAlbum == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _controllerName,
                              decoration: InputDecoration(hintText: 'Enter Name'),
                            ),
                            TextField(
                              controller: _controllerDescription,
                              decoration: InputDecoration(hintText: 'Enter Description'),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Create Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum = createProduct(
                                nameProduct: _controllerName.text, descriptionProduct: _controllerDescription.text);
                          });
                        },
                      ),
                    ],
                  )
                : FutureBuilder<ProductModel>(
                    future: _futureAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(snapshot.data.nameProduct),
                            Text(snapshot.data.descriptionProduct),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return CircularProgressIndicator();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


