import 'package:cc_uffs/domain/exceptions/uffs_exceptions.dart';

class UserNotFoundException extends UffsExceptions {

  @override
  String get message => 'Usuário não encontrado';
}