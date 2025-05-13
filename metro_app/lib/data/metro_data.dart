class MetroData {
  static final Map<String, List<String>> metroLines = {
    'Line1': [
      'المرج الجديدة',
      'المرج',
      'عزبة النخل',
      'عين شمس',
      'المطرية',
      'حدائق الزيتون',
      'حمامات القبة',
      'سراي القبة',
      'حدائق القبة',
      'الزيتون',
      'غمرة',
      'الشهداء',
      'أحمد عرابي',
      'جمال عبد الناصر',
      'أنور السادات',
      'سعد زغلول',
      'السيدة زينب',
      'الملك الصالح',
      'مار جرجس',
      'الزهراء',
      'دار السلام',
      'حدائق المعادي',
      'المعادي',
      'ثكنات المعادي',
      'طرة البلد',
      'كوتسيكا',
      'طرة الأسمنت',
      'المعصرة',
      'حدائق حلوان',
      'وادي حوف',
      'جامعة حلوان',
      'عين حلوان',
      'حلوان',
    ],
    'Line2': [
      'شبرا الخيمة',
      'كلية الزراعة',
      'المظلات',
      'الخلفاوي',
      'سانت تريزا',
      'روض الفرج',
      'مسرة',
      'الشهداء',
      'العتبة',
      'محمد نجيب',
      'أنور السادات',
      'الأوبرا',
      'الدقي',
      'البحوث',
      'جامعة القاهرة',
      'فيصل',
      'الجيزة',
      'ضواحي الجيزة',
      'ساقية مكي',
      'المنيب',
    ],
    'Line3': [
      'عدلي منصور',
      'الهايكستب',
      'عمر بن الخطاب',
      'قباء',
      'هشام بركات',
      'النزهة',
      'نادي الشمس',
      'ألف مسكن',
      'هليوبوليس',
      'هارون',
      'الأهرام',
      'كلية البنات',
      'الاستاد',
      'أرض المعارض',
      'العباسية',
      'عبده باشا',
      'الجيش',
      'باب الشعرية',
      'العتبة',
      'جمال عبد الناصر',
      'ماسبيرو',
      'صفاء حجازي',
      'الكيت كات',
      'السودان',
      'إمبابة',
      'البوهي',
      'القومية العربية',
      'الطريق الدائري',
      'محور روض الفرج',
      'التوفيقية',
      'وادي النيل',
      'جامعة الدول العربية',
      'بولاق الدكرور',
      'جامعة القاهرة',
    ],
  };

  static List<String> getAllStations() {
    return metroLines.values.expand((list) => list).toSet().toList();
  }

  static String? getLineForStation(String station) {
    for (var entry in metroLines.entries) {
      if (entry.value.contains(station)) {
        return entry.key;
      }
    }
    return null;
  }

  static String? getCommonStation(String line1, String line2) {
    final s1 = metroLines[line1]!;
    final s2 = metroLines[line2]!;
    for (var s in s1) {
      if (s2.contains(s)) return s;
    }
    return null;
  }

  static List<String> getPath(
    String from,
    String to,
    List<String> lineStations,
  ) {
    final i1 = lineStations.indexOf(from);
    final i2 = lineStations.indexOf(to);
    final start = i1 < i2 ? i1 : i2;
    final end = i1 < i2 ? i2 : i1;
    return lineStations.sublist(start, end + 1);
  }
}
