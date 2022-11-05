import 'package:flutter/widgets.dart';

class Empty extends StatelessWidget {
  final double? width, height;
  final int? flex;

  const Empty({Key? key, this.width, this.height, this.flex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (flex == null)
        ? SizedBox(width: width, height: height)
        : Expanded(
            flex: flex!,
            child: Container(),
          );
  }
}
