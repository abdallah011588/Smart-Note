

import 'package:shared_preferences/shared_preferences.dart';

class sharedPref
{
  static late SharedPreferences prefs;

  static init()async
  {
    prefs =await SharedPreferences.getInstance();
  }

  static Future<bool> saveString({
    required String key,
    required String value,
  })async
  {
    return await prefs.setString(key, value);
  }

  static String? getString({required String key,})
  {
    return  prefs.getString(key);
  }


}