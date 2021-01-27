import 'package:e_shop_test/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WeatherCubit extends Cubit<ProductsState> {
  WeatherCubit() : super(InitialState());
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({this.repository}) : super(InitialState()) {
    _getTrendingMovies();
  }

  final MovieRepository repository;

  void _getTrendingMovies() async {
    try {
      emit(LoadingState());
      final movies = await repository.getMovies();
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}