import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap/bloc/company_cubit.dart';
import 'package:tap/presentation/screens/home_screen.dart';
import 'package:tap/services/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) =>
            CompanyBloc(apiServices: ApiServices())..fetchCompanies(),
        child: HomeScreen(),
      ),
    );
  }
}
