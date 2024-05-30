import 'package:code_challenge/model/country.dart';
import 'package:code_challenge/model/states.dart';
import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {
  final int? value;
  final List<T> items;
  final void Function(int?) onChanged;

  const DropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      constraints: const BoxConstraints(minWidth: 200),
      child: DropdownButton<int>(
        isExpanded: true,
        value: value,
        hint: const Text(''),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<int>>((T item) {
          final int id = item is Country ? item.id : (item as States).id;
          final String name = item is Country ? item.name : (item as States).name;
          return DropdownMenuItem<int>(
            value: id,
            child: Text(name),
          );
        }).toList(),
        underline: Container(),  // Remove the default underline
        dropdownColor: Colors.white,  // Set background color of the dropdown items
      ),
    );
  }
}
