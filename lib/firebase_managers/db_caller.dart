import '../models/category_artwork.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBCaller {
  //----------User----------//
  static void createUser(User user, String id) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(id).set(user.toJson());
  }
  //----------Categories----------//
  static void createCategory(CategoryArtwork category){
    CollectionReference categories = FirebaseFirestore.instance.collection("categories");
    categories.add(category.toJson()); 
  }

}
