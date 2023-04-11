import 'package:flutter/material.dart';

import '../shared/utils.dart' show TextFormatter;

class HeaderStyle {
  final bool titleCentered;

  final bool formatButtonVisible;

  final bool formatButtonShowsNext;

  final TextFormatter? titleTextFormatter;

  final TextStyle titleTextStyle;

  final TextStyle formatButtonTextStyle;

  final BoxDecoration formatButtonDecoration;

  final EdgeInsets headerPadding;

  final EdgeInsets headerMargin;

  final EdgeInsets formatButtonPadding;

  final EdgeInsets leftChevronPadding;

  final EdgeInsets rightChevronPadding;

  final BoxDecoration decoration;

  const HeaderStyle({
    this.titleCentered = false,
    this.formatButtonVisible = true,
    this.formatButtonShowsNext = true,
    this.titleTextFormatter,
    this.titleTextStyle = const TextStyle(fontSize: 17.0),
    this.formatButtonTextStyle = const TextStyle(fontSize: 14.0),
    this.formatButtonDecoration = const BoxDecoration(
      border: Border.fromBorderSide(BorderSide()),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    this.headerMargin = const EdgeInsets.all(0.0),
    this.headerPadding = const EdgeInsets.symmetric(vertical: 8.0),
    this.formatButtonPadding =
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    this.leftChevronPadding = const EdgeInsets.all(12.0),
    this.rightChevronPadding = const EdgeInsets.all(12.0),
    this.decoration = const BoxDecoration(),
  });
}
