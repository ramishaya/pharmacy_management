import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../data/models/login_model.dart';
import '../../../data/repos/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;

  Future<void> loginUserInfo({
    required String phoneNumber,
    required String password,
  }) async {
    emit(LoginLoading());
    var reslut = await loginRepo.loginUserInfo(
        phoneNumber: phoneNumber, password: password);
    reslut.fold((failure) {
      emit(LoginFailure(failure.errMessage));
    }, (loginModel) {
      emit(LoginSuccess(loginModel));
    });
  }
}
