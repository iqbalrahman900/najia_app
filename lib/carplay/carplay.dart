import 'package:flutter_carplay/flutter_carplay.dart';

class CarPlayManager {
  final FlutterCarplay _flutterCarplay = FlutterCarplay();

  void initializeCarplayTemplates() {
    final List<CPListSection> section1Items = generateQuranPlayerItems();
    final List<CPListSection> section2Items = generatePrayerTimesItems();

    FlutterCarplay.setRootTemplate(
      rootTemplate: CPTabBarTemplate(
        templates: [
          createCPListTemplate(section1Items, "Quran", "music.note"),
          createCPListTemplate(section2Items, "Prayers", "moon.fill"),
        ],
      ),
      animated: true,
    );
  }

  void setupCarplayConnectionListener(
      Function(CPConnectionStatusTypes) callback) {
    _flutterCarplay.addListenerOnConnectionChange(callback);
  }

  void removeListenerOnConnectionChange() {
    _flutterCarplay.removeListenerOnConnectionChange();
  }

  List<CPListSection> generateQuranPlayerItems() {
    final List<CPListItem> quranPlayerItems = [
      createCPListItem(
        "Surah Al-Fatihah",
        "Syeikh Misyari Alafasy + Malay Translation",
        'assets/images/najia.png',
      ),
      createCPListItem(
        "Surah Al-Baqarah",
        "Syeikh Misyari Alafasy + Malay Translation",
        'assets/images/najia.png',
      ),
      createCPListItem(
        "Surah Ali-Imran",
        "Syeikh Misyari Alafasy + Malay Translation",
        'assets/images/najia.png',
      ),
      createCPListItem(
        "Surah An-Nisa",
        "Syeikh Misyari Alafasy + Malay Translation",
        'assets/images/najia.png',
      ),
      createCPListItem(
        "Surah Al-Maidah",
        "Syeikh Misyari Alafasy + Malay Translation",
        'assets/images/najia.png',
      ),
    ];

    return [CPListSection(items: quranPlayerItems, header: "Quran Player")];
  }

  List<CPListSection> generatePrayerTimesItems() {
    final List<CPListItem> prayerTimesItems = [
      createCPListItem("Imsak", "in N/A hours N/A minutes N/A seconds",
          'assets/images/najia.png'),
      createCPListItem("Subuh", "in N/A hours N/A minutes N/A seconds",
          'assets/images/najia.png'),
      createCPListItem("Zohor", "in N/A hours N/A minutes N/A seconds",
          'assets/images/najia.png'),
      createCPListItem("Asar", "in N/A hours N/A minutes N/A seconds",
          'assets/images/najia.png'),
      createCPListItem("Maghrib", "in N/A hours N/A minutes N/A seconds",
          'assets/images/najia.png'),
      createCPListItem("Isha", "in N/A hours N/A minutes N/A seconds",
          'assets/images/najia.png'),
    ];

    return [CPListSection(items: prayerTimesItems, header: "Prayer Times")];
  }

  CPListItem createCPListItem(String text, String detailText, String image) {
    return CPListItem(
      text: text,
      detailText: detailText,
      image: image,
    );
  }

  CPListTemplate createCPListTemplate(
      List<CPListSection> sections, String title, String systemIcon) {
    return CPListTemplate(
      sections: sections,
      title: title,
      showsTabBadge: false,
      systemIcon: systemIcon,
    );
  }
}
