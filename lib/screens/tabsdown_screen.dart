import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:traveling_app/models/trips.dart';
import 'package:traveling_app/screens/categories_screen.dart';
import 'package:traveling_app/screens/favorite_trips_screen.dart';
import 'package:traveling_app/widgets/app_drawer.dart';
import 'package:traveling_app/screens/ntifications_screen.dart';

class TabsdownScreen extends StatefulWidget {
  final List<Trip> favoriteTrips;

  const TabsdownScreen({Key? key, required this.favoriteTrips})
    : super(key: key);

  @override
  State<TabsdownScreen> createState() => _TabsdownScreenState();
}

class _TabsdownScreenState extends State<TabsdownScreen> {
  int _selectedIndex = 0;
  late List<Trip> _favoriteTrips;
  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _favoriteTrips = List.from(
      widget.favoriteTrips,
    ); // نسخ القائمة لتجنب تعديل الأصل
    _updateScreens();
  }

  void _removeFavoriteTrip(String tripId) {
    setState(() {
      _favoriteTrips.removeWhere((trip) => trip.id == tripId);
      _updateScreens();
    });
  }

  void _updateScreens() {
    _screens = [
      {'screen': const CategoriesScreen(), 'title': 'تصنيفات الرحلات'},
      {
        'screen': FavoriteTripsScreen(
          favoriteTrips: _favoriteTrips,
          removeFromFavorites: _removeFavoriteTrip, // تمرير الدالة للحذف
        ),
        'title': 'الرحلات المفضلة',
      },
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(NotificationsScreen.screenRoute);
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: const Text(
                    '5', // عدد الإشعارات الوهمية
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
        title: Text(_screens[_selectedIndex]['title'] as String),
      ),
      body: _screens[_selectedIndex]['screen'] as Widget,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).primaryColor,
        height: 60,
        items: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.dashboard, color: Colors.white, size: 30),
              if (_selectedIndex != 0) // إظهار النص فقط إذا لم يكن العنصر نشطًا
                Text(
                  "الرئيسية",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white, size: 30),
              if (_selectedIndex != 1) // إظهار النص فقط إذا لم يكن العنصر نشطًا
                Text(
                  "المفضلة",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
            ],
          ),
        ],
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
      ),
    );
  }
}
