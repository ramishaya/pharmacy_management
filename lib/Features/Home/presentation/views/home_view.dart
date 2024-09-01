import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/Features/Home/presentation/view_models/my_requests_cubit/my_requests_cubit.dart';
import 'package:pharmacy/Features/Home/presentation/views/logout_view.dart';
import 'package:pharmacy/Features/Home/presentation/views/my_requests_view.dart';

import 'package:pharmacy/Features/Home/presentation/views/widgets/home_body.dart';
import 'package:pharmacy/constants.dart';

class HomeView extends StatefulWidget {
  final String userName;
  const HomeView({super.key, required this.userName});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List navPages = [const HomeBody(userName: 'User'), const MyRequestsView() , const LogoutView()];

  int currentIndex = 0;
  onTap(int index) {
    // MyReserveCubit(
    //         myReserveRepository:
    //             MyReserveRepository(myResrveWebServices: MyResrveWebServices()))
    // .fetchMyReserve();
    setState(() {
      currentIndex = index;
    });
  }

  // void initShared() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: kprimecolor,
            width: 1,
          ))),
          child: BottomNavigationBar(
            backgroundColor: /*Color(0xFF005B9F),*/ kPrimaryColor,
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: kprimecolor,
            unselectedItemColor: kprimecolor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(label: "Home ", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "My Requests", icon: Icon(Icons.wallet_travel)),
              BottomNavigationBarItem(
                  label: "Logout", icon: Icon(Icons.account_circle)),
            ],
          ),
        ),
        body: navPages[currentIndex]);
  }
}
