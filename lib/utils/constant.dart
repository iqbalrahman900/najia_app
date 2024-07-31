import 'dart:ui';

class NajiaColors {
  static const black = Color(0xff151429);
  static const bgColor = Color(0xffFEF5ED);
  static const white = Color(0xffFFFFFF);
  static const red = Color(0xffE93941);
}

class MalaysiaData {
  final states = {
    'Johor': [
      {'code': 'JHR01', 'name': 'Pulau Aur dan Pulau Pemanggil'},
      {'code': 'JHR02', 'name': 'Johor Bharu, Kota Tinggi, Mersing'},
      {'code': 'JHR03', 'name': 'Kluang, Pontian'},
      {'code': 'JHR04', 'name': 'Batu Pahat, Muar, Segamat, Gemas Johor'},
    ],
    'Kedah': [
      {
        'code': 'KDH01',
        'name': 'Kota Setar, Kubang Pasu, Pokok Sena (Daerah Kecil)'
      },
      {'code': 'KDH02', 'name': 'Kuala Muda, Yan, Pendang'},
      {'code': 'KDH03', 'name': 'Padang Terap, Sik'},
      {'code': 'KDH04', 'name': 'Baling'},
      {'code': 'KDH05', 'name': 'Bandar Baharu, Kulim'},
      {'code': 'KDH06', 'name': 'Langkawi'},
      {'code': 'KDH07', 'name': 'Gunung Jerai'}
    ],
    'Kelantan': [
      {
        'code': 'KTN01',
        'name':
            'Bachok, Kota Bharu, Machang, Pasir Mas, Pasir Puteh, Tanah Merah, Tumpat, Kuala Krai, Mukim Chiku'
      },
      {'code': 'KTN03', 'name': 'Gua Musang (Daerah Galas Dan Bertam), Jeli'},
    ],
    'Melaka': [
      {'code': 'MLK01', 'name': 'SELURUH NEGERI MELAKA'},
    ],
    'Negeri Sembilan': [
      {'code': 'NGS01', 'name': 'Tampin, Jempol'},
      {
        'code': 'NGS02',
        'name': 'Jelebu, Kuala Pilah, Port Dickson, Rembau, Seremban'
      },
    ],
    'Pahang': [
      {'code': 'PHG01', 'name': 'Pulau Tioman'},
      {'code': 'PHG02', 'name': 'Kuantan, Pekan, Rompin, Muadzam Shah'},
      {
        'code': 'PHG03',
        'name': 'Jerantut, Temerloh, Maran, Bera, Chenor, Jengka'
      },
      {'code': 'PHG04', 'name': 'Bentong, Lipis, Raub'},
      {'code': 'PHG05', 'name': 'Genting Sempah, Janda Baik, Bukit Tinggi'},
      {
        'code': 'PHG06',
        'name': 'Cameron Highlands, Genting Highlands, Bukit Fraser'
      },
    ],
    'Perlis': [
      {'code': 'PLS01', 'name': 'Kangar, Padang Besar, Arau'},
    ],
    'Pulau Pinang': [
      {'code': 'PNG01', 'name': 'Seluruh Negeri Pulau Pinang'},
    ],
    'Perak': [
      {'code': 'PRK01', 'name': 'Tapah, Slim River, Tanjung Malim'},
      {
        'code': 'PRK02',
        'name':
            'Kuala Kangsar, Sg. Siput (Daerah Kecil), Ipoh, Batu Gajah, Kampar'
      },
      {'code': 'PRK03', 'name': 'Lenggong, Pengkalan Hulu, Grik'},
      {'code': 'PRK04', 'name': 'Temengor, Belum'},
      {
        'code': 'PRK05',
        'name':
            'Kg Gajah, Teluk Intan, Bagan Datuk, Seri Iskandar, Beruas, Parit, Lumut, Sitiawan, Pulau Pangkor'
      },
      {'code': 'PRK06', 'name': 'Selama, Taiping, Bagan Serai, Parit Buntar'},
      {'code': 'PRK07', 'name': 'Bukit Larut'},
    ],
    'Sabah': [
      {
        'code': 'SBH01',
        'name':
            'Bahagian Sandakan (Timur), Bukit Garam, Semawang, Temanggong, Tambisan, Bandar Sandakan'
      },
      {
        'code': 'SBH02',
        'name':
            'Beluran, Telupid, Pinangah, Terusan, Kuamut, Bahagian Sandakan (Barat)'
      },
      {
        'code': 'SBH03',
        'name':
            'Lahad Datu, Silabukan, Kunak, Sahabat, Semporna, Tungku, Bahagian Tawau (Timur)'
      },
      {
        'code': 'SBH04',
        'name':
            'Bandar Tawau, Balong, Merotai, Kalabakan, Bahagian Tawau (Barat)'
      },
      {
        'code': 'SBH05',
        'name': 'Kudat, Kota Marudu, Pitas, Pulau Banggi, Bahagian Kudat'
      },
      {'code': 'SBH06', 'name': 'Gunung Kinabalu'},
      {
        'code': 'SBH07',
        'name':
            'Kota Kinabalu, Ranau, Kota Belud, Tuaran, Penampang, Papar, Putatan, Bahagian Pantai Barat'
      },
      {
        'code': 'SBH08',
        'name':
            'Pensiangan, Keningau, Tambunan, Nabawan, Bahagian Pendalaman (Atas)'
      },
      {
        'code': 'SBH09',
        'name':
            'Beaufort, Kuala Penyu, Sipitang, Tenom, Long Pa Sia, Membakut, Weston, Bahagian Pendalaman (Bawah)'
      },
    ],
    'Selangor': [
      {
        'code': 'SGR01',
        'name':
            'Gombak, Petaling, Sepang, Hulu Langat, Hulu Selangor, Rawang, Shah Alam'
      },
      {'code': 'SGR02', 'name': 'Kuala Selangor, Sabak Bernam'},
      {'code': 'SGR03', 'name': 'Klang, Kuala Langat'},
    ],
    'Sarawak': [
      {'code': 'SWK01', 'name': 'Limbang, Lawas, Sundar, Trusan'},
      {'code': 'SWK02', 'name': 'Miri, Niah, Bekenu, Sibuti, Marudi'},
      {'code': 'SWK03', 'name': 'Pandan, Belaga, Suai, Tatau, Sebauh, Bintulu'},
      {
        'code': 'SWK04',
        'name': 'Sibu, Mukah, Dalat, Song, Igan, Oya, Balingian, Kanowit, Kapit'
      },
      {
        'code': 'SWK05',
        'name': 'Sarikei, Matu, Julau, Rajang, Daro, Bintangor, Belawai'
      },
      {
        'code': 'SWK06',
        'name':
            'Lubok Antu, Sri Aman, Roban, Debak, Kabong, Lingga, Engkelili, Betong, Spaoh, Pusa, Saratok'
      },
      {
        'code': 'SWK07',
        'name': 'Serian, Simunjan, Samarahan, Sebuyau, Meludam'
      },
      {'code': 'SWK08', 'name': 'Kuching, Bau, Lundu, Sematan'},
      {'code': 'SWK09', 'name': 'Zon Khas (Kampung Patarikan)'},
    ],
    'Terengganu': [
      {'code': 'TRG01', 'name': 'Kuala Terengganu, Marang, Kuala Nerus'},
      {'code': 'TRG02', 'name': 'Besut, Setiu'},
      {'code': 'TRG03', 'name': 'Hulu Terengganu'},
      {'code': 'TRG04', 'name': 'Dungun, Kemaman'},
    ],
    'Wilayah Persekutuan': [
      {'code': 'WLY01', 'name': 'Kuala Lumpur, Putrajaya'},
      {'code': 'WLY02', 'name': 'Labuan'},
    ],
  };
}
