import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

class UserPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Users>(context).getUser();

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(100),
        ),
        color: Theme.of(context).primaryColor,
      ),
      width: double.infinity,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.08,
              ),
              Container(
                width: constraints.maxWidth * 0.4,
                height: constraints.maxHeight * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: userData.userImage == ""
                        ? const AssetImage('assets/images/default_user.png')
                        : NetworkImage(userData.userImage),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userData.username.toString(),
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          );
        },
      ),
    );
  }
}
