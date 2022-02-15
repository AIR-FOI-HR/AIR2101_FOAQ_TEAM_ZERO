// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:museum_app/screens/about_us.dart';
import 'package:museum_app/screens/login/password_reset.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/museums.dart';
import './providers/categories.dart';
import './providers/artworks.dart';
import './providers/users.dart';
import './providers/tickets.dart';
import './providers/work_times.dart';
import './providers/bills.dart';
import './providers/user_tickets.dart';
import './providers/museums_halls.dart';

import './screens/homepage/museums_overview_screen.dart';
import './screens/museum_detail_screen.dart';
import './screens/categories/category_artwork_screen.dart';
import './screens/categories/category_artwork_editing_screen.dart';
import './screens/ticket_purchase/buy_ticket_screen.dart';
import './screens/login/login_screen.dart';
import './screens/artworks/manage_artworks_screen.dart';
import './screens/login/registration_screen.dart';
import './screens/my_profile/my_profile_screen.dart';
import './screens/my_profile/my_profile_editing_screen.dart';
import './screens/single_musem_configuration/single_museum_configuration_screen.dart';
import './screens/single_musem_configuration/ticket_crud_screen.dart';
import './screens/single_musem_configuration/museum_work_time_crud_screen.dart';
import './screens/artworks/edit_add_artworks_screen.dart';
import './screens/ticket_purchase/ticket_purchase_screen.dart';
import './screens/ticket_purchase/bill_details_screen.dart';
import './screens/navigation_support/navigation_support_screen.dart';
import './screens/navigation_support/museum_nav_supp_screen.dart';
import './screens/navigation_support/museum_nav_supp_crud_screen.dart';
import './screens/artworks/favorite_artworks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Museums(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Artworks(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Tickets(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => WorkTimes(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Bills(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserTickets(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => MuseumsHalls(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Museum Guide',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(19, 92, 97, 1),
          accentColor: Color.fromRGBO(0, 201, 224, 1),
          primaryColorLight: Color.fromRGBO(93, 158, 163, 1),
          cardColor: Color.fromRGBO(59, 124, 129, 1),
          primaryColorDark: Color.fromRGBO(0, 39, 44, 1),
          highlightColor: Color.fromRGBO(255, 138, 68, 1),
          shadowColor: Color.fromRGBO(212, 204, 168, 1),
          buttonColor: Color.fromRGBO(207, 146, 42, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
                headline5: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
                headline4: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
                headline3: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
                headline2: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: Color.fromRGBO(212, 204, 168, 1),
                ),
                headline1: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Color.fromRGBO(212, 204, 168, 1),
                ),
                button: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  backgroundColor: Color.fromRGBO(255, 138, 68, 1),
                ),
              ),
        ),
        home: MuseumsOverviewScreen(),
        routes: {
          CategoryArtworkScreen.routeName: (ctx) => CategoryArtworkScreen(),
          MuseumDetailScreen.routeName: (ctx) => MuseumDetailScreen(),
          CategoryArtworkEditingScreen.routeName: (ctx) =>
              CategoryArtworkEditingScreen(),
          BuyTicketScreen.routeName: (ctx) => BuyTicketScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          ManageArtworksScreen.routeName: (ctx) => ManageArtworksScreen(),
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
          MyProfileEditingScreen.routeName: (ctx) => MyProfileEditingScreen(),
          SingleMuseumConfigurationScreen.routeName: (ctx) =>
              SingleMuseumConfigurationScreen(),
          TicketCrudScreen.routeName: (ctx) => TicketCrudScreen(),
          MuseumWorkTimeCrudScreen.routeName: (ctx) =>
              MuseumWorkTimeCrudScreen(),
          EditAddArtworksScreen.routeName: (ctx) => EditAddArtworksScreen(),
          TicketPurchaseScreen.routeName: (ctx) => TicketPurchaseScreen(),
          BillDetailsScreen.routeName: (ctx) => BillDetailsScreen(),
          NavigationSupportScreen.routeName: (ctx) => NavigationSupportScreen(),
          MuseumNavSuppScreen.routeName: (ctx) => MuseumNavSuppScreen(),
          MuseumNavSuppCrudScreen.routeName: (ctx) => MuseumNavSuppCrudScreen(),
          FavoriteArtworks.routeName: (ctx) => FavoriteArtworks(),
          AboutUs.routeName: (ctx) => AboutUs(),
          PasswordReset.routeName: (ctx) => PasswordReset(),
        },
      ),
    );
  }
}
