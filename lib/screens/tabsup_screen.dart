// import 'package:flutter/material.dart';
// import 'package:traveling_app/screens/categories_screen.dart';
// import 'package:traveling_app/screens/favorite_trips_screen.dart';

// class TabsScreen extends StatelessWidget {
//   const TabsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('دليل سياحي'),
//           bottom: TabBar(
//             labelColor: Colors.white, // لون النصوص في التاب النشط
//             unselectedLabelColor:
//                 Colors.white70, // لون النصوص في التاب غير النشط
//             indicatorColor: Colors.white, // لون الخط السفلي للمؤشر
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.dashboard, color: Colors.white),
//                 text: 'التصنيفات',
//               ),
//               Tab(
//                 icon: Icon(Icons.star, color: Colors.white),
//                 text: 'الرحلات المفضلة',
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(children: [CategoriesScreen(), FavoriteTripsScreen()]),
//       ),
//     );
//   }
// }
