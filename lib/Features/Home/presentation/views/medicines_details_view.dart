import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/Core/utils/my_text_styles.dart';
import 'package:pharmacy/Features/Home/data/models/all_medicines_model.dart';
import 'package:pharmacy/constants.dart';

class MedicineDetailsView extends StatelessWidget {
  //final String categoryName;
  final List<Medicine> medicines;

  const MedicineDetailsView({
    Key? key,
    // required this.categoryName,
    required this.medicines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.1),
            child: Divider(color: borderColor, height: 0.1),
          ),
        
          title: const Text(
            "Category Details",
            style: TextStyle(
                fontSize: MyTextStyles.bigTextSize,
                fontWeight: MyTextStyles.thinTextWeight,
                color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * sidesmargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(medicines[0].category,
                            style: const TextStyle(
                              fontSize: MyTextStyles.bigTextSize,
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
                    const SizedBox(height: 5),
                    Text('Avaliable medinces',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: borderColor, height: 0.1),
              SizedBox(
                //height: size.height,
                // width: size.width,
                child: ListView.builder(
                  itemCount: medicines.length,
                  physics:
                      const PageScrollPhysics(parent: BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Medicine medicine = medicines[index];
                    return Padding(
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
                                'Scientific Name : ${medicine.scientificName}',
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: MyTextStyles.thinTextWeight,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Commercial Name : ${medicine.commercialName}',
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: MyTextStyles.thinTextWeight,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'price : ${medicine.price}',
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
                                      'Quantity: ${medicine.quantity}',
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
                                      'Manufacturer: ${medicine.manufacturer}',
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
                                      'Expire Date : ${medicine.expireDate.year}/${medicine.expireDate.month}/${medicine.expireDate.day}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
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
        ));
  }
}
