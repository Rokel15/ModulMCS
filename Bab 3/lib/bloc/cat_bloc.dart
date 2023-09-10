import 'package:bloc/bloc.dart';
import 'package:mcs_bab_2/data/cats_data.dart';
import 'package:mcs_bab_2/models/cat.dart';
import 'package:meta/meta.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc() : super(CatInitial()) {
    on<OnCatEventCalled>((event, emit) async {
      emit(CatLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(CatLoaded(catsData));
    });
  }
}
