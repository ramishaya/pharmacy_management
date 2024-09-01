import 'package:dio/dio.dart';
import 'package:pharmacy/Core/utils/api_service.dart';

import 'package:pharmacy/Core/errors/failuers.dart';

import 'package:dartz/dartz.dart';
import 'package:pharmacy/Features/Search/data/models/add_fav_model.dart';
import 'package:pharmacy/Features/Search/data/models/medicine_details_model.dart';
import 'package:pharmacy/Features/Search/data/models/order_request_model.dart';
import 'package:pharmacy/Features/Search/data/models/search_medicine_model.dart';
import 'package:pharmacy/Features/Search/data/repos/search_medicine_repo.dart';

import '../models/order_medicine_model.dart';

class SearchMedicineRepoImpl implements SearchMedicineRepo {
  final ApiService apiService;
  final String bearerToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjM2OjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzAzODgwMDI1LCJleHAiOjE3MDM4ODM2MjUsIm5iZiI6MTcwMzg4MDAyNSwianRpIjoiSk54eTdYTmZTbXdOU2RvWSIsInN1YiI6IjEiLCJwcnYiOiI5ZTIwYWJmNTBhMTVkZGJiOWNlYjJlYjQ4MDc1MmZiYjc5NmIzYjRlIn0.8pZYd9YSYuYwZJBkjvOA30LMIC4mfB8F-5mqhuPdAsY';
  const SearchMedicineRepoImpl({required this.apiService});
  @override
  Future<Either<Failure, List<MedicinesResault>>> searchMedicines(
      {required String key}) async {
    try {
      var response = await apiService.postWithToken(
          endpoint: 'search',
          data: {
            'key': key,
          },
          bearerToken: bearerToken);

      // Parsing the JSON response into the SearchMedicineModel
      SearchMedicineModel searchMedicineModel =
          SearchMedicineModel.fromJson(response);

      // Extracting the MedicinesResult list
      List<MedicinesResault>? medicinesList = searchMedicineModel.medicines;

      // Checking if the medicinesList is not null and returning it
      if (medicinesList != null) {
        // ignore: avoid_print
        print("we got the search resault data for medicines ");

        return Right(medicinesList);
      } else {
        return Left(ServerFailure('No Medicines or Categories are found'));
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in search Medicines repository");
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Details>> showMedicineDetails(
      {required String id}) async {
    try {
      var response = await apiService.get(
          endpoint: 'show-details/$id', bearerToken: bearerToken);

      MedicineDetailsModel medicineDetailsModel =
          MedicineDetailsModel.fromJson(response);

      Details? medicineDetails = medicineDetailsModel.details;

      if (medicineDetails != null) {
        // ignore: avoid_print
        print("we got the Medicine Details ");

        return Right(medicineDetails);
      } else {
        return Left(ServerFailure('No Details is found'));
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in  Medicines Details repository");
        // ignore: avoid_print
        print(ServerFailure.fromDioError(e).errMessage);
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AddFavModel>> addFav({required String id}) async {
    try {
      var response = await apiService.get(
          endpoint: 'add-to-favorites/$id', bearerToken: bearerToken);

      AddFavModel addFavModel = AddFavModel.fromJson(response);

      if (addFavModel.statusNumber == 200) {
        // ignore: avoid_print
        print("we added the medicie to favorite ");

        return Right(addFavModel);
      } else {
        return Left(ServerFailure('Can not add to favorite'));
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("error in  Medicines Details repository");
        // ignore: avoid_print
        print(ServerFailure.fromDioError(e).errMessage);
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, OrderMedicineModel>> orderMedicine(
      {required List<Product> products}) async {
    try {
      var response = await apiService.postWithToken(
          endpoint: 'add-req', // Replace with your actual endpoint
          data: OrderRequestModel(products: products).toJson(),
          bearerToken: bearerToken);

      OrderMedicineModel orderResponse = OrderMedicineModel.fromJson(response);

      if (orderResponse.status == true) {
        print(orderResponse.message);
        // ignore: avoid_print
        print("Order Placed Successfully!");
        return Right(orderResponse);
      } else {
        // Handling failure scenario
        return Left(ServerFailure('Failed to place the order'));
      }
    } catch (e) {
      if (e is DioException) {
        // ignore: avoid_print
        print("Error in placing the order");
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
