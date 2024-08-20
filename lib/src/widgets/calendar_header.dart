// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../customization/header_style.dart';
import '../shared/utils.dart' show CalendarFormat, DayBuilder;
import 'custom_icon_button.dart';
import 'format_button.dart';

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = headerStyle.titleTextFormatter?.call(focusedMonth, locale) ??
        DateFormat('MMMM y', locale).format(focusedMonth);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: ShapeDecoration(
          color: Color(0xFFF5F7FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        padding: EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (headerStyle.leftChevronVisible)
              CustomIconButton(
                icon: headerStyle.leftChevronIcon,
                onTap: onLeftChevronTap,
                margin: headerStyle.leftChevronMargin,
                padding: headerStyle.leftChevronPadding,
              ),
            Spacer(),
            Container(
              child: headerTitleBuilder?.call(context, focusedMonth) ??
                  GestureDetector(
                    onTap: onHeaderTap,
                    onLongPress: onHeaderLongPress,
                    child: Text(
                      text,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                        letterSpacing: -0.6,
                        color: Color(0xFF525866),
                      ),
                      textAlign: headerStyle.titleCentered
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
            ),
            Spacer(),
            if (headerStyle.formatButtonVisible &&
                availableCalendarFormats.length > 1)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: FormatButton(
                  onTap: onFormatButtonTap,
                  availableCalendarFormats: availableCalendarFormats,
                  calendarFormat: calendarFormat,
                  decoration: headerStyle.formatButtonDecoration,
                  padding: headerStyle.formatButtonPadding,
                  textStyle: headerStyle.formatButtonTextStyle,
                  showsNextFormat: headerStyle.formatButtonShowsNext,
                ),
              ),
            if (headerStyle.rightChevronVisible)
              CustomIconButton(
                icon: headerStyle.rightChevronIcon,
                onTap: onRightChevronTap,
                margin: headerStyle.rightChevronMargin,
                padding: headerStyle.rightChevronPadding,
              ),
          ],
        ),
      ),
    );
  }
}
