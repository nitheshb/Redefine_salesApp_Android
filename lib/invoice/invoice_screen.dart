import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:call_log/call_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redefine_sales_app/invoice/cart_screen.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String? number;
  void callLogs() async {
    log("enterred");
    Iterable<CallLogEntry> entries = await CallLog.query();

    setState(() {
      number = entries.first.number;
    });
  }

  @override
  void initState() {
    callLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showModalBottomSheet(context);
          },
          backgroundColor: Color(0xFF0c039e),
          label: Text('Add User'),
          icon: const Icon(
            Icons.add,
            // color: Color(0xff33264b),
          ),
        ),
        appBar: AppBar(
            backgroundColor: Color(0xFF0c039e), title: const Text("Invoice")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
                Text(
                  "Customers",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.030,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('spark_leads')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        // log(snapshot.data?.docs[0].data().toString() ?? "");
                        return Column(
                          children: [
                            PhysicalModel(
                              color: Colors.blueGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              elevation: 30,
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: MediaQuery.of(context).size.height *
                                      0.130,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Text(
                                                snapshot.data
                                                        ?.docs[index]['Name']
                                                        .toString()
                                                        .toUpperCase() ??
                                                    " ",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                                snapshot.data
                                                        ?.docs[index]['Status']
                                                        .toString()
                                                        .toUpperCase() ??
                                                    " ",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF0c039e),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: Text(
                                                  snapshot
                                                          .data
                                                          ?.docs[index]
                                                              ['Project']
                                                          .toString()
                                                          .toUpperCase() ??
                                                      " ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]['Mobile'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Source: ${snapshot.data?.docs[index]['Source']}"),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CartScreen(
                                                                userDetail: snapshot
                                                                        .data
                                                                        ?.docs[
                                                                    index])));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFF0c039e),
                                                ),
                                                height: 30,
                                                width: 100,
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.010,
                            )
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(9.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 14.0,
            right: 14.0,
            top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.020,
                ),
                Text(
                  "Add A user",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'User name...'),
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              autofocus: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            Row(
              children: [
                Text(
                  "Phone number : +91 ${number ?? " "}",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: MediaQuery.of(context).size.height * 0.020),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      callLogs();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Loaction'),
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              autofocus: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF0c039e),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: MediaQuery.of(context).size.height * 0.070,
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.030,
                        ),
                        const Text(
                          "Add User",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
