import 'package:dio/dio.dart';
import 'package:pharmacy/Core/utils/api_service.dart';
import 'package:pharmacy/Features/Home/data/models/all_medicines_model.dart';

import 'package:pharmacy/Core/errors/failuers.dart';

import 'package:dartz/dartz.dart';
import 'package:pharmacy/Features/Home/data/models/my_requests_model.dart';
import 'package:pharmacy/Features/Home/data/models/orders_report_model.dart';
import 'package:pharmacy/Features/Home/data/models/report_details_model.dart';
import 'package:pharmacy/Features/Home/presentation/views/my_requests_view.dart';

import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  final String bearerToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM2OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzAzODgwMDI1LCJleHAiOjE3MDM4ODM2MjUsIm5iZiI6MTcwMzg4MDAyNSwianRpIjoiSk54eTdYTmZTbXdOU2RvWSIsInN1YiI6IjEiLCJwcnYiOiI5ZTIwYWJmNTBhMTVkZGJiOWNlYjJlYjQ4MDc1MmZiYjc5NmIzYjRlIn0.8pZYd9YSYuYwZJBkjvOA30LMIC4mfB8F-5mqhuPdAsY';
  const HomeRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, List<Map<String, List<Medicine>>>>>
      fetchAllMedicines() async {
    try {
      var data = await apiService.get(
          endpoint: 'browse-medication', bearerToken: bearerToken);
      // Parsing the JSON response into the AllMedicinesModel
      AllMedicinesModel allMedicinesModel = AllMedicinesModel.fromJson(data);

      // Constructing the list of maps with categories and their medicines
      List<Map<String, List<Medicine>>> categoryMedicineList =
          allMedicinesModel.medicines.categories.entries.map((entry) {
        return {entry.key: entry.value};
      }).toList();

      return Right(categoryMedicineList);
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in Fetching Medicines repository");
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Requests>?>> fecthMyRequests() async {
    try {
      var data = await apiService.get(
          endpoint: 'show-requests', bearerToken: bearerToken);
      // Parsing the JSON response into the AllMedicinesModel
      MyRequestsModel myresponse = MyRequestsModel.fromJson(data);

      List<Requests>? myRequestsData = myresponse.requests;
      print('we got the requests that you ordered');
      //print(myRequestsData![1].paymentState);
      return Right(myRequestsData);
      //  else {
      //   return Left(ServerFailure('Error in fetching the requests'));
      // }

      // Constructing the list of maps with categories and their medicines
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in Fetching My Requests Repository");
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<MyOrdersReport>?>> fecthOrdersReport() async {
    try {
      var data = await apiService.get(
          endpoint: 'request-report', bearerToken: bearerToken);
      // Parsing the JSON response into the AllMedicinesModel
      OrdersReportModel response = OrdersReportModel.fromJson(data);

      if (response.statusNumber == 200) {
        List<MyOrdersReport>? ordersReport = response.requests;
        print('we got the report');
        //print(ordersReport![0].paymentState);
        return Right(ordersReport);
      } else {
        return Left(ServerFailure('Error in fetching the report'));
      }

      // Constructing the list of maps with categories and their medicines
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in Fetching  report  Repository");
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ReportDetails>?>> fecthReportDetails(
      {required int reportID}) async {
    try {
      var data = await apiService.get(
          endpoint: 'request-details/$reportID', bearerToken: bearerToken);
      // Parsing the JSON response into the AllMedicinesModel
      ReportDetailsModel response = ReportDetailsModel.fromJson(data);

      if (response.statusNumber == 200) {
        List<ReportDetails>? reportDetails = response.details;
        print('we got the report details');

        return Right(reportDetails);
      } else {
        return Left(ServerFailure('Error in fetching the report details'));
      }

      // Constructing the list of maps with categories and their medicines
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in Fetching  report  Repository");
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
