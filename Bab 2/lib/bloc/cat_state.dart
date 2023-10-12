part of 'cat_bloc.dart';

@immutable
abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {}
