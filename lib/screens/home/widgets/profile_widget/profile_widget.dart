import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cc_uffs/blocs/user/user_bloc.dart';
import 'package:cc_uffs/helpers/generate_qr_code.dart';
import 'package:cc_uffs/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/custom_sliver_app_bar.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(),
      body: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).user;
    final String name = user.name;
    final String cpf = user.cpf;

    return Stack(
      children: <Widget>[
        Container(
          child: ListView(
            children: <Widget>[
              _Header(
                name: name,
                cpf: cpf,
                imageUrl: 'https://placekitten.com/200/200',
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  child: _QrCode(),
                ),
              ),
              SizedBox(height: 40),
              FlatButton(
                  onPressed: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * .82,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          'Compartilhar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 30),
              _IconTextButton(text: 'meus dados'),
              _IconTextButton(text: 'segurança'),
              _IconTextButton(text: 'ajuda'),
              _IconTextButton(text: 'placeholder'),
              _IconTextButton(text: 'placeholder2'),
              _IconTextButton(text: 'placeholder4'),
              SizedBox(height: 20),
              FlatButton(
                onPressed: () =>
                    BlocProvider.of<UserBloc>(context).add(UserEventLogout()),
                child: Text(
                  'sair do aplicativo',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(child: Text('Versão 1.0.0')),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
    @required this.name,
    @required this.cpf,
    @required this.imageUrl,
  }) : super(key: key);

  final String name;
  final String cpf;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 25,
                color: Theme.of(context).primaryColor,
              ),
              Center(
                child: ClipOval(
                  child: Container(
                    color: Colors.grey[200],
                    height: 80,
                    width: 80,
                    child: CachedNetworkImage(imageUrl: imageUrl),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w500,
                wordSpacing: 1.7,
                letterSpacing: .6,
              ),
            ),
          ),
          SizedBox(height: 5),

          Text(
            "CPF: $cpf",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              // color: Colors.grey[800],
              // letterSpacing: .6,
            ),
          ),
          // Text("Matricula: $cpf"),
        ],
      ),
    );
  }
}

class _QrCode extends StatelessWidget {
  const _QrCode({
    Key key,
    bool showLogo,
  })  : this.showLogo = showLogo ?? false,
        super(key: key);

  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) => !snapshot.hasData
          ? SizedBox()
          : Stack(
              children: <Widget>[
                if (showLogo)
                  Center(
                    child: Image.asset(
                      ImageAssets.logo,
                      width: 75,
                    ),
                  ),
                Container(
                  width: 200,
                  height: 200,
                  child: _QrCodeImageWithOpacity(
                    imageFile: snapshot.data,
                  ),
                ),
              ],
            ),
      future: QrCodeFile.getQrCode(),
    );
  }
}

class _QrCodeImageWithOpacity extends StatefulWidget {
  const _QrCodeImageWithOpacity({
    Key key,
    this.imageFile,
  }) : super(key: key);

  final File imageFile;

  @override
  __QrCodeImageWithOpacityState createState() =>
      __QrCodeImageWithOpacityState();
}

class __QrCodeImageWithOpacityState extends State<_QrCodeImageWithOpacity> {
  double _opacity = 0;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: FileImage(widget.imageFile),
      loadingBuilder: (context, child, ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          Future.delayed(Duration(milliseconds: 1)).then((value) {
            setState(() {
              _opacity = 1;
            });
          });
          return AnimatedOpacity(
            child: child,
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
          );
        }
        return Container();
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame != null
                ? child
                : Container(
                    color: Colors.grey[200],
                  ),
          );
        }
      },
      width: 200,
      height: 200,
    );
  }
}

class _IconTextButton extends StatelessWidget {
  const _IconTextButton({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Icon(Icons.ac_unit, color: Colors.grey[600]),
              SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(fontSize: 17),
              ),
              Expanded(child: Container()),
              Icon(Icons.chevron_right, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }
}
