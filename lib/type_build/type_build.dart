typedef LoadAdCallback = Future<void> Function();

class TypeBase {
  ///类型
  String type;

  ///展示的比例
  int probability;

  TypeBase({
    required this.type,
    this.probability = 1,
  });

  void initAdSubscription() {}

  void dispose() async {}
}
