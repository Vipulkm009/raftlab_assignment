import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raftlab_assignment/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:raftlab_assignment/views/components/bottom_nav_item.dart';
import 'package:raftlab_assignment/views/screen1.dart';
import 'package:raftlab_assignment/views/screen2.dart';
import 'package:raftlab_assignment/views/screen3.dart';
import 'package:raftlab_assignment/views/screen4.dart';

class MyHomePage extends StatelessWidget {
  List<Widget> screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Center(
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreen1)
                return Text(
                  'Screen 1',
                );

              if (state is HomeScreen2)
                return Text(
                  'Screen 2',
                );

              if (state is HomeScreen3)
                return Text(
                  'Screen 3',
                );

              // if(state is HomeScreen4)
              return Text(
                'Screen 4',
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreen1) return screens[0];
          if (state is HomeScreen2) return screens[1];
          if (state is HomeScreen3) return screens[2];
          return screens[3];
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.only(
          top: 5.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            top: BorderSide(
              color: Colors.black45,
            ),
          ),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(12.0),
          //   topRight: Radius.circular(12.0),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<HomeScreenBloc>(context)
                    .add(HomeScreen1Event());
              },
              child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  return BottomNavItem(
                    isSelected: state is HomeScreen1,
                    number: 1,
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<HomeScreenBloc>(context)
                    .add(HomeScreen2Event());
              },
              child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  return BottomNavItem(
                    isSelected: state is HomeScreen2,
                    number: 2,
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<HomeScreenBloc>(context)
                    .add(HomeScreen3Event());
              },
              child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  return BottomNavItem(
                    isSelected: state is HomeScreen3,
                    number: 3,
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<HomeScreenBloc>(context)
                    .add(HomeScreen4Event());
              },
              child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  return BottomNavItem(
                    isSelected: state is HomeScreen4,
                    number: 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
