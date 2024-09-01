import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/orders_report_model.dart';
import '../../../data/repos/home_repo.dart';


part 'orders_report_state.dart';

class OrdersReportCubit extends Cubit<OrdersReportState> {
  OrdersReportCubit(this.homeRepo) : super(OrdersReportInitial());
  final HomeRepo homeRepo;

  Future<void> fecthOrdersReport() async {
    emit(OrdersReportLoading());
    var reslut = await homeRepo.fecthOrdersReport();
    reslut.fold((failure) {
      emit(OrdersReportFailure(failure.errMessage));
    }, (allMedicinesModel) {
      // ignore: avoid_print
      print('we Emit your report  the you ordered  ');

      emit(OrdersReportSuccess(allMedicinesModel));
    });
  }

  void reset() {
    emit(OrdersReportInitial());
  }
}
