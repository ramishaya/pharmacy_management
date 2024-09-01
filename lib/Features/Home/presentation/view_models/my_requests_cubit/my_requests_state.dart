part of 'my_requests_cubit.dart';

abstract class MyRequestsState extends Equatable {
  const MyRequestsState();

  @override
  List<Object> get props => [];
}

class MyRequestsInitial extends MyRequestsState {}

class MyRequestsLoading extends MyRequestsState {}

class MyRequestsFailure extends MyRequestsState {
  final String errMessage;

  const MyRequestsFailure(this.errMessage);
}

class MyRequestsSuccess extends MyRequestsState {
  final List<Requests>? myRequests;

  const MyRequestsSuccess(this.myRequests);
}
