import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/layouts/news_app/cubit/cubit.dart';
import 'package:rest_api/layouts/news_app/cubit/states.dart';
import 'package:rest_api/shared/components/components.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {},
      builder:(context, state)
      {
        var cubit=NewsCubit.get(context);

       return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              defaultTextField(
                controller: controller,
                label: "search",
                onChange: (value) {
                  cubit.getSearchItem(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "you must write the item which you need it";
                  }
                },
              ),
              Expanded(child: itemslist(list: cubit.searchArticle,isSearch: true,context: context)),
            ],
          ),
        );
      },
      );


  }
}
