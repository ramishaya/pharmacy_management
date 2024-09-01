 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/service_locator.dart';

import 'package:pharmacy/Features/Home/data/repos/home_repo_impl.dart';

import 'package:pharmacy/Features/Home/presentation/view_models/all_medicines_cubit.dart/all_medicines_cubit.dart';
import 'package:pharmacy/Features/Home/presentation/view_models/my_requests_cubit/my_requests_cubit.dart';
import 'package:pharmacy/Features/Home/presentation/view_models/report_details_cubit/report_details_cubit.dart';

import 'package:pharmacy/Features/Home/presentation/views/orders_reports_view.dart';
import 'package:pharmacy/Features/Home/presentation/views/report_details_view.dart';
import 'package:pharmacy/Features/Login/data/repos/login_repo_impl.dart';
import 'package:pharmacy/Features/Login/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:pharmacy/Features/OnBoard/presenation/views/on_board_view.dart';
import 'package:pharmacy/Features/Search/data/repos/search_medicine_repo_impl.dart';
import 'package:pharmacy/Features/Search/presentation/view_models/add_fav_cubit/add_fav_cubit.dart';
import 'package:pharmacy/Features/Search/presentation/view_models/order_medicine_cubit/order_medicine_cubit.dart';
import 'package:pharmacy/Features/Search/presentation/views/med_details_view.dart';
import 'package:pharmacy/Features/Search/presentation/views/search_result_view.dart';
import 'package:pharmacy/Features/SignUp/data/repos/signup_repo_impl.dart';
import 'package:pharmacy/Features/SignUp/presentation/view_models/sign_up_cubit/signup_cubit.dart';

import '../../Features/Home/data/models/all_medicines_model.dart';
import '../../Features/Home/presentation/view_models/orders_report_cubit/orders_report_cubit.dart';
import '../../Features/Home/presentation/views/home_view.dart';
import '../../Features/Home/presentation/views/medicines_details_view.dart';
import '../../Features/Login/presentation/views/login_view.dart';
import '../../Features/Search/presentation/view_models/seacrh_medicine_cubit/search_medicine_cubit.dart';
import '../../Features/Search/presentation/view_models/show_medicine_details_cubit/show_medicine_details_cubit.dart';
import '../../Features/SignUp/presentation/views/sign_up_view.dart';

abstract class AppRouter {
  static const kSignupView = '/signUpView';
  static const kLoginView = '/LoginView';
  static const kSearchView = '/searchView';
  static const kHomeView = '/homeView';
  static const kMedicinesDetailsView = '/medicinesDetailsView';
  // Ensure this constant is correct
  static const kSearchResultView = '/searchResultView';
  static const kmedDetailsView = '/medDetailsView';
  static const kordersReportView = '/ordersReportView';
  static const kreportDetailsView = '/reportDetailsView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
         name: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const OnBoardView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0), // Top to Bottom
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: kSignupView,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => SignupCubit(getIt.get<SignUpRepoImpl>()),
            child: const SignUpView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0), // Bottom to Top
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: kLoginView,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => LoginCubit(getIt.get<LoginRepoImpl>()),
            child: const LoginView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
          path: kHomeView,
          name: '/homeView',
          pageBuilder: (context, state) {
            final username = state.extra as String;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: MultiBlocProvider(providers: [
                BlocProvider(
                  create: (context) =>
                      AllMedicinesCubit(getIt.get<HomeRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) =>
                      MyRequestsCubit(getIt.get<HomeRepoImpl>()),
                ),
              ], child: HomeView(userName: username)),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0), // Bottom to Top
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          }),
      GoRoute(
          path: kMedicinesDetailsView,
          pageBuilder: (context, state) {
            //final categoryName = state.pathParameters['categoryName'] ?? 'Unknown';
            final medicines = state.extra as List<Medicine>;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: MedicineDetailsView(medicines: medicines),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0), // Bottom to Top
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          }),
      GoRoute(
          path: kSearchResultView,
          pageBuilder: (context, state) {
            final searchKey = state.extra as String;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) =>
                    SearchMedicineCubit(getIt.get<SearchMedicineRepoImpl>()),
                child: SearchResultView(searchKey: searchKey),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          }),
      GoRoute(
          path: kmedDetailsView,
          pageBuilder: (context, state) {
            final id = state.extra as String;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: MultiBlocProvider(providers: [
                BlocProvider(
                  create: (context) => ShowMedicineDetailsCubit(
                      getIt.get<SearchMedicineRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) =>
                      AddFavCubit(getIt.get<SearchMedicineRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) =>
                      OrderMedicineCubit(getIt.get<SearchMedicineRepoImpl>()),
                ),
              ], child: MedDetailsView(id: id)),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0), // Bottom to Top
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          }),
      GoRoute(
          path: kordersReportView,
          pageBuilder: (context, state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: BlocProvider(
                  create: (context) =>
                      OrdersReportCubit(getIt.get<HomeRepoImpl>()),
                  child: const OrdersReportsView()),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          }),
      GoRoute(
          path: kreportDetailsView,
          pageBuilder: (context, state) {
            final id = state.extra as int;
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: BlocProvider(
                  create: (context) =>
                      ReportDetailsCubit(getIt.get<HomeRepoImpl>()),
                  child: ReportDetailsView(
                    reportID: id,
                  )),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            );
          }),

      // Add more routes as needed
    ],
  );
}
