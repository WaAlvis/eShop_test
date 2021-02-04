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
          } else if (state is LoadedState) {
            final products = state.products;
            return viewList == true
                ? GridViewWidgetCustom(
                    productList: products,
                  )
                : ListViewWidgetCustom(
                    dataUrl: products,
                  );
            // Text(products[0].nameProduct);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
