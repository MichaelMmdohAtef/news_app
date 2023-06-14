import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/layouts/news_app/cubit/cubit.dart';
import 'package:rest_api/layouts/news_app/cubit/states.dart';
import 'package:rest_api/modules/Search/search_screen.dart';
import 'package:rest_api/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state)=>{} ,
        builder:(context,state) {
         var cubit=NewsCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(Icons.brightness_4_outlined),
                      onPressed: (){
                        cubit.changeThemeMode();
                      },
                    ),
                    IconButton(
                        icon: Icon(Icons.search),
                      onPressed: (){
                        navigateTo(context,Search());
                      },
                    ),
                  ],
                  title: Text("News App"),
                ),
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: cubit.bottomItems,
                  currentIndex: cubit.currentIndex,
                  onTap: (index){
                    cubit.changeCurrentIndex(index);
                  },
                ),
              );
        },
      );

  }
}
