import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/meals_provider.dart';

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

final filteredMealsProvider = Provider((ref) {
  final providedMeals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  
  return providedMeals.where((meal) {
      if (activeFilters[MealsFilter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[MealsFilter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[MealsFilter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[MealsFilter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
});