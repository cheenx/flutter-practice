import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/widget/diff_scale_text.dart';
import 'package:gsy_github_app/widget/mole_widget.dart';
import 'package:rive/rive.dart';

/// 欢迎页
class WelcomePage extends StatefulWidget {
  static const String sName = "/";

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool haInit = false;
  String text = "";
  double fontSize = 60;
  double size = 200;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (haInit) {
      return;
    }
    haInit = true;

    //防止多次进入
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        text = "Welcome";
        fontSize = 60;
      });
    });

    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        text = "GithubApp";
        fontSize = 60;
      });
    });

    Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
      NavigatorUtils.goLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: GSYColors.white,
        child: Stack(
          children: [
            const Center(
              child: Image(image: AssetImage('static/images/welcome.png')),
            ),
            Align(
              alignment: const Alignment(0.0, 0.3),
              child: DiffScaleText(
                text: text,
                textStyle: GoogleFonts.akronim().copyWith(
                  color: GSYColors.primaryDarkValue,
                  fontSize: fontSize,
                ),
              ),
            ),
            const Align(
              alignment: Alignment(0.0, 0.8),
              child: Mole(),
            ),
            Align(
              alignment: const Alignment(0.0, .9),
              child: SizedBox(
                width: size,
                height: size,
                child: RiveAnimation.asset(
                  'static/file/launch.riv',
                  animations: const ["lookUp"],
                  onInit: (arb) {
                    var controller =
                        StateMachineController.fromArtboard(arb, "birb");
                    var smi = controller?.findInput<bool>("dance");
                    arb.addController(controller!);
                    smi?.value == true;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
