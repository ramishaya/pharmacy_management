import 'package:dio/dio.dart';
import 'package:pharmacy/Core/errors/failuers.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacy/Core/utils/api_service.dart';
import 'package:pharmacy/Features/Login/data/models/logout_model.dart';

import '../models/login_model.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService _apiService;

  LoginRepoImpl(this._apiService);

  @override
  Future<Either<Failure, LoginModel>> loginUserInfo({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      var data = await _apiService.post(
          endpoint: 'login',
          data: {'phone_number': phoneNumber, 'password': password});
      LoginModel loginResponse = LoginModel.fromJson(data);
      return Right(loginResponse);
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print

        print("error in login repository");
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      var data = await _apiService.post(
        endpoint: 'logout',
        data: {

        }
        );
      LogoutModel logoutResponse = LogoutModel.fromJson(data);
      return Right(logoutResponse);
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print

        print("error in logout repository");
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
