import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final flitersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(flitersProvider);
  return meals.where((element) {
    if (activeFilters[Filter.glutenFree]! && !element.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !element.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !element.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
