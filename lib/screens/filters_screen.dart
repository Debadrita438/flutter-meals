import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/widgets/filter_item.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilterSet = activeFilters[MealsFilter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[MealsFilter.lactoseFree]!;
    _vegetarianFilterSet = activeFilters[MealsFilter.vegetarian]!;
    _veganFilterSet = activeFilters[MealsFilter.vegan]!;
  }

  void _setDrawerScreen(String screenIdentifier) {
    Navigator.of(context).pop();
    if (screenIdentifier == 'meals') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => const TabsScreen()),
      );
    }
  }

  Future<bool> _onWillPopHandler() async {
    ref.read(filtersProvider.notifier).setFilters({
      MealsFilter.glutenFree: _glutenFreeFilterSet,
      MealsFilter.lactoseFree: _lactoseFreeFilterSet,
      MealsFilter.vegetarian: _vegetarianFilterSet,
      MealsFilter.vegan: _veganFilterSet,
    });
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setDrawerScreen,
      ),
      body: WillPopScope(
        onWillPop: _onWillPopHandler,
        child: Column(
          children: [
            FilterItem(
              filterTitle: 'Glueten-free',
              filterSubtitle: 'Only include gluten-free meals.',
              filterValue: _glutenFreeFilterSet,
              onFilter: (isChecked) {
                setState(() => _glutenFreeFilterSet = isChecked);
              },
            ),
            FilterItem(
              filterTitle: 'Lactose-free',
              filterSubtitle: 'Only include Lactose-free meals.',
              filterValue: _lactoseFreeFilterSet,
              onFilter: (isChecked) {
                setState(() => _lactoseFreeFilterSet = isChecked);
              },
            ),
            FilterItem(
              filterTitle: 'Vegetarian',
              filterSubtitle: 'Only include vegetarian meals.',
              filterValue: _vegetarianFilterSet,
              onFilter: (isChecked) {
                setState(() => _vegetarianFilterSet = isChecked);
              },
            ),
            FilterItem(
              filterTitle: 'Vegan',
              filterSubtitle: 'Only include vegan meals.',
              filterValue: _veganFilterSet,
              onFilter: (isChecked) {
                setState(() => _veganFilterSet = isChecked);
              },
            ),
          ],
        ),
      ),
    );
  }
}
