import 'package:cc_uffs/helpers/http.dart';
import 'package:cc_uffs/shared/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:site_cc_parser/site_cc_parser.dart';

abstract class SiteCCService {
  static Future<HomeContentResponse> fetchHomePage() async {
    final response = await Future.wait([
      Scrapper.getContent(FetchContentFrom.news).timeout(
        HTTP_TIMEOUT,
        onTimeout: () => throw Exception(CustomHttpException.HTTP_TIMEOUT),
      ),
      Scrapper.getContent(FetchContentFrom.posts).timeout(
        HTTP_TIMEOUT,
        onTimeout: () => throw Exception(CustomHttpException.HTTP_TIMEOUT),
      ),
      Scrapper.getContent(FetchContentFrom.vacancies).timeout(
        HTTP_TIMEOUT,
        onTimeout: () => throw Exception(CustomHttpException.HTTP_TIMEOUT),
      ),
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
