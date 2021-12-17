import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_2/helper/catch_exceptions.dart';
import 'package:test_2/logic/model/category.dart';
import 'package:test_2/logic/repository/repositore.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  final repository = Repository();

  StoresBloc() : super(StoresInitial()) {
    //
    on<EventStores>((event, emit) async {
      emit(StoresInitial());
      try {
        final model = await repository.getStores();
        emit(StoresLoaded(model: model));
      } on DioError catch (e) {
        emit(StoresError(mes: CatchException.convertException(e)));
      }
    });
  }
}
