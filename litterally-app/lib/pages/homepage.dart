import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:web3dart/web3dart.dart';


import 'scanpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double littycoin = 38.322;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            //height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff00F240), Color(0xff067C0A)]),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      Text(
                        'Hello Jerry!',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Your LittyCoin Balance is",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image(
                          image: AssetImage('images/Image-4.png'),
                          width: 50,
                          height: 50),
                      Text(
                        '${littycoin}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                TextButton(onPressed: () async{
                  var apiUrl = "http://localhost:8545"; //Replace with your API

                  var httpClient = new Client();
                  var ethClient = new Web3Client(apiUrl, httpClient);
                  var credentials = EthereumAddress.fromHex("0xEE52d20b02629515C99332C0d16FbdD7D7f4CaaA");

                  EtherAmount balance = await ethClient.getBalance(credentials);
                  print(balance.getValueInUnit(EtherUnit.ether));
                  littycoin= balance.getValueInUnit(EtherUnit.ether);
                }, child: Text("Clickhere")),
                flatButton("Scan QR CODE", ScanPage()),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        String codeSanner = await BarcodeScanner.scan(); //barcode scnner
        setState(() {
          littycoin += int.parse(codeSanner);
        });
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }
}
