import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init() async{
    sharedPreferences= await SharedPreferences.getInstance();
  }

  static Future putBoolean({
    required String key,
    required bool isDark
})async{
   await sharedPreferences!.setBool(key,isDark);
  }

  static bool? getBoolean({
    required String key
}) {
     return sharedPreferences!.getBool(key);
   // isDark==null?isDark=false:isDark=isDark;

  }
}