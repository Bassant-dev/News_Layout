import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/dark_mode/states_dark.dart';
import 'package:news_layout/network/cache_helper.dart';

class CubitDark extends Cubit<Statesdark> {
  CubitDark() : super(InitialStatesdark());


  static CubitDark get(context) => BlocProvider.of(context);

  bool isDark = false;
  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      }).catchError((error){
        ChangeModeStateFail(error.toString());
      });
    }
  }
}
