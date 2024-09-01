import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/utils/app_router.dart';

import '../../../../Core/utils/my_text_styles.dart';
import '../../../../Core/widgets/custom_error_widget.dart';
import '../../../../Core/widgets/custom_loading_indecator.dart';
import '../../../../constants.dart';
import '../../data/models/orders_report_model.dart';
import '../view_models/orders_report_cubit/orders_report_cubit.dart';

class OrdersReportsView extends StatefulWidget {
  const OrdersReportsView({super.key});

  @override
  State<OrdersReportsView> createState() => _OrdersReportsViewState();
}

class _OrdersReportsViewState extends State<OrdersReportsView> {
  @override
  void initState() {
    BlocProvider.of<OrdersReportCubit>(context).fecthOrdersReport();
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
                BlocProvider.of<OrdersReportCubit>(context).reset();
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
              const Text('Orders Report',
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
        body: BlocBuilder<OrdersReportCubit, OrdersReportState>(
          builder: (context, state) {
            if (state is OrdersReportSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      //height: size.height,
                      // width: size.width,
                      child: ListView.builder(
                        itemCount: state.report?.length ?? 0,
                        physics: const PageScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          MyOrdersReport order = state.report![index];
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                  AppRouter.kreportDetailsView,
                                  extra: order.id);
                            },
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
                                        'Order ID: ${order.id}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'payment State: ${order.paymentState}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Receive State ${order.receiveState}',
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
            } else if (state is OrdersReportFailure) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else {
              return const CustomLoadingIndecator();
            }
          },
        ));
  }
}
