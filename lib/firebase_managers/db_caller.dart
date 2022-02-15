import 'package:museum_app/models/work_time.dart';

import '../models/category_artwork.dart';
import '../models/user.dart';
import '../models/museum.dart';
import '../models/artwork.dart';
import '../models/ticket.dart';
import '../models/bill.dart';
import '../models/user_ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBCaller {
  //----------Collection references----------//
  static final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  static final CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

  static final CollectionReference museums =
      FirebaseFirestore.instance.collection("museums");

  static final CollectionReference artworks =
      FirebaseFirestore.instance.collection("artworks");

  static final CollectionReference tickets =
      FirebaseFirestore.instance.collection("tickets");

  static final CollectionReference worktimes =
      FirebaseFirestore.instance.collection("worktimes");

  static final CollectionReference bills =
      FirebaseFirestore.instance.collection("bills");

  static final CollectionReference userTickets =
      FirebaseFirestore.instance.collection("userTickets");

  //----------User----------//
  static void createUser(User user, String id) {
    users.doc(id).set(user.toJson());
  }

  static void updateUser(User user) async {
    return await users
        .doc(user.id)
        .update(user.toJson())
        .then((_) => print("User update"))
        .catchError((error) => print("Failed to update user"));
  }

  //----------Categories----------//
  static Future<void> addCategory(CategoryArtwork category) async {
    return await categories
        .add(category.toJson())
        .then((_) => print("Category added"))
        .catchError((error) => print("Failed to add category"));
  }

  static Future<void> deleteCategory(String categoryId) async {
    return await categories
        .doc(categoryId)
        .delete()
        .then((_) => print("Category ${categoryId} deleted"))
        .catchError((_) => print("Failed to delete category"));
  }

  static Future<void> updateCategory(CategoryArtwork category) async {
    return await categories
        .doc(category.id)
        .update({'name': category.name})
        .then((_) => print("Category updated"))
        .catchError((_) => print("Error while updating"));
  }

  //----------Artworks----------//
  static Future<void> addArtwork(Artwork artwork) async {
    return await artworks
        .add(artwork.toJson())
        .then((_) => print("Artowrk added"))
        .catchError((_) => print("Failed to add artwork"));
  }

  static Future<void> deleteArtwork(String artworkId) async {
    return await artworks
        .doc(artworkId)
        .delete()
        .then((_) => print("Artwork ${artworkId} deleted"))
        .catchError((_) => print("Failed to delete artwork"));
  }

  static Future<void> updateArtwork(Artwork artwork) async {
    return await artworks
        .doc(artwork.id)
        .update(artwork.toJson())
        .then((_) => print("Artwork updated"))
        .catchError((_) => print("Error while updating"));
  }

  //----------Museums----------//

  static Future<void> addMuseum(Museum museum) async {
    return await museums
        .add(museum.toJson())
        .then((_) => print("Museum added"))
        .catchError((_) => print("Failed to add museum"));
  }

  static Future<void> updateMuseum(Museum museum) async {
    return await museums
        .doc(museum.id)
        .update(museum.toJson())
        .then((_) => print("Museum updated"))
        .catchError((_) => print("Error while updating"));
  }

  //----------Tickets----------//

  static Future<void> addTicket(Ticket ticket) async {
    return await tickets
        .add(ticket.toJson())
        .then((_) => print("Museum added"))
        .catchError((_) => print("Failed to add ticket"));
  }

  static Future<void> deleteTicket(String ticketId) async {
    return await tickets
        .doc(ticketId)
        .delete()
        .then((_) => print("Ticket ${ticketId} deleted"))
        .catchError((_) => print("Failed to delete ticket"));
  }

  static Future<void> updateTicket(Ticket ticket) async {
    return await tickets
        .doc(ticket.id)
        .update(ticket.toJson())
        .then((_) => print("Ticket updated"))
        .catchError((_) => print("Error while updating"));
  }

  //----------Work Time----------//

  static Future<void> addWorkTime(WorkTime worktime) async {
    return await worktimes
        .add(worktime.toJson())
        .then((_) => print("WorkTime added"))
        .catchError((_) => print("Failed to add work time"));
  }

  static Future<void> updateWorkTime(WorkTime workTime) async {
    return await worktimes
        .doc(workTime.id)
        .update(workTime.toJson())
        .then((_) => print("WorkTime updated"))
        .catchError((_) => print("Error while updating"));
  }

  //----------Bill----------//

  static Future<String> addBill(Bill bill) async {
    String id;
    await bills
        .add(bill.toJson())
        .then((value) => id = value.id)
        .catchError((_) => print("Failed to add bill"));
    return id;
  }

  static Future<void> updateBill(Bill bill) async {
    return await bills
        .doc(bill.id)
        .update(bill.toJson())
        .then((_) => print("Bill updated"))
        .catchError((_) => print("Error while updating"));
  }

  static Future<void> deleteBill(String billId) async {
    return await bills
        .doc(billId)
        .delete()
        .then((_) => print("Bill ${billId} deleted"))
        .catchError((_) => print("Failed to delete bill"));
  }
  //----------Biil | User Tickets----------//

  static Future<void> addUserTicket(UserTicket userTicket) async {
    return await userTickets
        .add(userTicket.toJson())
        .then((_) => print("UserTicket added"))
        .catchError((_) => print("Failed to add userTicket"));
  }

  static Future<void> deleteUserTicket(String billId) async {
    return await userTickets
        .where("bill", isEqualTo: billId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userTickets
            .doc(element.id)
            .delete()
            .then((value) => print("User ticket deleted"));
      });
    });
  }
}
