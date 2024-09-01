import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmacy/Core/utils/my_text_styles.dart';
import 'package:pharmacy/Features/Search/presentation/view_models/seacrh_medicine_cubit/search_medicine_cubit.dart';
import 'package:pharmacy/Features/Search/presentation/views/widgets/search_result_body.dart';
import 'package:pharmacy/constants.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key, required this.searchKey});
  final String searchKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.1),
            child: Divider(color: borderColor, height: 0.1),
          ),
          leading: BackButton(
            color: kprimecolor,
            onPressed: () {
              BlocProvider.of<SearchMedicineCubit>(context).clearSearch();
              Navigator.pop(context);
            },
          ),
          title: Text(
            searchKey,
            style: const TextStyle(
                color: Colors.black, fontWeight: MyTextStyles.thinTextWeight),
          ),
        ),
        body: SearchResultBody(searchKey: searchKey));
  }
}
