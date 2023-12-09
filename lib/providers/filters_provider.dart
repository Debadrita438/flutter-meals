import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MealsFilter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<MealsFilter, bool>> {
  FiltersNotifier()
      : super({
          MealsFilter.glutenFree: false,
          MealsFilter.lactoseFree: false,
          MealsFilter.vegetarian: false,
          MealsFilter.vegan: false
        });

  void setFilters(Map<MealsFilter, bool> activeFilters) {
    state = activeFilters;
  }

  void setFilter(MealsFilter filterLabel, bool isActive) {
    state = {...state, filterLabel: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<MealsFilter, bool>>(
  (ref) => FiltersNotifier(),
);
