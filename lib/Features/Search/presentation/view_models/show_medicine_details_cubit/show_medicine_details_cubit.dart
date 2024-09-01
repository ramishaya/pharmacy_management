import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/medicine_details_model.dart';
import '../../../data/repos/search_medicine_repo.dart';

part 'show_medicine_details_state.dart';

class ShowMedicineDetailsCubit extends Cubit<ShowMedicineDetailsState> {
  ShowMedicineDetailsCubit(this.searchMedicineRepo)
      : super(ShowMedicineDetailsInitial());
  final SearchMedicineRepo searchMedicineRepo;

  Future<void> showMedicineDetails({
    required String id,
  }) async {
    emit(ShowMedicineDetailsLoading());
    var reslut = await searchMedicineRepo.showMedicineDetails(id: id);
    reslut.fold((failure) {
      emit(ShowMedicineDetailsFailure(failure.errMessage));
    }, (medicinesDetails) {
      emit(ShowMedicineDetailsSuccess(medicinesDetails));
    });
  }

  void clearDetails() {
    emit(ShowMedicineDetailsInitial());
  }
}
