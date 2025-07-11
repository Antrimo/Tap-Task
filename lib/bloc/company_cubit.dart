import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/models/company_detail_model.dart';
import 'package:tap/models/company_list_model.dart';
import 'package:tap/services/api_services.dart';

class CompanyListCubit extends Cubit<List<CompanyListModel>> {
  final ApiServices apiServices;

  CompanyListCubit({required this.apiServices}) : super([]);

  Future<void> fetchCompanies() async {
    try {
      final companies = await apiServices.fetchList();
      emit(companies);
    } catch (e) {
      emit([]);
    }
  }
}

class CompanyDetailCubit extends Cubit<CompanyDetailModel?> {
  final ApiServices apiServices;

  CompanyDetailCubit({required this.apiServices}) : super(null);

  Future<void> fetchDetail() async {
    try {
      emit(null);
      final detail = await apiServices.fetchDetail();
      emit(detail);
    } catch (e) {
      emit(null);
    }
  }
}
