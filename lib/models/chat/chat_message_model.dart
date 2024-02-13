class ChatMessageModel {
  String? message;
  bool? isCurrentUser;
  DateTime? messageAt;
  DateTime? updatedAt;

  ChatMessageModel(
      {this.message, this.isCurrentUser, this.messageAt, this.updatedAt});

 static List<ChatMessageModel> messages()=>[
    ChatMessageModel(
      message: "Hi",
      isCurrentUser: false,
      messageAt: DateTime.now(),
      updatedAt: DateTime.now()
    ),
    ChatMessageModel(
        message: "Hello",
        isCurrentUser: true,
        messageAt: DateTime.now(),
        updatedAt: DateTime.now()
    ),
    ChatMessageModel(
        message: "How are you?",
        isCurrentUser: false,
        messageAt: DateTime.now(),
        updatedAt: DateTime.now()
    )
  ];
}
