import 'package:equatable/equatable.dart';
import 'package:e_shop_test/utilies/product_model.dart';



abstract class ProductsState extends Equatable {}

class InitialState extends ProductsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ProductsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends ProductsState {
  LoadedState(this.movies);

  final List<ProductModel> movies;

  @override
  List<Object> get props => [movies];
}

class ErrorState extends ProductsState {
  @override
  List<Object> get props => [];
}
