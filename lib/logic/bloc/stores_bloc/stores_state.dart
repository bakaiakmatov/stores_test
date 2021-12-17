part of 'stores_bloc.dart';

@immutable
abstract class StoresState {}

class StoresInitial extends StoresState {}

class StoresLoaded extends StoresState {
  final Category model;

  StoresLoaded({required this.model});
}

class StoresError extends StoresState {
  final CatchException mes;

  StoresError({required this.mes});
}
