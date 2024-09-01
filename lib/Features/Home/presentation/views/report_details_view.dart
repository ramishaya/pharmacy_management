import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pharmacy/Features/Home/presentation/view_models/report_details_cubit/report_details_cubit.dart';

import '../../../../Core/utils/my_text_styles.dart';
import '../../../../Core/widgets/custom_error_widget.dart';
import '../../../../Core/widgets/custom_loading_indecator.dart';
import '../../../../constants.dart';
import '../../data/models/report_details_model.dart';

class ReportDetailsView extends StatefulWidget {
  const ReportDetailsView({super.key, required this.reportID});
  final int reportID;

  @override
  State<ReportDetailsView> createState() => _ReportDetailsViewState();
}

class _ReportDetailsViewState extends State<ReportDetailsView> {
  @override
  void initState() {
    BlocProvider.of<ReportDetailsCubit>(context)
        .fecthReportDetails(reportID: widget.reportID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<ReportDetailsCubit>(context).reset();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kprimecolor,
              )),
          elevation: 0,
          backgroundColor: kPrimaryColor,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.1),
            child: Divider(color: borderColor, height: 0.1),
          ),
          title: Row(
            children: [
              const Text(' Report Details ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: MyTextStyles.thinTextWeight,
                  )),
              const SizedBox(width: 3.0),
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 7.0,
                height: 7.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kprimecolor,
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<ReportDetailsCubit, ReportDetailsState>(
          builder: (context, state) {
            if (state is ReportDetailsSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      //height: size.height,
                      // width: size.width,
                      child: ListView.builder(
                        itemCount: state.reportDetails?.length??0,
                        physics: const PageScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ReportDetails order = state.reportDetails![index];
                          return GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * sidesmargin,
                                  vertical: size.height * verticalMargin),
                              child: Card(
                                color: kSoftPink,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(curvInHomeView),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      
                                      Text(
                                        ' Order ID : ${order.scientificName}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'commercial name ${order.commercialName}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'price : ${order.price}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'manufacturer : ${order.manufacturer}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Categoury : ${order.cat}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Expire Date : ${order.expireDate}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ReportDetailsFailure) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else {
              return const CustomLoadingIndecator();
            }
          },
        ));
  }
}
