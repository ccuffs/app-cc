import 'package:cc_uffs/blocs/user/user_bloc.dart';
import 'package:cc_uffs/screens/home/home_view.dart';
import 'package:cc_uffs/shared/widgets/loaders.dart';
import 'package:cc_uffs/shared/widgets/splash_screen.dart';
import 'package:cc_uffs/shared/widgets/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Padrões de Cores da UFFS
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      builder: (context) => UserBloc.autoLogin(),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserAutoLoginSuccess) {
          return HomeView();
        } else if (state is UserEventFirstUse)
          return WelcomeMessage();
        else if (state is UserStateLogoutSuccess)
          return HomeView(userJustLoggedOut: true);
        else if (state is UserStateSignInSuccessFromRoute) {
          return HomeView();
        } else if (state is UserStateLoadingSigningIn) {
          //Todo: this loading should be prettier
          return SignInUserLoader();
        } else if (state is UserStateLogoutLoading) {
          //Todo: this loading should be prettier
          return SignOutUserLoader();
        } else {
          // Display splash Screen...
          return SplashScreen();
        }
      }),
    );
  }
}
