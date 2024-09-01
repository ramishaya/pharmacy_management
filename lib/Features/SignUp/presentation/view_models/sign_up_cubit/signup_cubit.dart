import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/Features/SignUp/data/repos/signup_repo.dart';

import '../../../data/models/sign_up_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignUpState> {
  SignupCubit(this.signUpRepo) : super(SignUpInitial());
  final SignUpRepo signUpRepo;

  Future<void> signUpUserInfo({
    required String username,
    required String phoneNumber,
    required String password,
  }) async {
    emit(SignUpLoading());
    var reslut = await signUpRepo.signUpUserInfo(
        username: username, phoneNumber: phoneNumber, password: password);
    reslut.fold((failure) {
      emit(SignUpFailure(failure.errMessage));
    }, (signupModel) {
      emit(SignUpSuccess(signupModel));
    });
  }
}
