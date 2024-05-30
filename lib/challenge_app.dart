
import 'package:code_challenge/network/api.service.dart';
import 'package:code_challenge/repository/country_repository.dart';
import 'package:code_challenge/view/country_state_dropdown_view.dart';
import 'package:code_challenge/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Example',
      home: BlocProvider(
        create: (context) => CountryStateViewModel(CountryRepository()),
        child: const CountryStateDropdownView(),
      ),
    );
  }
}