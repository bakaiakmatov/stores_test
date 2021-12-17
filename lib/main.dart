import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_2/logic/bloc/stores_bloc/stores_bloc.dart';
import 'package:test_2/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StoresBloc()..add(EventStores()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StoresApp',
          theme: ThemeData(
            primaryColor: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const SplashScreen()
        ));
  }
}
