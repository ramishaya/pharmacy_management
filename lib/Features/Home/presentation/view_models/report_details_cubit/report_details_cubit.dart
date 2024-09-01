import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/orders_report_model.dart';
import '../../../data/models/report_details_model.dart';
import '../../../data/repos/home_repo.dart';


part 'report_details_state.dart';

class ReportDetailsCubit extends Cubit<ReportDetailsState> {
  ReportDetailsCubit(this.homeRepo) : super(ReportDetailsInitial());
  final HomeRepo homeRepo;

  Future<void> fecthReportDetails({required int reportID}) async {
    emit(ReportDetailsLoading());
    var reslut = await homeRepo.fecthReportDetails(reportID: reportID);
    reslut.fold((failure) {
      emit(ReportDetailsFailure(failure.errMessage));
    }, (allMedicinesModel) {
      // ignore: avoid_print
      print('we Emit your report  the you ordered  ');

      emit(ReportDetailsSuccess(allMedicinesModel));
    });
  }

  void reset() {
    emit(ReportDetailsInitial());
  }
}
