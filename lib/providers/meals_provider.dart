import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});

