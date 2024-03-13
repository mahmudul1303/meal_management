import 'package:flutter/material.dart';
import 'package:meal_management/data/meal.dart';
import 'package:meal_management/screens/categories.dart';
import 'package:meal_management/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  void _showInfoMessege(String messege) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messege)));
  }

  void _toggleMealFavourites(Meal meal) {
    final isExixting = _favouriteMeals.contains(meal);
    if (isExixting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessege('Meal is no longer a favourite');
    } else {
      setState(() {
        _showInfoMessege('Mark as Favourite');
        _favouriteMeals.add(meal);
      });
    }
  }

  void _selectPage(int index) {
    setState(
      () {
        _selectedPageIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavourites,
    );
    var activePageTittle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavourites,
      );
      activePageTittle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTittle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Favourites'),
          ]),
    );
  }
}
