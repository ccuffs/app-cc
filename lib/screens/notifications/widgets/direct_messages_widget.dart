import 'package:cached_network_image/cached_network_image.dart';
import 'package:cc_uffs/blocs/direct_message/direct_message_bloc.dart';
import 'package:cc_uffs/services/direct_messages_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectMessagesWidget extends StatelessWidget {
  const DirectMessagesWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DirectMessageBloc>(
      create: (context) => DirectMessageBloc.buildAndFetch(),
      child: BlocBuilder<DirectMessageBloc, DirectMessageState>(
        builder: (context, state) {
          if (state is DirectMessageErrorState) {
            return Center(child: Text('Error'));
          } else if (state is DirectMessageSuccessState)
            return _DirectMessagesList(messages: state.messages);

          return _DirectMessagesList(loading: true);
        },
      ),
    );
  }
}

class _DirectMessagesList extends StatelessWidget {
  const _DirectMessagesList({
    Key key,
    bool loading,
    this.messages,
  })  : this.loading = loading ?? false,
        super(key: key);

  final bool loading;
  final List<DirectMessage> messages;

  @override
  Widget build(BuildContext context) {
    final _controller = ScrollController();

    return Container(
      child: ListView.builder(
        controller: _controller,
        reverse: true,
        itemCount: loading ? 10 : messages.length,
        itemBuilder: (context, index) => Column(
          children: [
            if (!loading && index == 0)
              _DateHeader(date: messages[index].formatedDate)
            else if (!loading &&
                messages[index - 1]
                        .date
                        .difference(messages[index].date)
                        .inDays !=
                    0)
              _DateHeader(date: messages[index].formatedDate),
            _MessageContainer(
              placeholder: loading,
              authorImage:
                  messages != null ? messages[index].authorImage : null,
              message: messages != null ? messages[index].message : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({
    Key key,
    @required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5), child: Text(date));
  }
}

class _MessageContainer extends StatelessWidget {
  const _MessageContainer({
    Key key,
    this.message,
    this.authorImage,
    placeholder,
  })  : this.placeholder = placeholder ?? false,
        super(key: key);

  final String message;
  final String authorImage;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _Consts._messageContainerMargin,
      child: Stack(
        children: <Widget>[
          Container(
            margin: _Consts.messageMargin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(_Consts.borderRadius),
                  topRight: Radius.circular(_Consts.borderRadius),
                  bottomRight: Radius.circular(_Consts.borderRadius)),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: _Consts.messagePadding,
              child: placeholder
                  ? SizedBox(
                      height: _Consts.placeholderSize, width: double.infinity)
                  : Text(message, style: TextStyle(fontSize: 16)),
            ),
          ),
          ClipOval(
            child: Container(
              height: _Consts.authorImageSize,
              width: _Consts.authorImageSize,
              color: Colors.grey[300],
              child: placeholder || authorImage == null
                  ? Container()
                  : CachedNetworkImage(imageUrl: authorImage),
            ),
          )
        ],
      ),
    );
  }
}

abstract class _Consts {
  static const double authorImageSize = 35;
  static const double placeholderSize = 25;
  static const double borderRadius = 20;
  static const EdgeInsets messagePadding =
      EdgeInsets.symmetric(vertical: 12.0, horizontal: 25);
  static const EdgeInsets messageMargin =
      EdgeInsets.only(left: 20, right: 60, top: 5);

  static const EdgeInsets _messageContainerMargin =
      EdgeInsets.symmetric(horizontal: 15, vertical: 10);
}
