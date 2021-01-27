import 'package:dio/dio.dart';
import 'package:e_shop_test/cubit/product_state.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({this.repository}) : super(InitialState()) {
    _getProducts();
  }

  final ProductRepository repository;

  void _getProducts() async {
    try {
      emit(LoadingState());
      final products = await repository.fetchProducts(http.Client());
      emit(LoadedState(products));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
