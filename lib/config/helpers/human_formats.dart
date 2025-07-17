import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HumanFormats {
  static Future<void> initFormats() async {
    Intl.defaultLocale = 'en';
    await initializeDateFormatting('es', null);
    await initializeDateFormatting('en', null);
  }

  static String formatDouble(double value) {
    final formatter = NumberFormat('0.#');
    return formatter.format(value);
  }

  static String durationToTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes % 60);
    final seconds = (duration.inSeconds % 60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  static String timeDifference(DateTime startDate, [DateTime? endDate]) {
    final now = endDate ?? DateTime.now();
    final difference = now.difference(startDate);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays % 365) % 30;

    if (years > 0) {
      return years == 1 ? '1 año' : '$years años';
    } else if (months > 0) {
      return months == 1 ? '1 mes' : '$months meses';
    } else {
      return days == 1 ? '1 día' : '$days días';
    }
  }

  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  static String formatDateReadable(DateTime date, {String? locale}) {
    final format = DateFormat('d MMM, y', locale);
    String formattedDate = format.format(date);

    List<String> parts = formattedDate.split(' ');

    if (parts.length >= 2) {
      String monthPart = parts[1];
      if (monthPart.isNotEmpty) {
        String capitalizedMonth =
            monthPart[0].toUpperCase() + monthPart.substring(1);
        parts[1] = capitalizedMonth;
      }
    }

    return parts.join(' ');
  }

  static int calculateAge(DateTime birthDate, {DateTime? reference}) {
    final now = reference ?? DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static String timeAgo(DateTime date, {DateTime? reference}) {
    final now = reference ?? DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${diff.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${diff.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (diff.inDays < 31) {
      return '${diff.inDays} ${diff.inDays == 1 ? 'day' : 'days'} ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  static String formatTime(DateTime date) {
    // 'HH:mm' para formato de 24 horas (ej: 13:30)
    // 'h:mm a' para formato de 12 horas con AM/PM (ej: 1:30 PM)
    final format = DateFormat('HH:mm');
    return format.format(date);
  }
}
