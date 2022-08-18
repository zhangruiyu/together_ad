import 'dart:async';
import 'dart:ui';

import '../type_build/type_build.dart';

abstract class RewardVideoAd extends TypeBase {
  StreamController<RewardAdCallback>? streamController;
  Completer<bool>? _adCompleter;

  RewardVideoAd({
    required super.type,
    super.probability,
  });

  Future<void> load(
    Completer<bool> adCompleter,
  ) async {
    initAdSubscription();
    _adCompleter = adCompleter;
    loadAd();
  }

  Future<void> loadAd();

  void streamControllerAddEvent(RewardAdCallback event) {
    if (streamController != null && !streamController!.isClosed) {
      streamController!.add(event);
    }
  }

  void adCompleter(bool result) {
    if (_adCompleter != null && !_adCompleter!.isCompleted) {
      _adCompleter!.complete(result);
    }
  }
}

class RewardAdCallback {
  String adType;
  String actionType;
  dynamic data;

  bool get success => actionType == 'verify';

  RewardAdCallback({required this.adType, required this.actionType, this.data});
}

///
/// 激励广告回调
///
class RewardCallBack {
  OnShow? onShow;
  OnClose? onClose;
  OnClick? onClick;
  OnFail? onFail;
  OnReady? onReady;
  OnUnReady? onUnReady;
  OnVerify? onVerify;

  RewardCallBack({
    this.onShow,
    this.onClose,
    this.onClick,
    this.onFail,
    this.onReady,
    this.onUnReady,
    this.onVerify,
  });
}

///显示
typedef OnShow = void Function(int sdkType);

///失败
typedef OnFail = void Function(int sdkType, int code, dynamic message);

///点击
typedef OnClick = void Function(int sdkType);

///关闭
typedef OnClose = void Function(int sdkType);

///广告预加载完成
typedef OnReady = void Function(int sdkType);

///广告预加载未完成
typedef OnUnReady = void Function(int sdkType);

///广告奖励验证
typedef OnVerify = void Function(
    int sdkType, String transId, bool verify, int amount, String name);
