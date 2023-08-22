
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_layout/widgets/web_vview_screen.dart';

Widget defaultButton ({
  double width=double.infinity,
  bool isUppercase=true,
  Color background = Colors.blue,
  required Function function,
  required String text,

}) => Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: () {

    },
    child: Text(
      isUppercase? text.toUpperCase():text,
      style: const TextStyle(
          color: Colors.white
      ),

    ),

  ),
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,

  required String? Function(String?)? validate,
  void Function(String)? onsubmit,
  required String label,
  required IconData prifex,
  void Function()? ontap,
  void Function(String)? onChange,
  bool isclickable=true,
  IconData? suffix,
  bool isPassword=false,
  void Function()? suffixpressed

}
    ) =>TextFormField(

  onTap:ontap ,
  enabled: isclickable,
  onChanged : onChange,

  obscureText:isPassword,
  controller: controller,
  validator: validate,
  keyboardType: type,
  onFieldSubmitted: onsubmit,

  decoration: InputDecoration(
    labelText: (label),
    prefixIcon:Icon(prifex),
    suffixIcon: suffix !=null ? IconButton(
        onPressed:suffixpressed
        ,icon: Icon(suffix)) :null,
    // ignore: prefer_const_constructors
    border: OutlineInputBorder(),


  ),
);
Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text(

            '${model['time']}',

          ),

        ),

        const SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: const TextStyle(

                    fontSize: 18.0,

                    fontWeight: FontWeight.bold

                ),

              ),

              const Text(

                '23 sep ,2022',

                style: TextStyle(

                    color: Colors.grey

                ),

              ),

            ],

          ),

        ),

        const SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: (){

              //AppCubit.get(context).updateData(status: 'done', id: model['id']);

            },

            icon: const Icon(

              Icons.check_circle,

              color: Colors.green,

            )

        ),

        IconButton(

            onPressed: (){

              //AppCubit.get(context).updateData(status: 'archive', id: model['id']);

            },

            icon: const Icon(

              Icons.archive,

              color: Colors.black45,

            )

        )

      ],

    ),

  ),
  onDismissed: (direction){
   // AppCubit.get(context).deleteData(id: model['id']);
  },
);
Widget tasksbuilder({
  required List<Map> heloo
}) =>ConditionalBuilder(
  condition: heloo.length >0,
  builder: (context)=>ListView.separated(
      itemBuilder:(context,index) => buildTaskItem(heloo[index],context),
      separatorBuilder:(context,index) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20.0,
        ),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
      ),
      itemCount: heloo.length
  ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'no tasks yet, please add some tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        )
      ],
    ),
  ),
);
Widget myDiveder()=> Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article,context) =>InkWell(
  onTap: (){
    navigateto(context, WebViewScreen(
      article['url'],
    ),);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

        children: [

          ConditionalBuilder(
            condition: article['urlToImage']!=null,

            builder: (context)=>Container(

              width: 120.0,

              height: 120.0,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0),

                image:  DecorationImage(
                  image:
                  NetworkImage('${article['urlToImage']}',)
                  , fit: BoxFit.cover,

                ),


              ),

            ),

            fallback: (context)=>Container(

              width: 120.0,

              height: 120.0,

              child: Image.asset('assets/image/download.png',

                fit: BoxFit.cover,),

            ),),



          SizedBox(

            width: 20.0,

          ),

          Expanded(

            child: Container(

              height: 120.0,

              child: Column(

                //mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.start,

                children:  [

                  Expanded(

                    child: Text(

                      '${article['title']}',

                      style: Theme.of(context).textTheme.bodyText1,

                      maxLines: 3,

                      overflow: TextOverflow.ellipsis,

                    ),

                  ),

                  Text(

                    "${article['publishedAt']}",

                    style: TextStyle(

                        color: Colors.grey

                    ),

                  ),

                ],

              ),

            ),

          )

        ]),





  ),
);
Widget articleBuilder(list,context,{isSearch=false}) => ConditionalBuilder(
  condition:list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index) =>buildArticleItem(list[index],context),
    separatorBuilder: (context,index) =>myDiveder(),
    itemCount: 10,
  ),
  fallback: (context) =>isSearch?Container(): Center(child: CircularProgressIndicator()),
);

void navigateto (context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context) => widget),);

Widget defaultTextButton({
  required  function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );
