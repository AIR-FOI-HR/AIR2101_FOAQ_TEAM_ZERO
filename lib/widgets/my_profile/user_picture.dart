import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/users.dart';

class UserPicture extends StatelessWidget {
  final String user = 'msakac';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Users>(context);
    return Container(
      child: Column(
        children: [
          Image.network(userData.findByUsername(user).userImage),
        ],
      ),
    );
  }
}
