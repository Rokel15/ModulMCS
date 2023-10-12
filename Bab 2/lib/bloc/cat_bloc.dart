import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc() : super(CatInitial()) {
    on<CatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
