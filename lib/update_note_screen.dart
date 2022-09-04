import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynote/cubit/cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mynote/localization/localization_methods.dart';

class updateNoteScreen extends StatelessWidget {

  final String noteText;
  final int noteId;
  updateNoteScreen({
    required this.noteText,
    required this.noteId,
  });

  var formKey=GlobalKey<FormState>();
  var noteController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    noteController.text=noteText;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title:Text(
          intl.DateFormat('yyyy-MM-dd – kk:mm a').format(DateTime.now()),
          style:const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions:[
          TextButton(
            child: Text( getTranslated(context, 'update_note')!,style: TextStyle(color: Colors.blue[200]),),
            onPressed: (){
                 if(formKey.currentState!.validate())
                  {
                    appCubit.get(context).updateDatabase(id:  noteId, text: noteController.text);
                    //noteDate: '${intl.DateFormat('yyyy-MM-dd – kk:mm a').format(DateTime.now())}',
                    Navigator.pop(context);
                  }
                  else {
                    Fluttertoast.showToast(
                      msg:getTranslated(context, 'empty_note')!,
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
             // contentPadding:
             // EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 0),
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
    );
  }
}
