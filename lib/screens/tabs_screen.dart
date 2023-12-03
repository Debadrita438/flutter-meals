import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  MealsFilter.glutenFree: false,
  MealsFilter.lactoseFree: false,
  MealsFilter.vegetarian: false,
  MealsFilter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<MealsFilter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal is added to favorite!');
    }
  }

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
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[MealsFilter.glutenFree]! && meal.isGlutenFree) {
        return true;
      }
      if (_selectedFilters[MealsFilter.lactoseFree]! && meal.isLactoseFree) {
        return true;
      }
      if (_selectedFilters[MealsFilter.vegetarian]! && meal.isVegetarian) {
        return true;
      }
      if (_selectedFilters[MealsFilter.vegan]! && meal.isVegan) {
        return true;
      }
      return false;
    }).toList();

    Widget activePage = CategoriesScreen(
      toggleMealFavorite: _toggleMealFavStatus,
      filteredMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        mealsList: _favoriteMeals,
        toggleMealFavStatus: _toggleMealFavStatus,
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
