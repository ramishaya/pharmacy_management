part of 'search_medicine_cubit.dart';

abstract class SearchMedicineState extends Equatable {
  const SearchMedicineState();

  @override
  List<Object> get props => [];
}

class SearchMedicineInitial extends SearchMedicineState {}

class SearchMedicineLoading extends SearchMedicineState {}

class SearchMedicineFailure extends SearchMedicineState {
  final String errMessage;

  const SearchMedicineFailure(this.errMessage);
}

class SearchMedicineSuccess extends SearchMedicineState {
  final List<MedicinesResault> medicines;

  const SearchMedicineSuccess(this.medicines);
}
