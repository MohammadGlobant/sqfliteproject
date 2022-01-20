import 'package:flutter/material.dart';
import 'package:sqfliteproject/AppRouter.dart';

void main() => runApp(SqfLiteProject(appRouter: AppRouter(),));


class SqfLiteProject extends StatelessWidget {
  final AppRouter appRouter;
  const SqfLiteProject({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
