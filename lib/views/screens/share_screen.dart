import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: ()async{
           createProfileLink();
          }, icon: Icon(Icons.share))
        ],
      ),
    );
  }

  createProfileLink()async{
    var parameters = DynamicLinkParameters(link: Uri.parse("https://baat-cheet.com"), uriPrefix: 'https://baatcheetapp.page.link/home');
    var link = await FirebaseDynamicLinks.instance.buildLink(parameters);
    await Share.share(link.toString());
  }
}
