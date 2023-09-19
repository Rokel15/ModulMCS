part of 'cat_bloc.dart';

@immutable
sealed class CatState {}

final class CatInitial extends CatState {}

final class CatLoading extends CatState {}

final class CatLoaded extends CatState {
  final List<Cat> result;

  CatLoaded(this.result);
}

final class CatLoadedGrid extends CatLoaded {
  CatLoadedGrid(List<Cat> result) : super(result);
}
