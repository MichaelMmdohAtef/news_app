import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api/layouts/news_app/cubit/cubit.dart';
import 'package:rest_api/modules/webView/web_view.dart';

Widget itemslist({required List list,isSearch=false,required context})=>ConditionalBuilder(

    condition: list.length > 0,

    builder:(context)=>ListView.separated(

      physics: BouncingScrollPhysics(),

        itemBuilder:(context,index)=>InkWell(
          onTap: (){
            navigateTo(context, WebScreen(list[index]["url"]));
          },
          child: Padding(

            padding: const EdgeInsets.all(20.0),

            child: Column(

              children: [

                Container(

                    width: double.infinity,

                    height: 90,

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Expanded(

                        child: Text("${list[index]["title"]}",

                        maxLines: 2,

                          textAlign: TextAlign.center,

                          overflow: TextOverflow.ellipsis,

                          style: Theme.of(context).textTheme.bodyText1,

                        ),),

                        Text("${list[index]["publishedAt"]}",

                        style: Theme.of(context).textTheme.bodyText1,

                        ),

                      ],

                    ),

                  ),

              ],

            ),

          ),
        ),

        separatorBuilder:(context,index)=>Padding(

          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: SizedBox(

            width: double.infinity,

            height: 1,

            child: Container(

              color: Theme.of(context).textTheme.bodyText1!.color,

            ),

          ),

        ),

            // SizedBox(height: 5,),

        itemCount: list.length,),

    fallback:(context)=>isSearch?Container():Center(child: CircularProgressIndicator()),

);

 navigateTo(BuildContext context,Widget activity)=>Navigator.push(context,
     MaterialPageRoute(builder:(context)=>activity));

 Widget defaultTextField({
   required TextEditingController? controller,
   required String label,
   Function(String)? onChange,
   String? Function(String?)? validator,
})=>Padding(
  padding: const EdgeInsets.all(15.0),
  child:   TextFormField(
     decoration: InputDecoration(
       labelStyle: TextStyle(
         textBaseline: TextBaseline.ideographic,
       fontSize: 25,
       ),
         border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(60),
         ),
          labelText: label,
       focusColor: Colors.deepOrange
     ),
    style: TextStyle(color: Colors.black,
    fontSize: 20,
    ),
    cursorColor: Colors.indigo,

    onChanged: onChange,
    keyboardType: TextInputType.text,
    controller:controller,
    validator:validator,
   ),
);