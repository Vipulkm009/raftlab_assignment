import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raftlab_assignment/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:raftlab_assignment/blocs/internet_bloc/internet_bloc.dart';
import 'package:raftlab_assignment/blocs/screen1_bloc/screen1_bloc.dart';
import 'package:raftlab_assignment/blocs/screen2_bloc/screen2_bloc.dart';
import 'package:raftlab_assignment/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeScreenBloc(),
        ),
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => Screen1Bloc(),
        ),
        BlocProvider(
          create: (context) => Screen2Bloc(),
        )
      ],
      child: MaterialApp(
        title: 'Raftlab Assignment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
