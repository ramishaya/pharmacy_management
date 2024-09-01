part of 'report_details_cubit.dart';



abstract class ReportDetailsState extends Equatable {
  const ReportDetailsState();

  @override
  List<Object> get props => [];
}

class ReportDetailsInitial extends ReportDetailsState {}

class ReportDetailsLoading extends ReportDetailsState {}

class ReportDetailsFailure extends ReportDetailsState {
  final String errMessage;

  const ReportDetailsFailure(this.errMessage);
}

class ReportDetailsSuccess extends ReportDetailsState {
  final List <ReportDetails>? reportDetails;

  const ReportDetailsSuccess(this.reportDetails);
}
