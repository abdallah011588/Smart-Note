import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mynote/add_note_screen.dart';
import 'package:mynote/boardscreen.dart';
import 'package:mynote/components.dart';
import 'package:mynote/cubit/cubit.dart';
import 'package:mynote/cubit/states.dart';
import 'package:mynote/lang_models/language.dart';
import 'package:mynote/localization/localization_methods.dart';
import 'package:mynote/main.dart';
import 'package:mynote/search.dart';
import 'package:mynote/secret_note_screen.dart';
import 'package:mynote/shared/shared_pref.dart';

class NoteScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var passController = TextEditingController();
  String? pass;
  List<Language> langs= Language.languageList();

  // var scaffoldKey = GlobalKey<ScaffoldState>();
  // var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appState>(
     listener: (context, state) => () {},
     builder: (context, state) {
       pass = sharedPref.getString(key: 'pass');
       var cubit = appCubit.get(context);
      return Scaffold(
        // key: scaffoldKey,
         appBar: AppBar(
           title:  Text(
             getTranslated(context, 'notes')!,
             style:const TextStyle(fontWeight: FontWeight.bold),
           ),
           titleSpacing: 0,
           actions: [
               Padding(
               padding:const EdgeInsets.all(15),
                child: DropdownButton(
                   underline:const SizedBox(),
                   icon:const Icon(
                     Icons.more_vert,
                     color:Colors.white,
                   ),
                   items: [
                      DropdownMenuItem(
                       value: 'delete',
                       child: Text(
                         getTranslated(context,'delete_all')!,
                       style:const TextStyle(color: Colors.black,),
                     ),
                   ),
                   ],
                   onChanged: (value){
                    appCubit.get(context).deleteAllFromDatabase(type: 'normal');
                   }
               ),
             ),
           ],
          ),
        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Image(
                  image: AssetImage('assets/icon/noteboard.jpg'),
                 // alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading:const Icon(Icons.folder_special_outlined),
                iconColor: HexColor('6F80D4'),
                title:  Text(
                  getTranslated(context, 'secret')!,
                  style:const TextStyle(fontSize: 18),
                ),
                onTap: () {
                  if(pass != null)
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text( getTranslated(context, 'password')!),
                            content: Form(
                              key: formKey,
                              child: TextFormField(
                                obscureText: cubit.isPass,
                                controller: passController,
                                decoration: InputDecoration(
                                  hintText: getTranslated(context, 'password')!,
                                  border:const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.showPassword();
                                    },
                                    icon: Icon(
                                      cubit.isPass
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                ),
                                validator: (value){
                                  if(value!=sharedPref.getString(key: 'pass'))
                                  {
                                    return getTranslated(context, 'wrong_password')!;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                  {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          secretNoteScreen(),
                                        ));
                                  }
                                  passController.clear();
                                },
                                child: Text(getTranslated(context, 'ok')!),
                              ),
                              TextButton(
                                onPressed: () {
                                  passController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(getTranslated(context, 'cancel')!),
                              ),
                            ],
                          );
                        });
                  }
                  else
                  {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(getTranslated(context, 'create_password')!),
                            content: SingleChildScrollView(
                              child: Form(
                                key: formKey2,
                                child: TextFormField(
                                  obscureText: cubit.isPass,
                                  controller: passController,
                                  decoration: InputDecoration(
                                    hintText: getTranslated(context, 'password')!,
                                    border:const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.showPassword();
                                      },
                                      icon: Icon(
                                        cubit.isPass ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return getTranslated(context, 'empty_password')!;
                                    } else if (value.length < 5) {
                                      return getTranslated(context, 'short_password')!;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (formKey2.currentState!.validate()) {
                                    sharedPref.saveString(key: 'pass', value: passController.text)
                                        .then((value) {
                                      //passWord=passController.text;
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                secretNoteScreen(),
                                          ));
                                      passController.clear();
                                    });
                                  }
                                },
                                child: Text( getTranslated(context, 'ok')!,),
                              ),
                              TextButton(
                                onPressed: () {
                                  passController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(getTranslated(context, 'cancel')!,),
                              ),
                            ],
                          );
                        });
                  }
                },
              ),
              ExpansionTile(
                title: Text(
                  getTranslated(context,'language')!,
                  style:const TextStyle(fontSize: 18),
                ),
                leading: Icon(Icons.language,color: HexColor('6F80D4'),),
                children: [
                  RadioListTile(
                    value: '1',
                    title:const Text('Arabic'),
                    subtitle: Text(langs[1].flag),
                    groupValue:appCubit.get(context).groupValue ,
                    onChanged: (value1){
                      sharedPref.saveString(key: 'currentLang', value: value1.toString()).then((value) {
                        appCubit.get(context).changeLanguage(value1.toString());
                        _changeLanguage(langs[1] , context);
                        Navigator.pop(context);
                      });
                    },
                  ),
                  RadioListTile(
                    value:'2',
                    groupValue: appCubit.get(context).groupValue,
                    title:const Text('English'),
                    subtitle: Text(langs[0].flag),
                    onChanged: (value1){
                   sharedPref.saveString(key: 'currentLang', value: value1.toString()).then((value) {
                   appCubit.get(context).changeLanguage(value1.toString());
                   _changeLanguage(langs[0] , context);
                    Navigator.pop(context);
                   });
                 },
                  ),
                ],
              ),
              ListTile(
                leading:const Icon(Icons.share_outlined),
                iconColor: HexColor('6F80D4'),
                title:  Text(
                  getTranslated(context, 'share')!,
                  style:const TextStyle(fontSize: 18),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
         body: cubit.notes.length > 0 ? Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: InkWell(
                 onTap: () {
                   showSearch(
                       context: context,
                       delegate: noteSearchDelegate(list: cubit.notes));
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),));
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.grey[300],
                     borderRadius: BorderRadius.circular(15.0),
                   ),
                   child: Padding(
                     padding:
                     const EdgeInsetsDirectional.only(start: 5.0),
                     child: Row(
                       children: [
                         const Icon(Icons.search),
                         const SizedBox(
                           width: 20.0,
                         ),
                          Text(
                           getTranslated(context, 'search')!,
                           style:const TextStyle(fontSize: 18.0),
                         ),
                       ],
                     ),
                   ),
                   width: double.infinity,
                   height: 50.0,
                 ),
               ),
             ),
             Expanded(
               child: ListView.separated(
                 itemBuilder: (context, index) => itemBuilder(
                     notes: cubit.notes[index], context: context
                 ),
                 separatorBuilder:(context, index)=> Padding(
                   padding: const EdgeInsets.symmetric(vertical: 5.0,),
                   child: Container(
                     height: 1,
                     width: double.infinity,
                     color:Colors.grey[300],
                   ),
                 ),
                 itemCount: cubit.notes.length,
               ),
             ),
           ],
         )
       : const boardScreen(),
       floatingActionButton: FloatingActionButton(
           backgroundColor: Colors.deepOrange[400],//HexColor('6F80D4'),
           tooltip: getTranslated(context, 'add_note')!,
           onPressed: () {
             Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => addNoteScreen(noteType: 'normal'),
                 ),
             );
             /// Another Way To Add Note By Using BottomSheet
             /*
                  if(cubit.isshown)
                  {
                    if(formkey.currentState!.validate())
                    {
                      cubit.changefabicon(icon: Icon(Icons.edit), shown: false);
                      cubit.insertIntoDatabase(text: textcontroller.text);
                      Navigator.pop(context);
                      //  print('closed');
                      //  isshown=false;
                      // fabicon=Icon(Icons.edit);
                    }
                  }
                  else
                  {
                    cubit.changefabicon(icon: Icon(Icons.add), shown: true);
                    //  isshown=true;
                    // fabicon=Icon(Icons.add);
                    scafoldkey.currentState!.showBottomSheet((context)
                    {
                      return Form(
                        key: formkey,
                        child: Container(
                          height: 400.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextFormField(
                              ///decoration: InputDecoration(),
                              validator: (value) {
                                if(value!.isEmpty)
                                {
                                  return 'Note is empty';
                                }
                              },
                              maxLines: 10,
                              keyboardType: TextInputType.text,
                              controller: textcontroller,
                            ),
                          ),
                        ),
                      );
                    }).closed.then((value) {
                      cubit.changefabicon(icon: Icon(Icons.edit), shown: false);

                    });
                  }
              */
           },
           child:const Icon(Icons.edit),//cubit.fabIcon,
         ),
       );
     },
    );
  }
}


void _changeLanguage(Language lang ,context) async
{
  Locale _temp = await setLocale(lang.languageCode);
  MyApp.setLocale( context, _temp);
}