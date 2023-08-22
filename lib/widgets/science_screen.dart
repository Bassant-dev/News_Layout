import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_layout/component/component.dart';
import 'package:news_layout/cubit_all/cubit.dart';
import 'package:news_layout/cubit_all/states_all.dart';

class SciencesScreen extends StatelessWidget {
  const SciencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit,NewsStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var list=NewCubit.get(context).science;
        return articleBuilder(list,context);
      },
    );
  }
}
