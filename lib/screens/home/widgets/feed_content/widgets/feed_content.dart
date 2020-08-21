import 'package:cc_uffs/blocs/home_feed/home_feed_bloc.dart';
import 'package:cc_uffs/shared/widgets/display_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FeedContentType { news, posts, vacancies }

class FeedContent extends StatelessWidget {
  const FeedContent({Key key, @required this.type}) : super(key: key);

  final FeedContentType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFeedBloc, HomeFeedState>(
      builder: (context, state) {
        if (state is HomeFeedStateInitial)
          return DisplayPost(placeholder: true);
        else if (state is HomeFeedStateSuccessFetching) {
          if (type == FeedContentType.news)
            return DisplayPost(items: state.homeContent.news);
          if (type == FeedContentType.posts)
            return DisplayPost(items: state.homeContent.posts);
          else
            return DisplayPost(items: state.homeContent.vacancies);
        } else //Error state
          return Center(child: Text('Um erro ocorreu'));
      },
    );
  }
}
