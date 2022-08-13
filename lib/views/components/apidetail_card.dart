import 'package:flutter/material.dart';
import 'package:raftlab_assignment/models/api_details.dart';
import 'package:raftlab_assignment/views/components/api_card.dart';

class APIDetailCard extends StatelessWidget {
  const APIDetailCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final APIDetails data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.only(
              left: 10.0,
              top: 5.0,
              bottom: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.id == null ? '' : data.id!.toString()),
                Text(
                  data.name,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  data.description,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  // width: MediaQuery.of(context).size.width * 0.6,
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 3.0,
                    // direction: Axis.vertical,
                    children: [
                      APICard(
                        icon: Icons.check,
                        title: data.isHttps ? 'HTTPS' : 'HTTP',
                      ),
                      APICard(
                        icon: data.cors.compareTo('yes') == 0
                            ? Icons.check
                            : data.cors.compareTo('no') == 0
                                ? Icons.close
                                : Icons.access_time,
                        title: data.cors,
                      ),
                      Visibility(
                        visible: data.auth.isNotEmpty,
                        child: APICard(
                          icon: Icons.key,
                          title: data.auth,
                        ),
                      ),
                      APICard(
                        icon: Icons.category,
                        title: data.category,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Go To\nLink',
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black87),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width * 0.27, 50)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
