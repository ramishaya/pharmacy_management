import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Features/Login/data/repos/login_repo_impl.dart';
import 'package:pharmacy/Features/Login/presentation/view_models/logout_cubit/logout_cubit.dart';

import '../../../../Core/utils/service_locator.dart';
import '../../../../Core/utils/shared_preferences.dart';
import '../../../../Core/widgets copy/custom_button.dart';
import '../../../../Core/widgets copy/custom_error_widget.dart';
import '../../../../Core/widgets copy/custom_loading_indecator.dart';
import '../../../../constants.dart';

class LogoutView extends StatefulWidget {
  const LogoutView({super.key});

  @override
  State<LogoutView> createState() => _LogoutViewState();
}

class _LogoutViewState extends State<LogoutView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LogoutCubit(getIt.get<LoginRepoImpl>()),
      child: Scaffold(
          body: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            // ignore: avoid_print
            print("Login is Success Congrats!");

            SharedPref.removeData(key: 'token');
            // ignore: prefer_interpolation_to_compose_strings, avoid_print
            print("THE USER Token : ");
            // ignore: avoid_print

            GoRouter.of(context).pushReplacementNamed('/');
          }
        },
        builder: (context, state) {
          if (state is LogoutInitial) {
            return Padding(
              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * sidesmargin,
                                  vertical: size.height * verticalMargin),
              child: Center(
                child: CustomButton(
                  text: 'Logout',
                  onPressed: () {
                    BlocProvider.of<LogoutCubit>(context).logout();
                  },
                  width: double.maxFinite,
                  height: size.height * 0.064,
                ),
              ),
            );
          } else if (state is LogoutFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else {
            return const CustomLoadingIndecator();
          }
        },
      )),
    );
  }
}
