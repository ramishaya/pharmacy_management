import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/Core/widgets/custom_error_widget.dart';
import 'package:pharmacy/Core/widgets/custom_loading_indecator.dart';
import 'package:pharmacy/Features/Home/data/models/my_requests_model.dart';
import 'package:pharmacy/Features/Home/presentation/view_models/my_requests_cubit/my_requests_cubit.dart';

import '../../../../Core/utils/app_router.dart';
import '../../../../Core/utils/my_text_styles.dart';
import '../../../../constants.dart';

class MyRequestsView extends StatefulWidget {
  const MyRequestsView({super.key});

  @override
  State<MyRequestsView> createState() => _MyRequestsViewState();
}

class _MyRequestsViewState extends State<MyRequestsView> {
  @override
  void initState() {
    BlocProvider.of<MyRequestsCubit>(context).fetchMyRequests();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
       onWillPop: () async {
         Navigator.pushReplacementNamed(context, AppRouter.kHomeView);
          return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0.1),
              child: Divider(color: borderColor, height: 0.1),
            ),
            title: Row(
              children: [
                const Text('Available Requests',
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
          body: BlocBuilder<MyRequestsCubit, MyRequestsState>(
            builder: (context, state) {
              if (state is MyRequestsSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        //height: size.height,
                        // width: size.width,
                        child: ListView.builder(
                          
                          itemCount: state.myRequests?.length ?? 0,
                          physics: const PageScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Requests request = state.myRequests![index];
                            return Padding(
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Text(
                                        ' payment State: ${request.paymentState}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Receive State ${request.receiveState}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight:
                                                MyTextStyles.thinTextWeight,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'price : ${request.price }',
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is MyRequestsFailure) {
                return CustomErrorWidget(errMessage: state.errMessage);
              } else {
                return const CustomLoadingIndecator();
              }
            },
          )),
    );
  }
}
