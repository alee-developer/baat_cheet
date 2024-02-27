import 'package:baat_cheet_app/controllers/users/users_controller.dart';
import 'package:baat_cheet_app/models/users/user_details_model.dart';
import 'package:baat_cheet_app/views/screens/profile/profile_widgets.dart';
import 'package:baat_cheet_app/views/utils/extensions/context_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:baat_cheet_app/views/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/builders/loader_builder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile imageFile = XFile("");
  bool editName = false;
  bool editAbout = false;
  UserDetailsModel userData = UserDetailsModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String imagePath = "";
  bool hasImagePath = false;
  bool showLoader = true;
  var imageUrl = "";

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    getUserDetails();
  }

  getUserDetails() async {
    userData = await UsersController().getUserDetails();
    setState(() {});
    if (userData.imageUrl != null && userData.imageUrl !="") {
      imagePath = userData.imageUrl ?? "";
      hasImagePath = true;
    }
    // hasImagePath = false;
    showLoader = false;
    aboutController =
        TextEditingController(text: userData.about ?? "About you?");
    nameController = TextEditingController(text: userData.name);
  }

  @override
  Widget build(BuildContext context) {
    var view = ProfileWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Profile"),
      ),
      body: showLoader ? view.profileShimmerView() : mainView(),
    );
  }

  Widget mainView() {
    var view = ProfileWidgets(context: context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
      children: [
        view.userImageView(imagePath, hasImagePath, onPressed: () {
          showTakeImageView(context);
        }).center(),
        20.height,
        view.itemView(nameController, canEdit: editName, onPressed: () {
          setState(() {
            editName = !editName;
          });
        }),
        16.height,
        view.itemView(TextEditingController(text: userData.email ?? "")),
        16.height,
        view.itemView(aboutController, canEdit: editAbout, onPressed: () {
          setState(() {
            editAbout = !editAbout;
          });
        }),
        40.height,
        view.itemButton(
            enabled: editAbout
                ? editAbout
                : editName
                    ? editName
                    : imageFile.path != ""
                        ? true
                        : false,
            onPressed: () async {
              LoaderBuilder(context: context).showLoader();
              if (imageFile.path != "") {
                imageUrl =
                    await UsersController().uploadProfilePicture(imageFile);
              }
              var userController = UsersController();
              var data = UserDetailsModel(
                  userId: userController.getUserId,
                  createdAt: userData.createdAt,
                  updatedAt: DateTime.now(),
                  name: nameController.text,
                  email: userData.email,
                  about: aboutController.text,
                  imageUrl: imageUrl != "" ? imageUrl : userData.imageUrl);
              await userController.updateUser(data);
              if (!mounted) return;
              LoaderBuilder(context: context).dismissLoader();
            })
      ],
    );
  }

  showTakeImageView(BuildContext context) {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text("Take Image!"),
            content:
                const Text("Take an image from gallery or camera to upload"),
            actions: [
              ElevatedButton.icon(
                  onPressed: () {
                    getImageFromSource(ImageSource.gallery);
                    context.onBackPressed;
                  },
                  icon: const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  )),
              10.width,
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    getImageFromSource(ImageSource.camera);
                    context.onBackPressed;
                  },
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                  label: const Text("Camera",
                      style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }

  getImageFromSource(ImageSource source) async {
    imageFile = (await ImagePicker().pickImage(source: source,imageQuality: 50)) ?? XFile("");
    setState(() {
      imagePath = imageFile.path;
      hasImagePath = false;
    });
  }
}
