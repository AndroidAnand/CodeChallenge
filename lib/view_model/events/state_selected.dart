
import 'package:code_challenge/view_model/events/country_state_event.dart';

class StateSelected extends CountryStateEvent {
  final int stateId;
  StateSelected(this.stateId);
}