import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/Features/Search/data/models/order_request_model.dart';
import 'package:pharmacy/Features/Search/data/repos/search_medicine_repo.dart';

import 'order_medicine_state.dart';

class OrderMedicineCubit extends Cubit<OrderMedicineState> {
  final SearchMedicineRepo searchMedicineRepo;

  OrderMedicineCubit(this.searchMedicineRepo) : super(OrderMedicineInitial());

  Future<void> orderMedicine(List<Product> products) async {
    emit(OrderMedicineLoading());
    var result = await searchMedicineRepo.orderMedicine(products: products);
    result.fold(
      (failure) => emit(OrderMedicineFailure(
          failure.errMessage)), // Adjust according to your Failure class
      (orderMedicineModel) => emit(OrderMedicineSuccess(orderMedicineModel)),
    );
  }

  void reset() {
    emit(OrderMedicineInitial());
  }
}
