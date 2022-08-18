import 'dart:async';

import 'package:flutter_unionad/flutter_unionad.dart';
import 'package:together_ad/ad/reward_ad.dart';

class HuaweiRewardVideoAd extends RewardVideoAd {
  String androidCodeId, iosCodeId, rewardName, userID, mediaExtra;
  int rewardAmount;

  HuaweiRewardVideoAd({
    required super.type,
    required this.androidCodeId,
    required this.iosCodeId,
    required this.rewardName,
    required this.userID,
    required this.mediaExtra,
    required this.rewardAmount,
    super.probability,
  });

  StreamSubscription? adSubscription;

  @override
  void initAdSubscription() {
    adSubscription = FlutterUnionadStream.initAdStream(
      //激励广告
      flutterUnionadRewardAdCallBack: FlutterUnionadRewardAdCallBack(
        onShow: () {},
        onClick: () {},
        onFail: (error) {
          adCompleter(false);
        },
        onClose: () {
          adCompleter(false);
        },
        onSkip: () {
          // print("激励广告跳过");
        },
        onReady: () async {},
        onUnReady: () {},
        onVerify: (rewardVerify, rewardAmount, rewardName, errorCode, error) {
          adCompleter(true);
          streamControllerAddEvent(
              RewardAdCallback(adType: type, actionType: 'verify', data: {
            'rewardVerify': rewardVerify,
            'rewardAmount': rewardAmount,
            'rewardName': rewardName,
            'errorCode': errorCode,
            'error': error,
          }));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    adSubscription?.cancel();
  }

  @override
  Future<void> loadAd() async {
    ///这里网络请求
    FlutterUnionad.loadRewardVideoAd(
        androidCodeId: androidCodeId,
        iosCodeId: iosCodeId,
        rewardName: rewardName,
        rewardAmount: rewardAmount,
        userID: userID,
        mediaExtra: mediaExtra);
  }
}
