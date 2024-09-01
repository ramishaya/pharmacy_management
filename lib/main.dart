import 'package:flutter/material.dart';

import 'package:pharmacy/Core/utils/service_locator.dart';
import 'package:pharmacy/Features/Search/data/repos/search_medicine_repo_impl.dart';

import 'Core/utils/app_router.dart';

import 'Features/Search/data/models/order_request_model.dart';
import 'constants.dart';

void main() {
  //   print('snfksn');

 
  // print('hello');
     setupServiceLocator();
  //   List<Product> products = [
  //   Product(id: 1, quantity: 2, price: 30.23),
  //   Product(id: 2, quantity: 3, price: 45.50),

  // ];


  runApp(const PharmacyApp());
}

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(kprimecolor),
              foregroundColor: MaterialStatePropertyAll(kprimecolor),
              shadowColor: MaterialStatePropertyAll(kprimecolor))),
      primaryColor: kprimecolor,
      scaffoldBackgroundColor: kPrimaryColor,
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: kprimecolor,
        fillColor: kprimecolor,
        iconColor: kprimecolor,
        focusColor: kprimecolor,
        hoverColor: kprimecolor,
        suffixIconColor: kprimecolor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  kprimecolor), // Color of the border when TextFormField is focused
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kprimecolor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: kprimecolor, iconColor: kprimecolor)),
      iconTheme: const IconThemeData(
        color: kprimecolor, // setting the default icon color
      ),
      primaryIconTheme: const IconThemeData(
        color: kprimecolor, // setting the default primary icon color
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kprimecolor, // Set your desired color here
      ),
    );
  }
}
