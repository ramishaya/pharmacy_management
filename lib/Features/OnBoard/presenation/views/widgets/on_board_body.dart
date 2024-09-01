import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/app_router.dart';

import 'package:pharmacy/Core/utils/assets_data.dart';

import '../../../../../Core/utils/my_text_styles.dart';

import '../../../../../Core/widgets/custom_outlined_buttom.dart';
import '../../../../../constants.dart';

class OnBoardBody extends StatelessWidget {
  const OnBoardBody({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsData.pahr1),
                    fit: BoxFit.cover)),
          )),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    fadeInColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * sidesmargin,
            right: size.width * sidesmargin,
            top: size.height * 0.356,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: MyTextStyles.bigTextSize,
                      fontWeight: FontWeight.bold,
                      shadows: [MyTextStyles.textShadow],
                    ),
                    children: [
                      TextSpan(
                        text: 'Order\n',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'the Best ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Medicine\n',
                        style: TextStyle(
                            color: MyTextStyles.mytextColor,
                            fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: 'in ',
                        style: TextStyle(
                            color: MyTextStyles.mytextColor,
                            fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: 'one step',
                        style: TextStyle(
                            color: MyTextStyles.mytextColor,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                    'We are fully prepared to help you and your pharmacy to get the best Medicine in the market.',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: MyTextStyles.thinTextWeight,
                      shadows: [MyTextStyles.textShadow],
                    )),
              ],
            ),
          ),
          Positioned(
            left: size.width * sidesmargin,
            right: size.width * sidesmargin,
            bottom: size.width * sidesmargin,
            child: Column(
              children: <Widget>[
                CustomOutlinedButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kLoginView);
                  },
                  text: "Login",
                  width: double.maxFinite,
                  height: size.height * 0.064,
                  //imageIcon: AssetsData.emailIcon,
                  radius: 30,
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: MyTextStyles.thinTextWeight,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.kSignupView);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: MyTextStyles.mytextColor,
                              fontWeight: MyTextStyles.thinTextWeight),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
