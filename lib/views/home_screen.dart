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
          appBar: AppBar(
            backgroundColor: Colors.black,
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
          body: Center(
            child: Text('Loading...'),
          ),
          bottomNavigationBar: Card(
            elevation: 1.0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white70,
                // border: Border(
                //   top: BorderSide(
                //     color: Colors.black,
                //     width: 0.1,
                //   ),
                // ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<HomeScreenBloc>(context)
                          .add(Screen1Event());
                    },
                    child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                      builder: (context, state) {
                        return BottomNavigationBarItem(
                          isSelected: state is HomeScreen1,
                          number: 1,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<HomeScreenBloc>(context)
                          .add(Screen2Event());
                    },
                    child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                      builder: (context, state) {
                        return BottomNavigationBarItem(
                          isSelected: state is HomeScreen2,
                          number: 2,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<HomeScreenBloc>(context)
                          .add(Screen3Event());
                    },
                    child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                      builder: (context, state) {
                        return BottomNavigationBarItem(
                          isSelected: state is HomeScreen3,
                          number: 3,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<HomeScreenBloc>(context)
                          .add(Screen4Event());
                    },
                    child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                      builder: (context, state) {
                        return BottomNavigationBarItem(
                          isSelected: state is HomeScreen4,
                          number: 4,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomNavigationBarItem extends StatelessWidget {
  final bool isSelected;
  final int number;
  const BottomNavigationBarItem({
    Key? key,
    required this.isSelected,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          getIconData(number),
        ),
        Text(
          'Screen ${number}',
          style:
              isSelected ? TextStyle(fontWeight: FontWeight.bold) : TextStyle(),
        ),
      ],
    );
  }

  IconData getIconData(int num) {
    switch (num) {
      case 1:
        return isSelected ? Icons.looks_one : Icons.looks_one_outlined;
      case 2:
        return isSelected ? Icons.looks_two : Icons.looks_two_outlined;
      case 3:
        return isSelected ? Icons.looks_3 : Icons.looks_3_outlined;
      default:
        return isSelected ? Icons.looks_4 : Icons.looks_4_outlined;
    }
  }
}
