import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const BaseLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    this.appBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: child,
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: const Color(0xFF202F4B),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat-Arabic-Regular',
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat-Arabic-Regular',
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'احجز تذكرتك',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alt_route),
              label: 'خطوط المترو',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'تذكرتي',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'المزيد'),
          ],
          onTap: (index) {
            if (index == currentIndex) return;

            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/lines');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/myTickets');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/more');
                break;
            }
          },
        ),
      ),
    );
  }
}
