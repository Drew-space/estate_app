import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = Provider<List<String>>((ref) {
  return ["All", "House", "Villa", "Apartments", "Office"];
});

final selectedCategoryProvider = StateProvider<String>((ref) => "All");

/// This class manages the list of favorited house IDs.
/// I'm using a Set instead of a List because I don't want
/// the same house to be added twice, and checking if an id
/// already exists in a Set is faster than checking in a List.
class FavoritesNotifier extends Notifier<Set<String>> {
  // This runs once when the app first asks for the favorites.
  // I'm just starting with an empty set, since no house is
  // favorited yet when the app opens.
  @override
  Set<String> build() {
    return <String>{};
  }

  // This is the function the heart icon calls when tapped.
  // It checks if the house is already favorited or not,
  // and does the opposite of whatever it currently is.
  void toggle(String houseId) {
    // make a normal copy of the current set first
    Set<String> updatedFavorites = Set<String>.from(state);

    bool alreadyFavorited = updatedFavorites.contains(houseId);

    if (alreadyFavorited) {
      // it's already a favorite, so remove it
      updatedFavorites.remove(houseId);
    } else {
      // it's not a favorite yet, so add it
      updatedFavorites.add(houseId);
    }

    // important: I have to reassign "state" to the new set.
    // If I only called .add() or .remove() on "state" directly,
    // Riverpod wouldn't know anything changed, and the UI
    // (the heart icon) wouldn't update.
    state = updatedFavorites;
  }

  // small helper so I can easily check from anywhere
  // if a specific house is currently favorited
  bool isFavorite(String houseId) {
    return state.contains(houseId);
  }
}

// This turns the class above into something my widgets can
// actually use with ref.watch() and ref.read()
final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

/// All houses
final housesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      "id": "h1",
      "images": [
        "https://media.vrbo.com/lodging/93000000/92750000/92749300/92749255/78a6905c.jpg?impolicy=resizecrop&rw=575&rh=575&ra=fill",
        "https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=1200",
        "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200",
      ],
      "title": "La Grand Maison",
      "location": "Tokyo, Japan",
      "price": "\$1224",
      "category": "House",
      "description":
          "A sleek, modern home nestled in a quiet Tokyo neighborhood, offering open living spaces, high-end finishes, and easy access to downtown dining and transit.",
      "agentName": "Natasya Wilodra",
      "agentRole": "Owner",
      "agentImage": "https://randomuser.me/api/portraits/women/65.jpg",
      "rating": 4.8,
      "reviews": 1275,
      "beds": "3 Beds",
      "baths": "2 Bath",
      "sqft": "1450 sqft",
      "facilities": [
        "Car Parking",
        "Wi-fi & Network",
        "Gym & Fitness",
        "Laundry",
      ],
      "address": "Grand City St. 100, Tokyo, Japan",
    },
    {
      "id": "h2",
      "images": [
        "https://images.unsplash.com/photo-1484154218962-a197022b5858?w=1200",
      ],
      "title": "Modern Villa",
      "location": "Tokyo, Japan",
      "price": "\$1424",
      "category": "Villa",
      "description":
          "A bright, minimalist villa with floor-to-ceiling windows, a private garden, and a fully equipped modern kitchen.",
      "agentName": "Charolette Hanlin",
      "agentRole": "Agent",
      "agentImage": "https://randomuser.me/api/portraits/women/44.jpg",
      "rating": 4.6,
      "reviews": 150,
      "beds": "Studio",
      "baths": "1 Bath",
      "sqft": "850 sqft",
      "facilities": ["Swimming Pool", "Pet Center", "Sport Center"],
      "address": "Azizi Riviera, Meydan, Tokyo",
    },
    {
      "id": "h3",
      "images": [
        "https://cdn.furnishedhousing.com/property-images/8242683_R.jpg",
        "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200",
      ],
      "title": "Sky Apartments",
      "location": "Tokyo, Japan",
      "price": "\$17821",
      "category": "Apartments",
      "description":
          "Spacious two-bedroom apartment with a private balcony, hotel-style amenities, and a 24-hour concierge.",
      "agentName": "Natasya Wilodra",
      "agentRole": "Owner",
      "agentImage": "https://randomuser.me/api/portraits/women/65.jpg",
      "rating": 4.8,
      "reviews": 1275,
      "beds": "2 Beds",
      "baths": "2 Bath",
      "sqft": "1100 sqft",
      "facilities": [
        "Car Parking",
        "Restaurant",
        "Wi-fi & Network",
        "Gym & Fitness",
      ],
      "address": "Grand City St. 100, Tokyo, Japan",
    },
    {
      "id": "h4",
      "images": [
        "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200",
      ],
      "title": "Business Office",
      "location": "Tokyo, Japan",
      "price": "\$21469",
      "category": "Office",
      "description":
          "An executive office space featuring a reception area, meeting rooms, and high-speed internet, ideal for growing teams.",
      "agentName": "Charolette Hanlin",
      "agentRole": "Agent",
      "agentImage": "https://randomuser.me/api/portraits/women/44.jpg",
      "rating": 4.5,
      "reviews": 92,
      "beds": "—",
      "baths": "2 Bath",
      "sqft": "2000 sqft",
      "facilities": ["Car Parking", "Wi-fi & Network", "Sport Center"],
      "address": "9 Evergreen Center, Tokyo, Japan",
    },
    {
      "id": "h5",
      "images": [
        "https://paltonmorgan.com/naresus/2023/02/paramount-4-1280x719.jpg",
      ],
      "title": "Luxury House",
      "location": "Osaka, Japan",
      "price": "\$4200",
      "category": "House",
      "description":
          "A stately family home set in a gated community, with six bedrooms, a home cinema, and a private pool.",
      "agentName": "Natasya Wilodra",
      "agentRole": "Owner",
      "agentImage": "https://randomuser.me/api/portraits/women/65.jpg",
      "rating": 4.9,
      "reviews": 540,
      "beds": "6 Beds",
      "baths": "5 Bath",
      "sqft": "3200 sqft",
      "facilities": [
        "Car Parking",
        "Swimming Pool",
        "Gym & Fitness",
        "Pet Center",
      ],
      "address": "488 Forwell Road, Osaka, Japan",
    },
    {
      "id": "h6",
      "images": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnc1dXL2P0p4-Th64EBakI4UQc0TWV1TTEpVgawnUBegcb9qeiOKxlIN4&s=10",
      ],
      "title": "Green Villa",
      "location": "Kyoto, Japan",
      "price": "\$8500",
      "category": "Villa",
      "description":
          "A peaceful villa surrounded by greenery, blending traditional architecture with modern comfort.",
      "agentName": "Charolette Hanlin",
      "agentRole": "Agent",
      "agentImage": "https://randomuser.me/api/portraits/women/44.jpg",
      "rating": 4.7,
      "reviews": 312,
      "beds": "4 Beds",
      "baths": "3 Bath",
      "sqft": "2400 sqft",
      "facilities": ["Swimming Pool", "Restaurant", "Pet Center"],
      "address": "657 Lukken Court, Kyoto, Japan",
    },
  ];
});

final filteredHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final houses = ref.watch(housesProvider);

  if (selectedCategory == "All") {
    return houses;
  }

  return houses
      .where((house) => house["category"] == selectedCategory)
      .toList();
});

/// This gives me only the houses that are currently favorited.
/// I use this on the Favorites screen instead of housesProvider.
final favoriteHousesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final allHouses = ref.watch(housesProvider);
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
