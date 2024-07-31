const List surah = [
  {
    "id": 1,
    "name": "Al Fatiha",
    "totalVerse": 7,
    "english": "The Opening",
    "turkish": "Fâtiha",
    "place": "Makkah",
    "arabic": "الفاتحة"
  },
  {
    "id": 2,
    "name": "Al Baqarah",
    "totalVerse": 286,
    "english": "The Cow",
    "turkish": "Bakara",
    "place": "Madinah",
    "arabic": "البقرة"
  },
  {
    "id": 3,
    "name": "Ali Imran",
    "totalVerse": 200,
    "english": "The Family of Imran",
    "turkish": "Âl-i İmrân",
    "place": "Madinah",
    "arabic": "آل عمران"
  },
  {
    "id": 4,
    "name": "An Nisa",
    "totalVerse": 176,
    "english": "The Women",
    "turkish": "Nisâ",
    "place": "Madinah",
    "arabic": "النساء"
  },
  {
    "id": 5,
    "name": "Al Ma'idah",
    "totalVerse": 120,
    "english": "The Table",
    "turkish": "Mâide",
    "place": "Madinah",
    "arabic": "المائدة"
  },
  {
    "id": 6,
    "name": "Al An'am",
    "totalVerse": 165,
    "english": "The Cattle",
    "turkish": "En'âm",
    "place": "Makkah",
    "arabic": "الأنعام"
  },
  {
    "id": 7,
    "name": "Al A'raf",
    "totalVerse": 206,
    "english": "The Heights",
    "turkish": "A'râf",
    "place": "Makkah",
    "arabic": "الأعراف"
  },
  {
    "id": 8,
    "name": "Al Anfal",
    "totalVerse": 75,
    "english": "The Spoils of War",
    "turkish": "Enfâl",
    "place": "Madinah",
    "arabic": "الأنفال"
  },
  {
    "id": 9,
    "name": "At Taubah",
    "totalVerse": 129,
    "english": "The Repentance",
    "turkish": "Tevbe",
    "place": "Madinah",
    "arabic": "التوبة"
  },
  {
    "id": 10,
    "name": "Yunus",
    "totalVerse": 109,
    "english": "Jonah",
    "turkish": "Yûnus",
    "place": "Makkah",
    "arabic": "يونس"
  },
  {
    "id": 11,
    "name": "Hud",
    "totalVerse": 123,
    "english": "Hud",
    "turkish": "Hûd",
    "place": "Makkah",
    "arabic": "هود"
  },
  {
    "id": 12,
    "name": "Yusuf",
    "totalVerse": 111,
    "english": "Joseph",
    "turkish": "Yûsuf",
    "place": "Makkah",
    "arabic": "يوسف"
  },
  {
    "id": 13,
    "name": "Ar Ra'd",
    "totalVerse": 43,
    "english": "The Thunder",
    "turkish": "Ra'd",
    "place": "Madinah",
    "arabic": "الرعد"
  },
  {
    "id": 14,
    "name": "Ibrahim",
    "totalVerse": 52,
    "english": "Abraham",
    "turkish": "İbrâhîm",
    "place": "Makkah",
    "arabic": "ابراهيم"
  },
  {
    "id": 15,
    "name": "Al Hijr",
    "totalVerse": 99,
    "english": "The Stoneland",
    "turkish": "Hicr",
    "place": "Makkah",
    "arabic": "الحجر"
  },
  {
    "id": 16,
    "name": "An Nahl",
    "totalVerse": 128,
    "english": "The Honey Bee",
    "turkish": "Nahl",
    "place": "Makkah",
    "arabic": "النحل"
  },
  {
    "id": 17,
    "name": "Al Isra'",
    "totalVerse": 111,
    "english": "The Night Journey",
    "turkish": "İsrâ",
    "place": "Makkah",
    "arabic": "الإسراء"
  },
  {
    "id": 18,
    "name": "Al Kahf",
    "totalVerse": 110,
    "english": "The Cave",
    "turkish": "Kehf",
    "place": "Makkah",
    "arabic": "الكهف"
  },
  {
    "id": 19,
    "name": "Maryam",
    "totalVerse": 98,
    "english": "Mary",
    "turkish": "Meryem",
    "place": "Makkah",
    "arabic": "مريم"
  },
  {
    "id": 20,
    "name": "Ta Ha",
    "totalVerse": 135,
    "english": "Ta Ha",
    "turkish": "Tâhâ",
    "place": "Makkah",
    "arabic": "طه"
  },
  {
    "id": 21,
    "name": "Al Anbiya",
    "totalVerse": 112,
    "english": "The Prophets",
    "turkish": "Enbiyâ",
    "place": "Makkah",
    "arabic": "الأنبياء"
  },
  {
    "id": 22,
    "name": "Al Hajj",
    "totalVerse": 78,
    "english": "The Pilgrimage",
    "turkish": "Hac",
    "place": "Madinah",
    "arabic": "الحج"
  },
  {
    "id": 23,
    "name": "Al Mu minun",
    "totalVerse": 118,
    "english": "The Believers",
    "turkish": "Mü'minûn",
    "place": "Makkah",
    "arabic": "المؤمنون"
  },
  {
    "id": 24,
    "name": "An Nur",
    "totalVerse": 64,
    "english": "The Light",
    "turkish": "Nûr",
    "place": "Madinah",
    "arabic": "النور"
  },
  {
    "id": 25,
    "name": "Al Furqan",
    "totalVerse": 77,
    "english": "The Criterion",
    "turkish": "Furkân",
    "place": "Makkah",
    "arabic": "الفرقان"
  },
  {
    "id": 26,
    "name": "As Su'ara",
    "totalVerse": 227,
    "english": "The Poets",
    "turkish": "Şuarâ",
    "place": "Makkah",
    "arabic": "الشعراء"
  },
  {
    "id": 27,
    "name": "An Naml",
    "totalVerse": 93,
    "english": "The Ant",
    "turkish": "Neml",
    "place": "Makkah",
    "arabic": "النمل"
  },
  {
    "id": 28,
    "name": "Al Qasas",
    "totalVerse": 88,
    "english": "The Narrations",
    "turkish": "Kasas",
    "place": "Makkah",
    "arabic": "القصص"
  },
  {
    "id": 29,
    "name": "Al Ankabut",
    "totalVerse": 69,
    "english": "The Spider",
    "turkish": "Ankebût",
    "place": "Makkah",
    "arabic": "العنكبوت"
  },
  {
    "id": 30,
    "name": "Ar Rum",
    "totalVerse": 60,
    "english": "Rome",
    "turkish": "Rûm",
    "place": "Makkah",
    "arabic": "الروم"
  },
  {
    "id": 31,
    "name": "Luqman",
    "totalVerse": 34,
    "english": "Luqman",
    "turkish": "Lokmân",
    "place": "Makkah",
    "arabic": "لقمان"
  },
  {
    "id": 32,
    "name": "As Sajdah",
    "totalVerse": 30,
    "english": "The Prostration",
    "turkish": "Secde",
    "place": "Makkah",
    "arabic": "السجدة"
  },
  {
    "id": 33,
    "name": "Al Ahzab",
    "totalVerse": 73,
    "english": "The Clans",
    "turkish": "Ahzâb",
    "place": "Madinah",
    "arabic": "الأحزاب"
  },
  {
    "id": 34,
    "name": "Saba'",
    "totalVerse": 54,
    "english": "Sheba",
    "turkish": "Sebe'",
    "place": "Makkah",
    "arabic": "سبإ"
  },
  {
    "id": 35,
    "name": "Fatir",
    "totalVerse": 45,
    "english": "The Originator",
    "turkish": "Fâtır",
    "place": "Makkah",
    "arabic": "فاطر"
  },
  {
    "id": 36,
    "name": "Ya'sin",
    "totalVerse": 83,
    "english": "Ya Sin",
    "turkish": "Yâsîn",
    "place": "Makkah",
    "arabic": "يس"
  },
  {
    "id": 37,
    "name": "As Saffat",
    "totalVerse": 182,
    "english": "Those Who Set The Ranks",
    "turkish": "Sâffât",
    "place": "Makkah",
    "arabic": "الصافات"
  },
  {
    "id": 38,
    "name": "Saad",
    "totalVerse": 88,
    "english": "Ṣād",
    "turkish": "Sâd",
    "place": "Makkah",
    "arabic": "ص"
  },
  {
    "id": 39,
    "name": "Az Zumar",
    "totalVerse": 75,
    "english": "The Crowds",
    "turkish": "Zümer",
    "place": "Makkah",
    "arabic": "الزمر"
  },
  {
    "id": 40,
    "name": "Ghafir",
    "totalVerse": 85,
    "english": "The Forgiver",
    "turkish": "Mü'min",
    "place": "Makkah",
    "arabic": "غافر"
  },
  {
    "id": 41,
    "name": "Fussilat",
    "totalVerse": 54,
    "english": "Expounded",
    "turkish": "Fussilet",
    "place": "Makkah",
    "arabic": "فصلت"
  },
  {
    "id": 42,
    "name": "Asy Syuaraa",
    "totalVerse": 53,
    "english": "The Consultation",
    "turkish": "Şûrâ",
    "place": "Makkah",
    "arabic": "الشورى"
  },
  {
    "id": 43,
    "name": "Az Zukhruf",
    "totalVerse": 89,
    "english": "The Gold Adornments",
    "turkish": "Zuhruf",
    "place": "Makkah",
    "arabic": "الزخرف"
  },
  {
    "id": 44,
    "name": "Ad Dukhan",
    "totalVerse": 59,
    "english": "The Smoke",
    "turkish": "Duhân",
    "place": "Makkah",
    "arabic": "الدخان"
  },
  {
    "id": 45,
    "name": "Al Jaathiyah",
    "totalVerse": 37,
    "english": "The Kneeling Down",
    "turkish": "Câsiye",
    "place": "Makkah",
    "arabic": "الجاثية"
  },
  {
    "id": 46,
    "name": "Al Ahqaf",
    "totalVerse": 35,
    "english": "Winding Sand tracts",
    "turkish": "Ahkâf",
    "place": "Makkah",
    "arabic": "الأحقاف"
  },
  {
    "id": 47,
    "name": "Muhammad",
    "totalVerse": 38,
    "english": "Muhammad",
    "turkish": "Muhammed",
    "place": "Madinah",
    "arabic": "محمد"
  },
  {
    "id": 48,
    "name": "Al Fath",
    "totalVerse": 29,
    "english": "The Victory",
    "turkish": "Fetih",
    "place": "Madinah",
    "arabic": "الفتح"
  },
  {
    "id": 49,
    "name": "Al Hujurat",
    "totalVerse": 18,
    "english": "The Private Apartments",
    "turkish": "Hucurât",
    "place": "Madinah",
    "arabic": "الحجرات"
  },
  {
    "id": 50,
    "name": "Qaaf",
    "totalVerse": 45,
    "english": "Q̈āf",
    "turkish": "Kâf",
    "place": "Makkah",
    "arabic": "ق"
  },
  {
    "id": 51,
    "name": "Ad Dariyat",
    "totalVerse": 60,
    "english": "The Wind That Scatter",
    "turkish": "Zâriyât",
    "place": "Makkah",
    "arabic": "الذاريات"
  },
  {
    "id": 52,
    "name": "At Tur",
    "totalVerse": 49,
    "english": "The Mount",
    "turkish": "Tûr",
    "place": "Makkah",
    "arabic": "الطور"
  },
  {
    "id": 53,
    "name": "An Najm",
    "totalVerse": 62,
    "english": "The Star",
    "turkish": "Necm",
    "place": "Makkah",
    "arabic": "النجم"
  },
  {
    "id": 54,
    "name": "Al Qamar",
    "totalVerse": 55,
    "english": "The Moon",
    "turkish": "Kamer",
    "place": "Makkah",
    "arabic": "القمر"
  },
  {
    "id": 55,
    "name": "Ar Rahman",
    "totalVerse": 78,
    "english": "The Most Merciful",
    "turkish": "Rahmân",
    "place": "Madinah",
    "arabic": "الرحمن"
  },
  {
    "id": 56,
    "name": "Al Waqiah",
    "totalVerse": 96,
    "english": "The Inevitable",
    "turkish": "Vâkıa",
    "place": "Makkah",
    "arabic": "الواقعة"
  },
  {
    "id": 57,
    "name": "Al Hadeed",
    "totalVerse": 29,
    "english": "The Iron",
    "turkish": "Hadîd",
    "place": "Madinah",
    "arabic": "الحديد"
  },
  {
    "id": 58,
    "name": "Al Mujadila",
    "totalVerse": 22,
    "english": "The Pleading",
    "turkish": "Mücâdele",
    "place": "Madinah",
    "arabic": "المجادلة"
  },
  {
    "id": 59,
    "name": "Al Hashr",
    "totalVerse": 24,
    "english": "The Mustering",
    "turkish": "Haşr",
    "place": "Manidah",
    "arabic": "الحشر"
  },
  {
    "id": 60,
    "name": "Al Mumtahanah",
    "totalVerse": 13,
    "english": "The Examined One",
    "turkish": "Mümtehine",
    "place": "Madinah",
    "arabic": "الممتحنة"
  },
  {
    "id": 61,
    "name": "As Saff",
    "totalVerse": 14,
    "english": "The Ranks",
    "turkish": "Saff",
    "place": "Madinah",
    "arabic": "الصف"
  },
  {
    "id": 62,
    "name": "Al Jumu'ah",
    "totalVerse": 11,
    "english": "Congregation (Friday)",
    "turkish": "Cuma",
    "place": "Madinah",
    "arabic": "الجمعة"
  },
  {
    "id": 63,
    "name": "Al Munafiqoon",
    "totalVerse": 11,
    "english": "The Hypocrites",
    "turkish": "Münâfikûn",
    "place": "Madinah",
    "arabic": "المنافقون"
  },
  {
    "id": 64,
    "name": "At Taghabun",
    "totalVerse": 18,
    "english": "The Cheating",
    "turkish": "Tegâbün",
    "place": "Madinah",
    "arabic": "التغابن"
  },
  {
    "id": 65,
    "name": "At Talaq",
    "totalVerse": 12,
    "english": "Divorce",
    "turkish": "Talâk",
    "place": "Madinah",
    "arabic": "الطلاق"
  },
  {
    "id": 66,
    "name": "At Tahreem",
    "totalVerse": 12,
    "english": "The Prohibition",
    "turkish": "Tahrîm",
    "place": "Madinah",
    "arabic": "التحريم"
  },
  {
    "id": 67,
    "name": "Al Mulk",
    "totalVerse": 30,
    "english": "The Dominion",
    "turkish": "Mülk",
    "place": "Makkah",
    "arabic": "الملك"
  },
  {
    "id": 68,
    "name": "Al Qalam",
    "totalVerse": 52,
    "english": "The Pen",
    "turkish": "Kalem",
    "place": "Makkah",
    "arabic": "القلم"
  },
  {
    "id": 69,
    "name": "Al Haaqqah",
    "totalVerse": 52,
    "english": "The Sure Reality",
    "turkish": "Hâkka",
    "place": "Makkah",
    "arabic": "الحاقة"
  },
  {
    "id": 70,
    "name": "Al Ma'arij",
    "totalVerse": 44,
    "english": "The Ways of Ascent",
    "turkish": "Meâric",
    "place": "Makkah",
    "arabic": "المعارج"
  },
  {
    "id": 71,
    "name": "Nuh",
    "totalVerse": 28,
    "english": "Noah",
    "turkish": "Nûh",
    "place": "Makkah",
    "arabic": "نوح"
  },
  {
    "id": 72,
    "name": "Al Jinn",
    "totalVerse": 28,
    "english": "The Jinn",
    "turkish": "Cin",
    "place": "makkah",
    "arabic": "الجن"
  },
  {
    "id": 73,
    "name": "Al Muzammil",
    "totalVerse": 20,
    "english": "The Enfolded One",
    "turkish": "Müzzemmil",
    "place": "Makkah",
    "arabic": "المزمل"
  },
  {
    "id": 74,
    "name": "Al Muddathir",
    "totalVerse": 56,
    "english": "The One Wrapped Up",
    "turkish": "Müddessir",
    "place": "Makkah",
    "arabic": "المدثر"
  },
  {
    "id": 75,
    "name": "Al Qiyamah",
    "totalVerse": 40,
    "english": "Resurrection",
    "turkish": "Kıyâmet",
    "place": "Makkah",
    "arabic": "القيامة"
  },
  {
    "id": 76,
    "name": "Al Insan",
    "totalVerse": 31,
    "english": "The Human",
    "turkish": "İnsân",
    "place": "Madinah",
    "arabic": "الانسان"
  },
  {
    "id": 77,
    "name": "Al Mursalat",
    "totalVerse": 50,
    "english": "Those Sent Forth",
    "turkish": "Mürselât",
    "place": "Makkah",
    "arabic": "المرسلات"
  },
  {
    "id": 78,
    "name": "An Naba",
    "totalVerse": 40,
    "english": "The Great News",
    "turkish": "Nebe",
    "place": "Makkah",
    "arabic": "النبأ"
  },
  {
    "id": 79,
    "name": "An Naaziat",
    "totalVerse": 46,
    "english": "Those Who Tear Out",
    "turkish": "Naziât",
    "place": "Makkah",
    "arabic": "النازعات"
  },
  {
    "id": 80,
    "name": "Abasa",
    "totalVerse": 42,
    "english": "He Frowned",
    "turkish": "Abese",
    "place": "Makkah",
    "arabic": "عبس"
  },
  {
    "id": 81,
    "name": "At Takweer",
    "totalVerse": 29,
    "english": "The Folding Up",
    "turkish": "Tekvîr",
    "place": "Makkah",
    "arabic": "التكوير"
  },
  {
    "id": 82,
    "name": "Al Infitar",
    "totalVerse": 19,
    "english": "The Overthrowing",
    "turkish": "İnfitâr",
    "place": "Makkah",
    "arabic": "الإنفطار"
  },
  {
    "id": 83,
    "name": "Al Mutaffifin",
    "totalVerse": 36,
    "english": "The Cleaving Asunder",
    "turkish": "Mutaffifîn",
    "place": "Makkah",
    "arabic": "المطففين"
  },
  {
    "id": 84,
    "name": "Al Inshiqaaq",
    "totalVerse": 25,
    "english": "The Dealers in Fraud",
    "turkish": "İnşikâk",
    "place": "Makkah",
    "arabic": "الإنشقاق"
  },
  {
    "id": 85,
    "name": "Al Buruj",
    "totalVerse": 22,
    "english": "The Constellations",
    "turkish": "Burûc",
    "place": "Makkah",
    "arabic": "البروج"
  },
  {
    "id": 86,
    "name": "At Taariq",
    "totalVerse": 17,
    "english": "The Morning Star",
    "turkish": "Târık",
    "place": "Makkah",
    "arabic": "الطارق"
  },
  {
    "id": 87,
    "name": "Al A'laa",
    "totalVerse": 19,
    "english": "The Most High",
    "turkish": "A'lâ",
    "place": "Makkah",
    "arabic": "الأعلى"
  },
  {
    "id": 88,
    "name": "Al Ghaashiyah",
    "totalVerse": 26,
    "english": "The Overwhelming Event",
    "turkish": "Gâşiye",
    "place": "Makkah",
    "arabic": "الغاشية"
  },
  {
    "id": 89,
    "name": "Al Fajr",
    "totalVerse": 30,
    "english": "The Daybreak",
    "turkish": "Fecr",
    "place": "Makkah",
    "arabic": "الفجر"
  },
  {
    "id": 90,
    "name": "Al Balad",
    "totalVerse": 20,
    "english": "The City",
    "turkish": "Beled",
    "place": "Makkah",
    "arabic": "البلد"
  },
  {
    "id": 91,
    "name": "Ash Shams",
    "totalVerse": 15,
    "english": "The Sun",
    "turkish": "Şems",
    "place": "Makkah",
    "arabic": "الشمس"
  },
  {
    "id": 92,
    "name": "Al Layl",
    "totalVerse": 21,
    "english": "The Night",
    "turkish": "Leyl",
    "place": "Makkah",
    "arabic": "الليل"
  },
  {
    "id": 93,
    "name": "Ad Dhuha",
    "totalVerse": 11,
    "english": "The Glorious Morning Light",
    "turkish": "Duhâ",
    "place": "Makkah",
    "arabic": "الضحى"
  },
  {
    "id": 94,
    "name": "Ash Sharh",
    "totalVerse": 8,
    "english": "The Opening Up of the Heart",
    "turkish": "İnşirâh",
    "place": "Makkah",
    "arabic": "الشرح"
  },
  {
    "id": 95,
    "name": "At Tin",
    "totalVerse": 8,
    "english": "The Fig Tree",
    "turkish": "Tîn",
    "place": "Makkah",
    "arabic": "التين"
  },
  {
    "id": 96,
    "name": "Al Alaq",
    "totalVerse": 19,
    "english": "The Clinging Clot",
    "turkish": "Alak",
    "place": "Makkah",
    "arabic": "العلق"
  },
  {
    "id": 97,
    "name": "Al Qadr",
    "totalVerse": 5,
    "english": "The Night of Honor",
    "turkish": "Kadir",
    "place": "Makkah",
    "arabic": "القدر"
  },
  {
    "id": 98,
    "name": "Al Bayyinah",
    "totalVerse": 8,
    "english": "The Clear Evidence",
    "turkish": "Beyyine",
    "place": "Madinah",
    "arabic": "البينة"
  },
  {
    "id": 99,
    "name": "Al Zalzalah",
    "totalVerse": 8,
    "english": "The Earthquake",
    "turkish": "Zilzâl",
    "place": "Madinah",
    "arabic": "الزلزلة"
  },
  {
    "id": 100,
    "name": "Al 'Adiyaat",
    "totalVerse": 11,
    "english": "The Courser",
    "turkish": "Âdiyât",
    "place": "Makkah",
    "arabic": "العاديات"
  },
  {
    "id": 101,
    "name": "Al Qaari'ah",
    "totalVerse": 11,
    "english": "The Striking Hour",
    "turkish": "Kâria",
    "place": "Makkah",
    "arabic": "القارعة"
  },
  {
    "id": 102,
    "name": "At Takaathur",
    "totalVerse": 8,
    "english": "The Piling Up",
    "turkish": "Tekâsür",
    "place": "Makkah",
    "arabic": "التكاثر"
  },
  {
    "id": 103,
    "name": "Al Asr",
    "totalVerse": 3,
    "english": "The Time",
    "turkish": "Asr",
    "place": "Makkah",
    "arabic": "العصر"
  },
  {
    "id": 104,
    "name": "Al Humazah",
    "totalVerse": 9,
    "english": "The Scandalmonger",
    "turkish": "Hümeze",
    "place": "Makkah",
    "arabic": "الهمزة"
  },
  {
    "id": 105,
    "name": "Al Fil",
    "totalVerse": 5,
    "english": "The Elephant",
    "turkish": "Fîl",
    "place": "Makkah",
    "arabic": "الفيل"
  },
  {
    "id": 106,
    "name": "Quraysh",
    "totalVerse": 4,
    "english": "The Quraysh",
    "turkish": "Kureyş",
    "place": "Makkah",
    "arabic": "قريش"
  },
  {
    "id": 107,
    "name": "Al Maun",
    "totalVerse": 7,
    "english": "The Neighbourly Assistance",
    "turkish": "Maûn",
    "place": "Makkah",
    "arabic": "الماعون"
  },
  {
    "id": 108,
    "name": "Al Kawthar",
    "totalVerse": 3,
    "english": "Abundance",
    "turkish": "Kevser",
    "place": "Makkah",
    "arabic": "الكوثر"
  },
  {
    "id": 109,
    "name": "Al Kafirun",
    "totalVerse": 6,
    "english": "The Disbelievers",
    "turkish": "Kâfirûn",
    "place": "Makkah",
    "arabic": "الكافرون"
  },
  {
    "id": 110,
    "name": "An Nasr",
    "totalVerse": 3,
    "english": "The Help",
    "turkish": "Nasr",
    "place": "Madinah",
    "arabic": "النصر"
  },
  {
    "id": 111,
    "name": "Al Masad",
    "totalVerse": 5,
    "english": "The Plaited Rope",
    "turkish": "Tebbet",
    "place": "Makkah",
    "arabic": "اللهب"
  },
  {
    "id": 112,
    "name": "Al Ikhlas",
    "totalVerse": 4,
    "english": "Purity of Faith",
    "turkish": "İhlâs",
    "place": "Makkah",
    "arabic": "الإخلاص"
  },
  {
    "id": 113,
    "name": "Al Falaq",
    "totalVerse": 5,
    "english": "The Rising Dawn",
    "turkish": "Felak",
    "place": "Makkah",
    "arabic": "الفلق"
  },
  {
    "id": 114,
    "name": "An Nas",
    "totalVerse": 6,
    "english": "Mankind",
    "turkish": "Nâs",
    "place": "Makkah",
    "arabic": "الناس"
  }
];
