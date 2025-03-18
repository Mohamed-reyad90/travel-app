import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const screenRoute = '/notifications';

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الإشعارات'), centerTitle: true),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          _buildNotificationItem(
            '🔥 عرض خاص!',
            'احجز الآن واحصل على خصم 20% على رحلتك القادمة!',
          ),
          _buildNotificationItem(
            '🚌 رحلة قادمة',
            'لا تنسَ رحلتك إلى وادي رم يوم الجمعة القادم!',
          ),
          _buildNotificationItem(
            '🌍 اكتشف وجهات جديدة',
            'استكشف أماكن سياحية مذهلة مضافة حديثًا!',
          ),
          _buildNotificationItem(
            '⏰ تذكير الدفع',
            'يرجى تأكيد حجزك قبل انتهاء المهلة المحددة!',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.purple),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
