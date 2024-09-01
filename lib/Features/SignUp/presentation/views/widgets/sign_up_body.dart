import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/app_router.dart';
import 'package:pharmacy/Core/widgets/custom_button.dart';
import 'package:pharmacy/Core/widgets/custom_error_widget.dart';
import 'package:pharmacy/Features/SignUp/presentation/view_models/sign_up_cubit/signup_cubit.dart';

import '../../../../../Core/utils/assets_data.dart';
import '../../../../../Core/utils/my_text_styles.dart';
import '../../../../../Core/widgets/custom_input_field.dart';
import '../../../../../Core/widgets/custom_loading_indecator.dart';
import '../../../../../constants.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late final SignupCubit signupCubit;
  @override
  void initState() {
    signupCubit = BlocProvider.of<SignupCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController mobilenumberController =
        TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocConsumer<SignupCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // ignore: avoid_print
          print("sign up is successe Congrats!");
          GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
        }
      },
      builder: (context, state) {
        if (state is SignUpInitial) {
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
                          text: 'SignUp\n',
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
                  mobilenumberController: nameController,
                  hintText: "Enter Your Name",
                  labelText: "Enter Your Name",
                  fieldColor: kprimecolor,
                  icon: Icons.person,
                  isObscure: false,
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
                      text: 'SignUp',
                      onPressed: () {
                        signupCubit.signUpUserInfo(
                          username: nameController.text,
                          phoneNumber: mobilenumberController.text,
                          password: passwordController.text,
                        );
                      },
                      width: double.maxFinite,
                      height: size.height * 0.064,
                    ))
              ],
            ),
          );
        } else if (state is SignUpFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const CustomLoadingIndecator();
        }
      },
    );
  }
}
