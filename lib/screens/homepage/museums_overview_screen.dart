import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/homepage/museums_grid.dart';
import '../../widgets/homepage/search_bar.dart';
import '../../widgets/homepage/dropdown_category.dart';
import '../../widgets/main_menu_drawer.dart';
import '../../widgets/app_bar.dart';
import '../../models/museum.dart';
import '../../models/user.dart';
import '../../providers/museums.dart';
import '../../providers/users.dart';
class MuseumsOverviewScreen extends StatefulWidget {
  @override
  State<MuseumsOverviewScreen> createState() => _MuseumsOverviewScreenState();
}

//when this widget builds we get all museums in one list. This list is used for filterign by category
//If we choose category then we can only search for that category
class _MuseumsOverviewScreenState extends State<MuseumsOverviewScreen> {
  //List<Museum> museumSearch; //this list is used for searching result
  List<Museum> museumsForWidget; //this list is used when passing data to MuseumsGrid widget
  List<Museum> mainMuseumList;
  User appUser; //this list is used for getting all museums and filtering,
                              //also it is used when searching
  String query = '';
  String category ='c0';

  @override
  void didChangeDependencies() {
    mainMuseumList = Provider.of<Museums>(context, listen: false).getMuseums;
    appUser = Provider.of<Users>(context).getUser();
    museumsForWidget = mainMuseumList;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('rebildam skrin');
    return Scaffold(
      appBar: appBar('Museum app', context, Theme.of(context).primaryColor,appUser),
      body: SingleChildScrollView(
        //remove this SingleChildScroolView if search is fixed
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownCategory(searchMuseumByCategory),
                SearchBar(searchMuseum),
              ],
            ),
            MuseumsGrid(museumsForWidget), //wrap with flexible if search is fixed
          ],
        ),
      ),
      drawer: MainMenuDrawer(),
    );
  }

  void searchMuseumByCategory(String categoryId){
    setState(() {
      this.category = categoryId;
      this.mainMuseumList = Provider.of<Museums>(context, listen:false).filterMusemsByCategory(categoryId);
      museumsForWidget = mainMuseumList;
    });
  }

  void searchMuseum(String query) {
    setState(() {
      this.query = query;
      this.museumsForWidget = mainMuseumList.where((museum) {
      final titleLower = museum.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();
    });
  }
}
