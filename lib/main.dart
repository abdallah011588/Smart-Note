import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mynote/cubit/cubit.dart';
import 'package:mynote/cubit/states.dart';
import 'package:mynote/localization/localization_methods.dart';
import 'package:mynote/localization/set_localization.dart';
import 'package:mynote/shared/shared_pref.dart';
import 'package:mynote/splah_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

   await sharedPref.init();
 // String x= sharedPref.getString(key: LANG_CODE)!;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _local;
  void setLocale(Locale locale) {
    setState(() {
      _local = locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _local = locale;
      });
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    if (_local == null)
    {
      return Container(
        child:const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else
    {
        return BlocProvider(
          create: (context) => appCubit()..createDatabase(),
          child: BlocConsumer<appCubit,appState>(
            listener: (context, state) => {},
            builder:(context, state){
              return MaterialApp(
                title: 'My Note',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    titleSpacing: 40.0,
                    elevation: 3.0,
                    backgroundColor: HexColor('5F84D2'),//6F80D4
                    foregroundColor: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('5F84D2'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                  ),
                ),
                home:splash_Screen(),//MyHome_Page(),// splash_Screen(),
                debugShowCheckedModeBanner: false,

            /// ////////////////////////////////////////////////////

                locale: _local,
                supportedLocales: [
                  const Locale('en', 'US'),
                  const Locale('ar', 'EG')
                ],

                localizationsDelegates: [
                  SetLocalization.localizationsDelegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocal, supportedLocales)
                {
                  for (var local in supportedLocales)
                  {
                    if (local.languageCode == deviceLocal!.languageCode &&
                        local.countryCode == deviceLocal.countryCode)
                    {
                      return deviceLocal;
                    }
                  }
                  return supportedLocales.first;
                },

              );
            } ,
          ),
        );
     }

  }


}
















/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

 */
