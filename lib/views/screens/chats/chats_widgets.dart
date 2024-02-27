import 'package:baat_cheet_app/models/users/user_details_model.dart';
import 'package:baat_cheet_app/views/screens/chats/chat_details_screen.dart';
import 'package:baat_cheet_app/views/screens/profile/profile_widgets.dart';
import 'package:baat_cheet_app/views/utils/colors.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../utils/builders/shimmer_builder.dart';

class ChatsWidgets {
  BuildContext context;

  ChatsWidgets({required this.context});

  Widget chatItemView(UserDetailsModel data) {
    var view = ProfileWidgets(context: context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      tileColor: secondaryColor.withOpacity(.5),
      onTap: () {
         ChatDetailsScreen(userData: data).pushWithWidget(context: context);
      },

      leading: view.userImageView(
          data.imageUrl ?? "",
          data.imageUrl == null
              ? false
              : data.imageUrl != ""
                  ? true
                  : false,
          size: 50,
          showIcon: false),

      title: Text(data.name ?? "User Name"),
      subtitle: Text(data.about ?? "About"),
      // trailing: PopupMenuButton(
      //     itemBuilder: (BuildContext context) {
      //       return [
      //         const PopupMenuItem(
      //           child: Text("Profile"),
      //         ),
      //         const PopupMenuItem(
      //           child: Text("Delete"),
      //         )
      //       ];
      //     },
      //     icon: const Icon(Icons.more_vert)),
    );
  }

  Widget chatShimmerView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: 16,
      itemBuilder: (c, index) {
        return ShimmerBuilder().showRectangularShimmer(
            height: 60,
            width: context.fullWidth,
            baseColor: Colors.grey.shade300);
      },
      separatorBuilder: (BuildContext context, int index) {
        return 10.height;
      },
    );
  }
}
