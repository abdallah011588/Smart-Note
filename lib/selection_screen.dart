
/*

import 'package:flutter/material.dart';
import 'package:mynote/cubit/cubit.dart';

class MyHome_Page extends StatefulWidget {

 // MyHome_Page({required Key key,}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHome_Page> {

  bool selectMode = false;
  // Map<String, bool> listItemSelected = {
  //   'List 1': false,
  //   'List 2': false,
  //   'List 3': false,
  //   'List 4': false,
  //   'List 5': false,
  //   'List 6': false,
  //   'List 7': false,
  //   'List 8': false,
  //   'List 9': false,
  // };
  Map<Map, bool> listItemSelected={};

  @override
  Widget build(BuildContext context) {
    //listItemSelected.clear();
    // if(listItemSelected.isEmpty) {
    //   listItemSelected = appCubit.get(context).listItemSelected;
    // }
    // else
    //   {
    //  //   listItemSelected={};
    //     listItemSelected = appCubit.get(context).listItemSelected;
    //   }

   // listItemSelected = appCubit.get(context).listItemSelected;

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        actions: [
          IconButton(
            onPressed: (){
              appCubit.get(context).listItemSelected.forEach((key, value) {
                if(value)
                  {
                    setState(() {

                      appCubit.get(context).deleteFromDatabase(id: key['id']);
                    //  appCubit.get(context).listItemSelected.clear();

                    });
                  }

              });
              setState(() {
                selectMode=false;
                appCubit.get(context).notes.clear();
                appCubit.get(context).createDatabase();
                Navigator.pop(context);
                // listItemSelected=appCubit.get(context).listItemSelected;
              });
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: appCubit.get(context). listItemSelected.keys.map((key) {
            return Card(
              child: GestureDetector(
                onTap: () {
                  // if multi-select mode is true, tap should select List item
                  if (selectMode &&  appCubit.get(context).listItemSelected.containsValue(true)) {
                    debugPrint('onTap on ${key['note']}');
                    setState(() {
                      appCubit.get(context).listItemSelected[key] = ! appCubit.get(context).listItemSelected[key]!;
                    });
                  } else {
                    // Stop multi-select mode when there's no more selected List item
                    debugPrint('selectMode STOP');
                    selectMode = false;
                  }
                },
                // Start List multi-select mode on long press
                onLongPress: () {
                  debugPrint('onLongPress on $key');
                  if (!selectMode) {
                    debugPrint('selectMode START');
                    selectMode = true;
                  }
                  setState(() {
                    appCubit.get(context).listItemSelected[key] = ! appCubit.get(context).listItemSelected[key]!;
                  });
                },
                child: Container(
                  // Change List item color if selected
                  color: ( appCubit.get(context).listItemSelected[key]!) ? Colors.lightBlueAccent
                      : Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: Text(key['note']),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}





*/