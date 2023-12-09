import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.categoryTitle,
    required this.mealsList,
  });

  final String? categoryTitle;
  final List<Meal> mealsList;

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh... Nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Maybe you can try adding some!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );

    if (mealsList.isNotEmpty) {
      bodyContent = ListView.builder(
        itemCount: mealsList.length,
        itemBuilder: (context, index) {
          return MealItem(
            meal: mealsList[index],
          );
        },
      );
    }

    if (categoryTitle == null) {
      return bodyContent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: bodyContent,
    );
  }
}
