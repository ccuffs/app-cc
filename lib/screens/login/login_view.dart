import 'package:cc_uffs/blocs/auth/sign_in_bloc.dart';
import 'package:cc_uffs/blocs/user/user_bloc.dart';
import 'package:cc_uffs/shared/constants.dart';
import 'package:cc_uffs/shared/themes.dart';
import 'package:cc_uffs/shared/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({showWithoutLogin})
      : this.showWithoutLogin = showWithoutLogin ?? true;

  final bool showWithoutLogin;
  static const routeName = '/sign-in';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          if (state is SignInStateError)
            return LoginViewScreen(error: state.message, loading: false);
          else if (state is SignInStateSuccess) {
            BlocProvider.of<UserBloc>(context)
                .add(UserEventSignInSuccessFromRoute(user: state.user));
            return Scaffold();
          } else if (state is SignInStateLoading)
            return LoginViewScreen(loading: true);
          else
            return LoginViewScreen(forceSignIn: widget.showWithoutLogin);
        },
      ),
    );
  }
}

class LoginViewScreen extends StatelessWidget {
  final String error;
  final bool loading;
  final bool forceSignIn;

  LoginViewScreen({Key key, this.error, bool loading, bool forceSignIn})
      : this.loading = loading ?? false,
        this.forceSignIn = forceSignIn ?? true,
        super(key: key);

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);

    void _authenticated() {
      final signInEvent = UserSignInEvent(
        authenticator: userNameController.text,
        password: passwordController.text,
      );

      bloc.add(signInEvent);
    }

    return Scaffold(
      appBar: buildDefaultAppBar(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                Container(
                  color: Themes.defaultTheme.primaryColor,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 430,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(
                        top: 0, left: 30, right: 30, bottom: 0),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 128,
                          child: Image.asset(ImageAssets.logoVerde),
                        ),
                        const SizedBox(height: 5),
                        if (error != null) Text(error),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: userNameController,
                          decoration: InputDecoration(
                              labelText: 'IdUFFS ou CPF',
                              labelStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              )),
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              )),
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color:
                                Themes.defaultTheme.primaryColor, //0xFFF519387
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: FlatButton(
                              onPressed: _authenticated,
                              child: Center(
                                child: Text(
                                  'ENTRAR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!forceSignIn)
                          FlatButton(
                            onPressed: () {
                              BlocProvider.of<SignInBloc>(context)
                                  .add(SignInLoading());

                              BlocProvider.of<UserBloc>(context)
                                  .add(UserEventCreateLocalUser());
                            },
                            child: Text('Continuar sem entrar'),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
