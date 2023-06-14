import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/layouts/news_app/cubit/states.dart';
import 'package:rest_api/modules/Business/business_screen.dart';
import 'package:rest_api/modules/science/science_screen.dart';
import 'package:rest_api/modules/sports/sports_screen.dart';
import 'package:rest_api/shared/network/local/cache_helper.dart';
import 'package:rest_api/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_sharp),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball_sharp),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_rounded),
      label: "Science",
    ),
  ];

  List<Widget> screens = [
    Business_screen(),
    Sports_screen(),
    Science_screen(),
  ];

  changeCurrentIndex(int index) {
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  List<dynamic> businessArticles = [];

   getBusinessData() async{
     emit(GetNewsBusinessLoadingStates());
     await DioHelper.getData(url: "v2/top-headlines",
        query: {
      "country": "eg",
      "category": "business",
      "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
    }).then((value){
      businessArticles=value.data["articles"];
      print(businessArticles[0]["title"]);
      emit(GetNewsBusinessSuccessStates());
    }).catchError((onError){
       print(onError.toString());
       emit(GetNewsBusinessErrorStates());
     });
  }

  List<dynamic> sportsArticles = [];

  getsportsData() async{
    emit(GetNewsSportsLoadingStates());
    await DioHelper.getData(url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
        }).then((value){
      sportsArticles=value.data["articles"];
      print(sportsArticles[0]["title"]);
      emit(GetNewsSportsSuccessStates());
    }).catchError((onError){
      print(onError.toString());
      emit(GetNewsSportsErrorStates());
    });
  }

  List<dynamic> scienceArticles = [];

  getscienceData() async{
    emit(GetNewsScienceLoadingStates());
    await DioHelper.getData(url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
        }).then((value){
      scienceArticles=value.data["articles"];
      print(scienceArticles[0]["title"]);
      emit(GetNewsScienceSuccessStates());
    }).catchError((onError){
      print(onError.toString());
      emit(GetNewsScienceErrorStates());
    });
  }


  List<dynamic> searchArticle = [];

  getSearchItem(String item) async{
    emit(GetSearchLoadingStates());
    await DioHelper.getData(url: "v2/everything",
        query: {
          "q": item,
          "apiKey": "65f7f556ec76449fa7dc7c0069f040ca",
        }).then((value){
      searchArticle=value.data["articles"];
      emit(GetSearchSuccessStates());
    }).catchError((onError){
      print(onError.toString());
      emit(GetSearchErrorStates());
    });
  }

  bool isDark=false;

   changeThemeMode({bool? darkModeFromShared}) async{
    if(darkModeFromShared!=null){
      isDark=darkModeFromShared;
      emit(OnChangeThemeMode());
    }else{
      isDark=!isDark;
    await  CacheHelper.putBoolean(key: "isDark", isDark: isDark)
        .then((value){
      emit(OnChangeThemeMode());
    });
    }

  }
}
