part of 'signup_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}
class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String errMessage;

  const SignUpFailure(this.errMessage);
}

class SignUpSuccess extends SignUpState {
  final SignUpModel info;

  const SignUpSuccess(this.info);
}
