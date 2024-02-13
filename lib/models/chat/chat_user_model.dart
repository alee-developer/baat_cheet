class ChatUserModel{
  String? title;
  String? subTitle;
  String? imagePath;
  ChatUserModel({this.title,this.imagePath,this.subTitle});

  static List<ChatUserModel> chats() => [
    ChatUserModel(
      title: "Ansar Ali",
      subTitle: "this is ansar's title",
      imagePath: "assets/icons/email_image.png"
    ),
    ChatUserModel(
        title: "Ali",
        subTitle: "this title",
        imagePath: "assets/icons/email_image.png"
    ),
    ChatUserModel(
        title: "Ansar Ali",
        subTitle: "this is ansar's title",
        imagePath: "assets/icons/google_image.png"
    )
  ];
}