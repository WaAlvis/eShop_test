import 'package:dio/dio.dart';
import 'package:e_shop_test/cubit/product_state.dart';
import 'package:e_shop_test/services/networking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WeatherCubit extends Cubit<ProductsState> {
  WeatherCubit() : super(InitialState());
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({this.repository}) : super(InitialState()) {
    _getTrendingMovies();
  }

  final ProductRepository repository;

  void _getTrendingMovies() async {
    try {
      emit(LoadingState());
      final movies = await repository.fetchProducts(Dio());
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}