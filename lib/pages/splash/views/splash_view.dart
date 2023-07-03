import 'package:erp_easy_chat_state/config/light_theme_colors.dart';
import 'package:erp_easy_chat_state/pages/login/views/login_view.dart';
import 'package:flutter/material.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginView(),));
    });
    return Scaffold(
      backgroundColor: LightThemeColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/bg_pattern.png", fit: BoxFit.cover,),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 60,
            right: 60,
            child: Image.asset("assets/images/logo.png"),
          ),
        ],
      )
    );
  }
}
