import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:raftlab_assignment/blocs/greetings_bloc/greetings_bloc.dart';
import 'package:raftlab_assignment/blocs/internet_bloc/internet_bloc.dart';
import 'package:raftlab_assignment/blocs/location_bloc/location_bloc.dart';
import 'package:raftlab_assignment/db/database.dart';

class Screen3 extends StatelessWidget {
  String distance = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<GreetingsBloc, GreetingsState>(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.18,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white24,
                ),
                child: Center(
                  child: state is GreetingsMorning
                      ? Text(
                          'Good Morning',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : state is GreetingsAfternoon
                          ? Text(
                              'Good Afternoon',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Text(
                              'Good Evening',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                ),
              );
            },
          ),
          BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGained) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Internet Connected...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.green,
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Internet Disconnected...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.18,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white24,
                ),
                child: state is InternetGained
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi,
                            size: 30,
                          ),
                          Text(
                            'Internet Connected',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 30,
                          ),
                          Text(
                            'No Internet Connection',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white24,
            ),
            child: Center(
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  if (state is LocationInitial)
                    return ElevatedButton(
                      onPressed: () async {
                        try {
                          Position position = await _determinePosition();
                          distance = (await Geolocator.distanceBetween(
                                      position.latitude,
                                      position.longitude,
                                      37.0902,
                                      95.7129) /
                                  1000)
                              .roundToDouble()
                              .toString();
                          BlocProvider.of<LocationBloc>(context)
                              .add(FindLocation(distance));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Some Error...'),
                          ));
                        }
                      },
                      child: Text(
                        'Find\nLocation',
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black87),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width * 0.5, 30)),
                      ),
                    );
                  return Text(
                    'You are $distance KM away from 37.0902°N, 95.7129° W',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white24,
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await APIDetailsDatabase.instance.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Database Cleared'),
                  ));
                },
                child: Text(
                  'Clear\nDatabase',
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.5, 30)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
