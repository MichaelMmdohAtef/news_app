import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/layouts/news_app/cubit/cubit.dart';
import 'package:rest_api/layouts/news_app/cubit/states.dart';
import 'package:rest_api/shared/components/components.dart';

class Sports_screen extends StatelessWidget {
  const Sports_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){

      },
      builder:(context,state){
        List<dynamic> list = NewsCubit.get(context).sportsArticles;
        return itemslist(list: list,context: context);
      },
    );
  }
}
