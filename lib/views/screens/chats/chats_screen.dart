import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/chat/chat_user_model.dart';
import 'package:baat_cheet_app/models/users/user_details_model.dart';
import 'package:baat_cheet_app/views/screens/chats/chats_widgets.dart';
import 'package:baat_cheet_app/views/screens/drawer/drawer_screen.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../controllers/chats/chat_controllers.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with ChatControllers {
  bool showSearchValue = true;
  var allUsers = ChatUserModel.chats();
  var searchedUsers = <ChatUserModel>[];

  @override
  void initState() {
    super.initState();
  }



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
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore.snapshots(),
              builder: (c, snapshot) {
                var data = snapshot.data?.docs
                        .map((e) => UserDetailsModel.fromJson(e.data()))
                        .toList() ??
                    List<UserDetailsModel>.empty();
                return data.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: SearchViewDelegate(data));
                        },
                        icon: const Icon(Icons.search))
                    : Container();
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.where("userId",isNotEqualTo: UsersController().getUserId).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          var data = snapshot.data?.docs
                  .map((e) => UserDetailsModel.fromJson(e.data()))
                  .toList() ??
              List<UserDetailsModel>.empty();
          if(snapshot.hasData){
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) => view.chatItemView(data[index]),
              separatorBuilder: (BuildContext context, int index) {
                return 1.height;
              },
            );

          }else{
            return view.chatShimmerView();
          }

        },
      ),
    );
  }
}

class SearchViewDelegate extends SearchDelegate {
  var users = <UserDetailsModel>[];

  SearchViewDelegate(this.users);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 10,
            backgroundColor: secondaryColor,
            iconTheme: IconThemeData()));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchingView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchingView(context);
  }

  searchingView(BuildContext context) {
    var view = ChatsWidgets(context: context);
    var searchUsers = [];
    for (var user in users) {
      if (user.name!.trim().toLowerCase().contains(query.toLowerCase())) {
        searchUsers.add(user);
      }
    }
    return ListView.separated(
      itemCount: searchUsers.length,
      itemBuilder: (context, index) => view.chatItemView(searchUsers[index]),
      separatorBuilder: (BuildContext context, int index) {
        return 1.height;
      },
    );
  }
}
