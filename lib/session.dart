import 'package:cc_uffs/domain/entities/user.dart';
// This is very polemic, some people think this shouldnt exist, and other, that this is necessary,
// For me, this make the life easier, but if the contributors decide that this is not a good idea
// i refactor so we wont use Session
class Session {
  static User user;
}