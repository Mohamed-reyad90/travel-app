import 'package:flutter/material.dart';
import 'package:traveling_app/models/trips.dart';
import 'package:traveling_app/screens/trip_details_screen.dart';

class TripItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final TripType tripType;
  final Season season;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  String get seasonText {
    switch (season) {
      case Season.summer:
        return 'صيف';
      case Season.winter:
        return 'شتاء';
      case Season.spring:
        return 'ربيع';
      case Season.autumn:
        return 'خريف';
    }
  }

  String get tripTypeText {
    switch (tripType) {
      case TripType.exploration:
        return 'استكشاف';
      case TripType.recovery:
        return 'نقاهة';
      case TripType.activities:
        return 'أنشطة';
      case TripType.therapy:
        return 'علاج';
    }
  }

  IconData getSeasonIcon() {
    switch (season) {
      case Season.summer:
        return Icons.wb_sunny; 
      case Season.winter:
        return Icons.ac_unit;
      case Season.spring:
        return Icons.local_florist;
      case Season.autumn:
        return Icons.park;
    }
  }

  void selectTrip(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamed(TripDetailsScreen.tripDetailsScreenRoute, arguments: id);
  }

  const TripItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.tripType,
    required this.season,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTrip(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: onFavoriteToggle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.6, 1],
                    ),
                  ),
                  height: 250,
                  alignment: Alignment.bottomRight,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 6),
                      Text('$duration ايام'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        getSeasonIcon(),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 6),
                      Text(seasonText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 6),
                      Text(tripTypeText),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
