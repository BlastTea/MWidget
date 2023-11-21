part of 'utils.dart';

// Material 3 Shapes
const double kShapeExtraSmall = 4.0;
const double kShapeSmall = 8.0;
const double kShapeMedium = 12.0;
const double kShapeLarge = 16.0;
const double kShapeExtraLarge = 28.0;

// Material 3 Elevations
List<BoxShadow> kElevation1Light = [
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    color: Colors.black.withOpacity(0.3),
  ),
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 1,
    color: Colors.black.withOpacity(0.15),
  ),
];

List<BoxShadow> kElevation2Light = [
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
    color: Colors.black.withOpacity(0.3),
  ),
  BoxShadow(
    offset: const Offset(0, 2),
    blurRadius: 6,
    spreadRadius: 2,
    color: Colors.black.withOpacity(0.15),
  )
];

List<BoxShadow> kElevation3Light = [
  BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 8,
    spreadRadius: 3,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation4Light = [
  BoxShadow(
    offset: const Offset(0, 6),
    blurRadius: 10,
    spreadRadius: 4,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 2),
    blurRadius: 3,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation5Light = [
  BoxShadow(
    offset: const Offset(0, 8),
    blurRadius: 12,
    spreadRadius: 6,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation1Dark = [
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 1,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation2Dark = [
  BoxShadow(
    offset: const Offset(0, 2),
    blurRadius: 6,
    spreadRadius: 2,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation3Dark = [
  BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 8,
    spreadRadius: 3,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 3,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation4Dark = [
  BoxShadow(
    offset: const Offset(0, 6),
    blurRadius: 10,
    spreadRadius: 4,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 2),
    blurRadius: 3,
    color: Colors.black.withOpacity(0.3),
  ),
];

List<BoxShadow> kElevation5Dark = [
  BoxShadow(
    offset: const Offset(0, 8),
    blurRadius: 12,
    spreadRadius: 6,
    color: Colors.black.withOpacity(0.15),
  ),
  BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 4,
    color: Colors.black.withOpacity(0.3),
  ),
];

// Material 3 Colors
const Color kColorPrimaryLight = Color(0xFF6750A4);
const Color kColorPrimaryDark = Color(0xFFD0BCFF);
const Color kColorPrimaryContainerLight = Color(0xFFEADDFF);
const Color kColorPrimaryContainerDark = Color(0xFF4F378B);
const Color kColorOnPrimaryLight = Color(0xFFFFFFFF);
const Color kColorOnPrimaryDark = Color(0xFF371E73);
const Color kColorOnPrimaryContainerLight = Color(0xFF21005E);
const Color kColorOnPrimaryContainerDark = Color(0xFFEADDFF);
const Color kColorInversePrimaryLight = Color(0xFFD0BCFF);
const Color kColorInversePrimaryDark = Color(0xFF6750A4);

const Color kColorSecondaryLight = Color(0xFF625B71);
const Color kColorSecondaryDark = Color(0xFFCCC2DC);
const Color kColorSecondaryContainerLight = Color(0xFFE8DEF8);
const Color kColorSecondaryContainerDark = Color(0xFF4A4458);
const Color kColorOnSecondaryLight = Color(0xFFFFFFFF);
const Color kColorOnSecondaryDark = Color(0xFF332D41);
const Color kColorOnSecondaryContainerLight = Color(0xFF1E192B);
const Color kColorOnSecondaryContainerDark = Color(0xFFE8DEF8);

const Color kColorTertiaryLight = Color(0xFF7D5260);
const Color kColorTertiaryDark = Color(0xFFEFB8C8);
const Color kColorTertiaryContainerLight = Color(0xFFFFD8E4);
const Color kColorTertiaryContainerDark = Color(0xFF633B48);
const Color kColorOnTertiaryLight = Color(0xFFFFFFFF);
const Color kColorOnTertiaryDark = Color(0xFF492532);
const Color kColorOnTertiaryContainerLight = Color(0xFF370B1E);
const Color kColorOnTertiaryContainerDark = Color(0xFFFFD8E4);

const Color kColorSurfaceLight = Color(0xFFFEF7FF);
const Color kColorSurfaceDark = Color(0xFF141218);
const Color kColorSurfaceDimLight = Color(0xFFDED8E1);
const Color kColorSurfaceDimDark = Color(0xFF141218);
const Color kColorSurfaceBrightLight = Color(0xFFFEF7FF);
const Color kColorSurfaceBrightDark = Color(0xFF3B383E);
const Color kColorSurfaceContainerLowestLight = Color(0xFFFFFFFF);
const Color kColorSurfaceContainerLowestDark = Color(0xFF0F0D13);
const Color kColorSurfaceContainerLowLight = Color(0xFFF7F2FA);
const Color kColorSurfaceContainerLowDark = Color(0xFF1D1B20);
const Color kColorSurfaceContainerLight = Color(0xFFF3EDF7);
const Color kColorSurfaceContainerDark = Color(0xFF211F26);
const Color kColorSurfaceContainerHighLight = Color(0xFFECE6F0);
const Color kColorSurfaceContainerHightDark = Color(0xFF2B2930);
const Color kColorSurfaceContainerHighestLight = Color(0xFFE6E0E9);
const Color kColorSurfaceContainerHighestDark = Color(0xFF36343B);
const Color kColorSurfaceVariantLight = Color(0xFFE7E0EC);
const Color kColorSurfaceVariantDark = Color(0xFF49454F);
const Color kColorOnSurfaceLight = Color(0xFF1C1B1F);
const Color kColorOnSurfaceDark = Color(0xFFE6E1E5);
const Color kColorOnSurfaceVariantLight = Color(0xFF49454E);
const Color kColorOnSurfaceVariantDark = Color(0xFFCAC4D0);
const Color kColorInverseSurfaceLight = Color(0xFF313033);
const Color kColorInverseSurfaceDark = Color(0xFFE6E1E5);
const Color kColorInverseOnSurfaceLight = Color(0xFFF4EFF4);
const Color kColorInverseOnSurfaceDark = Color(0xFF313033);

const Color kColorBackgroundLight = Color(0xFFFEF7FF);
const Color kColorBackgroundDark = Color(0xFF141218);
const Color kColorOnBackgroundLight = Color(0xFF1C1B1F);
const Color kColorOnBackgroundDark = Color(0xFFE6E1E5);

const Color kColorErrorLight = Color(0xFFB3261E);
const Color kColorErrorDark = Color(0xFFF2B8B5);
const Color kColorErrorContainerLight = Color(0xFFF9DEDC);
const Color kColorErrorContainerDark = Color(0xFF8C1D18);
const Color kColorOnErrorLight = Color(0xFFFFFFFF);
const Color kColorOnErrorDark = Color(0xFF601410);
const Color kColorOnErrorContainerLight = Color(0xFF410E0B);
const Color kColorOnErrorContainerDark = Color(0xFFF9DEDC);

const Color kColorOutlineLight = Color(0xFF79747E);
const Color kColorOutlineDark = Color(0xFF938F99);
const Color kColorOutlineVariantLight = Color(0xFFC4C7C5);
const Color kColorOutlineVariantDark = Color(0xFF444746);

const Color kColorShadowLight = Color(0xFF000000);
const Color kColorShadowDark = Color(0xFF000000);

const Color kColorSurfaceTintLight = Color(0xFF6750A4);
const Color kColorSurfaceTintDark = Color(0xFFD0BCFF);

const Color kColorScrimLight = Color(0xFF000000);
const Color kColorScrimDark = Color(0xFF000000);

// Material 3 Elevations
const double kElevationLevel0 = 0.0;
const double kElevationLevel1 = 1.0;
const double kElevationLevel2 = 3.0;
const double kElevationLevel3 = 6.0;
const double kElevationLevel4 = 8.0;
const double kElevationLevel5 = 12.0;

// Material 3 Durations (ms)
const int kDurationShort1 = 50;
const int kDurationShort2 = 100;
const int kDurationShort3 = 150;
const int kDurationShort4 = 200;
const int kDurationMedium1 = 250;
const int kDurationMedium2 = 300;
const int kDurationMedium3 = 350;
const int kDurationMedium4 = 400;
const int kDurationLong1 = 450;
const int kDurationLong2 = 500;
const int kDurationLong3 = 550;
const int kDurationLong4 = 600;
const int kDurationExtraLong1 = 700;
const int kDurationExtraLong2 = 800;
const int kDurationExtraLong3 = 900;
const int kDurationExtraLong4 = 1000;
