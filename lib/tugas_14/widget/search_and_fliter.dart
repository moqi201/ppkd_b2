// widgets/search_and_filter.dart
import 'package:flutter/material.dart';

class SearchAndFilter extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;

  const SearchAndFilter({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search character by name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: selectedGender,
          items: const [
            DropdownMenuItem(value: null, child: Text('All Genders')),
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
          onChanged: onGenderChanged,
          decoration: const InputDecoration(
            labelText: 'Filter by Gender',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
