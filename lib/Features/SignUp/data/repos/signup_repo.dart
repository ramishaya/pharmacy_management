import 'package:dartz/dartz.dart';
import 'package:pharmacy/Core/errors/failuers.dart';

import '../models/sign_up_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure, SignUpModel>> signUpUserInfo({
    required String username,
    required String phoneNumber,
    required String password,
  });
}
