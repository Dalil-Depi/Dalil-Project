import 'package:flutter/material.dart';

void main() {
  runApp(MetroApp());
}

class MetroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق المترو',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Cairo', brightness: Brightness.light),
      home: MetroLineScreen(),
      builder:
          (context, child) =>
              Directionality(textDirection: TextDirection.rtl, child: child!),
    );
  }
}

class MetroLineScreen extends StatelessWidget {
  final List<String> stations = [
    "عدلي منصور",
    "الهايكستب",
    "عزبة النخل",
    "عين شمس",
    "حمامات القبة",
    "سراي القبة",
    "حدائق الزيتون",
    "المطرية",
    "منشية الصدر",
    "العباسية",
    "الاستاد",
    "الزيتون",
    "الزهراء",
    "المعادي",
    "حلوان",
    "المنية",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_forward_ios),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('عدلي منصور'),
            SizedBox(width: 8),
            Text('الى'),
            SizedBox(width: 8),
            Text('المنية'),
          ],
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Text(
              "الخط الثالث - اتجاه محور روض الفرج",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(stations[index], style: TextStyle(fontSize: 16)),
                  trailing: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.green,
                    size: 16,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.train),
            label: 'احجز تذكرتك',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: 'خطوط المترو',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: 'تذاكري',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'المزيد',
          ),
        ],
      ),
    );
  }
}
