import 'package:dio/dio.dart';
import 'package:e_shop_test/cubit/product_state.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({this.repository}) : super(InitialState()) {
    _getTrendingMovies();
  }

  final ProductRepository repository;

  void _getTrendingMovies() async {
    try {
      emit(LoadingState());
      final movies = await repository.fetchProducts(http.Client());
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
