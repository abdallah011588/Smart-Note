
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mynote/notescreen.dart';

class splash_Screen extends StatefulWidget {
  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {

  Timer? timer;
  void goTo()
  {
    timer= Timer(const Duration(seconds: 5), (){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NoteScreen(),
          ),
              (route) => false
      );
    });
  }

  @override
  void initState() {
    goTo();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  /*
  final colorizeColors = [
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.red,
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 0,
        systemOverlayStyle:const SystemUiOverlayStyle(
          statusBarColor:Colors.white,
          statusBarIconBrightness:Brightness.dark,
        ),
      ),
      body: Container(
        width: double.infinity,
        color:Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
         DefaultTextStyle(
          style: TextStyle(
           fontSize: 50.0,
           fontWeight: FontWeight.bold,
           color: HexColor('5F84D2'),
          ),
          child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('Smart notes',speed: Duration(milliseconds: 300)),
           // WavyAnimatedText('Look at the waves',speed: Duration(milliseconds: 100)),
          ],
          isRepeatingAnimation: true,
        ),
      ),
         SizedBox(height: 30,),
         Padding(
              padding: const EdgeInsets.all(15.0),
              child:Center(child: CircularProgressIndicator(color:Colors.deepOrange[400],)),
            ),
          ],
        ),
      ),
    );
  }

}

/* SizedBox(
              width: 250.0,
              child: TextLiquidFill(
                text: 'Smart Notes',
                waveColor: Colors.blueAccent,
                boxBackgroundColor: Colors.white,
                loadDuration: Duration(seconds: 3),
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 300.0,
              ),
            ),
         SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style:  TextStyle(
                  fontSize: 30.0,
                  color: HexColor('6F80D4'),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Discipline is the best tool'),
                    TypewriterAnimatedText('Design first, then code'),
                    TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
                    TypewriterAnimatedText('Do not test bugs out, design them out'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
         SizedBox(
              width: 250.0,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Larry Page',
                    textStyle: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Bill Gates',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,

                      fontSize: 50.0,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Steve Jobs',
                    textStyle: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,

                    ),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),*/
/*
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TweenAnimationBuilder(
                duration:const Duration(seconds: 2),
                curve: Curves.linearToEaseOut,
                tween: Tween<double>(begin: 40,end: 60),
                builder: (context,double value,child)
                {
                  return Text(
                    'My notes',
                    style: TextStyle(
                      color:HexColor('6F80D4'),
                      fontSize: value,
                    ),
                  );
                },
                // child: FlutterLogo(size: 200,)
              ),
            ),*/