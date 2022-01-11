import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/homepage/museums_grid.dart';
import '../../widgets/homepage/search_bar.dart';
import '../../widgets/homepage/dropdown_category.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/app_bar.dart';
import '../../models/museum.dart';
import '../../providers/museums.dart';

class MuseumsOverviewScreen extends StatefulWidget {
  @override
  State<MuseumsOverviewScreen> createState() => _MuseumsOverviewScreenState();
}

class _MuseumsOverviewScreenState extends State<MuseumsOverviewScreen> {
  List<Museum> museums;
  List<Museum> allMuseums;
  String query = '';

  @override
  void didChangeDependencies() {
    allMuseums = Provider.of<Museums>(context, listen: false).getMuseums;
    museums = allMuseums;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('rebildam skrin');
    return Scaffold(
      appBar: appBar('Museum app', context, Theme.of(context).primaryColor),
      body: SingleChildScrollView(
        //remove this SingleChildScroolView if search is fixed
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownCategory(),
                SearchBar(query, searchMuseum),
              ],
            ),
            MuseumsGrid(museums), //wrap with flexible if search is fixed
          ],
        ),
      ),
      drawer: MainMenuDrawer(),
    );
  }

  void searchMuseum(String query) {
    setState(() {
      this.query = query;
      this.museums = Provider.of<Museums>(context, listen:false).searchMuseums(query);
    });
  }
}
