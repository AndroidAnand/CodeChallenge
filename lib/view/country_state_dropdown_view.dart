import 'package:code_challenge/model/country.dart';
import 'package:code_challenge/model/states.dart';
import 'package:code_challenge/view_model/country_view_model.dart';
import 'package:code_challenge/view_model/events/country_selected.dart';
import 'package:code_challenge/view_model/events/load_countries.dart';
import 'package:code_challenge/view_model/events/state_selected.dart';
import 'package:code_challenge/view_model/states/sountry_states_state.dart';
import 'package:code_challenge/widget/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CountryStateDropdownView extends StatefulWidget {
  const CountryStateDropdownView({super.key});

  @override
  CountryStateDropdownViewState createState() => CountryStateDropdownViewState();
}

class CountryStateDropdownViewState extends State<CountryStateDropdownView> {
  int? _selectedCountryId;
  int? _selectedStateId;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryStateViewModel>(context, listen: false).add(LoadCountries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country and State'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CountryStateViewModel, CountryStatesState>(
          builder: (context, state) {
            // Verify selected IDs against current lists to ensure they exist
            _selectedCountryId = state.countries.any((c) => c.id == _selectedCountryId) ? _selectedCountryId : null;
            _selectedStateId = state.states.any((s) => s.id == _selectedStateId) ? _selectedStateId : null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text("Country", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownWidget<Country>(
                  value: _selectedCountryId,
                  items: state.countries,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountryId = newValue;
                      _selectedStateId = null;  // Reset state selection when country changes
                    });
                    context.read<CountryStateViewModel>().add(CountrySelected(newValue!));
                  },
                ),
                const SizedBox(height: 20),
                const Text("State", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownWidget<States>(
                  value: _selectedStateId,
                  items: state.states,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStateId = newValue;
                    });
                    context.read<CountryStateViewModel>().add(StateSelected(newValue!));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
