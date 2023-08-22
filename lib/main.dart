import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_layout/cubit_all/cubit.dart';
import 'package:news_layout/cubit_all/states_all.dart';
import 'package:news_layout/dark_mode/cubit_dark.dart';
import 'package:news_layout/dark_mode/states_dark.dart';
import 'package:news_layout/network/bloc_observer.dart';
import 'package:news_layout/network/cache_helper.dart';
import 'package:news_layout/network/dio_helper.dart';
import 'package:news_layout/widgets/news_layout.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool ? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}
class MyApp extends StatelessWidget {
  final bool ? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitDark()..changeAppMode(
            fromShared: isDark
        ),),
        BlocProvider(
          create: (BuildContext context) =>NewCubit()..getBusiness(),

        ),
      ],
      child:BlocConsumer<CubitDark,Statesdark>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<NewCubit, NewsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      titleSpacing: 20.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                    ),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange,
                    ),
                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      backgroundColor: Colors.white,
                    ),
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  darkTheme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor: HexColor('333739'),
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light,
                      ),
                      backgroundColor: HexColor('333739'),
                      elevation: 0.0,
                      titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                    ),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange,
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      backgroundColor: HexColor('333739'),
                    ),
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  themeMode:
                  CubitDark.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  home: NewsLayout()
              );
            },
          );
        },
      ),
    );


  }
}

