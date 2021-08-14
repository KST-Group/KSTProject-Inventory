import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/settings/controllers/setting_controller.dart';

// class SettingView extends GetView<SettingController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Setting Page'),
//       ),
//     );
//   }
// }

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double bigLogo = 200;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size biggest = constraints.biggest;
        return Stack(
          children: <Widget>[
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(
                        500, 0, bigLogo, bigLogo),
                    biggest),
                end: RelativeRect.fromSize(
                    const Rect.fromLTWH(0, 0, bigLogo, bigLogo), biggest),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.bounceIn,
              )),
              child: const Padding(
                  padding: EdgeInsets.all(8), child: FlutterLogo()),
            ),
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(
                        500, 0, bigLogo, bigLogo),
                    biggest),
                end: RelativeRect.fromSize(
                    const Rect.fromLTWH(0, 0, bigLogo, bigLogo), biggest),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.bounceIn,
              )),
              child: const Padding(
                  padding: EdgeInsets.all(8), child: FlutterLogo()),
            ),
          ],
        );
      },
    );
  }
}
