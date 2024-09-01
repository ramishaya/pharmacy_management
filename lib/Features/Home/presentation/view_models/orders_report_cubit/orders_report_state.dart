part of 'orders_report_cubit.dart';

abstract class OrdersReportState extends Equatable {
  const OrdersReportState();

  @override
  List<Object> get props => [];
}

class OrdersReportInitial extends OrdersReportState {}

class OrdersReportLoading extends OrdersReportState {}

class OrdersReportFailure extends OrdersReportState {
  final String errMessage;

  const OrdersReportFailure(this.errMessage);
}

class OrdersReportSuccess extends OrdersReportState {
  final List<MyOrdersReport>? report;

  const OrdersReportSuccess(this.report);
}
