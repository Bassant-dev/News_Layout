import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/cubit_all/cubit.dart';
import 'package:news_layout/cubit_all/states_all.dart';
import 'package:news_layout/dark_mode/cubit_dark.dart';

class NewsLayout extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit,NewsStates>(
      listener: (context,state){},

      builder:(context,state){
        var cubit =NewCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'News App'
            ),
            actions: [
              // IconButton(
              // //     icon:Icon(Icons.search),
              // //     onPressed:(){
              // //       navigateto(context, SearchScreen(),);
              // //     },
              // // ),
              IconButton(
                icon:Icon(Icons.brightness_4_outlined),
                onPressed:(){
                  CubitDark.get(context).changeAppMode();
                },
              )
            ],


          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items:cubit.bottomItems ,
          ),
          body: cubit.screens[
          cubit.currentIndex
          ],
        );
      },
    );
  }
}
//https://newsapi.org/v2/everything?q=tesla&from=2022-09-24&sortBy=publishedAt&apiKey=API_KEY
//url:https://newsapi.org
//method(url):v2/everything
//query:q=tesla&from=2022-09-24&sortBy=publishedAt&apiKey=API_KEY

