import 'package:flutter/material.dart';
import '../core/app_colors.dart';  

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColors.bottomNavBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon:  Icons.menu,
            label: 'المزيد',
            onTap: () {
              // Navigate to More Screen
            }
          ),
          _buildNavItem(
            icon: Icons.confirmation_number_outlined,
            label: 'تذكرتي', 
            onTap: () {
              // Navigate to My Tickets Screen
            }
          ),
          _buildNavItem(
            icon: Icons.train_outlined,
            label: 'خطوط المترو',
            onTap: () {
              // Navigate to Metro Lines Screen
            }
          ),
          _buildNavItem(
            icon: Icons.home,
            label: 'احجز تذكرتك',
            onTap: () {
              // Navigate to Home Screen
            }
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon, 
    required String label, 
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 4),
          Text(
            label, 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 12
            )
          )
        ],
      ),
    );
  }
}