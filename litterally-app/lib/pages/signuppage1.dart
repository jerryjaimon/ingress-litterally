import 'package:flutter/material.dart';

class SignUpPageOne extends StatelessWidget {
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
            Text('What type of user are you?'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: null,
                    child: Text(
                      'Volunteer',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: null,
                    child: Text(
                      'Employee',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
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
