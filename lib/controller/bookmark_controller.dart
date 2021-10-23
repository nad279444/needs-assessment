import 'package:flutter/widgets.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_service.dart';
import "package:flutter/foundation.dart";


class BookmarkController with ChangeNotifier{
   //store all Bookmarks
  

  final BookmarkService _bookmarkService = BookmarkService();

   Future<List<RecipeModel>> getAllBookMarks() async{
     try {
       await _bookmarkService.open();
      List<RecipeModel>? recipes = await  _bookmarkService.getAllRecipe();
      if(recipes != null){
        notifyListeners();
        return recipes;
      }
      return [];
     } catch (error) {
       print("Error has occurred whilst fetching recipes $error");
       return [];
     }finally{
       await _bookmarkService.close();
     }
   }

   addToBookMarks(RecipeModel recipeModel)async {
     try {
       await _bookmarkService.open();
       RecipeModel recipe = await _bookmarkService.insert(recipeModel);
       print ('Added to bookMarks: ${recipe.toJson()}');
       await getAllBookMarks();
       notifyListeners();
     } catch (error) {
      print("Error has occurred whilst fetching recipes $error"); 
     }finally{
       await  _bookmarkService.close();
     }
   }

   Future<int>removeFromBookMarks(RecipeModel recipeModel) async {
     try {
       await _bookmarkService.open();
       int removeRecipe = await _bookmarkService.delete(recipeModel.id!);
       print ('delete $removeRecipe from bookMarks');
       await getAllBookMarks();
       return removeRecipe;
     } catch (error) {
      print("Error has occurred whilst fetching recipes $error");
      return 0; 
     }finally{
       await  _bookmarkService.close();
     }
  }
}