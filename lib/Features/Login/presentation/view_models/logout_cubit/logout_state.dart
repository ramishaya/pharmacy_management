part of 'logout_cubit.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutFailure extends LogoutState {
  final String errMessage;

  const LogoutFailure(this.errMessage);
}

class LogoutSuccess extends LogoutState {
  final LogoutModel info;

  const LogoutSuccess(this.info);
}
