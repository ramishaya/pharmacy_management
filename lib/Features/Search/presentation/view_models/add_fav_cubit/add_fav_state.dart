part of 'add_fav_cubit.dart';

abstract class AddFavState extends Equatable {
  const AddFavState();

  @override
  List<Object> get props => [];
  
}

class AddFavInitial extends AddFavState {}

class AddFavLoading extends AddFavState {}

class AddFavFailure extends AddFavState {
  final String errMessage;

  const AddFavFailure(this.errMessage);
}

class AddFavSuccess extends AddFavState {
  final AddFavModel message;

  const AddFavSuccess(this.message);
}
