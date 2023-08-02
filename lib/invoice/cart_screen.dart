import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefine_sales_app/helpers/item_card.dart';
import 'package:redefine_sales_app/model/invoice_model.dart';
import 'package:redefine_sales_app/pdf/pdf_api.dart';
import 'package:redefine_sales_app/pdf/pdf_invoice_Api.dart';

import '../helpers/card_screen.dart';
import '../helpers/item_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.userDetail});

  final QueryDocumentSnapshot<Map<String, dynamic>>? userDetail;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final goalPillarText = TextEditingController();
  final goalBeamText = TextEditingController();

  final boxPillarText = TextEditingController();
  final boxBeam1Text = TextEditingController();
  final boxBeam2Text = TextEditingController();
  bool pillars = true;

  bool beams = false;

  bool box = true;
  bool goal = false;
  bool cont = false;
  bool german = false;

  int totalAmount = 0;
  int pillarTotalCost = 0;
  int beamTotalCost = 0;
  int componentsCost = 0;

  bool components = false;
  final cartList = [];
  var myGoalList= boxList;
  
  var pillarVariant  = "400_400";
  var pillarPriceList;
    var beamsVariant  = "550_650";
  var beamsPriceList;

  final List<String> itemList = ["Pillars", "Beams", "Components"];
    final List<String> itemType = ["Box Truss","Goal Truss",  "Scafolding", 'German Tent'];
  emptyBoxPillar() {
    for (var i = 0; i < myGoalList['pillarList']!.length; i++) {
      myGoalList['pillarList']?[i]['qty'] = 0;
    }
  }

  emptyBoxBeam() {
    for (var i = 0; i < myGoalList['beamsList']!.length; i++) {
      myGoalList['beamsList']?[i]['qty'] = 0;
    }
  }

  emptyGoalPillar() {
    for (var i = 0; i < myGoalList['pillarList']!.length; i++) {
      myGoalList['pillarList']?[i]['qty'] = 0;
    }
  }

  emptyGoalBeam() {
    for (var i = 0; i < myGoalList['beamsList']!.length; i++) {
      myGoalList['beamsList']?[i]['qty'] = 0;
    }
  }
  @override
  void initState() {
    super.initState();
    myGoalList= boxList;

if(pillarVariant == "400_400"){
  pillarPriceList = variant_400_400;
}else if(pillarVariant == "380_380"){
  pillarPriceList = variant_380_380;
}else if(pillarVariant == "350_350"){
  pillarPriceList = variant_350_350;
}



if(beamsVariant == "550_650"){
  beamsPriceList = variant_550_650;
}
   emptyBoxPillar();
   emptyBoxBeam();
     emptyGoalPillar();
       emptyGoalBeam();
 
  }
 @override
  void dispose() {
    
myGoalList= boxList;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF0F3F6).withOpacity(1),
        
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.66,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.030,
                      vertical: MediaQuery.of(context).size.height * 0.010),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_ios)),
                          Text(
                            "Back",
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      if (goal == true) _goalHead(),
                      if (box == true) _boxHead(),
                    ],
                  )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    // vertical: MediaQuery.of(context).size.height * 0.020,
                    horizontal: MediaQuery.of(context).size.width * 0.020),
                height: 330,
                decoration:  BoxDecoration(
                    color: Colors.white,
                    // backgroundColor: Colors.red,
                
                      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: Colors.blueGrey)
                    ]),
                child: ListView(children: [
                   SizedBox(
            height: MediaQuery.of(context).size.height * 0.090,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ChoiceChip(
                  label: Text(
                    itemType[0],
                    style: TextStyle(
                        color: box == true ? Colors.white : Colors.black),
                  ),
                  selected: box,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                     setState(() {
                            box = true;
                            cont = false;
                            goal = false;
                            german= false;

                          });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemType[1],
                    style: TextStyle(
                        color: goal == true ? Colors.white : Colors.black),
                  ),
                  selected: goal,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                      setState(() {
                            box = false;
                            goal = true;
                            cont = false;
                            german= false;
                          });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemType[2],
                    style: TextStyle(
                        color:
                            cont == true ? Colors.white : Colors.black),
                  ),
                  selected: cont,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                            box = false;
                            cont = true;
                            goal = false;
                            german= false;

                          });
                  },
                ), SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemType[3],
                    style: TextStyle(
                        color:
                            cont == german ? Colors.white : Colors.black),
                  ),
                  selected: german,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                            box = false;
                            cont = false;
                            goal = false;
                            german= true;

                          });
                  },
                ),
              ],
            ),
          ),
       
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                              
                      Text(
                        "Dimensions",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.020),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      if (goal == true) _goalWidget(),
                      if (box == true) _boxWidget(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                Row(
                         mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                        children: [
                          
                     
                          Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF0c039e),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.trolley,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.030,
                                    ),
                                    Text(
                                      "₹$totalAmount ",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                final dueDate = DateTime.now()
                                    .add(const Duration(days: 7));
                                final invoice = Invoice(
                                    info: InvoiceInfo(
                                        description: "description",
                                        date: DateTime.now(),
                                        dueDate: dueDate,
                                        number: "9650903368"),
                                    supplier: const Supplier(
                                        address:
                                            "H-91, Old Seemapuri, Delhi -95",
                                        mobile: "9319935674",
                                        name: "Satyam"),
                                    customer: Customer(
                                        address:
                                            widget.userDetail?['Project'] ??
                                                "",
                                        mobile:
                                            widget.userDetail?['Mobile'] ??
                                                "",
                                        name:
                                            widget.userDetail?['Name'] ?? ""),
                                    items: [
                                      for (int i = 0;
                                          i < cartList.length;
                                          i++)
                                        InvoiceItem(
                                          date: DateTime.parse("2023-02-27"),
                                          name: cartList[i]['item'],
                                          description: "description",
                                          price:
                                              cartList[i]['price'].toString(),
                                          qty: cartList[i]['qty'].toString(),
                                        )
                                    ]);

                                final pdfFile =
                                    await PdfInvoiceApi.generate(invoice);
                                PdfApi.openFile(pdfFile);
                              },
                              icon: Icon(
                                Icons.download_for_offline,
                                color: const Color(0xFF0c039e),
                                size:
                                    MediaQuery.of(context).size.height * 0.05,
                              ))
                        ],
                      ),
                    
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _boxHead() {
    return Column(
      children: [
        if (cont != true)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.090,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ChoiceChip(
                  label: Text(
                    itemList[0],
                    style: TextStyle(
                        color: pillars == true ? Colors.white : Colors.black),
                  ),
                  selected: pillars,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                      pillars = value;
                      components = false;
                      beams = false;
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemList[1],
                    style: TextStyle(
                        color: beams == true ? Colors.white : Colors.black),
                  ),
                  selected: beams,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                      beams = value;
                      pillars = false;
                      components = false;
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemList[2],
                    style: TextStyle(
                        color:
                            components == true ? Colors.white : Colors.black),
                  ),
                  selected: components,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                      beams = false;
                      pillars = false;
                      components = value;
                    });
                  },
                ),
              ],
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.010,
        ),
        if (cont != true)
          if (pillars == true)
            ListView.builder(
              itemCount: boxList['pillarList']?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ItemCard(
                        removeTap: () {
                          setState(() {
                            if (int.parse(boxList['pillarList']?[index]['qty']
                                        .toString() ??
                                    '0') >
                                0) {
                              boxList['pillarList']?[index]['qty'] = int.parse(
                                      boxList['pillarList']?[index]['qty']
                                              .toString() ??
                                          '0') -
                                  1;

                              // totalAmount = cartList
                              //     .map((item) =>
                              //         item['price'] * item['qty'])
                              //     .reduce((item1, item2) =>
                              //         item1 + item2);

                              if (int.parse(boxList['pillarList']?[index]['qty']
                                          .toString() ??
                                      '0') ==
                                  0) {
                                cartList.removeAt(index);
                                log(cartList.toString());
                              }
                            }
                          });
                        },
                        addTap: () {
                          if (cartList
                              .contains(boxList['pillarList']?[index])) {
                            setState(() {
                              boxList['pillarList']?[index]['qty'] = int.parse(
                                      boxList['pillarList']?[index]['qty']
                                              .toString() ??
                                          '0') +
                                  1;
                            });
                            // setState(() {
                            //   totalAmount = cartList
                            //       .map((item) =>
                            //           item['price'] * item['qty'])
                            //       .reduce((item1, item2) =>
                            //           item1 + item2);
                            // });
                          }
                          if (!cartList
                              .contains(boxList['pillarList']?[index])) {
                            cartList.add(boxList['pillarList']?[index]);
                            setState(() {
                              boxList['pillarList']?[index]['qty'] = int.parse(
                                      boxList['pillarList']?[index]['qty']
                                              .toString() ??
                                          '0') +
                                  1;
                            });
                            // setState(() {
                            //   totalAmount = cartList
                            //       .map((item) =>
                            //           item['price'] * item['qty'])
                            //       .reduce((item1, item2) =>
                            //           item1 + item2);
                            // });
                          }
                        },
                        itemName:
                            boxList['pillarList']?[index]['item'].toString() ??
                                '',
                        qty: int.parse(
                            boxList['pillarList']?[index]['qty'].toString() ??
                                '0'),
                        size:
                            boxList['pillarList']?[index]['size'].toString() ??
                                ''),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.014,
                    )
                  ],
                );
              },
            ),
        if (beams == true)
          ListView.builder(
            itemCount: boxList['beamsList']?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ItemCard(
                      removeTap: () {
                        setState(() {
                          if (int.parse(boxList['beamsList']?[index]['qty']
                                      .toString() ??
                                  '0') >
                              0) {
                            boxList['beamsList']?[index]['qty'] = int.parse(
                                    boxList['beamsList']?[index]['qty']
                                            .toString() ??
                                        '0') -
                                1;

                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);

                            if (int.parse(boxList['beamsList']?[index]['qty']
                                        .toString() ??
                                    '0') ==
                                0) {
                              cartList.removeAt(index);
                              log(cartList.toString());
                            }
                          }
                        });
                      },
                      addTap: () {
                        if (cartList.contains(boxList['beamsList']?[index])) {
                          setState(() {
                            boxList['beamsList']?[index]['qty'] = int.parse(
                                    boxList['beamsList']?[index]['qty']
                                            .toString() ??
                                        '0') +
                                1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                        if (!cartList.contains(boxList['beamsList']?[index])) {
                          cartList.add(boxList['beamsList']?[index]);
                          setState(() {
                            boxList['beamsList']?[index]['qty'] = int.parse(
                                    boxList['beamsList']?[index]['qty']
                                            .toString() ??
                                        "0") +
                                1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                      },
                      itemName:
                          boxList['beamsList']?[index]['item'].toString() ??
                              " ",
                      qty: int.parse(
                          boxList['beamsList']?[index]['qty'].toString() ??
                              '0'),
                      size: boxList['beamsList']?[index]['size'].toString() ??
                          ""),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.014,
                  )
                ],
              );
            },
          ),
        if (components == true)
          ListView.builder(
            itemCount: boxList['componentsList']?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ItemCard(
                      removeTap: () {
                        setState(() {
                          if (int.parse(boxList['componentsList']?[index]['qty']
                                      .toString() ??
                                  " ") >
                              0) {
                            boxList['componentsList']?[index]['qty'] =
                                int.parse(boxList['componentsList']?[index]
                                                ['qty']
                                            .toString() ??
                                        "0") -
                                    1;

                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);

                            if (int.parse(boxList['componentsList']?[index]
                                            ['qty']
                                        .toString() ??
                                    " ") ==
                                0) {
                              cartList.removeAt(index);
                              log(cartList.toString());
                            }
                          }
                        });
                      },
                      addTap: () {
                        if (cartList
                            .contains(boxList['componentsList']?[index])) {
                          setState(() {
                            boxList['componentsList']?[index]['qty'] =
                                int.parse(boxList['componentsList']?[index]
                                                ['qty']
                                            .toString() ??
                                        "0") +
                                    1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                        if (!cartList
                            .contains(boxList['componentsList']?[index])) {
                          cartList.add(boxList['componentsList']?[index]);
                          setState(() {
                            boxList['componentsList']?[index]['qty'] =
                                int.parse(boxList['componentsList']?[index]
                                                ['qty']
                                            .toString() ??
                                        "0") +
                                    1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                      },
                      itemName: boxList['componentsList']?[index]['item']
                              .toString() ??
                          " ",
                      qty: int.parse(
                          boxList['componentsList']?[index]['qty'].toString() ??
                              '0'),
                      size: boxList['componentsList']?[index]['size']
                              .toString() ??
                          ''),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.014,
                  )
                ],
              );
            },
          ),
      ],
    );
  }

  Widget _goalHead() {
    return Column(
      children: [
        if (cont != true)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.090,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ChoiceChip(
                  label: Text(
                    itemList[0],
                    style: TextStyle(
                        color: pillars == true ? Colors.white : Colors.black),
                  ),
                  selected: pillars,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                      pillars = value;
                      components = false;
                      beams = false;
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemList[1],
                    style: TextStyle(
                        color: beams == true ? Colors.white : Colors.black),
                  ),
                  selected: beams,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                      beams = value;
                      pillars = false;
                      components = false;
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                ChoiceChip(
                  label: Text(
                    itemList[2],
                    style: TextStyle(
                        color:
                            components == true ? Colors.white : Colors.black),
                  ),
                  selected: components,
                  disabledColor: Colors.grey[100],
                  selectedColor: const Color(0xFF0c039e),
                  onSelected: (value) {
                    setState(() {
                      beams = false;
                      pillars = false;
                      components = value;
                    });
                  },
                ),
              ],
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.010,
        ),
        if (cont != true)
          if (pillars == true)
            ListView.builder(
              itemCount: myGoalList['pillarList']?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ItemCard(
                        removeTap: () {
                          setState(() {
                            if (int.parse(myGoalList['pillarList']?[index]['qty']
                                        .toString() ??
                                    '0') >
                                0) {
                              myGoalList['pillarList']?[index]['qty'] = int.parse(
                                      myGoalList['pillarList']?[index]['qty']
                                              .toString() ??
                                          '0') -
                                  1;

                              // totalAmount = cartList
                              //     .map((item) =>
                              //         item['price'] * item['qty'])
                              //     .reduce((item1, item2) =>
                              //         item1 + item2);

                              if (int.parse(myGoalList['pillarList']?[index]
                                              ['qty']
                                          .toString() ??
                                      '0') ==
                                  0) {
                                cartList.removeAt(index);
                                log(cartList.toString());
                              }
                            }
                          });
                        },
                        addTap: () {
                          if (cartList
                              .contains(myGoalList['pillarList']?[index])) {
                            setState(() {
                              myGoalList['pillarList']?[index]['qty'] = int.parse(
                                      myGoalList['pillarList']?[index]['qty']
                                              .toString() ??
                                          '0') +
                                  1;
                            });
                            // setState(() {
                            //   totalAmount = cartList
                            //       .map((item) =>
                            //           item['price'] * item['qty'])
                            //       .reduce((item1, item2) =>
                            //           item1 + item2);
                            // });
                          }
                          if (!cartList
                              .contains(myGoalList['pillarList']?[index])) {
                            cartList.add(myGoalList['pillarList']?[index]);
                            setState(() {
                              myGoalList['pillarList']?[index]['qty'] = int.parse(
                                      myGoalList['pillarList']?[index]['qty']
                                              .toString() ??
                                          '0') +
                                  1;
                            });
                            // setState(() {
                            //   totalAmount = cartList
                            //       .map((item) =>
                            //           item['price'] * item['qty'])
                            //       .reduce((item1, item2) =>
                            //           item1 + item2);
                            // });
                          }
                        },
                        itemName:
                            myGoalList['pillarList']?[index]['item'].toString() ??
                                '',
                        qty: int.parse(
                            myGoalList['pillarList']?[index]['qty'].toString() ??
                                '0'),
                        size:
                            myGoalList['pillarList']?[index]['size'].toString() ??
                                ''),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.014,
                    )
                  ],
                );
              },
            ),
        if (beams == true)
          ListView.builder(
            itemCount: myGoalList['beamsList']?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ItemCard(
                      removeTap: () {
                        setState(() {
                          if (int.parse(myGoalList['beamsList']?[index]['qty']
                                      .toString() ??
                                  '0') >
                              0) {
                            myGoalList['beamsList']?[index]['qty'] = int.parse(
                                    myGoalList['beamsList']?[index]['qty']
                                            .toString() ??
                                        '0') -
                                1;

                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);

                            if (int.parse(myGoalList['beamsList']?[index]['qty']
                                        .toString() ??
                                    '0') ==
                                0) {
                              cartList.removeAt(index);
                              log(cartList.toString());
                            }
                          }
                        });
                      },
                      addTap: () {
                        if (cartList.contains(myGoalList['beamsList']?[index])) {
                          setState(() {
                            myGoalList['beamsList']?[index]['qty'] = int.parse(
                                    myGoalList['beamsList']?[index]['qty']
                                            .toString() ??
                                        '0') +
                                1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                        if (!cartList.contains(myGoalList['beamsList']?[index])) {
                          cartList.add(myGoalList['beamsList']?[index]);
                          setState(() {
                            myGoalList['beamsList']?[index]['qty'] = int.parse(
                                    myGoalList['beamsList']?[index]['qty']
                                            .toString() ??
                                        "0") +
                                1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                      },
                      itemName:
                          myGoalList['beamsList']?[index]['item'].toString() ??
                              " ",
                      qty: int.parse(
                          myGoalList['beamsList']?[index]['qty'].toString() ??
                              '0'),
                      size: myGoalList['beamsList']?[index]['size'].toString() ??
                          ""),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.014,
                  )
                ],
              );
            },
          ),
        if (components == true)
          ListView.builder(
            itemCount: myGoalList['componentsList']?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ItemCard(
                      removeTap: () {
                        setState(() {
                          if (int.parse(myGoalList['componentsList']?[index]
                                          ['qty']
                                      .toString() ??
                                  " ") >
                              0) {
                            myGoalList['componentsList']?[index]['qty'] =
                                int.parse(myGoalList['componentsList']?[index]
                                                ['qty']
                                            .toString() ??
                                        "0") -
                                    1;

                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);

                            if (int.parse(myGoalList['componentsList']?[index]
                                            ['qty']
                                        .toString() ??
                                    " ") ==
                                0) {
                              cartList.removeAt(index);
                              log(cartList.toString());
                            }
                          }
                        });
                      },
                      addTap: () {
                        if (cartList
                            .contains(myGoalList['componentsList']?[index])) {
                          setState(() {
                            myGoalList['componentsList']?[index]['qty'] =
                                int.parse(myGoalList['componentsList']?[index]
                                                ['qty']
                                            .toString() ??
                                        "0") +
                                    1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                        if (!cartList
                            .contains(myGoalList['componentsList']?[index])) {
                          cartList.add(myGoalList['componentsList']?[index]);
                          setState(() {
                            myGoalList['componentsList']?[index]['qty'] =
                                int.parse(myGoalList['componentsList']?[index]
                                                ['qty']
                                            .toString() ??
                                        "0") +
                                    1;
                          });
                          setState(() {
                            totalAmount = cartList
                                .map((item) => item['price'] * item['qty'])
                                .reduce((item1, item2) => item1 + item2);
                          });
                        }
                      },
                      itemName: myGoalList['componentsList']?[index]['item']
                              .toString() ??
                          " ",
                      qty: int.parse(myGoalList['componentsList']?[index]['qty']
                              .toString() ??
                          '0'),
                      size: myGoalList['componentsList']?[index]['size']
                              .toString() ??
                          ''),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.014,
                  )
                ],
              );
            },
          ),
      ],
    );
  }

  Widget _goalWidget() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: goalPillarText,
            onChanged: (value) {
          

           
// reset values 
    emptyGoalPillar();
    pillarTotalCost = 0;


// 72 = 72/10 =.toInt = 7 and module will give 2     
  
var moudleFig = int.parse(goalPillarText.text) % 10 ;


    setState(() {
      var quantity = (int.parse(goalPillarText.text)/10).toInt();
      int cost = pillarPriceList['10']; // 

                    myGoalList['pillarList']?[0]['qty'] = quantity;
                    pillarTotalCost = pillarTotalCost + (quantity * cost );
                  });



 if(moudleFig == 0){
 

   var cost = variant_400_400['10'];
    setState(() {
                    myGoalList['pillarList']?[0]['qty'] = (int.parse(goalPillarText.text)/10).toInt();
                  });
}else if(moudleFig == 8){


    setState(() {
      int cost = pillarPriceList['4'];
                    myGoalList['pillarList']?[3]['qty'] = 2;
                     pillarTotalCost = pillarTotalCost + (2 * cost );
                  });
}else if(moudleFig == 7){


    setState(() {
                    myGoalList['pillarList']?[2]['qty'] = 1;
                    myGoalList['pillarList']?[4]['qty'] = 1;
                  });
}
else if(moudleFig == 6){
    setState(() {
                    myGoalList['pillarList']?[1]['qty'] = 1;
                  });
}
else if(moudleFig == 5){
    setState(() {
                    myGoalList['pillarList']?[2]['qty'] = 1;
                  });
}
else if(moudleFig == 4){
    setState(() {
                    myGoalList['pillarList']?[3]['qty'] = 1;
                  });
}
else if(moudleFig == 3){
    setState(() {
                    myGoalList['pillarList']?[4]['qty'] = 1;
                     myGoalList['pillarList']?[5]['qty'] = 1;
                  });
}
else if(moudleFig == 2){
    setState(() {
                    myGoalList['pillarList']?[4]['qty'] = 1;
                  });
}
else if(moudleFig == 1){
    setState(() {
                    myGoalList['pillarList']?[5]['qty'] = 1;
                  });
}
else{
  print('value of moduleFig ${moudleFig} ${(int.parse(goalPillarText.text)/10).toInt()}');

    setState(() {
                    myGoalList['pillarList']?[0]['qty'] = (int.parse(goalPillarText.text)/10).toInt();
                  });
}
            
         
            },
            decoration: InputDecoration(
                          isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
            ),
          ),
        ),
          SizedBox(
          width: MediaQuery.of(context).size.width * 0.010,
        ),
          Text(
                        "X",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.020),
                      ),
                       SizedBox(
          width: MediaQuery.of(context).size.width * 0.010,
        ),
        Expanded(
          child: TextFormField(
            controller: goalBeamText,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              
           

    emptyGoalBeam();
      beamTotalCost = 0;
      setState(() {
                    myGoalList['beamsList']?[0]['qty'] = (int.parse(goalBeamText.text)/10).toInt();
                  });
var moudleFig = int.parse(goalBeamText.text) % 10 ;
if(moudleFig == 0){
 

    setState(() {
                    myGoalList['beamsList']?[0]['qty'] = (int.parse(goalBeamText.text)/10).toInt();
                  });
}else if(moudleFig == 8){


    setState(() {
                    myGoalList['beamsList']?[3]['qty'] = 2;
                  });
}else if(moudleFig == 7){


    setState(() {
                    myGoalList['beamsList']?[2]['qty'] = 1;
                    myGoalList['beamsList']?[4]['qty'] = 1;
                  });
}
else if(moudleFig == 6){
    setState(() {
                    myGoalList['beamsList']?[1]['qty'] = 1;
                  });
}
else if(moudleFig == 5){
    setState(() {
                    myGoalList['beamsList']?[2]['qty'] = 1;
                  });
}
else if(moudleFig == 4){
    setState(() {
                    myGoalList['beamsList']?[3]['qty'] = 1;
                  });
}
else if(moudleFig == 3){
    setState(() {
                    myGoalList['beamsList']?[4]['qty'] = 1;
                     myGoalList['beamsList']?[5]['qty'] = 1;
                  });
}
else if(moudleFig == 2){
    setState(() {
                    myGoalList['beamsList']?[4]['qty'] = 1;
                  });
}
else if(moudleFig == 1){
    setState(() {
                    myGoalList['beamsList']?[5]['qty'] = 1;
                  });
}
else{
  print('value of moduleFig ${moudleFig} ${(int.parse(goalBeamText.text)/10).toInt()}');

    setState(() {
                    myGoalList['beamsList']?[0]['qty'] = (int.parse(goalBeamText.text)/10).toInt();
                  });
}
             
            },
            decoration: InputDecoration(

                            isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _boxWidget() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: boxPillarText,
            
            onChanged: (value) {
              if (cartList.contains(boxList['pillarList']?[0])) {
                if (boxPillarText.text == '') {
                  setState(() {
                    boxList['pillarList']?[0]['qty'] = 0;
                  });
                }
                setState(() {
                  boxList['pillarList']?[0]['qty'] =
                      int.parse(boxPillarText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }

              if (!cartList.contains(boxList['pillarList']?[0])) {
                cartList.add(boxList['pillarList']?[0]);
                setState(() {
                  boxList['pillarList']?[0]['qty'] =
                      int.parse(boxPillarText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }
            },
            decoration: InputDecoration(
              // contentPadding: const EdgeInsets.only(left: 5.0, top: 5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
              isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
          ),
        ),
         SizedBox(
          width: MediaQuery.of(context).size.width * 0.010,
        ),
          Text(
                        "X",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.020),
                      ),
                       SizedBox(
          width: MediaQuery.of(context).size.width * 0.010,
        ),
        Expanded(
          child: TextFormField(
            controller: boxBeam1Text,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (cartList.contains(boxList['beamsList']?[0])) {
                if (boxBeam1Text.text == '') {
                  setState(() {
                    boxList['beamsList']?[0]['qty'] = 0;
                  });
                }
                setState(() {
                  boxList['beamsList']?[0]['qty'] =
                      2 * int.parse(boxBeam1Text.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }

              if (!cartList.contains(boxList['beamsList']?[0])) {
                cartList.add(boxList['beamsList']?[0]);
                setState(() {
                  boxList['beamsList']?[0]['qty'] =
                      2 * int.parse(boxBeam1Text.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }
            },
            decoration: InputDecoration(
       
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
                         isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.010,
        ),
          Text(
                        "X",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.020),
                      ),
                       SizedBox(
          width: MediaQuery.of(context).size.width * 0.010,
        ),
        Expanded(
          child: TextFormField(
            controller: boxBeam2Text,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (cartList.contains(boxList['beamsList']?[0])) {
                if (boxBeam2Text.text == '') {
                  setState(() {
                    boxList['beamsList']?[0]['qty'] = 0;
                  });
                }
                setState(() {
                  boxList['beamsList']?[0]['qty'] =
                      2 * int.parse(boxBeam2Text.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }

              if (!cartList.contains(boxList['beamsList']?[0])) {
                cartList.add(boxList['beamsList']?[0]);
                setState(() {
                  boxList['beamsList']?[0]['qty'] =
                      2 * int.parse(boxBeam2Text.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }
            },
            decoration: InputDecoration(
     
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              filled: true,
                         isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
          ),
        ),
      ],
    );
  }
}
