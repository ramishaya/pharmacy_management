

import 'package:dartz/dartz.dart';
import 'package:pharmacy/Features/Home/data/models/all_medicines_model.dart';
import 'package:pharmacy/Features/Home/data/models/my_requests_model.dart';
import 'package:pharmacy/Features/Home/data/models/orders_report_model.dart';
import 'package:pharmacy/Features/Home/data/models/report_details_model.dart';
import 'package:pharmacy/Features/Home/presentation/views/my_requests_view.dart';

import '../../../../Core/errors/failuers.dart';

abstract class HomeRepo{
    Future <Either<Failure, List<Map<String, List<Medicine>>>>> fetchAllMedicines();
    Future <Either<Failure, List<Requests>?>> fecthMyRequests();
    Future <Either<Failure, List<MyOrdersReport>?>> fecthOrdersReport();
    Future <Either<Failure, List<ReportDetails>?>> fecthReportDetails({required int reportID});
}