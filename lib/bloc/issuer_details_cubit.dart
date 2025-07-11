import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tap/models/company_detail_model.dart';
import 'package:tap/services/api_services.dart';

part 'issuer_details_cubit.freezed.dart';

@freezed
class IssuerDetailsState with _$IssuerDetailsState {
  const factory IssuerDetailsState.initial() = _Initial;
  const factory IssuerDetailsState.loading() = _Loading;
  const factory IssuerDetailsState.loaded(IssuerDetails issuerDetails) =_Loaded;
  const factory IssuerDetailsState.error(String message) = _Error;
}

class IssuerDetailsCubit extends Cubit<IssuerDetailsState> {
  final ApiServices apiServices;

  IssuerDetailsCubit({required this.apiServices})
    : super(const IssuerDetailsState.initial());

  Future<void> fetchIssuerDetails() async {
    emit(const IssuerDetailsState.loading());
    try {
      final companyDetail = await apiServices.fetchDetail();
      emit(IssuerDetailsState.loaded(companyDetail.issuerDetails));
    } catch (e) {
      emit(IssuerDetailsState.error(e.toString()));
    }
  }
}
