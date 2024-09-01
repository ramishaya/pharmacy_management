import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/all_medicines_model.dart';
import '../../../data/models/my_requests_model.dart';
import '../../../data/repos/home_repo.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  MyRequestsCubit(this.homeRepo) : super(MyRequestsInitial());
  final HomeRepo homeRepo;

  Future<void> fetchMyRequests() async {
    emit(MyRequestsLoading());
    var reslut = await homeRepo.fecthMyRequests();
    reslut.fold((failure) {
      emit(MyRequestsFailure(failure.errMessage));
    }, (allMedicinesModel) {
      // ignore: avoid_print
      print('we Emit all the Requests the you ordered  ');

      emit(MyRequestsSuccess(allMedicinesModel));
    });
  }

  void reset() {
    emit(MyRequestsInitial());
  }
}
