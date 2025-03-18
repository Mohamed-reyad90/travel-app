import 'package:flutter/material.dart';
import 'package:traveling_app/models/trips.dart';
import 'package:traveling_app/screens/category_trips_screen.dart';
import 'package:traveling_app/screens/filter_screen.dart';
import 'package:traveling_app/screens/ntifications_screen.dart';
import 'package:traveling_app/screens/tabsdown_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:traveling_app/screens/trip_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = Trips_data;
  List<Trip> _favoriteTrips = [];

  void _changeFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableTrips =
          Trips_data.where((trip) {
            if (_filters['summer'] == true && !trip.isInsummer) {
              return false;
            }
            if (_filters['winter'] == true && !trip.isInwinter) {
              return false;
            }
            if (_filters['family'] == true && !trip.isForFamilies) {
              return false;
            }
            return true;
          }).toList();
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex = _favoriteTrips.indexWhere(
      (trip) => trip.id == tripId,
    );
    setState(() {
      if (existingIndex >= 0) {
        _favoriteTrips.removeAt(existingIndex);
      } else {
        _favoriteTrips.add(Trips_data.firstWhere((trip) => trip.id == tripId));
      }
    });
  }

  bool _isFavorite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AE"),
      debugShowCheckedModeBanner: false,
      title: 'Traveling App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(secondary: Colors.amber),
        fontFamily: 'elMessiri',
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineSmall: const TextStyle(
            color: Colors.purple,
            fontSize: 24,
            fontFamily: 'elMessiri',
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'elMessiri',
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'elMessiri',
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'elMessiri',
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.purple,
        ),
      ),
      routes: {
        '/': (ctx) => TabsdownScreen(favoriteTrips: _favoriteTrips),
        NotificationsScreen.screenRoute: (ctx) => const NotificationsScreen(),
        FilterScreen.screenRoute:
            (ctx) => FilterScreen(_changeFilter, _filters),
        CategoryTripsScreen.screenRoute:
            (ctx) => CategoryTripsScreen(_availableTrips),
        TripDetailsScreen.tripDetailsScreenRoute:
            (ctx) => TripDetailsScreen(_manageFavorite, _isFavorite),
      },
    );
  }
}
