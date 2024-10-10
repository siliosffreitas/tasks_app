import 'package:flutter/material.dart';

const _primaryColor = Color.fromRGBO(245, 189, 66, 1);
const _labelColor = Color.fromRGBO(138, 138, 138, 1);
const _unfocusedBorderColor = Color.fromRGBO(241, 241, 241, 1);
const _unselectedWidgetColor = Color.fromRGBO(219, 220, 222, 1);
const _radioButtonColor = Colors.black45;

final ThemeData makeDefaultAppTheme = ThemeData(
  primaryColor: _primaryColor,
  brightness: Brightness.light,
  primaryColorDark: _primaryColor,
  primaryColorLight: _primaryColor,
  unselectedWidgetColor: _unselectedWidgetColor,

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: _primaryColor,
    selectionColor: _primaryColor,
    selectionHandleColor: _primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.black,
    backgroundColor: _primaryColor,
  ),

  // primaryTextTheme: TextTheme(
  //   bodyLarge: TextStyle(color: Colors.black),
  // ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    color: _primaryColor,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    shadowColor: Colors.transparent,
    // attention to status bar icon color
    // systemOverlayStyle: SystemUiOverlayStyle.light,
    // titleTextStyle: TextStyle(
    //   color: Colors.black,
    // ),

    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    // textTheme: TextTheme(
    //     // center text style
    //     headline6: TextStyle(color: Colors.black),
    //     // Side text style
    //     bodyText2: TextStyle(color: Colors.black))),

    // textTheme: const TextTheme(
    // bodyText2: TextStyle(
    //   fontWeight: FontWeight.w300,
    //   fontStyle: FontStyle.normal,
    //   color: _primaryColor,
    // ),
    // headline1: TextStyle(
    //   fontSize: 20,
    //   fontWeight: FontWeight.bold,
    //   color: _primaryColor,
    // ),
    // : TextStyle(
    //   color: Colors.black,
    // ),
    // button: TextStyle(
    //   fontWeight: FontWeight.bold,
    //   fontSize: 13,
    //   color: Colors.white,

    //   // backgroundColor: Colors.white,
    // ),
    // headline6: TextStyle(
    //   color: Colors.white,
    //   fontSize: 18,
    //   fontWeight: FontWeight.w300,
    // ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: _primaryColor,
      ),
      borderRadius: BorderRadius.circular(28),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: _unfocusedBorderColor,
      ),
      borderRadius: BorderRadius.circular(28),
    ),

    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: _unfocusedBorderColor,
      ),
      borderRadius: BorderRadius.circular(28),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(28),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(28),
    ),
    labelStyle: const TextStyle(
      color: _labelColor,
    ),
    iconColor: _labelColor,
    // suffixStyle: TextStyle(
    //   height: 10,
    // ),
    // hintStyle: TextStyle(color: primaryColor),
    // enabledBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(color: primaryColor),
    // ),
    // focusedBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(
    //     color: primaryColor,
    //   ),
    // ),
    // labelStyle: TextStyle(color: primaryColor),
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: _labelColor,
    ),
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: _primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: _primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: _primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(color: _labelColor);
          }

          return const BorderSide(color: _primaryColor);
        },
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(_primaryColor),
      overlayColor: MaterialStateProperty.all(_primaryColor.withOpacity(0.5)),
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(_radioButtonColor),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(_radioButtonColor),
  ),
);
