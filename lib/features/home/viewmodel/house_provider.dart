import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../data/house_repository.dart';

final categoriesProvider = Provider<List<String>>((ref) {
  return ["All", "House", "Villa", "Apartments", "Office"];
});

final selectedCategoryProvider = StateProvider<String>((ref) => "All");

class FavoritesNotifier extends Notifier<Set<String>> {
  Box favouritesBox = Hive.box("favouritesBox");

  @override
  Set<String> build() {
    List savedList = favouritesBox.get("favouriteIds", defaultValue: []);

    Set<String> favSet = {};

    for (var id in savedList) {
      favSet.add(id.toString());
    }

    return favSet;
  }

  void toggle(String houseId) {
    Set<String> currentFavs = state;
    Set<String> newFavs = {};

    for (var id in currentFavs) {
      newFavs.add(id);
    }

    bool isAlreadyFav = false;

    for (var id in newFavs) {
      if (id == houseId) {
        isAlreadyFav = true;
      }
    }

    if (isAlreadyFav == true) {
      newFavs.remove(houseId);
    } else {
      newFavs.add(houseId);
    }

    state = newFavs;

    List<String> listToSave = newFavs.toList();
    favouritesBox.put("favouriteIds", listToSave);
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

final houseRepositoryProvider = Provider<HouseRepository>((ref) {
  return HouseRepository();
});

final housesStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final repository = ref.watch(houseRepositoryProvider);
  return repository.getHouses();
});

final filteredHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);

  final housesAsyncValue = ref.watch(housesStreamProvider);

  List<Map<String, dynamic>> allHouses = [];

  if (housesAsyncValue.hasValue) {
    allHouses = housesAsyncValue.value!;
  }

  if (selectedCategory == "All") {
    return allHouses;
  }

  List<Map<String, dynamic>> filtered = [];
  for (var house in allHouses) {
    if (house["category"] == selectedCategory) {
      filtered.add(house);
    }
  }

  return filtered;
});

final favoriteHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final housesAsyncValue = ref.watch(housesStreamProvider);

  List<Map<String, dynamic>> allHouses = [];
  if (housesAsyncValue.hasValue) {
    allHouses = housesAsyncValue.value!;
  }

  final favoriteIds = ref.watch(favoritesProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  List<Map<String, dynamic>> favorited = [];

  for (final house in allHouses) {
    if (favoriteIds.contains(house["id"])) {
      favorited.add(house);
    }
  }

  if (selectedCategory == "All") {
    return favorited;
  }

  List<Map<String, dynamic>> filtered = [];
  for (final house in favorited) {
    if (house["category"] == selectedCategory) {
      filtered.add(house);
    }
  }

  return filtered;
});
