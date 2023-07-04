part of 'models.dart';

class Business {
  Business({
    this.id,
    required this.name,
    required this.address,
    this.description,
    this.owner,
    this.tax,
    this.isOpen = true,
    this.logo,
    this.types,
    this.sundayOpeningHour,
    this.sundayClosingHour,
    this.mondayOpeningHour,
    this.mondayClosingHour,
    this.tuesdayOpeningHour,
    this.tuesdayClosingHour,
    this.wednesdayOpeningHour,
    this.wednesdayClosingHour,
    this.thursdayOpeningHour,
    this.thursdayClosingHour,
    this.fridayOpeningHour,
    this.fridayClosingHour,
    this.saturdayOpeningHour,
    this.saturdayClosingHour,
    this.latitude,
    this.longitude,
  });

  String? id;
  String name;
  String address;
  String? description;
  UserAccount? owner;
  double? tax;
  bool isOpen;
  MImage? logo;
  Set<BusinessType>? types;
  TimeOfDay? sundayOpeningHour;
  TimeOfDay? sundayClosingHour;
  TimeOfDay? mondayOpeningHour;
  TimeOfDay? mondayClosingHour;
  TimeOfDay? tuesdayOpeningHour;
  TimeOfDay? tuesdayClosingHour;
  TimeOfDay? wednesdayOpeningHour;
  TimeOfDay? wednesdayClosingHour;
  TimeOfDay? thursdayOpeningHour;
  TimeOfDay? thursdayClosingHour;
  TimeOfDay? fridayOpeningHour;
  TimeOfDay? fridayClosingHour;
  TimeOfDay? saturdayOpeningHour;
  TimeOfDay? saturdayClosingHour;
  double? latitude;
  double? longitude;

  bool get isOpeningNow {
    final now = TimeOfDay.now();

    final today = DateTime.now().weekday;

    TimeOfDay? openingHour;
    TimeOfDay? closingHour;

    switch (today) {
      case DateTime.sunday:
        openingHour = sundayOpeningHour;
        closingHour = sundayClosingHour;
        break;
      case DateTime.monday:
        openingHour = mondayOpeningHour;
        closingHour = mondayClosingHour;
        break;
      case DateTime.tuesday:
        openingHour = tuesdayOpeningHour;
        closingHour = tuesdayClosingHour;
        break;
      case DateTime.wednesday:
        openingHour = wednesdayOpeningHour;
        closingHour = wednesdayClosingHour;
        break;
      case DateTime.thursday:
        openingHour = thursdayOpeningHour;
        closingHour = thursdayClosingHour;
        break;
      case DateTime.friday:
        openingHour = fridayOpeningHour;
        closingHour = fridayClosingHour;
        break;
      case DateTime.saturday:
        openingHour = saturdayOpeningHour;
        closingHour = saturdayClosingHour;
        break;
    }

    if (openingHour != null && closingHour != null) {
      final currentTime = now.hour * 60 + now.minute;
      final openingTime = openingHour.hour * 60 + openingHour.minute;
      final closingTime = closingHour.hour * 60 + closingHour.minute;

      return currentTime >= openingTime && currentTime <= closingTime;
    }

    return false;
  }

  factory Business.fromMap(Map<String, dynamic> map) => Business(
        name: map[columnBusinessName],
        address: map[columnBusinessAddress],
        description: map[columnBusinessDescription],
        tax: map[columnBusinessTax],
        isOpen: map[columnBusinessIsOpen],
        types: Set.from(map[columnBusinessTypes].map((e) => BusinessType.fromValue(e))),
        sundayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessSundayOpeningHour]),
        sundayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessSundayClosingHour]),
        mondayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessMondayOpeningHour]),
        mondayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessMondayClosingHour]),
        tuesdayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessTuesdayOpeningHour]),
        tuesdayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessTuesdayClosingHour]),
        wednesdayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessWednesdayOpeningHour]),
        wednesdayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessWednesdayClosingHour]),
        thursdayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessThursdayOpeningHour]),
        thursdayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessThursdayClosingHour]),
        fridayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessFridayOpeningHour]),
        fridayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessFridayClosingHour]),
        saturdayOpeningHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessSaturdayOpeningHour]),
        saturdayClosingHour: TimeOfDayFromFormattedString.fromFormattedString(map[columnBusinessSaturdayClosingHour]),
        latitude: map[columnBusinessLatitude],
        longitude: map[columnBusinessLongitude],
      );

  Map<String, dynamic> toMap() => {
        columnBusinessId: id,
        columnBusinessName: name,
        columnBusinessAddress: address,
        if (description != null) columnBusinessDescription: description,
        columnBusinessOwner: owner!.uid,
        if (tax != null) columnBusinessTax: tax,
        columnBusinessIsOpen: isOpen,
        if (types != null) columnBusinessTypes: types!.map((e) => e.value).toList(),
        if (sundayOpeningHour != null) columnBusinessSundayOpeningHour: sundayOpeningHour!.toFormattedString(),
        if (sundayClosingHour != null) columnBusinessSundayClosingHour: sundayClosingHour!.toFormattedString(),
        if (mondayOpeningHour != null) columnBusinessMondayOpeningHour: mondayOpeningHour!.toFormattedString(),
        if (mondayClosingHour != null) columnBusinessMondayClosingHour: mondayClosingHour!.toFormattedString(),
        if (tuesdayOpeningHour != null) columnBusinessTuesdayOpeningHour: tuesdayOpeningHour!.toFormattedString(),
        if (tuesdayClosingHour != null) columnBusinessTuesdayClosingHour: tuesdayClosingHour!.toFormattedString(),
        if (wednesdayOpeningHour != null) columnBusinessWednesdayOpeningHour: wednesdayOpeningHour!.toFormattedString(),
        if (wednesdayClosingHour != null) columnBusinessWednesdayClosingHour: wednesdayClosingHour!.toFormattedString(),
        if (thursdayOpeningHour != null) columnBusinessThursdayOpeningHour: thursdayOpeningHour!.toFormattedString(),
        if (thursdayClosingHour != null) columnBusinessThursdayClosingHour: thursdayClosingHour!.toFormattedString(),
        if (fridayOpeningHour != null) columnBusinessFridayOpeningHour: fridayOpeningHour!.toFormattedString(),
        if (fridayClosingHour != null) columnBusinessFridayClosingHour: fridayClosingHour!.toFormattedString(),
        if (saturdayOpeningHour != null) columnBusinessSaturdayOpeningHour: saturdayOpeningHour!.toFormattedString(),
        if (saturdayClosingHour != null) columnBusinessSaturdayClosingHour: saturdayClosingHour!.toFormattedString(),
        if (latitude != null) columnBusinessLatitude: latitude,
        if (longitude != null) columnBusinessLongitude: longitude,
      };

  Map<String, dynamic> toFirestoreMap() => toMap()
    ..removeWhere(
      (key, value) => {
        columnBusinessId,
      }.contains(key),
    );

  Business copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    UserAccount? owner,
    double? tax,
    bool? isOpen,
    MImage? logo,
    Set<BusinessType>? types,
    TimeOfDay? sundayOpeningHour,
    TimeOfDay? sundayClosingHour,
    TimeOfDay? mondayOpeningHour,
    TimeOfDay? mondayClosingHour,
    TimeOfDay? tuesdayOpeningHour,
    TimeOfDay? tuesdayClosingHour,
    TimeOfDay? wednesdayOpeningHour,
    TimeOfDay? wednesdayClosingHour,
    TimeOfDay? thursdayOpeningHour,
    TimeOfDay? thursdayClosingHour,
    TimeOfDay? fridayOpeningHour,
    TimeOfDay? fridayClosingHour,
    TimeOfDay? saturdayOpeningHour,
    TimeOfDay? saturdayClosingHour,
    double? latitude,
    double? longitude,
  }) =>
      Business(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        description: description ?? this.description,
        owner: owner ?? this.owner,
        tax: tax ?? this.tax,
        isOpen: isOpen ?? this.isOpen,
        logo: logo ?? this.logo,
        types: types ?? this.types,
        sundayOpeningHour: sundayOpeningHour ?? this.sundayOpeningHour,
        sundayClosingHour: sundayClosingHour ?? this.sundayClosingHour,
        mondayOpeningHour: mondayOpeningHour ?? this.mondayOpeningHour,
        mondayClosingHour: mondayClosingHour ?? this.mondayClosingHour,
        tuesdayOpeningHour: tuesdayOpeningHour ?? this.tuesdayOpeningHour,
        tuesdayClosingHour: tuesdayClosingHour ?? this.tuesdayClosingHour,
        wednesdayOpeningHour: wednesdayOpeningHour ?? this.wednesdayOpeningHour,
        wednesdayClosingHour: wednesdayClosingHour ?? this.wednesdayClosingHour,
        thursdayOpeningHour: thursdayOpeningHour ?? this.thursdayOpeningHour,
        thursdayClosingHour: thursdayClosingHour ?? this.thursdayClosingHour,
        fridayOpeningHour: fridayOpeningHour ?? this.fridayOpeningHour,
        fridayClosingHour: fridayClosingHour ?? this.fridayClosingHour,
        saturdayOpeningHour: saturdayOpeningHour ?? this.saturdayOpeningHour,
        saturdayClosingHour: saturdayClosingHour ?? this.saturdayClosingHour,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
}
