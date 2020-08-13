import 'dart:convert';
import 'package:cc_uffs/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

abstract class DirectMessages {
  static Future<List<DirectMessage>> fetchFromServer() async {
    final response = await http
        .get(DIRECT_MESSAGE_URL)
        .timeout(HTTP_TIMEOUT, onTimeout: () => throw Exception('Timeout'));

    if (response.statusCode != 200) return null;

    await initializeDateFormatting('pt_BR', null);

    final messages = DirectMessage.parseList(response.body).map((e) {
      final formatedDate = _formatDate(e.date);
      e.formatedDate =
          formatedDate[0].toUpperCase() + formatedDate.substring(1);
      return e;
    }).toList();

    messages.sort((a, b) => b.date.compareTo(a.date));

    return messages;
  }
}

String _formatDate(DateTime date) {
  final difference = DateTime.now().difference(date);

  if (difference.inDays > 7)
    return DateFormat("d 'de' MMM 'de' y", 'pt-br').format(date);
  else if (difference.inHours >= 24)
    return DateFormat("EEE, H:m", 'pt-br').format(date);
  else {
    return difference.inHours > 1 && difference.inHours <= 24
        ? "${difference.inHours} Horas Atrás"
        : "${difference.inMinutes} Minutos Atrás";
  }
}

class DirectMessage {
  final String message;
  final String authorImage;
  final DateTime date;
  String formatedDate;

  DirectMessage({
    this.message,
    this.date,
    this.authorImage,
    this.formatedDate,
  });

  factory DirectMessage.fromJson(json) {
    Map map;

    if (json.runtimeType == String)
      map = jsonDecode(json);
    else
      map = json;

    return DirectMessage(
      date: DateTime.parse(map['date']),
      message: map['message'],
      authorImage: map['authorImage'],
      formatedDate: map['formatedDate'],
    );
  }

  Map<String, String> toMap() {
    return {
      "message": message,
      "date": date.toIso8601String(),
      "authorImage": authorImage,
      "formatedDate": formatedDate,
    };
  }

  String toJson() {
    final map = this.toMap();
    return jsonEncode(map);
  }

  static List<DirectMessage> parseList(json) {
    List<Map<String, dynamic>> list;

    if (json.runtimeType == String)
      list = jsonDecode(json).cast<Map<String, dynamic>>();
    else
      list = json;

    return list.map((e) => DirectMessage.fromJson(e)).toList();
  }

  static String toJsonList(List<DirectMessage> list) {
    final toConvert = list.map((e) => e.toMap()).toList();

    return jsonEncode(toConvert);
  }
}
