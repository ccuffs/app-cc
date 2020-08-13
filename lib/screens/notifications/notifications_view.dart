import 'package:cc_uffs/screens/notifications/widgets/direct_messages_widget.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) => [
          CustomSliverAppBar(
            showNotifications: false,
          ),
        ],
        body: DirectMessagesWidget(),
      ),
    );
  }
}
