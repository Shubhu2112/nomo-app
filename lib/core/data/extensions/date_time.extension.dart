extension DateTimeExtension on DateTime {
  String formatDateTime() {
    // Map of month names for easy lookup
    const List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    String day = this.day.toString().padLeft(2, '0'); // Ensures 2-digit day
    String month = monthNames[this.month - 1]; // Converts month number to name
    int year = this.year;
    String hour = this.hour > 12 ? (this.hour - 12).toString().padLeft(2, '0') : this.hour.toString().padLeft(2, '0'); // Converts to 12-hour format
    String minute = this.minute.toString().padLeft(2, '0'); // Ensures 2-digit minutes
    String period = this.hour >= 12 ? 'PM' : 'AM'; // Adds AM/PM

    return "$day $month $year, $hour:$minute $period";
  }
}
