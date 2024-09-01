import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/login_model.dart';
import '../../../data/models/logout_model.dart';
import '../../../data/repos/login_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.loginRepo) : super(LogoutInitial());
  final LoginRepo loginRepo;

  Future<void> logout() async {
    emit(LogoutLoading());
    var reslut = await loginRepo.logout();
    reslut.fold((failure) {
      emit(LogoutFailure(failure.errMessage));
    }, (logoutModel) {
      emit(LogoutSuccess(logoutModel));
    });
  }
}
