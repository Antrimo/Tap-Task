import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/models/company_list_model.dart';
import 'package:tap/services/api_services.dart';

class CompanyBloc extends Cubit<List<CompanyListModel>> {
  final ApiServices apiServices;

  CompanyBloc({required this.apiServices}) : super([]);

  Future<void> fetchCompanies() async {
    try {
      final companies = await apiServices.fetchList();
      emit(companies);
    } catch (e) {
      emit([]);
    }
  }
}
