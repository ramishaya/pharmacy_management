import 'package:dartz/dartz.dart';
import 'package:pharmacy/Features/Login/data/models/logout_model.dart';

import '../../../../Core/errors/failuers.dart';
import '../models/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> loginUserInfo(
      {required String phoneNumber, required String password});
  Future<Either<Failure, LogoutModel>> logout();
}
