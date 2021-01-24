import 'package:e_shop_test/utilies/custom_widgets/grid_view_widget_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/app_bar_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/list_view_widget_custom.dart';
import 'package:e_shop_test/utilies/product_model.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

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
          _openPopup(context);
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
        ],
      ),
    );
  }
}

_openPopup(context) {
  Alert(
      context: context,
      title: "LOGIN",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Username',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}



