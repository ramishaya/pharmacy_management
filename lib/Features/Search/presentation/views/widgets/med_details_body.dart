import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/Core/utils/my_text_styles.dart';
import 'package:pharmacy/Core/widgets/custom_button.dart';
import 'package:pharmacy/Core/widgets/custom_error_widget.dart';
import 'package:pharmacy/Core/widgets/custom_loading_indecator.dart';
import 'package:pharmacy/Features/Search/presentation/view_models/add_fav_cubit/add_fav_cubit.dart';
import 'package:pharmacy/Features/Search/presentation/view_models/show_medicine_details_cubit/show_medicine_details_cubit.dart';
import 'package:pharmacy/constants.dart';

import '../../../data/models/order_request_model.dart';
import '../../view_models/order_medicine_cubit/order_medicine_cubit.dart';
import '../../view_models/order_medicine_cubit/order_medicine_state.dart';

class MedDetailsBody extends StatefulWidget {
  final String id;
  final Size size;
  const MedDetailsBody({super.key, required this.id, required this.size});

  @override
  State<MedDetailsBody> createState() => _MedDetailsBodyState();
}

class _MedDetailsBodyState extends State<MedDetailsBody> {
  int _counter = 1;
  final TextEditingController _counterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowMedicineDetailsCubit>(context)
        .showMedicineDetails(id: widget.id);
    _counterController.text =
        '1'; // Initialize the controller with the default counter value
  }

  @override
  void dispose() {
    _counterController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _counterController.text = _counter
          .toString(); // Update the controller with the new counter value
    });
  }

  void orderMedicine(BuildContext context, ShowMedicineDetailsSuccess state) {
    if (state.medicineDetails != null) {
      // Extracting the necessary information
      int? medicineId = state.medicineDetails.id;
      double? price = state.medicineDetails.price;
      int quantity = int.tryParse(_counterController.text) ??
          1; // Safely parse the counter value

      // Create the product list (assuming your OrderMedicineCubit takes a list of products)
      List<Product> products = [
        Product(id: medicineId, quantity: quantity, price: price),
      ];

      // Send the order
      BlocProvider.of<OrderMedicineCubit>(context).orderMedicine(products);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderMedicineCubit, OrderMedicineState>(
      builder: (context, state) {
        return BlocBuilder<ShowMedicineDetailsCubit, ShowMedicineDetailsState>(
          builder: (context, state) {
            if (state is ShowMedicineDetailsSuccess) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.size.width * sidesmargin,
                    vertical: widget.size.height * verticalMargin),
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
                          'Scientific Name : ${state.medicineDetails.scientificName}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: MyTextStyles.thinTextWeight,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Commercial Name : ${state.medicineDetails.commercialName}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: MyTextStyles.thinTextWeight,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'price : ${state.medicineDetails.price}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: MyTextStyles.thinTextWeight,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align the text and icon to the start
                          children: [
                            const Icon(Icons.production_quantity_limits,
                                size: 20, color: kprimecolor),
                            const SizedBox(
                                width:
                                    3.0), // Add some spacing between the icon and text
                            Expanded(
                              child: Text(
                                'Quantity: ${state.medicineDetails.quantity}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align the text and icon to the start
                          children: [
                            const Icon(Icons.flag,
                                size: 20, color: kprimecolor),
                            const SizedBox(
                                width:
                                    3.0), // Add some spacing between the icon and text
                            Expanded(
                              child: Text(
                                'Manufacturer: ${state.medicineDetails.manufacturer}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align the text and icon to the start
                          children: [
                            const Icon(Icons.date_range,
                                size: 20, color: kprimecolor),
                            const SizedBox(
                                width:
                                    3.0), // Add some spacing between the icon and text
                            Expanded(
                              child: Text(
                                'Expire Date : ${state.medicineDetails.expireDate}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _counterController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    fillColor: kprimecolor,
                                    labelText: 'Quantity',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: _incrementCounter,
                                icon: const Icon(Icons.add),
                              ),
                              //CustomButton(text: 'Order This Medicine', onPressed: (){}, width: , height: height)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kprimecolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            curvInHomeView))),
                                onPressed: () {
                                  orderMedicine(context, state);
                                },
                                child: const Text('Order This Medicine'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ShowMedicineDetailsFailure) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else {
              return const CustomLoadingIndecator();
            }
          },
        );
      },
      listener: (context, orderState) {
        if (orderState is OrderMedicineSuccess) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Your order has been placed successfully!'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (orderState is OrderMedicineFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Failure'),
                content: Text(orderState.errMessage),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                backgroundColor: kprimecolor,
                title: Text("Loading"),
                content: CircularProgressIndicator(
                  color: kSoftPink,
                )),
          );
        }
      },
    );
  }
}
