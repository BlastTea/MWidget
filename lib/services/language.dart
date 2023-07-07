part of 'services.dart';

class Language {
  static ValueNotifier<LanguageType> languageTypeListenable = ValueNotifier(LanguageType.english)..addListener(() => languageListenable.value = _setValue());

  static ValueNotifier<Map<String, String>> languageListenable = ValueNotifier(_setValue());

  static Map<String, String> _setValue() => _data.map((key, value) => MapEntry(key, value[languageTypeListenable.value]!));

  static LanguageType get language => languageTypeListenable.value;

  static set language(LanguageType value) => languageTypeListenable.value = value;

  static String? getValue(String key) => _setValue()[key];

  static void addData(Map<String, Map<LanguageType, String>> data) => _data.addAll(data);

  static final Map<String, Map<LanguageType, String>> _data = {
    'January': {
      LanguageType.english: 'January',
      LanguageType.indonesian: 'Januari',
    },
    'February': {
      LanguageType.english: 'February',
      LanguageType.indonesian: 'Februari',
    },
    'March': {
      LanguageType.english: 'March',
      LanguageType.indonesian: 'Maret',
    },
    'April': {
      LanguageType.english: 'April',
      LanguageType.indonesian: 'April',
    },
    'May': {
      LanguageType.english: 'May',
      LanguageType.indonesian: 'Mei',
    },
    'June': {
      LanguageType.english: 'June',
      LanguageType.indonesian: 'Juni',
    },
    'July': {
      LanguageType.english: 'July',
      LanguageType.indonesian: 'Juli',
    },
    'August': {
      LanguageType.english: 'August',
      LanguageType.indonesian: 'Agustus',
    },
    'September': {
      LanguageType.english: 'September',
      LanguageType.indonesian: 'September',
    },
    'October': {
      LanguageType.english: 'October',
      LanguageType.indonesian: 'Oktober',
    },
    'November': {
      LanguageType.english: 'November',
      LanguageType.indonesian: 'November',
    },
    'December': {
      LanguageType.english: 'December',
      LanguageType.indonesian: 'Desember',
    },
    'Sunday': {
      LanguageType.english: 'Sunday',
      LanguageType.indonesian: 'Minggu',
    },
    'Monday': {
      LanguageType.english: 'Monday',
      LanguageType.indonesian: 'Senin',
    },
    'Tuesday': {
      LanguageType.english: 'Tuesday',
      LanguageType.indonesian: 'Selasa',
    },
    'Wednesday': {
      LanguageType.english: 'Wednesday',
      LanguageType.indonesian: 'Rabu',
    },
    'Thursday': {
      LanguageType.english: 'Thursday',
      LanguageType.indonesian: 'Kamis',
    },
    'Friday': {
      LanguageType.english: 'Friday',
      LanguageType.indonesian: 'Jum\'at',
    },
    'Saturday': {
      LanguageType.english: 'Saturday',
      LanguageType.indonesian: 'Sabtu',
    },
    'Ok': {
      LanguageType.english: 'Ok',
      LanguageType.indonesian: 'Ok',
    },
    'Cancel': {
      LanguageType.english: 'Cancel',
      LanguageType.indonesian: 'Batal',
    },
    'Restaurant': {
      LanguageType.english: 'Restaurant',
      LanguageType.indonesian: 'Restoran',
    },
    'Cafe and Coffee': {
      LanguageType.english: 'Cafe and Coffee',
      LanguageType.indonesian: 'Kafe dan Kopi',
    },
    'Clothing Store': {
      LanguageType.english: 'Clothing Store',
      LanguageType.indonesian: 'Toko Pakaian',
    },
    'Book Store': {
      LanguageType.english: 'Book Store',
      LanguageType.indonesian: 'Toko Buku',
    },
    'Electronics Store': {
      LanguageType.english: 'Electronics Store',
      LanguageType.indonesian: 'Toko Elektronik',
    },
    'Sports Equipment Store': {
      LanguageType.english: 'Sports Equipment Store',
      LanguageType.indonesian: 'Toko Perlengkapan Olahraga',
    },
    'Toy Store': {
      LanguageType.english: 'Toy Store',
      LanguageType.indonesian: 'Toko Mainan',
    },
    'Jewelry Store': {
      LanguageType.english: 'Jewelry Store',
      LanguageType.indonesian: 'Toko Perhiasan',
    },
    'Flower Shop': {
      LanguageType.english: 'Flower Shop',
      LanguageType.indonesian: 'Toko Bunga',
    },
    'Kitchen Equipment Store': {
      LanguageType.english: 'Kitchen Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Dapur',
    },
    'Electrical Equipment Store': {
      LanguageType.english: 'Electrical Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Listrik',
    },
    'Garden Equipment Store': {
      LanguageType.english: 'Garden Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Taman',
    },
    'Music Equipment Store': {
      LanguageType.english: 'Music Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Musik',
    },
    'Computer Equipment Store': {
      LanguageType.english: 'Computer Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Komputer',
    },
    'Security Equipment Store': {
      LanguageType.english: 'Security Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Keamanan',
    },
    'Photography Equipment Store': {
      LanguageType.english: 'Photography Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Fotografi',
    },
    'Household Equipment Store': {
      LanguageType.english: 'Household Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Rumah Tangga',
    },
    'Outdoor Equipment Store': {
      LanguageType.english: 'Outdoor Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Outdoor',
    },
    'Office Equipment Store': {
      LanguageType.english: 'Office Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Kantor',
    },
    'Electronic Equipment Store': {
      LanguageType.english: 'Electronic Equipment Store',
      LanguageType.indonesian: 'Toko Peralatan Elektronik',
    },
    'Food Court': {
      LanguageType.english: 'Food Court',
      LanguageType.indonesian: 'Food Court',
    },
    'Bakery': {
      LanguageType.english: 'Bakery',
      LanguageType.indonesian: 'Toko Roti',
    },
    'Car Workshop': {
      LanguageType.english: 'Car Workshop',
      LanguageType.indonesian: 'Bengkel Mobil',
    },
    'Bike Workshop': {
      LanguageType.english: 'Bike Workshop',
      LanguageType.indonesian: 'Bengkel Sepeda',
    },
    'Motorcycle Workshop': {
      LanguageType.english: 'Motorcycle Workshop',
      LanguageType.indonesian: 'Bengkel Motor',
    },
    'Furniture Gallery': {
      LanguageType.english: 'Furniture Gallery',
      LanguageType.indonesian: 'Galeri Furniture',
    },
    'Beauty Salon': {
      LanguageType.english: 'Beauty Salon',
      LanguageType.indonesian: 'Salon Kecantikan',
    },
    'Storage Warehouse': {
      LanguageType.english: 'Storage Warehouse',
      LanguageType.indonesian: 'Gudang Penyimpanan',
    },
    'Book Publisher': {
      LanguageType.english: 'Book Publisher',
      LanguageType.indonesian: 'Penerbit Buku',
    },
    'Photography Service': {
      LanguageType.english: 'Photography Service',
      LanguageType.indonesian: 'Layanan Fotografi',
    },
    'Graphic Design Service': {
      LanguageType.english: 'Graphic Design Service',
      LanguageType.indonesian: 'Layanan Desain Grafis',
    },
    'Landscaping Service': {
      LanguageType.english: 'Landscaping Service',
      LanguageType.indonesian: 'Layanan Taman',
    },
    'Security Service': {
      LanguageType.english: 'Security Service',
      LanguageType.indonesian: 'Layanan Keamanan',
    },
    'Massage Service': {
      LanguageType.english: 'Massage Service',
      LanguageType.indonesian: 'Layanan Pijat',
    },
    'Content Writing Service': {
      LanguageType.english: 'Content Writing Service',
      LanguageType.indonesian: 'Layanan Penulisan Konten',
    },
    'Translation Service': {
      LanguageType.english: 'Translation Service',
      LanguageType.indonesian: 'Layanan Penerjemahan',
    },
    'Music Studio': {
      LanguageType.english: 'Music Studio',
      LanguageType.indonesian: 'Studio Musik',
    },
    'Art Studio': {
      LanguageType.english: 'Art Studio',
      LanguageType.indonesian: 'Studio Seni',
    },
    'Laundry and Dry Cleaning': {
      LanguageType.english: 'Laundry and Dry Cleaning',
      LanguageType.indonesian: 'Laundry dan Dry Cleaning',
    },
    'Digital Marketing Service': {
      LanguageType.english: 'Digital Marketing Service',
      LanguageType.indonesian: 'Layanan Pemasaran Digital',
    },
    'Teaching Service': {
      LanguageType.english: 'Teaching Service',
      LanguageType.indonesian: 'Layanan Pengajaran',
    },
    'Event Management Service': {
      LanguageType.english: 'Event Management Service',
      LanguageType.indonesian: 'Layanan Manajemen Acara',
    },
    'Mobile App Development Service': {
      LanguageType.english: 'Mobile App Development Service',
      LanguageType.indonesian: 'Layanan Pengembangan Aplikasi Mobile',
    },
    'Interior Design Service': {
      LanguageType.english: 'Interior Design Service',
      LanguageType.indonesian: 'Layanan Desain Interior',
    },
    'Clinic': {
      LanguageType.english: 'Clinic',
      LanguageType.indonesian: 'Klinik',
    },
    'Online Fitness Service': {
      LanguageType.english: 'Online Fitness Service',
      LanguageType.indonesian: 'Layanan Kebugaran Online',
    },
    'Pet Shop': {
      LanguageType.english: 'Pet Shop',
      LanguageType.indonesian: 'Toko Hewan Peliharaan',
    },
    'Catering Service': {
      LanguageType.english: 'Catering Service',
      LanguageType.indonesian: 'Layanan Katering',
    },
    'Business Consulting Service': {
      LanguageType.english: 'Business Consulting Service',
      LanguageType.indonesian: 'Layanan Konsultasi Bisnis',
    },
    'Gallery': {
      LanguageType.english: 'Gallery',
      LanguageType.indonesian: 'Galeri',
    },
    'Camera': {
      LanguageType.english: 'Camera',
      LanguageType.indonesian: 'Kamera',
    },
    'Delete': {
      LanguageType.english: 'Delete',
      LanguageType.indonesian: 'Hapus',
    },
  };
}
