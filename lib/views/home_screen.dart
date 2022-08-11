import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raftlab_assignment/home_screen_bloc/home_screen_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text(''),
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
          ),
        );
      },
    );
  }
}
