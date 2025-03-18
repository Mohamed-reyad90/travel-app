import 'package:flutter/material.dart';
import 'package:traveling_app/models/trips.dart';

class TripDetailsScreen extends StatelessWidget {
  static const tripDetailsScreenRoute = '/trip-details';

  final void Function(String) manageFavorite; // تأكد من أن المعامل يأخذ tripId
  final bool Function(String)
  isFavorite; // تأكد من تمرير tripId للحصول على النتيجة الصحيحة

  const TripDetailsScreen(this.manageFavorite, this.isFavorite, {Key? key})
    : super(key: key);

  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.topRight,
      child: Text(titleText, style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  Widget buildListView(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedTrip = Trips_data.firstWhere((trip) => trip.id == tripId);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(selectedTrip.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedTrip.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            buildSectionTitle(context, 'الأنشطة'),
            buildListView(
              ListView.builder(
                itemCount: selectedTrip.activities.length,
                itemBuilder:
                    (context, index) => Card(
                      elevation: 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(selectedTrip.activities[index]),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 10),
            buildSectionTitle(context, 'البرنامج اليومي'),
            buildListView(
              ListView.builder(
                itemCount: selectedTrip.program.length,
                itemBuilder:
                    (context, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('يوم ${index + 1}'),
                          ),
                          title: Text(selectedTrip.program[index]),
                        ),
                        const Divider(),
                      ],
                    ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(tripId) ? Icons.star : Icons.star_border),
        onPressed: () => manageFavorite(tripId),
      ),
    );
  }
}
