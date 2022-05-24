
import 'dart:convert';

import 'package:ar_udhyog/customer_panel.dart';
import 'package:ar_udhyog/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'alert_box.dart';
import 'home_page.dart';


class CustomerLogin extends StatefulWidget {
  const CustomerLogin({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<CustomerLogin> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CustomerLogin> {
  TextEditingController userid=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isLoading = false;

  late int index=0;
  String? data;
  var customer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomer();
    // getSoldProduct();
  }
  /// ***********************************/
  void getCustomer() async {
    http.Response response = await http.get(Uri.parse(
        "https://mypottery.000webhostapp.com/MyPottery/GetCustomerAuthentication.php"));
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

  /// ***************************************************/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(onPressed: () { Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const LoginPage(title: 'Login page')),
        );}, icon: const Icon(Icons.arrow_back)),
        backgroundColor: const Color(0xffc9976b),
        title: const Text("Customer"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                ),
                child: Column(
                  children: [
                    const Icon(Icons.supervised_user_circle,size: 80.0,color: Colors.black,),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 65,
                      child: Card(
                        color: const Color(0xffc9976b),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: userid,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.white),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Color(0xffc9976b), width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              // isDense: true,
                              fillColor: Color(0xffc9976b),
                              // contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                              border: InputBorder.none,
                              // isDense: true,
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 17.0, right: 20),
                                  child: Icon(
                                    Icons.important_devices,
                                    color: Colors.white,
                                  )),
                              hintText: 'User ID:',
                              hintStyle:
                              TextStyle(fontSize: 15.0, color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: const Color(0xffc9976b),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
                          controller: password,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.white),
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Color(0xffc9976b), width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              // isDense: true,
                              fillColor: Color(0xffc9976b),
                              border: InputBorder.none,
                              // isDense: true,
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 17.0,right: 20),
                                  child:Icon(Icons.lock_open,color: Colors.white,)
                              ),
                              hintText: 'Password:',
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.white)),
                        ),
                      ),
                    ),
                    Card(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {

                          if(
                          userid.text.toString()== customer[index]['USER_ID']
                              .toString() &&  password.text.toString()==customer[index]['PASSWORD']
                              .toString() || userid.text.toString()== customer[index]['USER_ID']
                              .toString() &&  password.text.toString()==customer[index]['PASSWORD']
                              .toString()
                          ) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CustomerPanel(title: "Home Page")),
                            );
                          }
                          else
                          {
                            Fluttertoast.showToast(
                                msg: "wrong email or password",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 10.0);
                            print("Sorry Id or Password is wrong");

                          }
                        },
                        // uploadInventoryInfo,
                        child: const Text(
                          'LogIn',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
