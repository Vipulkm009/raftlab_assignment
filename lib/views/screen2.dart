import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raftlab_assignment/blocs/screen2_bloc/screen2_bloc.dart';
import 'package:raftlab_assignment/db/database.dart';
import 'package:raftlab_assignment/models/api_details.dart';
import 'package:raftlab_assignment/views/components/api_card.dart';
import 'package:raftlab_assignment/views/components/apidetail_card.dart';

class Screen2 extends StatelessWidget {
  List<APIDetails> data = [];
  List<String> categories = [];
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child:
          BlocConsumer<Screen2Bloc, Screen2State>(listener: (context, state) {
        // TODO: implement listener
      }, builder: (context, state) {
        if (state is Screen2Initial) {
          return FutureBuilder(
              future: fetchData(selectedCategory),
              builder: (BuildContext context,
                  AsyncSnapshot<List<APIDetails>> snapshot) {
                if (snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.done) {
                  data = snapshot.data ?? [];

                  if (data.isNotEmpty) {
                    selectedCategory = data[0].category;
                    // ignore: curly_braces_in_flow_control_structures
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height - 210,
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                APIDetailCard(data: data[index]),
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.black45,
                              thickness: 0.3,
                            ),
                            itemCount: data.length,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: categories
                                      .map((category) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 3.0,
                                            ),
                                            child: InputChip(
                                              backgroundColor:
                                                  selectedCategory.compareTo(
                                                              category) ==
                                                          0
                                                      ? Colors.white
                                                      : Colors.black,
                                              // selectedColor: Colors.white,
                                              // selected: selectedCategory
                                              //         .compareTo(category) ==
                                              //     0,
                                              onPressed: () {
                                                BlocProvider.of<Screen2Bloc>(
                                                        context)
                                                    .add(
                                                        CategoryChangingEvent());
                                                selectedCategory = category;
                                                BlocProvider.of<Screen2Bloc>(
                                                        context)
                                                    .add(
                                                        CategoryChangedEvent());
                                              },
                                              label: Text(
                                                category,
                                                style: TextStyle(
                                                  color: selectedCategory
                                                              .compareTo(
                                                                  category) ==
                                                          0
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: Text('No data in DB.'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      }),
    );
  }

  Future<List<APIDetails>> fetchData(String category) async {
    categories = await APIDetailsDatabase.instance.getCategories();
    print(categories);
    return await APIDetailsDatabase.instance.readAllNotes(category);
  }
}
