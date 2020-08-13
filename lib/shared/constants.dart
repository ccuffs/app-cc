const String SERVER_ADDRESS = '';
const Duration HTTP_TIMEOUT = Duration(seconds: 15);
const DIRECT_MESSAGE_URL =
    'https://gist.githubusercontent.com/fersasil/6ef1647232e6146bf0179b4db88131a2/raw/dm.json';
    
abstract class ImageAssets {
  static const logo = 'assets/images/logo.png';
  static const logoBranco = 'assets/images/logo-branco.png';
  static const logoVerde = 'assets/images/logo-verde.png';
  static const fullLogo = 'assets/images/full-logo.png';
}

abstract class LocalStorageFiles {
  static const user = '_user';
}
