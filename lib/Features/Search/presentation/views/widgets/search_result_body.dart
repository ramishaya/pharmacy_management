import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/app_router.dart';
import 'package:pharmacy/Core/utils/my_text_styles.dart';
import 'package:pharmacy/Core/widgets/custom_error_widget.dart';
import 'package:pharmacy/Core/widgets/custom_header.dart';
import 'package:pharmacy/Core/widgets/custom_loading_indecator.dart';
import 'package:pharmacy/constants.dart';

import '../../../../../Core/widgets/resalut_card.dart';
import '../../view_models/seacrh_medicine_cubit/search_medicine_cubit.dart';

class SearchResultBody extends StatefulWidget {
  const SearchResultBody({super.key, required this.searchKey});
  final String searchKey;

  @override
  State<SearchResultBody> createState() => _SearchResultBodyState();
}

class _SearchResultBodyState extends State<SearchResultBody> {
  @override
  void initState() {
    BlocProvider.of<SearchMedicineCubit>(context)
        .searchMedicine(key: widget.searchKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SearchMedicineCubit, SearchMedicineState>(
      builder: (context, state) {
        if (state is SearchMedicineSuccess) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  scsize: size,
                  title: 'Medicine Resalut',
                  subtitle: '${state.medicines.length} items found',
                ),
                const Divider(color: borderColor, height: 0.1),
                ResultCard(size: size),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.medicines.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kmedDetailsView,
                            extra: '${state.medicines[index].id}');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * sidesmargin,
                            vertical: size.height * verticalMargin),
                        child: Card(
                          color: kSoftPink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(curvInHomeView),
                            side: const BorderSide(
                              color: borderColor,
                              width: 1.0,
                            ),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.only(
                            //bottom: 14,
                            left: sidesmargin,
                            right: sidesmargin,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Scientific Name : ${state.medicines[index].scientificName}',
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: MyTextStyles.thinTextWeight,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Cat : ${state.medicines[index].cat}',
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: MyTextStyles.thinTextWeight,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'price : ${state.medicines[index].price}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: MyTextStyles.thinTextWeight,
                                        color: Colors.black),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        } else if (state is SearchMedicineFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const CustomLoadingIndecator();
        }
      },
    );
  }
}
