import 'package:flutter/widgets.dart';

class CalendarStyle {
  final int markersMaxCount;

  final bool canMarkersOverflow;

  final bool markersAutoAligned;

  final double markersAnchor;

  final double? markerSize;

  final double markerSizeScale;

  final PositionedOffset markersOffset;

  final AlignmentGeometry markersAlignment;

  final Decoration markerDecoration;

  final EdgeInsets markerMargin;

  final EdgeInsets cellMargin;

  final EdgeInsets cellPadding;

  final AlignmentGeometry cellAlignment;

  final double rangeHighlightScale;

  final Color rangeHighlightColor;
  final bool outsideDaysVisible;
  final bool isTodayHighlighted;
  final TextStyle todayTextStyle;

  final Decoration todayDecoration;

  final TextStyle selectedTextStyle;

  final Decoration selectedDecoration;

  final TextStyle rangeStartTextStyle;

  final Decoration rangeStartDecoration;

  final TextStyle rangeEndTextStyle;

  final Decoration rangeEndDecoration;

  final TextStyle withinRangeTextStyle;

  final Decoration withinRangeDecoration;
  final TextStyle outsideTextStyle;
  final Decoration outsideDecoration;

  final TextStyle disabledTextStyle;

  final Decoration disabledDecoration;

  final TextStyle holidayTextStyle;

  final Decoration holidayDecoration;

  final TextStyle weekendTextStyle;

  final Decoration weekendDecoration;

  final TextStyle defaultTextStyle;

  final Decoration defaultDecoration;

  final Decoration todayDateDecoration;

  final Decoration rowDecoration;

  final TableBorder tableBorder;

  final EdgeInsets tablePadding;

  const CalendarStyle({
    this.isTodayHighlighted = true,
    this.canMarkersOverflow = true,
    this.outsideDaysVisible = true,
    this.markersAutoAligned = true,
    this.markerSize,
    this.markerSizeScale = 0.2,
    this.markersAnchor = 0.7,
    this.rangeHighlightScale = 1.0,
    this.markerMargin = const EdgeInsets.symmetric(horizontal: 0.3),
    this.markersAlignment = Alignment.bottomCenter,
    this.markersMaxCount = 4,
    this.cellMargin = const EdgeInsets.all(6.0),
    this.cellPadding = const EdgeInsets.all(0),
    this.cellAlignment = Alignment.center,
    this.markersOffset = const PositionedOffset(),
    this.rangeHighlightColor = const Color(0xFF53C5EA),
    this.markerDecoration = const BoxDecoration(
      color: Color(0xFF263238),
      shape: BoxShape.circle,
    ),
    this.todayTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    this.todayDecoration = const BoxDecoration(
      color: Color(0xFF9FA8DA),
      shape: BoxShape.circle,
    ),
    this.todayDateDecoration = const BoxDecoration(
      color: Color(0x5953C5EA),
      shape: BoxShape.circle,
    ),
    this.selectedTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    this.selectedDecoration = const BoxDecoration(
      color: Color(0x8153C5EA),
      shape: BoxShape.circle,
    ),
    this.rangeStartTextStyle = const TextStyle(
      color: Color(0xFF53C5EA),
      fontSize: 16.0,
    ),
    this.rangeStartDecoration = const BoxDecoration(
      color: Color(0xFF53C5EA),
      shape: BoxShape.circle,
    ),
    this.rangeEndTextStyle = const TextStyle(
      color: Color(0xFFFAFAFA),
      fontSize: 16.0,
    ),
    this.rangeEndDecoration = const BoxDecoration(
      color: Color(0xFF53C5EA),
      shape: BoxShape.circle,
    ),
    this.withinRangeTextStyle = const TextStyle(),
    this.withinRangeDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.outsideTextStyle = const TextStyle(color: Color(0xFFAEAEAE)),
    this.outsideDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.disabledTextStyle = const TextStyle(color: Color(0xFFBFBFBF)),
    this.disabledDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.holidayTextStyle = const TextStyle(color: Color(0xFFFF7A7A)),
    this.holidayDecoration = const BoxDecoration(
      border: Border.fromBorderSide(
        BorderSide(
          color: Color(0xFF9FA8DA),
          width: 1.4,
        ),
      ),
      shape: BoxShape.circle,
    ),
    this.weekendTextStyle = const TextStyle(color: Color(0xFFFF7A7A)),
    this.weekendDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.defaultTextStyle = const TextStyle(),
    this.defaultDecoration = const BoxDecoration(shape: BoxShape.circle),
    this.rowDecoration = const BoxDecoration(),
    this.tableBorder = const TableBorder(),
    this.tablePadding = const EdgeInsets.all(0),
  });
}

class PositionedOffset {
  final double? top;

  final double? bottom;

  final double? start;

  final double? end;

  const PositionedOffset({this.top, this.bottom, this.start, this.end});
}
