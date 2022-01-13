import 'package:flutter/material.dart';

class MyProfileAtributs extends StatelessWidget {
  final String title;
  final String userData;

  const MyProfileAtributs(this.title, this.userData);

  Text textStyle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textStyle(context, title),
          textStyle(context, userData),
        ],
      ),
    );
  }
}
