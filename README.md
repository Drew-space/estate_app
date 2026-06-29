# Real Scout

A Flutter app where you can browse listings, filter by category, and save your favorites even when you're offline.

## What this is

Real Scout lets users scroll through property listings (houses, villas, apartments, offices), check out detail pages with images, pricing, and agent info, and tap to favorite the ones they like. The favorites stick around even after you close the app or lose your internet connection.

## Tech stack

- **Flutter** for the UI
- **Riverpod** for state management
- **Hive** for local storage (favorites persistence)
- **cached_network_image** for offline image caching
- **connectivity_plus** for detecting online/offline status

## Getting it running

1. Clone the repo
2. Run `flutter pub get`
3. Run `flutter pub run build_runner build` if Hive adapters need generating (skip this if there are none to generate)
4. Run the app with `flutter run`

That's it, no backend or API keys needed because everything's local right now.

## Why Riverpod

I went with Riverpod over plain Provider or Bloc mainly because of how clean it is to compose state and also i'm comming from javascript eco system. A lot of this app is just "take this list, filter it by that," and Riverpod's `Provider` and derived providers make that almost free `filteredHousesProvider` just watches the category and the house list and recomputes. No manual listeners, no boilerplate.

The other big reason is the `Notifier` class for favorites. I needed something that holds a `Set<String>` of favorited house IDs, exposes a way to toggle them, and persists to Hive every time something changes. Riverpod's `Notifier` pattern fit that perfectly one class, one source of truth, and any widget that watches `favoritesProvider` rebuilds automatically when something gets favorited or unfavorited.

## How offline works

There's no backend in this app right now, so "offline" mostly comes down to two things:

**Favorites persist locally.** When you tap the heart icon on a listing, it doesn't just update in-memory state — it also writes straight to a Hive box (`favouritesBox`). So even if you close the app completely or your phone loses signal, your favorites are still there next time you open it. On app start, the `FavoritesNotifier` reads whatever was last saved in Hive and uses that as the initial state.

**Images get cached.** Since the listing images are just remote URLs (Unsplash, etc.), I'm using `cached_network_image` so once an image has loaded once, it's saved locally and doesn't need to re-download every time you revisit a listing. This also means if you're offline but you've already viewed a property before, the images still show up instead of a broken image icon.

**Connectivity awareness.** I added `connectivity_plus` to actually detect when the device goes offline or comes back online, so the app can show a toast notification letting the user know their connection status changed, instead of just silently failing requests or leaving them guessing.

There's no sync-back-to-server step because there's no server — everything that needs to persist (favorites) lives in Hive on-device.

## Architecture overview

The app is structured around a handful of Riverpod providers that all build on each other:

- `housesProvider` — the raw list of all properties (currently hardcoded, but structured like it came from an API so swapping in a real data source later wouldn't require a rewrite)
- `categoriesProvider` — the filter categories (All, House, Villa, Apartments, Office)
- `selectedCategoryProvider` — just tracks which category the user currently has selected
- `filteredHousesProvider` — watches the above two and returns the filtered list
- `favoritesProvider` — a `Notifier` backed by Hive, holding the set of favorited house IDs
- `favoriteHousesProvider` — combines `housesProvider`, `favoritesProvider`, and the selected category to give you just the favorited listings, filtered the same way as the main list

The idea was to keep each provider doing one small job, and let the UI layer just watch whichever combination it needs instead of having screens compute things themselves.

## Scaling this up

Right now the data is hardcoded in `housesProvider`, which obviously won't fly for a real product. The natural next step would be swapping that out for an actual API call (probably wrapped in a `FutureProvider` or similar), and the rest of the app barely has to change since everything downstream already just consumes whatever `housesProvider` returns.

For favorites, Hive works fine for a single device, but if this needed to sync across devices for the same user, I'd add a backend layer and treat Hive as a local cache that syncs in the background rather than the source of truth.

## Biggest challenge

Honestly, coming from javascript ecosystem to flutter/dart the functions are bit confusing but yeah i was able to catch up be of some similarity one the trickiest part was getting the favorites logic to feel instant in the UI while also reliably persisting to Hive without doing it twice or missing an update. Riverpod's `Notifier` made the "feel instant" part easy since the UI just reacts to state changes, but I had to be careful that every state update was paired with a write to Hive, and that the initial `build()` correctly hydrated from whatever was already saved otherwise you'd get a flash of "no favorites" on app start even when there were saved ones.

I kept things intentionally simple here rather than over-engineering no sync queues, no conflict resolution, no offline write-ahead logs. Just: read from Hive on start, write to Hive on every change. For the scope of this app, that's all it needed.
