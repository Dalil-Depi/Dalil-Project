import 'package:flutter/material.dart';
import 'package:metro/core/app_colors.dart';

import '../screens/ticket_screen.dart';
import '../widgets/base_layout.dart';
import '../widgets/more_item_tile.dart';

class MoreScreen extends StatelessWidget {
  final String userName = "علي محمد علي";
  final String userEmail = "alielbana1@gmail.com";

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(
        'المزيد',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Montserrat-Arabic-Regular',
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );

    return BaseLayout(
      currentIndex: 3,
      appBar: appBar,
      backgroundColor: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TicketScreen()),
                  );
                },
                child: Transform.rotate(
                  angle: 3.14159,
                  child: Image.asset('images/arrow.png', width: 30, height: 30),
                ),
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Arabic-Regular',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Arabic-Regular',
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MoreItemTile(
                      title: "تعديل الحساب",
                      icon: Icons.settings,
                      onTap: () {},
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    MoreItemTile(
                      title: "طرق الدفع",
                      icon: Icons.payment,
                      onTap: () {},
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    MoreItemTile(
                      title: "تغيير اللغة",
                      icon: Icons.language,
                      fontFamily: 'Montserrat-Arabic-Regular',
                      onTap: () {},
                    ),
                    MoreItemTile(
                      title: "الأسئلة الشائعة",
                      icon: Icons.help_outline,
                      onTap: () {},
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    MoreItemTile(
                      title: "الشكاوى والاقتراحات",
                      icon: Icons.feedback_outlined,
                      onTap: () {},
                      fontFamily: 'Montserrat-Arabic-Regular',
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Montserrat-Arabic-Regular',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: const Text("تسجيل الخروج"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(
                                32,
                                47,
                                75,
                                1.0,
                              ),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: 'Montserrat-Arabic-Regular',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: const Text("تسجيل جديد"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
