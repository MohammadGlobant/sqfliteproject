import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqfliteproject/buisness_logic/sqflite_cubit.dart';
import 'package:sqfliteproject/screens/list_screen.dart';

class AppRouter{
  static const listscreen = '/';
  late SqfliteCubit sqfliteCubit;
  AppRouter();
  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case listscreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => SqfliteCubit()..createDB(), /// this mean go inside sqflitecubit and use the method
                child: BlocConsumer<SqfliteCubit,SqfliteState>(
                  listener: (BuildContext context,SqfliteState state){},
                  builder: (BuildContext context,SqfliteState state){
                    return const ListScreen();
                  }
                ),
            ),
        );
    }
  }
}
