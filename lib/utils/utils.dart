import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_widget/m_widget.dart';

part 'material_utils.dart';

const String keyTransactionFee = 'transaction_fee';

const String keyLanguage = 'language';
const String keyThemeMode = 'theme_mode';

const String tableUserAccounts = 'user_accounts';
const String columnUserAccountUid = 'uid';
const String columnUserAccountUsername = 'username';
const String columnUserAccountEmail = 'email';
const String columnUserAccountPassword = 'password';
const String columnUserAccountPhotoUrl = 'photo_url';

const String tableBusiness = 'business';
const String columnBusinessId = 'business_id';
const String columnBusinessName = 'name';
const String columnBusinessAddress = 'address';
const String columnBusinessDescription = 'description';
const String columnBusinessOwner = 'owner';
const String columnBusinessTax = 'tax';
const String columnBusinessIsOpen = 'is_open';
const String columnBusinessTypes = 'types';
const String columnBusinessIsOpeningEveryday = 'is_opening_everyday';
const String columnBusinessEverydayOpeningHour = 'everyday_opening_hour';
const String columnBusinessEverydayClosingHour = 'everyday_closing_hour';
const String columnBusinessSundayOpeningHour = 'sunday_opening_hour';
const String columnBusinessSundayClosingHour = 'sunday_closing_hour';
const String columnBusinessMondayOpeningHour = 'monday_opening_hour';
const String columnBusinessMondayClosingHour = 'monday_closing_hour';
const String columnBusinessTuesdayOpeningHour = 'tuesday_opening_hour';
const String columnBusinessTuesdayClosingHour = 'tuesday_closing_hour';
const String columnBusinessWednesdayOpeningHour = 'wednesday_opening_hour';
const String columnBusinessWednesdayClosingHour = 'wednesday_closing_hour';
const String columnBusinessThursdayOpeningHour = 'thursday_opening_hour';
const String columnBusinessThursdayClosingHour = 'thursday_closing_hour';
const String columnBusinessFridayOpeningHour = 'friday_opening_hour';
const String columnBusinessFridayClosingHour = 'friday_closing_hour';
const String columnBusinessSaturdayOpeningHour = 'saturday_opening_hour';
const String columnBusinessSaturdayClosingHour = 'saturday_closing_hour';
const String columnBusinessLatitude = 'latitude';
const String columnBusinessLongitude = 'longitude';

const double kCompactSize = 600.0;
const double kMediumSize = 840.0;

const String shortLorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis ipsum tortor, cursus volutpat sapien iaculis ac. Vivamus eu dui pharetra, accumsan eros non, placerat sem.';
const String longLorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis ipsum tortor, cursus volutpat sapien iaculis ac. Vivamus eu dui pharetra, accumsan eros non, placerat sem. Etiam pulvinar venenatis ligula, non condimentum lorem blandit nec. Nam elementum in tellus id viverra. Aliquam erat volutpat. Suspendisse placerat efficitur diam at laoreet. Maecenas feugiat purus sem, in malesuada sapien aliquam quis. Vestibulum ut velit eget massa egestas viverra non et turpis. Morbi fermentum pellentesque molestie. Fusce tempus neque nec justo iaculis aliquet. Duis consequat consequat aliquet.';

TextInputFormatter textFormatterDoubleWithNegative = FilteringTextInputFormatter.allow(RegExp(r'^-?\d+\.?\d*$'));
TextInputFormatter textFormatterDoubleOnly = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*$'));
TextInputFormatter textFormatterDigitsOnly = FilteringTextInputFormatter.digitsOnly;
TextInputFormatter textFormatterSingleLine = FilteringTextInputFormatter.singleLineFormatter;
TextInputFormatter textFormatterLetterOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
TextInputFormatter textFormatterLetterDigitsOnly = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

UserAccount? currentUserAccount;

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

EdgeInsets responsivePadding(Size size) {
  if (size.width < kCompactSize) {
    return const EdgeInsets.symmetric(horizontal: 16.0);
  }
  if (size.width <= kMediumSize) {
    return EdgeInsets.symmetric(horizontal: (size.width - kCompactSize) / 2 + 16.0);
  }

  return EdgeInsets.symmetric(horizontal: (size.width - kMediumSize) / 2 + 16.0);
}
