import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends SearchDelegate<String> {

  List<String> keywords = [];
  List<String> result = [];

  Future<void> addKeywords(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      keywords.add(value);
    prefs.setStringList('keywords', keywords);
    getKeywords(value);
  }

  Future<void> getKeywords(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    result= prefs.getStringList('keywords');
    print(result);
    return keywords;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
   return [
     IconButton(onPressed: (){
       query = '';
     },
       icon: Icon(Icons.clear)
       ),
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){Navigator.pop(context);},
      icon: Icon(Icons.arrow_back),
    );
    
  }

  @override
  Widget buildResults(BuildContext context) {
    final datasearch = keywords.where((element){
      return element.toLowerCase().contains(query.toLowerCase());
    });

    if (datasearch.isEmpty){
      addKeywords(query);
    }
    return ListView.builder(
      itemCount: datasearch.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(datasearch.elementAt(index)),
          leading: Icon(Icons.history), 
          );
      },

      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final datasearch = keywords.where((element){
      return element.toString().toLowerCase().contains(query.toLowerCase());
    });
    return ListView.builder(
      itemCount: datasearch.length, 
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(datasearch.elementAt(index)),
          leading: Icon(Icons.history),
          trailing: Icon(Icons.north_west),
        );
      },);
  }
}
