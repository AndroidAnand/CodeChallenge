import 'package:code_challenge/view_model/events/country_selected.dart';
import 'package:code_challenge/view_model/events/country_state_event.dart';
import 'package:code_challenge/view_model/events/load_countries.dart';
import 'package:code_challenge/view_model/events/state_selected.dart';
import 'package:code_challenge/view_model/states/sountry_states_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_challenge/repository/country_repository.dart';

class CountryStateViewModel extends Bloc<CountryStateEvent, CountryStatesState> {
  final CountryRepository countryRepository;

  CountryStateViewModel(this.countryRepository) : super(CountryStatesState()) {
    on<LoadCountries>(_loadCountries);
    on<CountrySelected>(_selectCountry);
    on<StateSelected>(_selectState);
  }

  Future<void> _loadCountries(LoadCountries event, Emitter<CountryStatesState> emit) async {
    try {
      final countries = await countryRepository.fetchCountries();
      emit(state.copyWith(countries: countries));
    } catch (error) {
      emit(state.copyWith(error: error.toString())); // Optionally handle errors
    }
  }

  Future<void> _selectCountry(CountrySelected event, Emitter<CountryStatesState> emit) async {
    try {
      final states = await countryRepository.fetchState(event.countryId.toString());
      emit(state.copyWith(states: states, selectedCountryId: event.countryId, selectedStatesId: null));
    } catch (error) {
      emit(state.copyWith(error: error.toString())); // Optionally handle errors
    }
  }

  void _selectState(StateSelected event, Emitter<CountryStatesState> emit) {
    emit(state.copyWith(selectedStatesId: event.stateId));
  }
}
