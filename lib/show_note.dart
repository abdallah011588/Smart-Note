import 'package:flutter/material.dart';
import 'package:mynote/localization/localization_methods.dart';

class ShowNote extends StatelessWidget {

  String ? noteText;

   ShowNote({ required this.noteText,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'note')!,),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
          child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children: [
              Text(
                noteText!,
                style:const TextStyle(fontSize: 20.0,),
              //  textDirection: TextDirection.rtl,
              ),
            ],
          ),
      ),
      ),
    );
  }
}
