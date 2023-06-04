import 'package:intl/intl.dart';

extension Dateformatting on DateTime {
  String formatDate() {
    DateFormat format = DateFormat('dd-MMMM-yyyy');
    String formatted = format.format(this);
    return formatted;
  }
}
