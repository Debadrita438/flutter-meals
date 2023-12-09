import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/widgets/filter_item.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  void _setDrawerScreen(String screenIdentifier, BuildContext context) {
    Navigator.of(context).pop();
    if (screenIdentifier == 'meals') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => const TabsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(
        onSelectScreen: (type) => _setDrawerScreen(type, context),
      ),
      body:  Column(
          children: [
            FilterItem(
              filterTitle: 'Glueten-free',
              filterSubtitle: 'Only include gluten-free meals.',
              filterValue: activeFilters[MealsFilter.glutenFree]!,
              onFilter: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(MealsFilter.glutenFree, isChecked);
              },
            ),
            FilterItem(
              filterTitle: 'Lactose-free',
              filterSubtitle: 'Only include Lactose-free meals.',
              filterValue: activeFilters[MealsFilter.lactoseFree]!,
              onFilter: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(MealsFilter.lactoseFree, isChecked);
              },
            ),
            FilterItem(
              filterTitle: 'Vegetarian',
              filterSubtitle: 'Only include vegetarian meals.',
              filterValue: activeFilters[MealsFilter.vegetarian]!,
              onFilter: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(MealsFilter.vegetarian, isChecked);
              },
            ),
            FilterItem(
              filterTitle: 'Vegan',
              filterSubtitle: 'Only include vegan meals.',
              filterValue: activeFilters[MealsFilter.vegan]!,
              onFilter: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(MealsFilter.vegan, isChecked);
              },
            ),
          ],
        ),
      );
  }
}
