import 'package:dio/dio.dart';
import 'package:pharmacy/Core/errors/failuers.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmacy/Core/utils/api_service.dart';
import 'package:pharmacy/Features/SignUp/data/models/sign_up_model.dart';
import 'package:pharmacy/Features/SignUp/data/repos/signup_repo.dart';

class SignUpRepoImpl implements SignUpRepo {
  final ApiService _apiService;
  
  SignUpRepoImpl(this._apiService);

  @override
  Future<Either<Failure, SignUpModel>> signUpUserInfo(
      {required String username,
   required String phoneNumber,
  required String  password,}) async {
    try {
      var data = await _apiService.post(endpoint: 'register', data: {
        'username':username,
        'phone_number':phoneNumber,
        'password':password
      });
      SignUpModel signupResponse = SignUpModel.fromJson(data);
      return Right(signupResponse);
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in repository");
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
