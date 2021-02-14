import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: AssetImage('images/logoliterally_trans-4.png'),
              alignment: AlignmentDirectional.center,
            ),
            Text('Litter.Responsibly'),
            Image(
              image: AssetImage('images/Volunteering-bro.png'),
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
