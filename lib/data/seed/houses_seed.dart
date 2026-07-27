import 'package:cloud_firestore/cloud_firestore.dart';

final houses = [
  {
    "images": [
      "https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=1200",
      "https://cdn.furnishedhousing.com/property-images/8242683_R.jpg",
      "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200",
    ],
    "title": "Luxury House",
    "location": "Osaka, Japan",
    "price": 4200.0,
    "category": "House",
    "description":
        "A stately family home set in a gated community, with six bedrooms, a home cinema, and a private pool.",
    "agentName": "Natasya Wilodra",
    "agentRole": "Owner",
    "agentImage": "https://randomuser.me/api/portraits/women/65.jpg",
    "rating": 4.9,
    "reviews": 540.0,
    "beds": 6.0,
    "baths": 5.0,
    "sqft": 3200.0,
    "facilities": [
      "Car Parking",
      "Swimming Pool",
      "Gym & Fitness",
      "Pet Center",
    ],
    "address": "488 Forwell Road, Osaka, Japan",
  },
  {
    "images": [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrMaagRTKYK-vt8N_UkWtAkjBMAnU3rrerCs_t06kAWV5zigPMuaAqRTA&s=10",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9G9ej0B0_IrG5uIDbghfSdTl7ZCO2TbqhLeHjggYYbCK04tigLL7HexRj&s=10",
    ],
    "title": "Green Villa",
    "location": "Kyoto, Japan",
    "price": 8500.0,
    "category": "Villa",
    "description":
        "A peaceful villa surrounded by greenery, blending traditional architecture with modern comfort.",
    "agentName": "Charolette Hanlin",
    "agentRole": "Agent",
    "agentImage": "https://randomuser.me/api/portraits/women/44.jpg",
    "rating": 4.7,
    "reviews": 312.0,
    "beds": 4.0,
    "baths": 3.0,
    "sqft": 2400.0,
    "facilities": ["Swimming Pool", "Restaurant", "Pet Center"],
    "address": "657 Lukken Court, Kyoto, Japan",
  },
];

Future<void> uploadHousesToFirestore() async {
  final firestore = FirebaseFirestore.instance;

  for (final house in houses) {
    await firestore.collection('houses').add(house);
  }

  print('Houses uploaded successfully!');
}
