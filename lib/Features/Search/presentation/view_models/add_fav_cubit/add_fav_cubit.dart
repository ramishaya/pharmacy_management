import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/add_fav_model.dart';
import '../../../data/models/medicine_details_model.dart';
import '../../../data/repos/search_medicine_repo.dart';

part 'add_fav_state.dart';

class AddFavCubit extends Cubit<AddFavState> {
  AddFavCubit(this.searchMedicineRepo)
      : super(AddFavInitial());
  final SearchMedicineRepo searchMedicineRepo;

  Future<void> addFav({
    required String id,
  }) async {
    emit(AddFavLoading());
    var reslut = await searchMedicineRepo.addFav(id: id);
    reslut.fold((failure) {
      emit(AddFavFailure(failure.errMessage));
    }, (message) {
      emit(AddFavSuccess(message));
    });
  }

  void clearDetails() {
    emit(AddFavInitial());
  }
}
