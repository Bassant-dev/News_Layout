import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/cubit_all/states_all.dart';
import 'package:news_layout/network/dio_helper.dart';
import 'package:news_layout/widgets/business_screen.dart';
import 'package:news_layout/widgets/science_screen.dart';
import 'package:news_layout/widgets/sport_screen.dart';


class NewCubit extends Cubit<NewsStates>{
  NewCubit(): super(NewsInitialStates());


  static NewCubit get (context) =>BlocProvider.of(context);
  int currentIndex =0;
  List<BottomNavigationBarItem> bottomItems =[
    const BottomNavigationBarItem(
        icon:Icon(
          Icons.business,
        ),
        label: 'Business'
    ),
    const BottomNavigationBarItem(
        icon:Icon(
          Icons.sports,
        ),
        label: 'Sports'
    ),
    const BottomNavigationBarItem(
        icon:Icon(
          Icons.science,
        ),
        label: 'Science'
    ),

  ];
  List<Widget> screens=[

    const BusinessScreen(),
    const SportssScreen(),
    const SciencesScreen(),


  ];
  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }
  List<dynamic> business =[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'834e09dd2bdb4583b70320f77058316f'
        }
    ).then((value) {
      // print(value.data.toString());
      business=value.data['articles'];
      print(business);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }



  List<dynamic> sports =[];
  void getSports(){
    emit(NewsGetBusinessLoadingState());
    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'834e09dd2bdb4583b70320f77058316f'
          }
      ).then((value) {
        // print(value.data.toString());
        sports=value.data['articles'];
        print(sports);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }

  }
  List<dynamic> science =[];
  void getScience(){

    emit(NewsGetBusinessLoadingState());
    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'834e09dd2bdb4583b70320f77058316f'
          }
      ).then((value) {
        // print(value.data.toString());
        science=value.data['articles'];
        print(science);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }

  }




  List<dynamic> search =[];
  void getsearch(String value){

    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
        url: 'v2/everything',
        query: {

          'q':'$value',
          'apiKey':'834e09dd2bdb4583b70320f77058316f'
        }
    ).then((value) {
      // print(value.data.toString());
      search=value.data['articles'];
      print(science);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });



  }




}
//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=834e09dd2bdb4583b70320f77058316f
