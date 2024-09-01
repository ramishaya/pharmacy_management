import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/all_medicines_model.dart';
import '../../../data/repos/home_repo.dart';

part 'all_medicines_state.dart';

class AllMedicinesCubit extends Cubit<AllMedicinesState> {
  AllMedicinesCubit(this.homeRepo) : super(AllMedicinesInitial());
  final HomeRepo homeRepo;

  Future<void> fetchAllMedicinesCategories() async {
    emit(AllMedicinesLoading());
    var reslut = await homeRepo.fetchAllMedicines();
    reslut.fold((failure) {
      emit(AllMedicinesFailure(failure.errMessage));
    }, (allMedicinesModel) {
      // ignore: avoid_print
      print('we Emit all the medicines categories');
      
      emit(AllMedicinesSuccess(allMedicinesModel));
    });
  }
}
