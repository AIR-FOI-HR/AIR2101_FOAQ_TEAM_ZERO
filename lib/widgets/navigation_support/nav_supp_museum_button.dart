import 'package:flutter/material.dart';

class NavSuppMuseumButton extends StatelessWidget {
  final String idBill;

  NavSuppMuseumButton(this.idBill);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).highlightColor,
          boxShadow: kElevationToShadow[6],
        ),
        child: FlatButton(
          child: Text(
            'Museum one',
            style: Theme.of(context).textTheme.headline5,
          ),
          onPressed: () {},
        ));
  }
}
