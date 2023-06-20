import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../logs.dart';

class Leadpage extends StatefulWidget {
  Leadpage({Key? key, this.n, this.num}) : super(key: key);
  var n;
  var num;
  @override
  State<Leadpage> createState() => _LeadpageState(n: n);
}

var name;
var phone;
var email;
var status;
var project;
TextEditingController mycontroller = TextEditingController();
String value = "";

class _LeadpageState extends State<Leadpage> {
  _LeadpageState({this.n});
  var n;
  var num;
  @override
  void initState() {
    print(n);
    FirebaseFirestore.instance
        .collection('spark_leads')
        .doc("$n")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      name = documentSnapshot['Name'];
      phone = documentSnapshot['Mobile'];
      email = documentSnapshot['Email'];
      status = documentSnapshot['Status'];
      project = documentSnapshot['Project'];
      setState(() {});
    });
    super.initState();
  }

  var num1;
  Widget? Button(bname, num) {
    return GestureDetector(
      onTap: () {
        num1 = num;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
                height: 30, width: 100, child: Center(child: Text(bname)))),
      ),
    );
  }

  Widget? Notes() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(children: [
              const Text("Notes"),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: 220,
                  height: 30,
                  child: Center(
                    child: TextField(
                      controller: mycontroller,
                      onChanged: (text) {
                        value = text;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Add Notes',
                          hintText: 'Enter Notes'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('spark_leads')
                        .doc("$n")
                        .collection("Notes")
                        .doc()
                        .set({
                      // .update({
                      // "${entry.timestamp.toString()}": {
                      "note": mycontroller.text
                      // }
                    });
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 10,
                    child: Container(
                      width: 220,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF82d9e3), Color(0xFFa5e7cc)])),
                      child: const Center(child: Text("Add")),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('spark_leads')
                    .doc("$n")
                    .collection("Notes")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                            elevation: 30,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text("${document['note']}")],
                              ),
                            )),
                      );
                    }).toList(),
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  var xdone;
  Widget? Scheduler() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Schedule"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _chosenday,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
                          '31'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Day",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _chosenday = value!;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _chosenmonth,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Month",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _chosenmonth = value!;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _chosenyear,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>['2022', '2023']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Year",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _chosenyear = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _chosenhour,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Hour",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _chosenhour = value!;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        focusColor: Colors.white,
                        value: _chosenminute,
                        //elevation: 5,
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
                          '31',
                          '32',
                          '33',
                          '34',
                          '35',
                          '36',
                          '37',
                          '38',
                          '39',
                          '40',
                          '41',
                          '42',
                          '43',
                          '44',
                          '45',
                          '46',
                          '47',
                          '48',
                          '49',
                          '50',
                          '51',
                          '52',
                          '53',
                          '54',
                          '55',
                          '56',
                          '57',
                          '58',
                          '59',
                          '60'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Minute",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _chosenminute = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('spark_leads')
                        .doc("$n")
                        .collection("Schedules")
                        .doc()
                        .set({
                      // .update({
                      // "${entry.timestamp.toString()}": {
                      "Day": "$_chosenday",
                      "Month": "$_chosenmonth",
                      "Year": "$_chosenyear",
                      "hour": _chosenhour,
                      "minute": _chosenminute
                      // }
                    });
                    xdone = 1;
                    setState(() {});
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 10,
                    child: Container(
                      width: 220,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF82d9e3), Color(0xFFa5e7cc)])),
                      child: const Center(child: Text("Add")),
                    ),
                  ),
                ),
              ),
              xdone == 1
                  ? const Text("Follow Up Scheduled Successfully")
                  : Container(),
              const Text("Follow Ups"),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('spark_leads')
                    .doc("$n")
                    .collection("Schedules")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Material(
                            elevation: 30,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${document['Day']}-${document['Month']}-${document['Year']}")
                                ],
                              ),
                            )),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? LeadStatus() {
    return Container(
      child: Column(
        children: [
          const Text("Lead Status"),
          DropdownButton<String>(
            focusColor: Colors.white,
            value: _chosenStatus,
            //elevation: 5,
            style: const TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: <String>[
              'New',
              'Follow Up',
              'Vist Fixed',
              'Visit Done',
              'Negotiation',
              'Booked',
              'RNR',
              'Not Interested'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            hint: const Text(
              "Lead Status",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                _chosenStatus = value!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('spark_leads')
                    .doc("$n")
                    .update({
                  // .update({
                  // "${entry.timestamp.toString()}": {
                  "Status": _chosenStatus
                  // }
                });
                xdone = 1;
              },
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: Container(
                  width: 220,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFF82d9e3), Color(0xFFa5e7cc)])),
                  child: const Center(child: Text("Update Status")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _chosenyear;
  String? _chosenday;
  String? _chosenmonth;
  String? _chosenhour;
  String? _chosenminute;
  String? _chosenStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[100],
        title: const Text("Lead Data"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Name".toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                        const TextSpan(text: "  "),
                                        TextSpan(
                                            text: "\n$name",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.teal[200],
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Phone",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      const TextSpan(text: "  "),
                                      TextSpan(
                                          text: "\n$phone",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.teal[200],
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Email",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                        const TextSpan(text: "  "),
                                        TextSpan(
                                            text: "\n$email".toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.teal[200],
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 243, 217, 226),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            // const TextSpan(text: "  "),
                                            Text(
                                                "$project"
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.pink[200],
                                                    fontWeight:
                                                        FontWeight.bold)))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 210, 241, 211),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Lead Status:",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.green[300],
                                                fontWeight: FontWeight.w500),
                                            children: <TextSpan>[
                                              // const TextSpan(text: "  "),
                                              TextSpan(
                                                  text: "\n$status"
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green[300],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ))),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(child: Text("Status:\n$status")),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Button("Schedules", 1)!,
                            Button("Tasks", 2)!,
                            Button("Notes", 3)!,
                          ],
                        ),
                        Column(
                          children: [
                            Button("Lead Status", 4)!,
                            Button("Logs", 5)!,
                            Button("Timeline", 6)!,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            num1 == 3
                ? Notes()!
                : num1 == 1
                    ? Scheduler()!
                    : num1 == 5
                        ? CallLogs(n: "$n", num: phone)
                        : num1 == 4
                            ? LeadStatus()!
                            : Container()
          ],
        ),
      ),
    );
  }
}
