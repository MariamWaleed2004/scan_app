/// Small, dependency-free date labels used across the app.
class DateFormatter {
  DateFormatter._();

  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  /// "May 12, 2025"
  static String date(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

  /// "4:45 PM"
  static String time(DateTime d) {
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${d.hour < 12 ? 'AM' : 'PM'}';
  }

  /// "Today", "Yesterday" or "May 12, 2025".
  static String day(DateTime d, {DateTime? now}) {
    final today = _dateOnly(now ?? DateTime.now());
    final diff = today.difference(_dateOnly(d)).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return date(d);
  }

  /// "Today, 11:20 AM", "Yesterday, 4:45 PM" or "May 12, 2025".
  static String relative(DateTime d, {DateTime? now}) {
    final label = day(d, now: now);
    return label == 'Today' || label == 'Yesterday' ? '$label, ${time(d)}' : label;
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
