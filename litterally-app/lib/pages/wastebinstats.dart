import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class wasteBinStats extends StatefulWidget {
  const wasteBinStats({Key key}) : super(key: key);

  @override
  _wasteBinStatsState createState() => _wasteBinStatsState();
}

class _wasteBinStatsState extends State<wasteBinStats> {
  int weight;
  String town;
  int uldist; //Ultrasound dist
  String wastebinid;
  String status;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
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
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            Text(
                              'Your Waste Bin!',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 134,),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),

                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Capacity Remaining:$uldist %",style: TextStyle(color: Colors.black,fontSize: 22),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Weight:$weight kg",style: TextStyle(color: Colors.black,fontSize: 22),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Location:$town",style: TextStyle(color: Colors.black,fontSize: 22),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Waste Bin ID:$wastebinid",style: TextStyle(color: Colors.black,fontSize: 22),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(onPressed: ()async{
                                      final http.Response response = await http.get(
                                          Uri.parse('https://wastemanagemet-iot-default-rtdb.firebaseio.com/wastebin_current/MAA0001.json')
                                      );
                                      setState(() {
                                        town = jsonDecode(response.body)['town'];
                                        uldist = jsonDecode(response.body)['dist'];
                                        weight = jsonDecode(response.body)['weight'];
                                        wastebinid = 'MAA0001';
                                      });
                                      print(jsonDecode(response.body));
                                    },color: Colors.lightGreen,child: Row(mainAxisSize:MainAxisSize.min,children: [Icon(Icons.refresh,color: Colors.white,),Text('Refresh',style: TextStyle(color:Colors.white,fontSize: 20))],),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child:Image(
                          width: 411,
                          image: AssetImage('images/wastebin.png',),
                        ), )  ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

}
