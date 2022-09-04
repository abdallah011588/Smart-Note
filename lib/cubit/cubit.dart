import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/cubit/states.dart';
import 'package:mynote/shared/shared_pref.dart';
import 'package:sqflite/sqflite.dart';

class appCubit extends Cubit<appState>{
  appCubit() : super(initialState());


  Icon fabIcon=const Icon(Icons.edit);
  bool isShown=false;
  bool isPass=true;

  List<Map> notes=[];
 // Map<String, bool> listItemSelected={};
//  Map<Map, bool> listItemSelected={};
  List<Map> secretNotes=[];
  List<Map> searchedNotes=[];
  late Database database;

  String groupValue =sharedPref.getString(key: 'currentLang') ??'2';

  static appCubit get(context) => BlocProvider.of(context);

  void changeFabIcon({
    required Icon icon,
    required bool shown,
  })
  {
    isShown=shown ;
    fabIcon=icon ;
    emit(appClosebottomsheetState());
  }

  void showPassword()
  {
    isPass=!isPass;
    emit(showPasswordState());
  }


  void changeLanguage(String groupV,)
  {
    groupValue=groupV;
    emit(showPasswordState());
  }


  void searchNotes(String value)
  {
    //searchnotes.clear();
    database.rawQuery("SELECT * FROM note WHERE note LIKE '%$value%' ").then((value){
      searchedNotes=value;
      emit(appsearchSuccessbaseState());
    }).catchError((onError){
      emit(appsearchErrorDatabaseState());
    });
  }


   /// /////////////////////////////
   /// LOCAL DATABASE FOR NOTES ////
   /// /////////////////////////////

  void createDatabase()
  {
     openDatabase(
      'mynote.db',
      version: 1,
      onCreate: (database,version){
      database.execute('CREATE TABLE note (id INTEGER PRIMARY KEY ,note TEXT,notedate TEXT ,type TEXT)').then((value){
        getFromDatabase(database);
      });
     },
     onOpen: (database){
        getFromDatabase(database);
      },
     ).then((value) {
       database=value;
       emit(appcreateDatabaseState());
     });
  }

  void insertIntoDatabase({
    required String text,
    required String noteDate,
    required String noteType,
  }){
    database.transaction( (txn) {
      return txn.rawInsert('INSERT INTO note(note ,notedate ,type) VALUES ( "$text","$noteDate", "$noteType" )')
      .then( (value)
      {
        getFromDatabase(database);
        emit(appInsertDatabaseState());
      });
    });
  }

  void getFromDatabase(database)
  {
    notes=[];
    secretNotes=[];
  //  listItemSelected.clear();

     database.rawQuery('SELECT * FROM note').then((value) {
       value.forEach((element){
         if(element['type']=='normal')
           {
             notes.add(element);
           //  listItemSelected.addAll({element:false});
           }
         else
           {
             secretNotes.add(element);
           }
       });
       //notes=  value;
       emit(appGetfromDatabaseState());
    });
  }

  void deleteFromDatabase({required int id})
  {
    database.rawDelete('DELETE FROM note WHERE id=? ', [id] ).then((value) {
      getFromDatabase(database);
      emit(appDeleteDatabaseState());
    });
  }

  void deleteAllFromDatabase({required String type})
  {
    database.rawDelete('DELETE FROM note WHERE type=? ', [type] ).then((value) {
      getFromDatabase(database);
      emit(appDeleteDatabaseState());
    });
  }

  void updateDatabase({required int id,required String text})
  {
    database.rawUpdate("UPDATE note set note ='$text' Where id=? ",[id]).then((value){
      getFromDatabase(database);
      emit(appUpdateDatabaseState());
    });
  }


}

/*
  void alterTable() async {
      await database.execute("ALTER TABLE note ADD notedate TEXT");
    }

 */
/*
  Future<dynamic> alterTable(String TableName, String ColumneName) async {
    var dbClient = await database;
    var count = await dbClient.execute("ALTER TABLE $TableName ADD "
        "COLUMN $ColumneName TEXT;");
    //print(await dbClient.query(TABLE_CUSTOMER));
    return count;
  }*/
/*
              onChanged: (String text) async {
                 List<Map> res = await database.rawQuery(
                  "SELECT * FROM sentences WHERE title LIKE '%${text}%' OR  body LIKE '%${text}%'");
 */