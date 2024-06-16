import 'package:flutter/material.dart';
import 'package:foresight_news_and_articles/core/utils/country_list.dart';

class CountryPicker extends StatefulWidget {
  final String initialCountry;
  final void Function(String) onCountrySelected;

  CountryPicker({
    required this.initialCountry,
    required this.onCountrySelected,
  });

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late String selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.initialCountry;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Country/Region'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: selectedCountry.isNotEmpty ? selectedCountry : null,
            items: countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountry = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Country/Region',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Or type your country/region',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                selectedCountry = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            widget.onCountrySelected(selectedCountry);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
