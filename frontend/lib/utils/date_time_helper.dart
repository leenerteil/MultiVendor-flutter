import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

class DateFormatter {
  static String formatDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    if (isArabic) {
      return DateFormat.yMMMMd('ar').format(date);
    } else {
      return DateFormat.yMMMMd('en').format(date);
    }
  }

  static String formatCurrency(BuildContext context, double amount) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final formatter = NumberFormat.currency(
      locale: isArabic ? 'ar' : 'en',
      symbol: isArabic ? 'د.إ' : '\$',
      decimalDigits: 2,
    );

    return formatter.format(amount);
  }
}
