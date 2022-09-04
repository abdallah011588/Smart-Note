import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynote/localization/localization_methods.dart';
class boardScreen extends StatelessWidget {
  const boardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/icon/noteboard.jpg'),
              alignment: Alignment.topCenter,fit: BoxFit.contain,
            ),
            const SizedBox(height: 10.0,),
            Text(
             getTranslated(context, 'note_board')!,
              style:const TextStyle(fontWeight: FontWeight.w400,fontSize: 20.0,),
            ),
          ],
        ),
      ),
    );
  }
}
