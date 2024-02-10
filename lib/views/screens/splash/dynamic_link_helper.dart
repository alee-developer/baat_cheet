import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHelper{
  final _dlInstance = FirebaseDynamicLinks.instance;

  Future<Uri> createLongLink({String sourceLink ="https://baat-cheet.com",String mainLink = "https://baatcheetapp.page.link/home" })async{
    var parameters = DynamicLinkParameters(link: Uri.parse(sourceLink), uriPrefix: mainLink);
    return await _dlInstance.buildLink(parameters);
  }

  Future<ShortDynamicLink> createShortLink({String sourceLink ="https://baat-cheet.com",String mainLink = "https://baatcheetapp.page.link/home" })async{
    var parameters = DynamicLinkParameters(link: Uri.parse(sourceLink), uriPrefix: mainLink);
    return await _dlInstance.buildShortLink(parameters,shortLinkType: ShortDynamicLinkType.short);
  }

  // from terminated state
  Future<PendingDynamicLinkData?> getInitLink() async => await _dlInstance.getInitialLink();

  // from background or foreground
  StreamSubscription<PendingDynamicLinkData> getStreamLink() =>_dlInstance.onLink.listen((event)=>event);

}