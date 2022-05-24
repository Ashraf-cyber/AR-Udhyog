import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ViewEmployees extends StatefulWidget {
  const ViewEmployees({Key? key, required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ViewEmployees> {
  String? data;
  var empoyees;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  /// ***********************************/
  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://mypottery.000webhostapp.com/MyPottery/GetEmployeesJson.php"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        empoyees = jsonDecode(
            data!)['data']; //get all the data from json string hospital length
        print(empoyees); // just printed length of data
      });
    } else {
      print(response.statusCode);
    }
  }


  String s = '';
  _making_Phone_Call() async {
    String url = 'tel:' + s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  /// ***********************************/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Employee"),
        backgroundColor: const Color(0xffc9976b),
      ),
      body: ListView.builder(
        itemCount: empoyees== null ? 0 :empoyees.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child:SingleChildScrollView(
              child: Container(
                height: 200,
                color: Colors.white,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Expanded(
                          child:Image.network(
                            "https://mypottery.000webhostapp.com/MyPottery/" +
                                empoyees[index]['PIC'],
                            fit: BoxFit.fill,
                            width: 100,
                            height: 175,
                            alignment: Alignment.center,
                          ),
                          flex:2 ,
                        ),
                      ),
                    ),
                    Expanded(
                      child:Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                const Text("Name-",style: TextStyle(fontWeight: FontWeight.w300),),
                                Text(
                                  empoyees[index]['EMPLOYEE_NAME']
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 17, fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Day Charge-",style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                Flexible(
                                  child: Text(
                                    empoyees[index]['DAY_CHARGE']
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Address-",style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                Flexible(
                                  child: Text(
                                    empoyees[index]['ADDRESS']
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 15, fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(

                              child: Row(

                                children: [
                                  const Icon(Icons.call),
                                  SizedBox(width: 10.0),
                                  RaisedButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        s = jsonDecode(data!)['data'][index]['CONTACT']
                                            .toString();
                                      }
                                      );
                                      _making_Phone_Call();
                                    },
                                    child: Text(
                                      empoyees[index]['CONTACT']
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 15, fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),

                      flex:8 ,
                    ),

                  ],
                ),
              ),
            ),
            elevation: 8,
            margin: EdgeInsets.all(10),
          );
         
        },
      ),
    );
  }
}
