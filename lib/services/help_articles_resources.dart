import 'dart:convert';
import 'package:cc_uffs/helpers/strings.dart';
import 'package:http/http.dart' as http;

import '../shared/constants.dart';

abstract class HelpArticlesResource {
  static Future<List<HelpArticleCategory>> fetchHelp() async {
    final response = await http.get(URL_TO_HELP_PAGE);

    if (response.statusCode != 200) return null;

    final json = response.body;

    final sessionItems = HelpArticleCategory.fromJsonList(json);

    return sessionItems;
  }
}

class HelpArticleCategory {
  final String title;
  final String content;
  final String id;
  final List<HelpArticleEntrie> entries;

  HelpArticleCategory({
    this.title,
    this.content,
    this.id,
    this.entries,
  });

  static searchList({List<HelpArticleCategory> items, String query}) {
    final _searchString = StringHelper.removeDiacritics(query).trim();

    // As palavras são quebradas e procuramos por cada uma delas nos objetos
    final searchWords = _searchString.split(' ');

    // Traz a lista de entries de todas as categorias... Facilita na iteração
    final allItems = items
        .map((e) => e.entries)
        .toList()
        .expand((element) => element)
        .toList();

    final result = allItems
        .where(
          (item) => searchWords.any(
            (word) => //Se alguma palavra for igual, retornara o objeto
                StringHelper.removeDiacritics(
                  item.title,
                ) // Faz com que á = a, etc...
                    .toLowerCase() // A e a, para melhorar a busca
                    .contains(word.toLowerCase()) ||
                StringHelper.removeDiacritics(item.content)
                    .toLowerCase()
                    .contains(word.toLowerCase()),
          ),
        )
        .toList();

    return result;
  }

  static List<HelpArticleCategory> fromJsonList(json) {
    final List<Map<String, dynamic>> jsonDecoded =
        jsonDecode(json).cast<Map<String, dynamic>>();

    final response =
        jsonDecoded.map((item) => HelpArticleCategory.fromMap(item)).toList();
    return response;
  }

  factory HelpArticleCategory.fromMap(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> items =
        map['entries'].cast<Map<String, dynamic>>();

    final entries = items
        .map(
          (item) => HelpArticleEntrie(
            content: item['content'],
            id: item['id'].toString(),
            title: item['title'],
          ),
        )
        .toList();

    return HelpArticleCategory(
      content: map['category']['content'],
      entries: entries,
      id: map['category']['id'].toString(),
      title: map['category']['title'],
    );
  }
}

class HelpArticleEntrie {
  final String id;
  final String title;
  final String content;

  HelpArticleEntrie({this.id, this.title, this.content});
}
