import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:traveling_app/widgets/app_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const screenRoute = '/filter-screen';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FilterScreen(this.saveFilters, this.currentFilters, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _summer = false;
  var _winter = false;
  var _families = false;

  @override
  void initState() {
    _summer = widget.currentFilters['summer'] ?? false;
    _winter = widget.currentFilters['winter'] ?? false;
    _families = widget.currentFilters['family'] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الفلترة'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'summer': _summer,
                'winter': _winter,
                'family': _families,
              };
              widget.saveFilters(selectedFilters);
              // توجيه المستخدم إلى الصفحة الرئيسية
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          _buildSwitchTile(
            'الرحلات الصيفية',
            'إظهار الرحلات في فصل الصيف فقط',
            _summer,
            (newValue) {
              setState(() {
                _summer = newValue;
              });
            },
          ),
          _buildSwitchTile(
            'الرحلات الشتوية',
            'إظهار الرحلات في فصل الشتاء فقط',
            _winter,
            (newValue) {
              setState(() {
                _winter = newValue;
              });
            },
          ),
          _buildSwitchTile(
            'مناسبة للعائلات',
            'إظهار الرحلات المناسبة للعائلات فقط',
            _families,
            (newValue) {
              setState(() {
                _families = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(subtitle, style: TextStyle(color: Colors.grey)),
            ],
          ),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
