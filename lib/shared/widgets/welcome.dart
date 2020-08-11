import 'package:cc_uffs/screens/login/login_view.dart';
import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Todo fix this, this screen is throwing errors
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          children: [
            Container(
                color: Colors.blue[300],
                child: Center(
                    child: Text('Deslize para esquerda',
                        style: TextStyle(fontSize: 30)))),
            Container(
              color: Colors.pink[200],
              child: Center(
                child: Text('Deslize para esquerda',
                    style: TextStyle(fontSize: 30)),
              ),
            ),
            LoginView(showWithoutLogin: false)
          ],
        ),
      ),
    );
  }
}
