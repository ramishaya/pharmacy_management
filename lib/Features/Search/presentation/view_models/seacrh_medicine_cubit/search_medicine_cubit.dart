import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/search_medicine_model.dart';

import '../../../data/repos/search_medicine_repo.dart';

part 'search_medicine_state.dart';

class SearchMedicineCubit extends Cubit<SearchMedicineState> {
  SearchMedicineCubit(this.searchMedicineRepo) : super(SearchMedicineInitial());
  final SearchMedicineRepo searchMedicineRepo;

  Future<void> searchMedicine({
    required String key,
  }) async {
    emit(SearchMedicineLoading());
    var reslut = await searchMedicineRepo.searchMedicines(key: key);
    reslut.fold((failure) {
      emit(SearchMedicineFailure(failure.errMessage));
    }, (medicinesList) {
      emit(SearchMedicineSuccess(medicinesList));
    });
  }

  void clearSearch() {
    emit(SearchMedicineInitial());
  }
}
