import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/assets_data.dart';
import 'package:pharmacy/Core/utils/my_text_styles.dart';
import 'package:pharmacy/Core/widgets/custom_error_widget.dart';
import 'package:pharmacy/Core/widgets/custom_loading_indecator.dart';
import 'package:pharmacy/Features/Home/presentation/view_models/all_medicines_cubit.dart/all_medicines_cubit.dart';
import 'package:pharmacy/Features/Home/presentation/views/widgets/user_icon.dart';
import 'package:pharmacy/Features/Home/presentation/views/widgets/user_welcome_text.dart';
import 'package:pharmacy/constants.dart';

import '../../../../../Core/utils/app_router.dart';
import '../../../../../Core/widgets/custom_search_bar.dart';
import '../../../data/models/all_medicines_model.dart';
import '../../view_models/my_requests_cubit/my_requests_cubit.dart';
import 'home_welcome_card.dart';

class HomeBody extends StatefulWidget {
  final String userName;
  const HomeBody({super.key, required this.userName});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    BlocProvider.of<MyRequestsCubit>(context).reset();
    BlocProvider.of<AllMedicinesCubit>(context).fetchAllMedicinesCategories();
    super.initState();
  }

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRouter.kHomeView);
        return false;
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * sidesmargin,
                    vertical: size.height * verticalMargin),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserWelcomeText(widget: widget),
                      const UserIcon()
                    ]),
              ),
              HomeWelcomeCard(size: size),
              // SizedBox(
              //   height: size.height * 0.007,
              // ),
              CustomSearchBar(
                size: size,
                searchController: searchController,
                searchFunction: () {
                  GoRouter.of(context).push(AppRouter.kSearchResultView,
                      extra: searchController.text);
                },
                hintText: "Search For Medcines , Categories",
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * sidesmargin,
                    vertical: size.height * verticalMargin),
                child: const Text(
                  "Our Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              BlocBuilder<AllMedicinesCubit, AllMedicinesState>(
                builder: (context, state) {
                  if (state is AllMedicinesSuccess) {
                    var categoryMaps = state.medicines;
                    var categoryNames =
                        categoryMaps.map((e) => e.keys.single).toList();
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * sidesmargin,
                      ),
                      child: SizedBox(
                        height: size.height * 0.25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: categoryNames.length,
                          itemBuilder: (context, index) {
                            String categoryName = categoryNames[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, cityDetails , arguments: cityList[index].name  );
                                List<Medicine> medicinesList =
                                    categoryMaps[index][categoryName] ?? [];
                                GoRouter.of(context).push(
                                  AppRouter
                                      .kMedicinesDetailsView, // Make sure this matches the route name in AppRouter
                                  extra: medicinesList,
                                  //queryParameters: {'categoryName': categoryName},  // queryParams is correct for simple data
                                );
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(right: size.width * 0.03),
                                width: size.width * 0.6,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(curvInHomeView),
                                    color: kprimecolor,
                                    border: Border.all(
                                        color: borderColor, width: 1)),
                                child:
                                    //height: size.height * 0.15,
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Medicine Type",
                                            style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            //! get the medicine category from the API

                                            categoryName,
                                            style: const TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(curvInHomeView),
                                            bottomRight: Radius.circular(
                                                curvInHomeView)),
                                        child: Image.asset(
                                          AssetsData.pahr6,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: size.height * 0.25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is AllMedicinesFailure) {
                    return CustomErrorWidget(errMessage: state.errMessage);
                  } else {
                    return const CustomLoadingIndecator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
