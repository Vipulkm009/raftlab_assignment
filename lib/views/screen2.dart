import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:raftlab_assignment/db/database.dart';
import 'package:raftlab_assignment/models/api_details.dart';
import 'package:raftlab_assignment/views/components/api_card.dart';
import 'package:raftlab_assignment/views/components/apidetail_card.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child: FutureBuilder(
          future: APIDetailsDatabase.instance.readAllNotes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<APIDetails>> snapshot) {
            if (snapshot.hasData ||
                snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data ?? [];
              if (data.isNotEmpty)
                return Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        APIDetailCard(data: data[index]),
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black45,
                      thickness: 0.3,
                    ),
                    itemCount: data.length,
                  ),
                );
              return Center(
                child: Text('No data in DB.'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  // Future<APIDetails> fetchData() async {
  //   final detail = await APIDetailsDatabase.instance.readAllNotes();
  //   print('d=$detail');
  //   return detail;
  // }
}
