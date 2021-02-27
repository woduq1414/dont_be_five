
import 'dart:io' show Platform;

import 'package:ads/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';





class AdManager {

  static bool dontShowAd = true;

  static Ads _ads;

  static String _appId =  Platform.isIOS
      ? 'ca-app-pub-3940256099942544~1458002511' // iOS Test App ID
      : 'ca-app-pub-2755450101712612~4590691946';

  bool isDebug = false;


  static String _bannerUnitId ="ca-app-pub-2755450101712612/7398201576";
  static String _interstitialUnitId = "ca-app-pub-2755450101712612/3458956563";

  AdManager(){
    if(isDebug == true){
      _bannerUnitId = BannerAd.testAdUnitId;
      _interstitialUnitId = InterstitialAd.testAdUnitId;
      _appId = FirebaseAdMob.testAppId;
    }
  }






  /// Assign a listener.
  static MobileAdListener _eventListener = (MobileAdEvent event) {
    if (event == MobileAdEvent.clicked) {
      print("_eventListener: The opened ad is clicked on.");
    }
  };

  static void showBanner(
      {String adUnitId,
        AdSize size,
        List<String> keywords,
        String contentUrl,
        bool childDirected,
        List<String> testDevices,
        bool testing,
        MobileAdListener listener,
        State state,
        double anchorOffset,
        AnchorType anchorType}) =>
  dontShowAd != true ?
      _ads?.showBannerAd(
          adUnitId: adUnitId,
          size: size,
          keywords: keywords,
          contentUrl: contentUrl,
          childDirected: childDirected,
          testDevices: testDevices,
          testing: testing,
          listener: listener,
          state: state,
          anchorOffset: anchorOffset,
          anchorType: anchorType) : null;

  static void hideBanner() => _ads?.closeBannerAd();

  /// Call this static function in your State object's initState() function.
  static void init() =>  dontShowAd != true ? _ads ??= Ads(
    _appId,
    bannerUnitId: _bannerUnitId,
    keywords: <String>['games', 'computers', 'game', 'mobile'],
    contentUrl: 'http://www.ibm.com',
    childDirected: false,
    testDevices: ['Samsung_Galaxy_SII_API_26:5554'],
    testing: false,
    listener: _eventListener,
  ) : null;

  /// Remember to call this in the State object's dispose() function.
  static void dispose() => _ads?.dispose();
}