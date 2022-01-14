import 'package:flutter/material.dart';
import 'package:museum_app/widgets/my_profile/user_data_column.dart';

import './settings_button.dart';

class UserDataDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Column(
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
                  border: Border.all(color: color.primaryColorDark, width: 3),
                ),
                child: UserDataColumn(),
              ),
              SettingsButton(constraints),
            ],
          ),
        );
      },
    );
  }
}
