import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'sqflite_state.dart';

class SqfliteCubit extends Cubit<SqfliteState> {
  SqfliteCubit() : super(SqfliteInitial());

  late Database database;
  List<Map> listOfItems = [];

  static SqfliteCubit get(context) => BlocProvider.of(context);

  void createDB() {
    openDatabase(
        'sqflite_project.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE sqflite_table (id INTEGER PRIMARY KEY, name TEXT, age Text)'
          ).then((value) => {
          }).catchError((error){
            print('error ${error.tostring}');
          });
        },
        onOpen: (database){
          getDataFromDatabase(database).then((value){
            listOfItems = value;
            print(listOfItems);
            emit(getAllfromDataBasestate());
          });
          print('on open DB');
        }
    ).then((value){
      database = value;
      emit(CreateDataBasestate());
    });
  }

   insertToDB({required String name, required String age}) async {
     await database.transaction((txn) async {
      txn.rawInsert('INSERT INTO sqflite_table(name, age) VALUES("$name", "$age")').
      then((value){

        print('$value inserted successfully');
        emit(AddToDataBasestate());
        getDataFromDatabase(database).then((value){
          listOfItems = value;
          print(listOfItems);
          emit(getAllfromDataBasestate());
        });
      }).catchError((error){
        print('the error $error');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async{
    return await database.rawQuery('SELECT * FROM sqflite_table');
  }

}
