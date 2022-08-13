import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raftlab_assignment/audio_player/page_manager.dart';
import 'package:raftlab_assignment/blocs/audio_player_bloc/audio_player_bloc.dart';
import 'package:raftlab_assignment/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:raftlab_assignment/blocs/internet_bloc/internet_bloc.dart';
import 'package:raftlab_assignment/views/components/bottom_nav_item.dart';
import 'package:raftlab_assignment/views/screen1.dart';
import 'package:raftlab_assignment/views/screen2.dart';
import 'package:raftlab_assignment/views/screen3.dart';
import 'package:raftlab_assignment/views/screen4.dart';

class MyHomePage extends StatelessWidget {
  late final PageManager _pageManager = PageManager();
  List<Widget> screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _pageManager = PageManager();
  // }

  // @override
  // void dispose() {
  //   _pageManager.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocBuilder<InternetBloc, InternetState>(
          builder: (context, internetState) {
            if (internetState is InternetGained) {
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
                  actions: [
                    ValueListenableBuilder<ButtonState>(
                      valueListenable: _pageManager.buttonNotifier,
                      builder: (_, value, __) {
                        switch (value) {
                          case ButtonState.loading:
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 32.0,
                              height: 32.0,
                              child: const CircularProgressIndicator(),
                            );
                          case ButtonState.paused:
                            return IconButton(
                              icon: const Icon(Icons.play_arrow),
                              iconSize: 32.0,
                              onPressed: _pageManager.play,
                            );
                          case ButtonState.playing:
                            return IconButton(
                              icon: const Icon(Icons.pause),
                              iconSize: 32.0,
                              onPressed: _pageManager.pause,
                            );
                        }
                      },
                    ),
                  ],
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
            return Scaffold(
              body: Container(
                child: Center(
                  child: Text('Internet Not Connected'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
