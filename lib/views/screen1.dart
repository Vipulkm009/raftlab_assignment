// ignore_for_file: sized_box_for_whitespace
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raftlab_assignment/blocs/internet_bloc/internet_bloc.dart';
import 'package:raftlab_assignment/blocs/screen1_bloc/screen1_bloc.dart';
import 'package:raftlab_assignment/db/database.dart';
import 'package:raftlab_assignment/models/api_details.dart';
import 'package:raftlab_assignment/views/components/api_card.dart';
import 'package:raftlab_assignment/views/components/apidetail_card.dart';

class Screen1 extends StatelessWidget {
  List<APIDetails> data = [];

  Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 220,
            child: BlocConsumer<InternetBloc, InternetState>(
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
                if (state is InternetGained) {
                  return BlocConsumer<Screen1Bloc, Screen1State>(
                    listener: (context, state) {
                      if (state is Screen1Initial) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Press Fetch Data Button'),
                        ));
                      } else if (state is Screen1Fetched) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Fetching Data'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Saving Data'),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is Screen1Initial) {
                        return const Center(
                          child: Text('No Data Found...'),
                        );
                      }
                      // if(state is Screen1Saving) {

                      // }
                      if (state is Screen1Saved) {
                        return const Center(
                          child: Text('Data Saved Successfullly...'),
                        );
                      }
                      return FutureBuilder(
                        future: getData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<APIDetails>> snapshot) {
                          if (snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            // print(snapshot.data);
                            data = snapshot.data!;
                            return ListView.separated(
                              itemBuilder: (context, index) =>
                                  APIDetailCard(data: data[index]),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Colors.black45,
                                thickness: 0.3,
                              ),
                              itemCount: data.length,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('Internet Not Connected...'),
                );
              },
            ),
          ),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<Screen1Bloc, Screen1State>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        if (state is Screen1Initial) {
                          BlocProvider.of<Screen1Bloc>(context)
                              .add(Screen1FetchEvent());
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        decoration: BoxDecoration(
                          color: state is Screen1Initial
                              ? Colors.black
                              : Colors.black45,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Text(
                          'Fetch Data',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<Screen1Bloc, Screen1State>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () async {
                        if (state is Screen1Fetched) {
                          BlocProvider.of<Screen1Bloc>(context)
                              .add(Screen1SavingEvent());
                          showCupertinoModalPopup(
                              context: context,
                              builder: ((context) => const Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )));
                          // final rows =
                          //     await APIDetailsDatabase.instance.clear();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Saving...'),
                          ));
                          data.forEach((apiDetail) async {
                            final detail = await APIDetailsDatabase.instance
                                .create(apiDetail);
                            print(detail.id);
                          });
                          await Future.delayed(Duration(seconds: 20));
                          Navigator.of(context).pop();
                          BlocProvider.of<Screen1Bloc>(context)
                              .add(Screen1SavedEvent());
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        decoration: BoxDecoration(
                          color: state is Screen1Fetched
                              ? Colors.black
                              : Colors.black45,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Text(
                          'Save Data',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<APIDetails>> getData() async {
    final res = await http.get(Uri.parse('https://api.publicapis.org/entries'));
    final data = Map<String, dynamic>.from(jsonDecode(res.body) as Map);
    final entries = List<Map<String, dynamic>>.from(data['entries'] as List);
    final apiData = entries.map((entry) => APIDetails.fromJson(entry)).toList();
    return apiData;
  }
}
