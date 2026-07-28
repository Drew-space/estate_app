// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/adapters.dart';
// import '../data/house_repository.dart';

// final categoriesProvider = Provider<List<String>>((ref) {
//   return ["All", "House", "Villa", "Apartments", "Office"];
// });
// final searchQueryProvider = StateProvider<String>((ref) => "");
// final selectedCategoryProvider = StateProvider<String>((ref) => "All");

// class FavoritesNotifier extends Notifier<Set<String>> {
//   Box favouritesBox = Hive.box("favouritesBox");

//   @override
//   Set<String> build() {
//     List savedList = favouritesBox.get("favouriteIds", defaultValue: []);

//     Set<String> favSet = {};

//     for (var id in savedList) {
//       favSet.add(id.toString());
//     }

//     return favSet;
//   }

//   void toggle(String houseId) {
//     Set<String> currentFavs = state;
//     Set<String> newFavs = {};

//     for (var id in currentFavs) {
//       newFavs.add(id);
//     }

//     bool isAlreadyFav = false;

//     for (var id in newFavs) {
//       if (id == houseId) {
//         isAlreadyFav = true;
//       }
//     }

//     if (isAlreadyFav == true) {
//       newFavs.remove(houseId);
//     } else {
//       newFavs.add(houseId);
//     }

//     state = newFavs;

//     List<String> listToSave = newFavs.toList();
//     favouritesBox.put("favouriteIds", listToSave);
//   }
// }

// final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
//   FavoritesNotifier.new,
// );

// final houseRepositoryProvider = Provider<HouseRepository>((ref) {
//   return HouseRepository();
// });

// final housesStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
//   final repository = ref.watch(houseRepositoryProvider);
//   return repository.getHouses();
// });

// final filteredHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
//   final selectedCategory = ref.watch(selectedCategoryProvider);
//   final searchQuery = ref.watch(searchQueryProvider).trim().toLowerCase();

//   final housesAsyncValue = ref.watch(housesStreamProvider);

//   List<Map<String, dynamic>> allHouses = [];

//   if (housesAsyncValue.hasValue) {
//     allHouses = housesAsyncValue.value!;
//   }

//   List<Map<String, dynamic>> filtered = [];

//   for (var house in allHouses) {
//     final category = house["category"]?.toString().toLowerCase() ?? "";
//     final title = house["title"]?.toString().toLowerCase() ?? "";
//     final location = house["location"]?.toString().toLowerCase() ?? "";
//     final description = house["description"]?.toString().toLowerCase() ?? "";
//     final facilities = house["facilities"]?.toString().toLowerCase() ?? "";
//     final address = house["address"]?.toString().toLowerCase() ?? "";

//     bool matchesCategory =
//         selectedCategory == "All" || category == selectedCategory.toLowerCase();

//     bool matchesSearch =
//         searchQuery.isEmpty ||
//         title.contains(searchQuery) ||
//         location.contains(searchQuery) ||
//         category.contains(searchQuery) ||
//         description.contains(searchQuery) ||
//         address.contains(searchQuery) ||
//         facilities.contains(searchQuery);
//     if (matchesCategory && matchesSearch) {
//       filtered.add(house);
//     }
//   }

//   return filtered;
// });

// // final filteredHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
// //   final selectedCategory = ref.watch(selectedCategoryProvider);

// //   final housesAsyncValue = ref.watch(housesStreamProvider);

// //   List<Map<String, dynamic>> allHouses = [];

// //   if (housesAsyncValue.hasValue) {
// //     allHouses = housesAsyncValue.value!;
// //   }

// //   if (selectedCategory == "All") {
// //     return allHouses;
// //   }

// //   List<Map<String, dynamic>> filtered = [];
// //   for (var house in allHouses) {
// //     if (house["category"] == selectedCategory) {
// //       filtered.add(house);
// //     }
// //   }

// //   return filtered;
// // });

// final favoriteHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
//   final housesAsyncValue = ref.watch(housesStreamProvider);

//   List<Map<String, dynamic>> allHouses = [];
//   if (housesAsyncValue.hasValue) {
//     allHouses = housesAsyncValue.value!;
//   }

//   final favoriteIds = ref.watch(favoritesProvider);
//   final selectedCategory = ref.watch(selectedCategoryProvider);

//   List<Map<String, dynamic>> favorited = [];

//   for (final house in allHouses) {
//     if (favoriteIds.contains(house["id"])) {
//       favorited.add(house);
//     }
//   }

//   if (selectedCategory == "All") {
//     return favorited;
//   }

//   List<Map<String, dynamic>> filtered = [];
//   for (final house in favorited) {
//     if (house["category"] == selectedCategory) {
//       filtered.add(house);
//     }
//   }

//   return filtered;
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../data/house_repository.dart';

final categoriesProvider = Provider<List<String>>((ref) {
  return ["All", "House", "Villa", "Apartments", "Office"];
});

/// ---------- SHARED DATA SOURCE ----------
/// Everybody dey watch this one — na the single source of truth from Firestore
final houseRepositoryProvider = Provider<HouseRepository>((ref) {
  return HouseRepository();
});

final housesStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final repository = ref.watch(houseRepositoryProvider);
  return repository.getHouses();
});

List<Map<String, dynamic>> filterHouses({
  required List<Map<String, dynamic>> houses,
  required String category,
  String query = "",
}) {
  final searchQuery = query.trim().toLowerCase();

  List<Map<String, dynamic>> filtered = [];

  for (var house in houses) {
    final houseCategory = house["category"]?.toString().toLowerCase() ?? "";
    final title = house["title"]?.toString().toLowerCase() ?? "";
    final location = house["location"]?.toString().toLowerCase() ?? "";
    final description = house["description"]?.toString().toLowerCase() ?? "";
    final facilities = house["facilities"]?.toString().toLowerCase() ?? "";
    final address = house["address"]?.toString().toLowerCase() ?? "";

    bool matchesCategory =
        category == "All" || houseCategory == category.toLowerCase();

    bool matchesSearch =
        searchQuery.isEmpty ||
        title.contains(searchQuery) ||
        location.contains(searchQuery) ||
        houseCategory.contains(searchQuery) ||
        description.contains(searchQuery) ||
        address.contains(searchQuery) ||
        facilities.contains(searchQuery);

    if (matchesCategory && matchesSearch) {
      filtered.add(house);
    }
  }

  return filtered;
}

final homeCategoryProvider = StateProvider<String>((ref) => "All");
final homeSearchQueryProvider = StateProvider<String>((ref) => "");

final homeFilteredHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final houses = ref.watch(housesStreamProvider).value ?? [];
  final category = ref.watch(homeCategoryProvider);
  final query = ref.watch(homeSearchQueryProvider);
  return filterHouses(houses: houses, category: category, query: query);
});

final exploreCategoryProvider = StateProvider<String>((ref) => "All");
final exploreSearchQueryProvider = StateProvider<String>((ref) => "");

final exploreFilteredHousesProvider = Provider<List<Map<String, dynamic>>>((
  ref,
) {
  final houses = ref.watch(housesStreamProvider).value ?? [];
  final category = ref.watch(exploreCategoryProvider);
  final query = ref.watch(exploreSearchQueryProvider);
  return filterHouses(houses: houses, category: category, query: query);
});

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

final favouritesCategoryProvider = StateProvider<String>((ref) => "All");

final favoriteHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final houses = ref.watch(housesStreamProvider).value ?? [];
  final favoriteIds = ref.watch(favoritesProvider);
  final category = ref.watch(favouritesCategoryProvider);

  List<Map<String, dynamic>> favorited = [];
  for (final house in houses) {
    if (favoriteIds.contains(house["id"])) {
      favorited.add(house);
    }
  }

  return filterHouses(houses: favorited, category: category);
});
