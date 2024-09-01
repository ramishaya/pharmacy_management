import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/Features/Search/presentation/view_models/show_medicine_details_cubit/show_medicine_details_cubit.dart';
import 'package:pharmacy/Features/Search/presentation/views/widgets/med_details_body.dart';
import '../../../../Core/utils/my_text_styles.dart';
import '../../../../constants.dart';
import '../view_models/add_fav_cubit/add_fav_cubit.dart';

class MedDetailsView extends StatefulWidget {
  const MedDetailsView({super.key, required this.id});
  final String id;

  @override
  State<MedDetailsView> createState() => _MedDetailsViewState();
}

class _MedDetailsViewState extends State<MedDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Using BlocConsumer to handle state changes and rebuild UI
    return BlocConsumer<AddFavCubit, AddFavState>(
      listener: (context, state) {
        // Handling the different states
        if (state is AddFavSuccess) {
          // Show a dialog when successfully added to favorites
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: kprimecolor,
              title: const Text(
                "Success",
                style: TextStyle(
                    fontSize: MyTextStyles.bigTextSize,
                    fontWeight: MyTextStyles.thinTextWeight),
              ),
              content: const Text("Medicine has been added to favorites!",
                  style: TextStyle(fontWeight: MyTextStyles.thinTextWeight)),
              actions: [
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(kSoftPink)),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: MyTextStyles.thinTextWeight),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        } else if (state is AddFavFailure) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: kprimecolor,
              title: const Text("Failed"),
              content: Text('$state.errMessage'),
              actions: [
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(kSoftPink)),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: MyTextStyles.thinTextWeight),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        } else {
          // Show the loading dialog
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                backgroundColor: kprimecolor,
                title: Text("Loading"),
                content: CircularProgressIndicator(
                  color: kSoftPink,
                )),
          );

          // Automatically close the dialog after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            // If the widget is still mounted (i.e., hasn't been disposed)
            if (mounted) {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // Close the dialog
            }
          });
        }
        // Add other state handling if necessary
      },
      builder: (context, state) {
        // Build UI based on the state
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
                BlocProvider.of<ShowMedicineDetailsCubit>(context)
                    .clearDetails();
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Medicine Details',
              style: TextStyle(
                  color: Colors.black, fontWeight: MyTextStyles.thinTextWeight),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  state is AddFavSuccess
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: state is AddFavSuccess ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  BlocProvider.of<AddFavCubit>(context).addFav(id: widget.id);
                },
              ),
            ],
          ),
          body: MedDetailsBody(id: widget.id, size: size),
        );
      },
    );
  }
}
