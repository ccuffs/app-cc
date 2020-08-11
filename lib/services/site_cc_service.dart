import 'package:flutter/foundation.dart';
import 'package:site_cc_parser/site_cc_parser.dart';

abstract class SiteCCService {
  static Future<HomeContentResponse> fetchHomePage() async {
    final response = await Future.wait([
      Scrapper.getContent(FetchContentFrom.news),
      Scrapper.getContent(FetchContentFrom.posts),
      Scrapper.getContent(FetchContentFrom.vacancies),
    ]);

    return HomeContentResponse(
      news: response[0],
      posts: response[1],
      vacancies: response[2],
    );
  }
}

class HomeContentResponse {
  final List<ParserSiteResponse> news;
  final List<ParserSiteResponse> posts;
  final List<ParserSiteResponse> vacancies;

  HomeContentResponse({
    @required this.news,
    @required this.posts,
    @required this.vacancies,
  });
}
