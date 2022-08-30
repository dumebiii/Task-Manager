import 'package:flutter/material.dart';

const kWhite = Colors.white;
const kBluegrey = Colors.blueGrey;
const kBlack = Colors.black;
const kLightBluegrey = Color(0xffcfd8dc);
const kRed = Colors.red;
const kTransparent = Colors.transparent;

//TEXT-STYLES
TextStyle kTitleTextStyle = const TextStyle(
  color: kWhite,
  fontSize: 32,
  fontWeight: FontWeight.bold,
);
TextStyle kMediumTextStyle = const TextStyle(
  color: kWhite,
  fontSize: 24,
  fontWeight: FontWeight.w500,
);
TextStyle kSubtitleTextStyle = const TextStyle(
  fontFamily: 'OpenSauceOne',
  fontSize: 16,
);

TextStyle kAppBarTextStyle = kSubtitleTextStyle.copyWith(
  fontFamily: 'OpenSauceOne',
  fontSize: 8,
  fontWeight: FontWeight.w600,
  color: kWhite,
);

//EXTRA

TextStyle kButtonTextStyle =
    const TextStyle(fontFamily: 'OpenSauceOne', color: kWhite, fontSize: 14);

// HORIZONTAL SPACING
const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 15.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

// VERTICAL SPACING
const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 15.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);

Widget verticalSpaceCustom(double height) => SizedBox(height: height);
