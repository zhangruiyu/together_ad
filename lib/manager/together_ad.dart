import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../ad/reward_ad.dart';
import '../type_build/type_build.dart';

/// 排序应该分2个
/// 1.随机播放
/// 2.按顺序播放

class TogetherAd {
  TogetherAd._();

  static final instance = TogetherAd._();
  Map<String, ItemAd> allAd = {};

  ///注册广告
  void register(String type, ItemAd itemAd) {
    allAd['type'] = itemAd;
  }

  void loadRewardAd(
    List<RewardVideoAd> typeAdList,
    StreamController<RewardAdCallback> streamController,
  ) async {
    if (allAd.isEmpty) {
      debugPrint('请先注册广告平台');
      return;
    }

    ///todo 这里可以对list进行排序 根据后端接口
    await for (var itemAd in Stream.fromIterable(typeAdList)) {
      Completer<bool> completer = Completer<bool>();
      itemAd.load(completer);
      if (await completer.future) {
        break;
      }
    }
    // RewardVideoAd loadType = (_getRandomLoadType(typeAdList) as RewardVideoAd);
  }

  ///生成随即数 获取当次该使用哪个sdk广告
  TypeBase _getRandomLoadType(List<TypeBase> typeAdList) {
    int sum = typeAdList.fold<int>(
        0,
        (int previousValue, TypeBase element) =>
            previousValue + element.probability);

    var rand = Random().nextInt(sum + 1);

    for (var value in typeAdList) {
      rand -= value.probability;
      //选中
      if (rand <= 0) {
        return value;
      }
    }
    return _getRandomLoadType(typeAdList);
  }
}

class ItemAd {
  ///开发时候备注而已
  String? remake;

  ItemAd(this.remake);
}
