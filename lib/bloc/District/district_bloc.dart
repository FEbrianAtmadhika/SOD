import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sod_new/models/districtmodel.dart';
import 'package:sod_new/services/addressservice.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  DistrictBloc() : super(DistrictInitial()) {
    on<DistrictEvent>((event, emit) async {
      if (event is DistrictGetAll) {
        try {
          emit(DistrictLoading());

          List<DistrictModel> res = await Addressservice().getAllDistrict();

          emit(DistrictSuccess(res));
        } catch (e) {
          emit(DistrictFailed(e.toString()));
        }
      }
    });
  }
}
