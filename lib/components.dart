
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:intl/intl.dart' as intl;
import 'package:mynote/cubit/cubit.dart';
import 'package:mynote/localization/localization_methods.dart';
import 'package:mynote/show_note.dart';
import 'package:mynote/update_note_screen.dart';


Widget itemBuilder( {required Map notes,required BuildContext context})
{
 // DateTime date=DateTime.now();
 // String noteDate=intl.DateFormat('yyyy-MM-dd – kk:mm a').format(date);
  return Dismissible(
    key: UniqueKey(),
    background: Container(
      color: HexColor('FF0000'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Icon(Icons.delete),
                  ),
                  Text(getTranslated(context,'delete')!),
                ],
              ),
            Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(getTranslated(context,'delete')!),
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
    appCubit.get(context).deleteFromDatabase(id: notes['id']);
    },
    child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowNote(noteText:notes['note']),),
            );
          },
            /*
          onLongPress: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => updateNoteScreen(
                      noteText:notes['note'],
                      noteId: notes['id'],
                  ),
                ),
            );
          },*/
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor:Colors.grey ,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => updateNoteScreen(
                                  noteText:notes['note'],
                                  noteId: notes['id'],
                                ),
                              ),
                            );
                        },
                            icon:const Icon(Icons.update),
                            label: Text(getTranslated(context,'update_note')!),
                        ),
                         ElevatedButton.icon(
                           onPressed: (){
                             appCubit.get(context).deleteFromDatabase(id: notes['id']);
                           },
                            icon:const Icon(Icons.delete),
                            label: Text(getTranslated(context,'delete')!),
                        ),

                      ],
                    ),
                ),
            );
          },
          onDoubleTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => updateNoteScreen(
              noteText:notes['note'],
              noteId: notes['id'],
                  ),
                ),
            );
          },
          /// ////////////////////////
          child: Container(
            height: 80.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: HexColor('5F84D2'),// A9BAE6 6E8CD3 6F80D4
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('${notes['note']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:const TextStyle(fontSize: 18.0,color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: Text('${notes['notedate']}',
                    style: TextStyle(fontSize: 13.0,color: Colors.grey[900]),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
          ),
        ),

    ),
  );
}
