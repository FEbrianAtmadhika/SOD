part of 'district_bloc.dart';

abstract class DistrictState extends Equatable {
  const DistrictState();

  @override
  List<Object> get props => [];
}

class DistrictInitial extends DistrictState {}

class DistrictLoading extends DistrictState {}

class DistrictFailed extends DistrictState {
  final String e;

  const DistrictFailed(this.e);

  @override
  List<Object> get props => [e];
}

class DistrictSuccess extends DistrictState {
  final List<DistrictModel> district;
  const DistrictSuccess(this.district);

  @override
  List<Object> get props => [district];
}
