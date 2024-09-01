import 'package:equatable/equatable.dart';
import 'package:pharmacy/Features/Search/data/models/order_medicine_model.dart';

abstract class OrderMedicineState extends Equatable {
  const OrderMedicineState();

  @override
  List<Object> get props => [];
}

class OrderMedicineInitial extends OrderMedicineState {}

class OrderMedicineLoading extends OrderMedicineState {}

class OrderMedicineFailure extends OrderMedicineState {
  final String errMessage;

  const OrderMedicineFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

class OrderMedicineSuccess extends OrderMedicineState {
  final OrderMedicineModel orderMedicineModel;

  const OrderMedicineSuccess(this.orderMedicineModel);

  @override
  List<Object> get props => [orderMedicineModel];
}
