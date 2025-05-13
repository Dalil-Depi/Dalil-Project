import 'package:flutter/material.dart';

class MoreItemTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String fontFamily;

  const MoreItemTile({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.fontFamily,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      trailing: Icon(icon, color: Colors.black),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyle(
            // تم إزالة 'const' هنا
            fontFamily: fontFamily, // الآن يمكن استخدام 'fontFamily' من المتغير
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
