part of 'all_medicines_cubit.dart';

abstract class AllMedicinesState extends Equatable {
  const AllMedicinesState();

  @override
  List<Object> get props => [];
}
class AllMedicinesInitial extends AllMedicinesState {}

class AllMedicinesLoading extends AllMedicinesState {}

class AllMedicinesFailure extends AllMedicinesState {
  final String errMessage;

  const AllMedicinesFailure(this.errMessage);
}

class AllMedicinesSuccess extends AllMedicinesState {
  final List<Map<String, List<Medicine>>> medicines;

  const AllMedicinesSuccess(this.medicines);
}
