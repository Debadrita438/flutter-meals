import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.filterTitle,
    required this.filterSubtitle,
    required this.filterValue,
    required this.onFilter,
  });

  final String filterTitle;
  final String filterSubtitle;
  final bool filterValue;
  final void Function(bool value) onFilter;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: filterValue,
      onChanged: onFilter,
      title: Text(
        filterTitle,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        filterSubtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 34,
        right: 22,
      ),
    );
  }
}
