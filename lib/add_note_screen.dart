
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynote/cubit/cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mynote/localization/localization_methods.dart';

class addNoteScreen extends StatelessWidget {

  final String noteType ;

  addNoteScreen({required this.noteType});
  var formKey=GlobalKey<FormState>();
  var noteController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    var cubit=appCubit.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title:Text(
            intl.DateFormat('yyyy-MM-dd – kk:mm a').format(DateTime.now()),
            style:const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions:[
            IconButton(
              icon:const Icon(Icons.add),
              onPressed: (){
                   if(formKey.currentState!.validate())
                    {
                      cubit.insertIntoDatabase(
                        text: noteController.text,
                        noteDate: intl.DateFormat('yyyy-MM-dd – kk:mm a').format(DateTime.now()),
                        noteType: noteType,
                      );
                      Navigator.pop(context);
                    }
                    else {
                      Fluttertoast.showToast(
                        msg: getTranslated(context, 'empty_note')!,
                        toastLength:Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 5,
                        textColor: Colors.white,
                        backgroundColor: Colors.red,
                        fontSize: 15.0,
                      );
                    }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child:  Form(
            key: formKey,
            child: TextFormField(
              controller: noteController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 0),
                hintText: getTranslated(context, 'take_note')!,
              ),
              validator: (value){
                if(value!.isEmpty)
                {
                  return '';
                }
              },
              expands: true,
              minLines: null,
              maxLines: null,
              //  maxLines: 10,
            ),
          ),
        ),
      ),
    );
  }
}
