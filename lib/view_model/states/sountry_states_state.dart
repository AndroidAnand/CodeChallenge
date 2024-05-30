
import 'package:code_challenge/model/country.dart';
import 'package:code_challenge/model/states.dart';

class CountryStatesState {
  final List<Country> countries;
  final List<States> states;
  final int? selectedCountryId;
  final int? selectedStatesId;
  final String? error;

  CountryStatesState({
    this.countries = const [],
    this.states = const [],
    this.selectedCountryId,
    this.selectedStatesId,
    this.error
  });

  CountryStatesState copyWith({
    List<Country>? countries,
    List<States>? states,
    int? selectedCountryId,
    int? selectedStatesId,
    String? error,
  }) {
    return CountryStatesState(
      countries: countries ?? this.countries,
      states: states ?? this.states,
      selectedCountryId: selectedCountryId,
      selectedStatesId: selectedStatesId,
    );
  }
}