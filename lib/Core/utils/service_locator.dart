import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy/Features/Home/data/repos/home_repo_impl.dart';
import 'package:pharmacy/Features/Login/data/repos/login_repo_impl.dart';
import 'package:pharmacy/Features/Search/data/repos/search_medicine_repo_impl.dart';

import '../../Features/SignUp/data/repos/signup_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<SignUpRepoImpl>(SignUpRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt
      .registerSingleton<LoginRepoImpl>(LoginRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<HomeRepoImpl>(
      HomeRepoImpl(apiService: getIt.get<ApiService>()));
  getIt.registerSingleton<SearchMedicineRepoImpl>(
      SearchMedicineRepoImpl(apiService: getIt.get<ApiService>()));
      

}
