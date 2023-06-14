import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rest_api/layouts/news_app/cubit/cubit.dart';
import 'package:rest_api/layouts/news_app/cubit/states.dart';
import 'package:rest_api/layouts/news_app/news_layout.dart';
import 'package:rest_api/shared/network/local/cache_helper.dart';
import 'package:rest_api/shared/network/remote/dio_helper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key:"isDark");
  isDark==null?isDark=false:isDark=isDark;
  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {
   bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>NewsCubit()..getBusinessData()
          ..getscienceData()
          ..getsportsData()
      ..changeThemeMode(darkModeFromShared: isDark),
    child: BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder:(context,state){
       var cubit=NewsCubit.get(context);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            appBarTheme:AppBarTheme(
              titleSpacing: 20,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
              ),
              titleTextStyle: TextStyle(
                 color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme:
            BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              elevation: 30,
            ),
          ),
          darkTheme: ThemeData(
            appBarTheme:AppBarTheme(
              titleSpacing: 20,
              backgroundColor: HexColor("333739"),
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: HexColor("333739")
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            scaffoldBackgroundColor: HexColor("333739"),
            bottomNavigationBarTheme:
            BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 30,
              backgroundColor: HexColor("333739"),
            ),
          ),
          themeMode: cubit.isDark?ThemeMode.dark:ThemeMode.light,
          home: Directionality(
              textDirection: TextDirection.ltr,
              child: NewsLayout()),
        );
      },
    ),
    );


  }
}
