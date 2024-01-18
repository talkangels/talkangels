import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';

class DynamicLinkService {
  final firebaseDynamicLinks = FirebaseDynamicLinks.instance;
  final androidParameters = const AndroidParameters(
    packageName: "com.example.talkangels",
  );
  final iosParameters = const IOSParameters(
    bundleId: "",
    appStoreId: "",
  );

  final uriPrefix = "https://talkangels.page.link";
  Future<String> createShareProfileLink({required String? angelId}) async {
    const socialMetaTagParameters = SocialMetaTagParameters(
      title: "",
      description: "",
    );
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$uriPrefix/shareProfile?angelId=$angelId"),
      uriPrefix: uriPrefix,
      androidParameters: androidParameters,
      iosParameters: iosParameters,
      socialMetaTagParameters: socialMetaTagParameters,
    );

    final dynamicLink = await firebaseDynamicLinks.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    log("DYNAMIC_LINKS_PROFILE=====>>>>   ${dynamicLink.shortUrl.toString()}");
    return dynamicLink.shortUrl.toString();
  }

  Future handleDynamicLinks() async {
    final data = await firebaseDynamicLinks.getInitialLink();
    _handleDeepLink(data);

    firebaseDynamicLinks.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData);
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData? data) async {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      debugPrint('_handleDeepLink | deeplink: $deepLink');
      log("DEEPLINK===>>>   $deepLink");

      /// Profile Details
      var isProfile = deepLink.pathSegments.contains('shareProfile');
      if (isProfile) {
        var angelIdStr = deepLink.queryParameters['angelId'];

        String? angelIds =
            (angelIdStr?.isNotEmpty ?? false) ? angelIdStr : null;
        if (angelIds != null) {
          Get.toNamed(
            Routes.personDetailScreen,
            arguments: {
              "angel_id": angelIds,
            },
          );
        }
      }
    }
  }

  Uri urlWithQueryParams({
    required String url,
    Map<String, dynamic>? params,
  }) {
    if (params?.isNotEmpty ?? false) {
      var queryString = Uri(
        queryParameters: params!.map(
          (key, value) => MapEntry(key, "$value"),
        ),
      ).query;

      return Uri.parse("$url?$queryString");
    }
    return Uri.parse(url);
  }
}

/// App Link
class DynamicShareAppLinkService {
  final firebaseDynamicLinks = FirebaseDynamicLinks.instance;
  // String? shortLink;
  final androidParameters = const AndroidParameters(
    packageName: "com.example.talkangels",
  );
  final iosParameters = const IOSParameters(
    bundleId: "",
    appStoreId: "",
  );

  final uriPrefix = "https://talkangels.page.link";
  Future<String> createShareAppLink({required String? referCode}) async {
    const socialMetaTagParameters = SocialMetaTagParameters(
      title: "",
      description: "",
    );
    final dynamicShareAppLinkParams = DynamicLinkParameters(
      link: Uri.parse("$uriPrefix/refer?referCode=$referCode"),
      uriPrefix: uriPrefix,
      androidParameters: androidParameters,
      iosParameters: iosParameters,
      socialMetaTagParameters: socialMetaTagParameters,
    );

    final dynamicShareAppLink = await firebaseDynamicLinks.buildShortLink(
      dynamicShareAppLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    // shortLink = dynamicLink.shortUrl.toString();
    log("DYNAMIC_LINKS_PROFILE=====>>>>   ${dynamicShareAppLink.shortUrl.toString()}");
    return dynamicShareAppLink.shortUrl.toString();
  }

  Future handleDynamicShareAppLinks() async {
    final data = await firebaseDynamicLinks.getInitialLink();
    _handleDeepShareAppLink(data);

    firebaseDynamicLinks.onLink.listen((dynamicShareAppLinkData) {
      _handleDeepShareAppLink(dynamicShareAppLinkData);
    });
  }

  Future<void> _handleDeepShareAppLink(PendingDynamicLinkData? data) async {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      debugPrint('_handleDeepLink | deeplink: $deepLink');
      log("DEEPLINK===>>>   $deepLink");

      /// Profile Details
      var isRefer = deepLink.pathSegments.contains('referCode');
      if (isRefer) {
        var referStr = deepLink.queryParameters['referCode'];

        String? referCode = (referStr?.isNotEmpty ?? false) ? referStr : null;
        if (referCode != null) {
          Get.toNamed(
            Routes.loginScreen,
            arguments: {
              "refer_code": referCode,
            },
          );
        }
      }
    }
  }

  Uri urlWithQueryParams({
    required String url,
    Map<String, dynamic>? params,
  }) {
    if (params?.isNotEmpty ?? false) {
      var queryString = Uri(
        queryParameters: params!.map(
          (key, value) => MapEntry(key, "$value"),
        ),
      ).query;

      return Uri.parse("$url?$queryString");
    }
    return Uri.parse(url);
  }
}
