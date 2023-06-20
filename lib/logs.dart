// import 'package:call_log/call_log.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CallLogs extends StatefulWidget {
//   CallLogs({Key? key, this.n}) : super(key: key);
//   var n;
//   @override
//   State<CallLogs> createState() => _CallLogsState(n: n);
// }

// class _CallLogsState extends State<CallLogs> {
//   _CallLogsState({Key? key, this.n});
//   String? n;
//   Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

//   @override
//   Widget build(BuildContext context) {
//     const TextStyle mono = TextStyle(fontFamily: 'monospace');
//     final List<Widget> children = <Widget>[];

//     for (CallLogEntry entry in _callLogEntries) {
//       int? a = entry.timestamp;

//       int day = DateTime.fromMillisecondsSinceEpoch(a!).day;
//       int month = DateTime.fromMillisecondsSinceEpoch(a).month;
//       int year = DateTime.fromMillisecondsSinceEpoch(a).year;
//       // print(DateTime.now());
//       String ic = entry.callType.toString();
//       if (day == DateTime.now().day &&
//           month == DateTime.now().month &&
//           year == DateTime.now().year) {
//         String x = entry.number.toString();
//         print("$x qwertyu");
//         String x1 = "+91" + n!;
//         print("$x and $x1 + ${x1 == x}");
//         if (x1 == x) {
//           print(entry.number.toString() + "dff");
//           FirebaseFirestore.instance
//               .collection('spark_leads_log')
//               .doc(n.toString())
//               .collection(entry.timestamp.toString())
//               .doc("logs")
//               .set({
//             "time": DateTime.fromMillisecondsSinceEpoch(a).toString(),
//             "type": entry.callType.toString(),
//             "duration": entry.duration
//           });
//         }
//         children.add(
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Material(
//               elevation: 10,
//               borderRadius: BorderRadius.circular(10),
//               child: SizedBox(
//                 height: 120,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: <Widget>[
//                       const Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Row(children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     height: 20,
//                                     width: 20,
//                                     decoration: BoxDecoration(
//                                         color: Colors.greenAccent,
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: SizedBox(
//                                         height: 0,
//                                         width: 10,
//                                         child: ic == "CallType.incoming"
//                                             ? const Icon(
//                                                 Icons.call_received,
//                                                 color: Colors.white,
//                                                 size: 15,
//                                               )
//                                             : ic == "CallType.missed"
//                                                 ? const Icon(
//                                                     Icons.call_missed,
//                                                     color: Colors.white,
//                                                     size: 15,
//                                                   )
//                                                 : const Icon(
//                                                     Icons.call_made,
//                                                     color: Colors.white,
//                                                     size: 15,
//                                                   )),
//                                   ),
//                                 ),
//                               ]),
//                               Column(
//                                 // mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   SizedBox(
//                                       height: 20,
//                                       // width: ,
//                                       child: Text(
//                                         entry.name != null
//                                             ? "${entry.name}"
//                                             : "No name",
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       )),
//                                   SizedBox(
//                                     height: 20,
//                                     // width: ,
//                                     child: Text("${entry.callType}" ==
//                                             "CallType.incoming"
//                                         ? "Incoming"
//                                         : "${entry.callType}" ==
//                                                 "CallType.outgoing"
//                                             ? "Outgoing"
//                                             : "Missed"),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 28.0),
//                             child: Text(
//                               "Duration: ${entry.duration} S",
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w600),
//                             ),
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 35.0, top: 10),
//                             child: RichText(
//                               text: TextSpan(
//                                   style: const TextStyle(
//                                       fontSize: 12.0, color: Colors.black),
//                                   children: <TextSpan>[
//                                     const TextSpan(
//                                         text: 'Date: ',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500)),
//                                     TextSpan(text: "$day-$month-$year")
//                                   ]),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 35.0, top: 10),
//                             child: RichText(
//                               text: TextSpan(
//                                   style: const TextStyle(
//                                       fontSize: 12.0, color: Colors.black),
//                                   children: <TextSpan>[
//                                     const TextSpan(
//                                         text: 'Time: ',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500)),
//                                     TextSpan(
//                                         text:
//                                             "${DateTime.fromMillisecondsSinceEpoch(a).hour}H: ${DateTime.fromMillisecondsSinceEpoch(a).minute}M")
//                                   ]),
//                             ),
//                           )
//                         ],
//                       ),
//                       // Text('F. NUMBER  : ${entry.formattedNumber}', style: mono),
//                       // Text('C.M. NUMBER: ${entry.cachedMatchedNumber}',
//                       // style: mono),
//                     ],
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Call Logs"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () async {},
//                   child: const Text('Today'),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(children: children),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CallLogs extends StatefulWidget {
  CallLogs({Key? key, this.n, this.num}) : super(key: key);
  var n;
  var num;
  @override
  State<CallLogs> createState() => _CallLogsState(n: n, num: num);
}

class _CallLogsState extends State<CallLogs> {
  _CallLogsState({this.n, this.num});
  var n;
  var num;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('spark_leads_log')
                      .doc("$n")
                      .collection("logs")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      print(snapshot.data.toString());
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        var x = DateTime.fromMicrosecondsSinceEpoch(
                            int.parse(document['time']) * 1000);
                        // if(document.id == nid)
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                "${x.day.toString()}-${x.month.toString()}-${x.year.toString()}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            children: <TextSpan>[
                                              const TextSpan(text: "  "),
                                              TextSpan(
                                                  text:
                                                      "${document['duration']}s"
                                                          .toString()
                                                          .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Text(
                                            document['subtype'] ==
                                                    "CallType.outgoing"
                                                ? "OutGoing"
                                                : document['subtype'] ==
                                                        "CallType.incoming"
                                                    ? "Incoming"
                                                    : "Missed",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    ),
                                    Text(
                                      document['by'].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Note: ${document["notes"]}"),
                                      ],
                                    )
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
      ),
    );
  }
}
