import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'alerbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OperationType(title: 'Daily Assign Work'),
    );
  }
}

class OperationType extends StatefulWidget {
  const OperationType({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<OperationType> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OperationType> {

  String? employee_name;
  String? product_name;
  TextEditingController work_description=TextEditingController();
  TextEditingController number_of_items=TextEditingController();
  bool isLoading = false;

  Future<void> uploadInventoryInfo() async {

    if ( number_of_items.text.isNotEmpty &&
        work_description.text.isNotEmpty &&
        employee_name!= null &&
        product_name!= null) {
      setState(() {
        isLoading = true;
      });
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://mypottery.000webhostapp.com/MyPottery/DailyAssignWork.php"));

      // request.files
      //     .add(await http.MultipartFile.fromPath('image', uploadimage!.path)
      // );

      request.fields["NUMBER_OF_ITEM"] = number_of_items.text;
      request.fields["WORK_DESCRIPTION"] = work_description.text;
      request.fields["EMPLOYEE_NAME"] = employee_name!;
      request.fields["PRODUCT_NAME"] = product_name!;


      var res = await request.send();

      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        number_of_items.clear();
        work_description.clear();
        employee_name=null;
        product_name=null;
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.task_alt_rounded)),
        backgroundColor: const Color(0xffc9976b),
        title: const Text("Daily Assign Work"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.handyman,size: 60.0,color: Colors.black,),
              const SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 65,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: const Color(0xffc9976b),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child:  DropdownButton<String>(
                            hint: const Text("Select operation type",style: TextStyle(color: Colors.white),),
                            isExpanded: true,
                            dropdownColor: const Color(0xffc9976b),
                            value:employee_name,
                            icon: const Icon(Icons.arrow_downward,color: Colors.white,),

                            iconSize: 25,
                            elevation: 16,
                            underline: Container(
                              height: 0.0,
                              color: const Color(0xffc9976b),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                employee_name = newValue!;
                                print(employee_name);
                              });
                            },
                            items: <String>['hgchdgfdd','dsdfdff','dsddfdf','dfdffffg']
                                .map<DropdownMenuItem<String>>((String value1) {
                              return DropdownMenuItem<String>(
                                value: value1,

                                child: Text(value1,style:  const TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 65,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: const Color(0xffc9976b),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          child:  DropdownButton<String>(
                            hint: const Text("Select operation type",style: TextStyle(color: Colors.white),),
                            isExpanded: true,
                            dropdownColor: const Color(0xffc9976b),
                            value:product_name,
                            icon: const Icon(Icons.arrow_downward,color: Colors.white,),

                            iconSize: 25,
                            elevation: 16,
                            underline: Container(
                              height: 0.0,
                              color: const Color(0xffc9976b),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                product_name = newValue!;
                                print(product_name);
                              });
                            },
                            items: <String>['hgchdgfdd','dsdfdff','dsddfdf','dfdffffg']
                                .map<DropdownMenuItem<String>>((String value1) {
                              return DropdownMenuItem<String>(
                                value: value1,

                                child: Text(value1,style:  const TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                          ),
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
                          controller: number_of_items,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.left,
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
                              hintText: 'Number of items:',
                              hintStyle: TextStyle(
                                  fontSize: 15.0, color: Colors.white)),
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
                          controller: work_description,
                          textAlign: TextAlign.left,
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
                              hintText: 'Work description:',
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
                          'Submit',
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
