import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'alertbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MaterialName2(title: 'Add Material'),
    );
  }
}


class MaterialName2 extends StatefulWidget {
  const MaterialName2({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<MaterialName2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MaterialName2> {
  TextEditingController material_name=TextEditingController();
  TextEditingController material_unit=TextEditingController();
  bool isLoading = false;

  Future<void> uploadInventoryInfo() async {

    if ( material_name.text.isNotEmpty &&
        material_unit.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://mypottery.000webhostapp.com/MyPottery/AddMaterial.php"));

      // request.files
      //     .add(await http.MultipartFile.fromPath('image', uploadimage!.path)
      // );

      request.fields["MATERIAL_NAME"] = material_name.text;
      request.fields["MATERIAL_UNIT"] = material_unit.text;



      var res = await request.send();

      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        material_name.clear();
        material_unit.clear();
        showModalBox("Success", "Data is Submitted Successfully", context);
        // ignore: avoid_print
        print(res);
      } else {
        setState(() {
          isLoading = false;
          showModalBox("Error", "Data is not Submitted Successfully", context);
        });
      }
    } else {
      setState(() {
        showModalBox("Error", "Please Filled All Field Properly", context);
        isLoading = false;
      });
    }
  }
  /// ***************************************************/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.post_add_rounded)),
        backgroundColor: const Color(0xffc9976b),
        title: const Text("Add Material"),
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
                    const Icon(Icons.post_add_rounded,size: 80.0,color: Colors.black,),
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
                          controller: material_name,
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
                                    Icons.drive_file_rename_outline,
                                    color: Colors.white,
                                  )),
                              hintText: 'Material Name:',
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
                          controller: material_unit,
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
                              // contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                              border: InputBorder.none,
                              // isDense: true,
                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 17.0,right: 20),
                                  child:Icon(Icons.production_quantity_limits_rounded,color: Colors.white,)
                              ),
                              hintText: 'Material Unit:',
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
                        onPressed: uploadInventoryInfo,
                        child: const Text(
                          'Add Material',
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
