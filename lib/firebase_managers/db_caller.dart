import '../models/category_artwork.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBCaller {
  static final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  static final CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  //----------User----------//
  static void createUser(User user, String id) {
    users.doc(id).set(user.toJson());
  }

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
}
