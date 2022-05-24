import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ViewCustomer extends StatefulWidget {
  const ViewCustomer({Key? key, required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ViewCustomer> {
  String? data;
  var customer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  /// ***********************************/
  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://mypottery.000webhostapp.com/MyPottery/GetCustomerJson.php"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
       customer = jsonDecode(
            data!)['data']; //get all the data from json string hospital length
        print(customer); // just printed length of data
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
        title: const Text("List of Customers"),
        backgroundColor: const Color(0xffc9976b),
      ),
      body: ListView.builder(
        itemCount: customer== null ? 0 :customer.length,
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
                                customer[index]['PIC'],
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
                                  customer[index]['OWNER_NAME']
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
                                  "Shop Name-",style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                Flexible(
                                  child: Text(
                                    customer[index]['SHOP_NAME']
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
                                    customer[index]['ADDRESS']
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
                                  const SizedBox(width: 10.0),
                                  RaisedButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        s = jsonDecode(data!)['data'][index]['CONTACT_NO']
                                            .toString();
                                      });
                                      _making_Phone_Call();
                                    },
                                    child: Text(
                                      customer[index]['CONTACT_NO']
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
