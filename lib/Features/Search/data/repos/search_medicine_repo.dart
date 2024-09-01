

import 'package:dartz/dartz.dart';
import 'package:pharmacy/Features/Search/data/models/add_fav_model.dart';
import 'package:pharmacy/Features/Search/data/models/medicine_details_model.dart';


import '../../../../Core/errors/failuers.dart';
import '../models/order_medicine_model.dart';
import '../models/order_request_model.dart';
import '../models/search_medicine_model.dart';

abstract class SearchMedicineRepo{
    Future <Either<Failure, List<MedicinesResault>>> searchMedicines({required String key});
     Future <Either<Failure,  Details>> showMedicineDetails({required String id});
     Future <Either<Failure,  AddFavModel>> addFav({required String id});
     Future <Either<Failure,  OrderMedicineModel>> orderMedicine({required List<Product> products});

    
}

