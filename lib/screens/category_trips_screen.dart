import 'package:flutter/material.dart';
import 'package:traveling_app/models/trips.dart';
import 'package:traveling_app/widgets/trip_item.dart';

class CategoryTripsScreen extends StatelessWidget {
  static const screenRoute = '/category-trips';

  final List<Trip> availableTrips;

  const CategoryTripsScreen(this.availableTrips, {super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (routeArgs == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("خطأ في تحميل الصفحة")),
        body: const Center(child: Text("تعذر تحميل بيانات التصنيف.")),
      );
    }

    final categoryTitle = routeArgs['title']!;
    final categoryId = routeArgs['id']!;

    final filteredTrips =
        availableTrips.where((trip) {
          return trip.categories.contains(categoryId);
        }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(categoryTitle, style: const TextStyle(color: Colors.white)),
      ),
      body:
          filteredTrips.isEmpty
              ? const Center(
                child: Text(
                  "لا توجد رحلات متاحة لهذا التصنيف.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: filteredTrips.length,
                itemBuilder: (ctx, index) {
                  return TripItem(
                    id: filteredTrips[index].id,
                    title: filteredTrips[index].title,
                    imageUrl: filteredTrips[index].imageUrl,
                    duration: filteredTrips[index].duration,
                    tripType: filteredTrips[index].tripType,
                    season: filteredTrips[index].season,
                    isFavorite:
                        filteredTrips[index].isFavorite, // ✅ تمرير حالة المفضلة
                    onFavoriteToggle: () {}, // ✅ يجب تمرير دالة للتحكم بالمفضلة
                  );
                },
              ),
    );
  }
}
