const String HELP_MAIL_ADDRESS_CH = 'computacao.ch@uffs.edu.br';
const String HELP_MAIL_SUBJECT = 'Ajuda';
const String SERVER_ADDRESS = '';
const Duration HTTP_TIMEOUT = Duration(seconds: 15);
const Duration SPLASH_TIME = Duration(seconds: 2);
const DIRECT_MESSAGE_URL =
    'https://gist.githubusercontent.com/fersasil/6ef1647232e6146bf0179b4db88131a2/raw/dm.json';

const URL_TO_HELP_PAGE =
    'https://gist.githubusercontent.com/fersasil/40e4f877cf375540d2a4e7a11d49d461/raw/ajuda.json';

abstract class ImageAssets {
  static const logo = 'assets/images/logo.png';
  static const logoBranco = 'assets/images/logo-branco.png';
  static const logoVerde = 'assets/images/logo-verde.png';
  static const fullLogo = 'assets/images/full-logo.png';
}

abstract class LocalStorageFiles {
  static const user = '_user';
}
