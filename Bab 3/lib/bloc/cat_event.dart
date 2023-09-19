part of 'cat_bloc.dart';

@immutable
sealed class CatEvent {}

class OnCatEventCalled extends CatEvent {}
