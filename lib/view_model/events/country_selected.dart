import 'package:code_challenge/view_model/events/country_state_event.dart';

class CountrySelected extends CountryStateEvent {
  final int countryId;
  CountrySelected(this.countryId);
}