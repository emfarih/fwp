String formatDateWithTimezone(DateTime date) {
  // Format the date and time parts
  String formattedDate = "${date.year.toString().padLeft(4, '0')}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.day.toString().padLeft(2, '0')}T"
      "${date.hour.toString().padLeft(2, '0')}:"
      "${date.minute.toString().padLeft(2, '0')}:"
      "${date.second.toString().padLeft(2, '0')}";

  return "${formattedDate}Z";
}
