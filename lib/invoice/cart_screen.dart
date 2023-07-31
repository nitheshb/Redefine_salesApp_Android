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
  bool pillars = true;

  bool beams = false;

  bool box = true;
  bool goal = false;
  bool cont = false;

  int totalAmount = 0;

  bool components = false;
  final cartList = [];

  final List<String> itemList = ["Pillars", "Beams", "Components"];

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
                                      color: pillars == true
                                          ? Colors.white
                                          : Colors.black),
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
                                      color: beams == true
                                          ? Colors.white
                                          : Colors.black),
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
                                      color: components == true
                                          ? Colors.white
                                          : Colors.black),
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
                            itemCount: pillarsList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ItemCard(
                                      removeTap: () {
                                        setState(() {
                                          if (int.parse(pillarsList[index]
                                                      ['qty']
                                                  .toString()) >
                                              0) {
                                            pillarsList[index]['qty'] =
                                                int.parse(pillarsList[index]
                                                            ['qty']
                                                        .toString()) -
                                                    1;

                                            totalAmount = cartList
                                                .map((item) =>
                                                    item['price'] * item['qty'])
                                                .reduce((item1, item2) =>
                                                    item1 + item2);

                                            if (int.parse(pillarsList[index]
                                                        ['qty']
                                                    .toString()) ==
                                                0) {
                                              cartList.removeAt(index);
                                              log(cartList.toString());
                                            }
                                          }
                                        });
                                      },
                                      addTap: () {
                                        if (cartList
                                            .contains(pillarsList[index])) {
                                          setState(() {
                                            pillarsList[index]['qty'] =
                                                int.parse(pillarsList[index]
                                                            ['qty']
                                                        .toString()) +
                                                    1;
                                          });
                                          setState(() {
                                            totalAmount = cartList
                                                .map((item) =>
                                                    item['price'] * item['qty'])
                                                .reduce((item1, item2) =>
                                                    item1 + item2);
                                          });
                                        }
                                        if (!cartList
                                            .contains(pillarsList[index])) {
                                          cartList.add(pillarsList[index]);
                                          setState(() {
                                            pillarsList[index]['qty'] =
                                                int.parse(pillarsList[index]
                                                            ['qty']
                                                        .toString()) +
                                                    1;
                                          });
                                          setState(() {
                                            totalAmount = cartList
                                                .map((item) =>
                                                    item['price'] * item['qty'])
                                                .reduce((item1, item2) =>
                                                    item1 + item2);
                                          });
                                        }
                                      },
                                      itemName:
                                          pillarsList[index]['item'].toString(),
                                      qty: int.parse(
                                          pillarsList[index]['qty'].toString()),
                                      size: pillarsList[index]['size']
                                          .toString()),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.030,
                                  )
                                ],
                              );
                            },
                          ),
                      if (beams == true)
                        ListView.builder(
                          itemCount: beamsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ItemCard(
                                    removeTap: () {
                                      setState(() {
                                        if (int.parse(beamsList[index]['qty']
                                                .toString()) >
                                            0) {
                                          beamsList[index]['qty'] = int.parse(
                                                  beamsList[index]['qty']
                                                      .toString()) -
                                              1;

                                          totalAmount = cartList
                                              .map((item) =>
                                                  item['price'] * item['qty'])
                                              .reduce((item1, item2) =>
                                                  item1 + item2);

                                          if (int.parse(beamsList[index]['qty']
                                                  .toString()) ==
                                              0) {
                                            cartList.removeAt(index);
                                            log(cartList.toString());
                                          }
                                        }
                                      });
                                    },
                                    addTap: () {
                                      if (cartList.contains(beamsList[index])) {
                                        setState(() {
                                          beamsList[index]['qty'] = int.parse(
                                                  beamsList[index]['qty']
                                                      .toString()) +
                                              1;
                                        });
                                        setState(() {
                                          totalAmount = cartList
                                              .map((item) =>
                                                  item['price'] * item['qty'])
                                              .reduce((item1, item2) =>
                                                  item1 + item2);
                                        });
                                      }
                                      if (!cartList
                                          .contains(beamsList[index])) {
                                        cartList.add(beamsList[index]);
                                        setState(() {
                                          beamsList[index]['qty'] = int.parse(
                                                  beamsList[index]['qty']
                                                      .toString()) +
                                              1;
                                        });
                                        setState(() {
                                          totalAmount = cartList
                                              .map((item) =>
                                                  item['price'] * item['qty'])
                                              .reduce((item1, item2) =>
                                                  item1 + item2);
                                        });
                                      }
                                    },
                                    itemName:
                                        beamsList[index]['item'].toString(),
                                    qty: int.parse(
                                        beamsList[index]['qty'].toString()),
                                    size: beamsList[index]['size'].toString()),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.030,
                                )
                              ],
                            );
                          },
                        ),
                      if (components == true)
                        ListView.builder(
                          itemCount: componentsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ItemCard(
                                    removeTap: () {
                                      setState(() {
                                        if (int.parse(componentsList[index]
                                                    ['qty']
                                                .toString()) >
                                            0) {
                                          componentsList[index]['qty'] =
                                              int.parse(componentsList[index]
                                                          ['qty']
                                                      .toString()) -
                                                  1;

                                          totalAmount = cartList
                                              .map((item) =>
                                                  item['price'] * item['qty'])
                                              .reduce((item1, item2) =>
                                                  item1 + item2);

                                          if (int.parse(componentsList[index]
                                                      ['qty']
                                                  .toString()) ==
                                              0) {
                                            cartList.removeAt(index);
                                            log(cartList.toString());
                                          }
                                        }
                                      });
                                    },
                                    addTap: () {
                                      if (cartList
                                          .contains(componentsList[index])) {
                                        setState(() {
                                          componentsList[index]['qty'] =
                                              int.parse(componentsList[index]
                                                          ['qty']
                                                      .toString()) +
                                                  1;
                                        });
                                        setState(() {
                                          totalAmount = cartList
                                              .map((item) =>
                                                  item['price'] * item['qty'])
                                              .reduce((item1, item2) =>
                                                  item1 + item2);
                                        });
                                      }
                                      if (!cartList
                                          .contains(componentsList[index])) {
                                        cartList.add(componentsList[index]);
                                        setState(() {
                                          componentsList[index]['qty'] =
                                              int.parse(componentsList[index]
                                                          ['qty']
                                                      .toString()) +
                                                  1;
                                        });
                                        setState(() {
                                          totalAmount = cartList
                                              .map((item) =>
                                                  item['price'] * item['qty'])
                                              .reduce((item1, item2) =>
                                                  item1 + item2);
                                        });
                                      }
                                    },
                                    itemName: componentsList[index]['item']
                                        .toString(),
                                    qty: int.parse(componentsList[index]['qty']
                                        .toString()),
                                    size: componentsList[index]['size']
                                        .toString()),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.030,
                                )
                              ],
                            );
                          },
                        ),
                    ],
                  )),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.020,
                    horizontal: MediaQuery.of(context).size.width * 0.020),
                height: MediaQuery.of(context).size.height * 0.27,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.blueGrey)
                    ]),
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
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
                          Center(
                            child: IconButton(
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
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Text(
                        "Price Range",
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
                      CardScreen(
                        boxColor: box == true
                            ? const Color(0xFF0c039e)
                            : Colors.white,
                        contColor: cont == true
                            ? const Color(0xFF0c039e)
                            : Colors.white,
                        goalColor: goal == true
                            ? const Color(0xFF0c039e)
                            : Colors.white,
                        onBoxTap: () {
                          setState(() {
                            box = true;
                            cont = false;
                            goal = false;
                          });
                        },
                        onContTap: () {
                          setState(() {
                            box = false;
                            cont = true;
                            goal = false;
                          });
                        },
                        ongoalTap: () {
                          setState(() {
                            box = false;
                            cont = false;
                            goal = true;
                          });
                        },
                        name1: 'Box',
                        name2: 'Goal',
                        name3: 'Scaffolding',
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

  Widget _goalWidget() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: goalPillarText,
            onChanged: (value) {
              if (cartList.contains(pillarsList[0])) {
                if (goalPillarText.text == '') {
                  setState(() {
                    pillarsList[0]['qty'] = 0;
                  });
                }
                setState(() {
                  pillarsList[0]['qty'] = 2 * int.parse(goalPillarText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }

              if (!cartList.contains(pillarsList[0])) {
                cartList.add(pillarsList[0]);
                setState(() {
                  pillarsList[0]['qty'] = 2 * int.parse(goalPillarText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5.0, top: 5.0),
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
          width: MediaQuery.of(context).size.width * 0.020,
        ),
        Expanded(
          child: TextFormField(
            controller: goalBeamText,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (cartList.contains(beamsList[0])) {
                if (goalBeamText.text == '') {
                  setState(() {
                    beamsList[0]['qty'] = 0;
                  });
                }
                setState(() {
                  beamsList[0]['qty'] = int.parse(goalBeamText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }

              if (!cartList.contains(beamsList[0])) {
                cartList.add(beamsList[0]);
                setState(() {
                  beamsList[0]['qty'] = int.parse(goalBeamText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5.0, top: 5.0),
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
            controller: goalPillarText,
            onChanged: (value) {
              if (cartList.contains(pillarsList[0])) {
                if (goalPillarText.text == '') {
                  setState(() {
                    pillarsList[0]['qty'] = 0;
                  });
                }
                setState(() {
                  pillarsList[0]['qty'] = int.parse(goalPillarText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }

              if (!cartList.contains(pillarsList[0])) {
                cartList.add(pillarsList[0]);
                setState(() {
                  pillarsList[0]['qty'] = int.parse(goalPillarText.text);
                });
                setState(() {
                  totalAmount = cartList
                      .map((item) => item['price'] * item['qty'])
                      .reduce((item1, item2) => item1 + item2);
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5.0, top: 5.0),
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
          width: MediaQuery.of(context).size.width * 0.020,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5.0, top: 5.0),
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
          width: MediaQuery.of(context).size.width * 0.020,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5.0, top: 5.0),
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
}
