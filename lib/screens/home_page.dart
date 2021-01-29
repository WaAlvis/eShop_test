import 'package:dio/dio.dart';
import 'package:e_shop_test/cubit/product_cubit.dart';
import 'package:e_shop_test/cubit/product_state.dart';
import 'package:e_shop_test/utilies/custom_widgets/grid_view_widget_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/app_bar_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/list_view_widget_custom.dart';
import 'package:e_shop_test/utilies/custom_widgets/pop_up_package.dart';
import 'package:e_shop_test/utilies/product_model.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool viewList = false;
  bool productCreated = false;

  void changeShowElement() {
    setState(() {
      viewList = !viewList;
    });
  }

  Future<List<ProductModel>> getProductsData() async {
    ProductRepository productRepository = ProductRepository(Dio());
    return await productRepository.fetchProducts(Dio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarCustom(
            viewList: viewList,
            onPressed: changeShowElement,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openPopup(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Icon(Icons.close),
              );
            }else if (state is LoadedState) {
              final products = state.products;

              return  ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(products[index].nameProduct),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(products[index].imageProduct),
                    ),
                  ),
                ),
              );
            }else {
              return Container();
            }
          },
        )

        // FutureBuilder(
        //   future: getProductsData(),
        //   builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return viewList == true
        //           ? GridViewWidgetCustom(
        //               dataUrl: snapshot,
        //             )
        //           : ListViewWidgetCustom(
        //               dataUrl: snapshot,
        //             );
        //     } else {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
        );
  }
}
