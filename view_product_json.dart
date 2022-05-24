import 'package:ar_udhyog/purchase_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key, required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ViewProduct> {
  String? data;
  var products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  /// ***********************************/
  void getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://mypottery.000webhostapp.com/MyPottery/GetProductJson.php"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        products = jsonDecode(
            data!)['data']; //get all the data from json string hospital length
        print(products); // just printed length of data
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
        title: const Text("List of Products"),
        backgroundColor: const Color(0xffc9976b),
      ),
      body: ListView.builder(
        itemCount: products == null ? 0 :products.length,
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
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child:Image.network(
                                              "https://mypottery.000webhostapp.com/MyPottery/" +
                                                  products[index]['PIC'],
                                              fit: BoxFit.fill,
                                              width: 110,
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
                                const Text("Name: "),
                                Text(
                                      products[index]['PRODUCT_NAME']
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 20, fontFamily: 'Montserrat',
                                                              fontWeight: FontWeight.bold
                                                          ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Des: ",
                                ),
                                Flexible(
                                  child: Text(
                                        products[index]['DESCRIPTION']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 12, fontFamily: 'Montserrat',fontWeight: FontWeight.w300
                                                            ),
                                    ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "MRP: ",style: TextStyle(fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        products[index]['PRODUCT_MRP']
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 15, fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    "Order Now : ",style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  RaisedButton(
                                    color: Colors.red,
                                    onPressed: () { Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const PurchaseProduct(title: 'Purchase Product')),
                                    ); },
                                    child: const Icon(Icons.add_shopping_cart_rounded,color: Colors.white)
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
