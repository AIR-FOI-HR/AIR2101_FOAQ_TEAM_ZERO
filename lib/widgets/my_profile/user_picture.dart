import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

class UserPicture extends StatelessWidget {
  final String user = 'ttomiek';

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context);
    final userData = users.findByUsername(user);

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
                    image: userData.userImage == null
                        ? const AssetImage('assets/images/default_user.png')
                        : NetworkImage(userData.userImage),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userData.username,
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          );
        },
      ),
    );
  }
}
