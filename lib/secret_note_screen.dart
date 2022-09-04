
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mynote/add_note_screen.dart';
import 'package:mynote/boardscreen.dart';
import 'package:mynote/components.dart';
import 'package:mynote/cubit/cubit.dart';
import 'package:mynote/cubit/states.dart';
import 'package:mynote/localization/localization_methods.dart';
import 'package:mynote/search.dart';
import 'package:mynote/shared/shared_pref.dart';

class secretNoteScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var formKey2=GlobalKey<FormState>();
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var textController=TextEditingController();
  var oldPassController=TextEditingController();
  var newPassController=TextEditingController();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<appCubit,appState>(
     listener: (context, state) => (){},
     builder: (context, state)
     {
       var cubit=appCubit.get(context);
       return Scaffold(
         key: scaffoldKey,
         appBar: AppBar(
           title: Text(
             getTranslated(context, 'secret')!,
             style:const TextStyle(fontWeight: FontWeight.bold) ,
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
                     DropdownMenuItem(
                       value: 'password',
                       child: Text(
                        getTranslated(context,'password')!,
                         style:const TextStyle(color: Colors.black,),
                       ),
                     ),
                   ],
                   onChanged: (value){
                     if(value=='delete') {
                        appCubit
                            .get(context)
                            .deleteAllFromDatabase(type: 'secret');
                      }
                      if(value=='password') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    getTranslated(context, 'change_password')!),
                                content: Form(
                                  key: formKey2,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          obscureText: cubit.isPass,
                                          controller: oldPassController,
                                          decoration: InputDecoration(
                                            labelText: getTranslated( context, 'old_password')!,
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                cubit.showPassword();
                                              },
                                              icon: Icon(
                                                cubit.isPass
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value !=
                                                sharedPref.getString(
                                                    key: 'pass')) {
                                              return getTranslated(
                                                  context, 'wrong_password')!;
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          obscureText: cubit.isPass,
                                          controller: newPassController,
                                          decoration: InputDecoration(
                                            labelText: getTranslated(
                                                context, 'new_password')!,
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                cubit.showPassword();
                                              },
                                              icon: Icon(
                                                cubit.isPass
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
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
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (formKey2.currentState!.validate()) {
                                        sharedPref
                                            .saveString(
                                                key: 'pass',
                                                value: newPassController.text)
                                            .then((value) {
                                          //passWord=newPassController.text;
                                          Navigator.pop(context);
                                          oldPassController.clear();
                                          newPassController.clear();
                                        });
                                      }
                                    },
                                    child: Text(
                                      getTranslated(context, 'ok')!,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      oldPassController.clear();
                                      newPassController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      getTranslated(context, 'cancel')!,
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    }
               ),
             ),
           ],
         ),
         body: cubit.secretNotes.length>0?
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: InkWell(
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.grey[300],
                     borderRadius: BorderRadius.circular(15.0),
                   ),
                   child: Padding(
                     padding: const EdgeInsetsDirectional.only(start: 5.0),
                     child: Row(
                       children: [
                         const Icon(Icons.search),
                         const SizedBox(width: 20.0,),
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
                 onTap: (){
                   showSearch(context: context, delegate: noteSearchDelegate(list: cubit.secretNotes));
                 },
               ),
             ),
             Expanded(
               child: ListView.builder(
                 itemBuilder: (context, index) => itemBuilder(notes: cubit.secretNotes[index],context: context),
                 itemCount:cubit.secretNotes.length ,
               ),
             ),
           ],
         )
         :const boardScreen(),
         floatingActionButton:FloatingActionButton(
           backgroundColor:Colors.deepOrange[400],// HexColor('6F80D4'),
           tooltip: getTranslated(context, 'add_note')!,
           onPressed: (){
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => addNoteScreen(noteType: 'secret'),),
             );
           },
           child: cubit.fabIcon,
         ),
       );
     },
   );
  }
}
