import 'package:flutter/material.dart';
import 'package:traveling_app/widgets/trip_item.dart';
import '../models/trips.dart';

class FavoriteTripsScreen extends StatelessWidget {
  final List<Trip> favoriteTrips;
  final Function(String) removeFromFavorites; 

  const FavoriteTripsScreen({
    Key? key,
    required this.favoriteTrips,
    required this.removeFromFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteTrips.isEmpty) {
      return const Center(child: Text('ليس لديك رحلات مفضلة'));
    }

    return ListView.builder(
      itemCount: favoriteTrips.length,
      itemBuilder: (context, index) {
        return TripItem(
          id: favoriteTrips[index].id,
          title: favoriteTrips[index].title,
          imageUrl: favoriteTrips[index].imageUrl,
          duration: favoriteTrips[index].duration,
          tripType: favoriteTrips[index].tripType,
          season: favoriteTrips[index].season,
          isFavorite: true,
          onFavoriteToggle: () {
            removeFromFavorites(favoriteTrips[index].id);
          },
        );
      },
    );
  }
}
