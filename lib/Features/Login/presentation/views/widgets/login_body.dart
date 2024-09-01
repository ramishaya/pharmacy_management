import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/app_router.dart';

import 'package:pharmacy/Core/widgets/custom_button.dart';
import 'package:pharmacy/Core/widgets/custom_error_widget.dart';
import 'package:pharmacy/Core/widgets/custom_loading_indecator.dart';
import 'package:pharmacy/Features/Login/presentation/view_models/login_cubit/login_cubit.dart';

import '../../../../../Core/utils/assets_data.dart';
import '../../../../../Core/utils/my_text_styles.dart';
import '../../../../../Core/utils/shared_preferences.dart';
import '../../../../../Core/widgets/custom_input_field.dart';
import '../../../../../constants.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final LoginCubit loginCubit;
  void initShared() async {
    await SharedPref.init();
  }

  @override
  void initState() {
    loginCubit = BlocProvider.of<LoginCubit>(context);
    initShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController mobilenumberController =
        TextEditingController();

    final TextEditingController passwordController = TextEditingController();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // ignore: avoid_print
          print("Login is Success Congrats!");

          SharedPref.saveData(key: 'token', value: state.info.data!.token);
          // ignore: prefer_interpolation_to_compose_strings, avoid_print
          print("THE USER Token : ");
          // ignore: avoid_print
          print(state.info.data!.token);

          GoRouter.of(context).pushReplacementNamed(AppRouter.kHomeView,
              extra: state.info.data!.username);
        }
      },
      builder: (context, state) {
        if (state is LoginInitial) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetsData.pharmacyLogo),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * sidesmargin,
                    right: size.width * sidesmargin,
                    bottom: size.width * sidesmargin,
                  ),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: MyTextStyles.bigTextSize,
                        fontWeight: FontWeight.bold,
                        shadows: [MyTextStyles.textShadow],
                      ),
                      children: [
                        TextSpan(
                          text: 'Login\n',
                          style: TextStyle(
                              color: MyTextStyles.mytextColor,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: 'with ',
                          style: TextStyle(
                              color: MyTextStyles.mytextColor,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: 'your Information',
                          style: TextStyle(
                              color: MyTextStyles.mytextColor,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputField(
                  size: size,
                  mobilenumberController: mobilenumberController,
                  hintText: "Enter Your Phone Number",
                  labelText: "Enter Your Phone Number",
                  fieldColor: kprimecolor,
                  icon: Icons.numbers,
                  isObscure: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                CustomInputField(
                  size: size,
                  mobilenumberController: passwordController,
                  hintText: "Enter Your Password",
                  labelText: "Enter Your Password",
                  fieldColor: kprimecolor,
                  icon: Icons.password,
                  isObscure: true,
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: size.width * sidesmargin,
                      right: size.width * sidesmargin,
                      bottom: size.width * sidesmargin,
                    ),
                    child: CustomButton(
                      text: 'Login',
                      onPressed: () {
                        loginCubit.loginUserInfo(
                            phoneNumber: mobilenumberController.text,
                            password: passwordController.text);
                      },
                      width: double.maxFinite,
                      height: size.height * 0.064,
                    ))
              ],
            ),
          );
        } else if (state is LoginFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const CustomLoadingIndecator();
        }
      },
    );
  }
}
