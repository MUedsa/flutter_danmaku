// 弹幕主场景
import 'package:flutter/material.dart';
import 'package:flutter_danmaku/flutter_danmaku.dart';
import 'package:flutter_danmaku/src/config.dart';

class FlutterDanmakuArea extends StatefulWidget {
  const FlutterDanmakuArea({required this.controller, Key? key})
      : super(key: key);

  final FlutterDanmakuController controller;

  // TODO 不知道什么用 final Function(FlutterDanmakuBulletModel)? bulletTapCallBack;

  @override
  State<FlutterDanmakuArea> createState() => FlutterDanmakuAreaState();
}

class FlutterDanmakuAreaState extends State<FlutterDanmakuArea> {
  late final FlutterDanmakuController controller;

  @override
  void initState() {
    super.initState();
    widget.controller.setState = setState;
    controller = widget.controller;
  }

  // 构建全部的子弹
  List<Widget> buildAllBullet(BuildContext context) {
    return List.generate(controller.bullets.length,
        (index) => buildBulletToScreen(context, controller.bullets[index]));
  }

  // 构建子弹
  Widget buildBulletToScreen(
      BuildContext context, FlutterDanmakuBulletModel bulletModel) {
    FlutterDanmakuBullet bullet = FlutterDanmakuBullet(
        bulletModel.id, bulletModel.text,
        color: bulletModel.color, builder: bulletModel.builder);
    return Positioned(
        right: bulletModel.offsetX,
        top: bulletModel.offsetY + FlutterDanmakuConfig.areaOfChildOffsetY,
        child: FlutterDanmakuConfig.bulletTapCallBack == null
            ? bullet
            : GestureDetector(
                onTap: () =>
                    FlutterDanmakuConfig.bulletTapCallBack!(bulletModel),
                child: bullet));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FlutterDanmakuConfig.areaSize.height,
      width: FlutterDanmakuConfig.areaSize.width,
      child: Stack(
        children: [...buildAllBullet(context)],
      ),
    );
  }
}
