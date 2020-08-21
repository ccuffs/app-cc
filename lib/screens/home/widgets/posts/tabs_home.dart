import 'package:cc_uffs/screens/home/widgets/feed_content/widgets/feed_content.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class TabsHome extends StatelessWidget {
  static const _tabs = [
    Tab(text: "Noticias"),
    Tab(text: "Postagens"),
    Tab(text: "Vagas"),
  ];

  final _tabsContent = [
    FeedContent(type: FeedContentType.news),
    FeedContent(type: FeedContentType.posts),
    FeedContent(type: FeedContentType.vacancies),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) => [
            CustomSliverAppBar(
              bottom: TabBar(
                tabs: _tabs,
              ),
            ),
          ],
          body: TabBarView(
            children: _tabsContent,
          ),
        ),
      ),
    );
  }
}
