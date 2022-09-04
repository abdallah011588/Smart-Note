import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mynote/components.dart';
import 'package:mynote/cubit/cubit.dart';
import 'package:mynote/cubit/states.dart';

 /// My costumed way to search
class searchScreen extends StatelessWidget {
  var searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<appCubit,appState>(
      listener: (context, state) => {},
      builder:(context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5.0),
                      child:TextFormField(
                        decoration: const InputDecoration(
                          label: Text('بحث'),
                          prefix: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        //controller: searchcontroller,
                        onChanged: (value){
                          appCubit.get(context).searchNotes(value);
                        },
                        keyboardType: TextInputType.text,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                 /*  appCubit.get(context).searchnotes.length>0?*/
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => itemBuilder(notes: appCubit.get(context).searchedNotes[index],context: context),
                    itemCount:appCubit.get(context).searchedNotes.length ,
                    physics:const NeverScrollableScrollPhysics(),
                  ),//:Center(child: Text('not found')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Search Delegate *
class noteSearchDelegate extends SearchDelegate{

  final List<Map> list;
  noteSearchDelegate({required this.list,});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query='';
        },
        icon:const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, 'Close');
      },
      icon:const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map> resultList = query.isEmpty? []
    : list.where((element) => element['note'].contains(query)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.separated(

        itemBuilder: (context, index)
        {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: itemBuilder(notes: resultList[index], context: context),
          );
        },
        separatorBuilder:(context, index)=> Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,),
          child: Container(
            height: 1,
            width: double.infinity,
            color:Colors.grey[300],
          ),
        ),
        itemCount: resultList.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<Map> searchList = query.isEmpty? []
        : list.where((element) => element['note'].contains(query)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.separated(
        itemBuilder: (context, index)
        {
          return itemBuilder(notes: searchList[index], context: context);
        },
        separatorBuilder:(context, index)=> Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,),
          child: Container(
            height: 1,
            width: double.infinity,
            color:Colors.grey[300],
          ),
        ),
        itemCount: searchList.length,
      ),
    );
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme:const InputDecorationTheme(
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color:Colors.black,
        ),
        border: InputBorder.none,
      ),
      textTheme:const TextTheme(
          subtitle1: TextStyle(
            color:Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 2,
        backgroundColor:HexColor('5F84D2'),
        iconTheme:const IconThemeData(
          color: Colors.white
        )
      )
    );
  }

}
