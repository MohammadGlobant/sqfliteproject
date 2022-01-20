part of 'sqflite_cubit.dart';

@immutable
abstract class SqfliteState {}

class SqfliteInitial extends SqfliteState {}

class CreateDataBasestate extends SqfliteState {}

class AddToDataBasestate extends SqfliteState {}

class getAllfromDataBasestate extends SqfliteState {}
