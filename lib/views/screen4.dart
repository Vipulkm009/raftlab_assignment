import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Screen4 extends StatelessWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 60,
      child: Container(
        height: MediaQuery.of(context).size.height - 120,
        child: Center(
          child: Text('Screen 4'),
        ),
      ),
    );
  }
}
