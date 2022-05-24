import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ViewRawProduct extends StatefulWidget {
  const ViewRawProduct({Key? key, required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ViewRawProduct> {
  String? data;
  var raw_product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSoldProduct();
    // getSoldProduct();
  }
  /// ***********************************/
  void getSoldProduct() async {
    http.Response response = await http.get(Uri.parse(
        "https://mypottery.000webhostapp.com/MyPottery/GetRawProduct.php"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        raw_product = jsonDecode(
            data!)['data']; //get all the data from json string hospital length
        print(raw_product); // just printed length of data
      });
    } else {
      print(response.statusCode);
    }
  }

  /// ***********************************/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List of Raw Products"),
          backgroundColor: const Color(0xffc9976b),
        ),
        body: ListView.builder(
            itemCount: raw_product == null ? 0 : raw_product.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                elevation: 5.0,
                child: SizedBox(
                  height: 130,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Product Name- ",
                          ),
                          Text(
                            raw_product[index]['PRODUCT_NAME']
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          const Text(
                            "Quantity- ",
                          ),
                          Text(
                            raw_product[index]['QUANTITY']
                                .toString(),
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),



                    ],
                  ),
                ),

              );

            }
        )
    );

  }

}
