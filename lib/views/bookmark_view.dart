import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/controller/bookmark_controller.dart';
import 'package:recipe_app/model/recipe_model.dart';

//TODO: GET ALL BOOKMARKED RECIPES
//TODO: DELETE RECIPE

class BookmarkView extends StatelessWidget {
  const BookmarkView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookmarkController>(
      create: (context) => BookmarkController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookmark'),
        ),
        body: Consumer<BookmarkController>(
          builder: (context,bookmarkController,child){
              return FutureBuilder(
                future: bookmarkController.getAllBookMarks() ,
                builder: (context,AsyncSnapshot<List<RecipeModel>>snapshot){
        
            if(snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData ){
              return const CircularProgressIndicator();
            }
            return ListView.separated(
              itemBuilder: (BuildContext context,int index){
                RecipeModel recipeModel = snapshot.data![index];
                  return ListTile(
                    title: Text(recipeModel.title),
                    trailing:   IconButton(
                      onPressed: () async {
                        await bookmarkController.removeFromBookMarks(recipeModel);
                      },
                      icon: const  Icon(Icons.delete_forever_outlined,),
                  ));
              }, 
              separatorBuilder: (BuildContext context,int index){
                  return const Divider();
              }, 
              itemCount: snapshot.data!.length);
          });
          },
           
        )
      ),
    );
  }
}