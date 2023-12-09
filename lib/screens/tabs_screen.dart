import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';

import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  MealsFilter.glutenFree: false,
  MealsFilter.lactoseFree: false,
  MealsFilter.vegetarian: false,
  MealsFilter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<MealsFilter, bool> _selectedFilters = kInitialFilters;

  void _selectTabHandler(int pageIndex) {
    setState(() => _selectedPageIndex = pageIndex);
  }

  void _setDrawerScreen(String screenIdentifier) async {
    Navigator.of(context).pop();
    if (screenIdentifier == 'filters') {
      final result = await Navigator.of(context).push<Map<MealsFilter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() => _selectedFilters = result ?? kInitialFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final providedMeals = ref.watch(mealsProvider);
    final availableMeals = providedMeals.where((meal) {
      if (_selectedFilters[MealsFilter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[MealsFilter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[MealsFilter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[MealsFilter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      filteredMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        mealsList: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setDrawerScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _selectTabHandler(index),
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
