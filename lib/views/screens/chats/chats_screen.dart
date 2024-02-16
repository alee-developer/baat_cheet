import 'package:baat_cheet_app/models/chat/chat_user_model.dart';
import 'package:baat_cheet_app/views/screens/chats/chats_widgets.dart';
import 'package:baat_cheet_app/views/screens/drawer/drawer_screen.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool showSearchValue = true;
  var allUsers = ChatUserModel.chats();
  var searchedUsers = <ChatUserModel>[];

  @override
  Widget build(BuildContext context) {
    var view = ChatsWidgets(context: context);
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 10,
        title: const Text("Chats"),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: SearchViewDelegate(allUsers));
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: ListView.separated(
        itemCount:
        allUsers.length,
        itemBuilder: (context, index) => view.chatItemView(
            allUsers[index]),
        separatorBuilder: (BuildContext context, int index) {
          return 1.height;
        },
      ),
    );
  }
}

class SearchViewDelegate extends SearchDelegate {
  var users = <ChatUserModel>[];
  SearchViewDelegate(this.users);
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 10,
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData()
      )
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton(onPressed: (){
       query = '';
     }, icon: const Icon(Icons.clear))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchingView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchingView(context);
  }

  searchingView(BuildContext context){
    var view = ChatsWidgets(context: context);
    var searchUsers = [];
    for(var user in users){
      if(user.title!.trim().toLowerCase().contains(query)){
        searchUsers.add(user);
      }
    }
    return ListView.separated(
      itemCount:
      searchUsers.length,
      itemBuilder: (context, index) => view.chatItemView(
          searchUsers[index]),
      separatorBuilder: (BuildContext context, int index) {
        return 1.height;
      },
    );
  }

}

