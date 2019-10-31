import 'package:cc_uffs/domain/exceptions/uffs_exceptions.dart';

class ApiException extends UffsExceptions {

  @override
  String get message => 'Ocorreu um erro de comunicação de comunicação';
}