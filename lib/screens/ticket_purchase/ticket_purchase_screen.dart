import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/screens/my_profile/my_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/museums.dart';
import '../../providers/work_times.dart';
import '../../providers/artworks.dart';
import '../../providers/categories.dart';
import '../../providers/tickets.dart';
import '../../providers/users.dart';
import '../../providers/bills.dart';
import '../../providers/user_tickets.dart';

import '../../widgets/main_menu_drawer.dart';
import '../../widgets/ticket_purchase/buy_ticket.dart';
import '../../widgets/my_reservations/my_reservations.dart';

class TicketPurchaseScreen extends StatelessWidget {
  static const routeName = '/TicketPurchase';
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context, listen: false).getUser();
    int tabIndex = ModalRoute.of(context).settings.arguments;
    Future<void> _refreshAllData() async {
      await Provider.of<Museums>(context, listen: false).fetchMuseums();
      await Provider.of<Artworks>(context, listen: false).fetchArtworks();
      await Provider.of<Tickets>(context, listen: false).fetchTickets();
      await Provider.of<Categories>(context, listen: false).fetchCategories();
      await Provider.of<WorkTimes>(context, listen: false).fetchWorkTimes("");
      await Provider.of<UserTickets>(context, listen: false).fetchUserTickets();
      await Provider.of<Bills>(context, listen: false).fetchBills();
      await Future.delayed(Duration(milliseconds: 700));
      _isFetched = true;
    }

    final color = Theme.of(context);

    final appBarProperty = AppBar(
      title: const Text('Tickets'),
      backgroundColor: color.primaryColor,
      bottom: TabBar(
        indicatorColor: color.highlightColor,
        labelStyle: color.textTheme.headline4,
        tabs: const [
          Tab(text: 'Buy tickets'),
          Tab(text: 'My reservations'),
        ],
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: CircleAvatar(
            backgroundImage: user.userImage == ""
                ? NetworkImage(
                    "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg")
                : NetworkImage(user.userImage),
          ),
          iconSize: 45,
          tooltip: 'Log out',
          onPressed: () {
            Navigator.of(context).pushNamed(MyProfileScreen.routeName);
          },
        )
      ],
    );

    return DefaultTabController(
      initialIndex: tabIndex ?? 0,
      length: 2,
      child: Scaffold(
        appBar: appBarProperty,
        drawer: MainMenuDrawer(),
        body: FutureBuilder(
            future: _isFetched ? null : _refreshAllData(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done ||
                  _isFetched) {
                return TabBarView(
                  children: [
                    BuyTicket(),
                    MyReservations(),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
