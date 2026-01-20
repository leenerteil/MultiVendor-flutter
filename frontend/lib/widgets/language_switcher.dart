import 'package:flutter/material.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import '../localization/locale_provider.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final isArabic = localeProvider.isArabic;

    return ListTile(
      leading: const Icon(Icons.language, color: Color(0xFF3D5150)),
      title: Text(
        AppLocalizations.of(context)!.language,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isArabic ? 'العربية' : 'English',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1CE2D6)),
          ),
          const SizedBox(width: 8),
          Switch(
            value: isArabic,
            activeColor: const Color(0xFF1CE2D6),
            onChanged: (value) => localeProvider.toggleLocale(),
          ),
        ],
      ),
    );
  }
}