import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

class UserDataDisplay extends StatelessWidget {
  Text textStyle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget myProfileAtributs(
      BuildContext context, String title, String userData) {
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

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<Users>(context);
    final userData = userDataProvider.findByUsername('ttomiek');
    final color = Theme.of(context);
    final divider = Divider(
      thickness: 2,
      color: color.primaryColor,
    );
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                border: Border.all(color: color.primaryColor, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myProfileAtributs(context, 'Full name:',
                      '${userData.name} ${userData.surname}'),
                  divider,
                  myProfileAtributs(context, 'Email', userData.email),
                  divider,
                  myProfileAtributs(
                      context, 'Phone:', userData.phoneNumber ?? 'not added'),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 80, right: 80),
              width: double.infinity,
              height: constraints.maxHeight * 0.22,
              child: Center(
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: color.highlightColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                    ),
                    child: Text('Settings', style: color.textTheme.headline5),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
