part of 'show_medicine_details_cubit.dart';



abstract class ShowMedicineDetailsState extends Equatable {
  const ShowMedicineDetailsState();

  @override
  List<Object> get props => [];
}

class ShowMedicineDetailsInitial extends ShowMedicineDetailsState {}

class ShowMedicineDetailsLoading extends ShowMedicineDetailsState {}

class ShowMedicineDetailsFailure extends ShowMedicineDetailsState {
  final String errMessage;

  const ShowMedicineDetailsFailure(this.errMessage);
}

class ShowMedicineDetailsSuccess extends ShowMedicineDetailsState {
  final  Details medicineDetails;

  const ShowMedicineDetailsSuccess(this.medicineDetails);
}
