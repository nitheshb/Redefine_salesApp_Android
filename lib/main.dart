import 'package:call_log/call_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:redefine_sales_app/auth/authenticate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lead_data/leadpage.dart';
// import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ERP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Authenticate(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  TextEditingController textEditingController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<int> _counter;
  Future<int>? _mobile;
  Future<int>? _docu;

  // Future<void> _incrementCounter(num) async {
  //   final SharedPreferences prefs = await _prefs;
  //   final int mobile = num;

  //   setState(() {
  //     _mobile = prefs.setInt('mobile', mobile).then((bool success) {
  //       return mobile;
  //     });
  //   });
  // }
  addStringToSF(number, id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', number);
    prefs.setString('id', id);
  }

  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

  @override
  void initState() {
    print("hello");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getStringValuesSF();
  }

  var status;
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    DateTime now = DateTime.now();
    if (isBackground && status == null) {
      // TextPreferences.setText(controller.text);
      print("bga------------------------");
    } else {
      setState(() {
        getStringValuesSF();
      });
    }
  }

  var x;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('stringValue');
    String? id = prefs.getString("id");
    print(stringValue);
    x = stringValue;
    test(x, id);
  }

  // String aa = getStringValuesSF().toString();
  void test(n, id) async {
    final Iterable<CallLogEntry> result = await CallLog.query();
    setState(() {
      _callLogEntries = result;
    });
    for (CallLogEntry entry in _callLogEntries) {
      int? a = entry.timestamp;
      int day = DateTime.fromMillisecondsSinceEpoch(a!).day;
      int month = DateTime.fromMillisecondsSinceEpoch(a).month;
      int year = DateTime.fromMillisecondsSinceEpoch(a).year;
      // print(DateTime.now());

      String ic = entry.callType.toString();
      if (day == DateTime.now().day &&
          month == DateTime.now().month &&
          year == DateTime.now().year) {
        String x = entry.number.toString();
        if (entry.number.toString() == n) {
          print(true);
          print(id);
          FirebaseFirestore.instance
              .collection('spark_leads_log')
              .doc(id)
              .collection("logs")
              .doc(entry.timestamp.toString())
              .set({
            // .update({
            // "${entry.timestamp.toString()}": {
            "by": "Userid",
            "duration": entry.duration,
            "type": "ph",
            "notes": "Nothing to Show",
            "time": "${entry.timestamp}",
            "subtype": entry.callType.toString()
            // }
          });
          print(entry.number);

          final pref = await SharedPreferences.getInstance();
          await pref.clear();
        } else {
          print(x);
          print(false);
          print(false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF0c039e), title: const Text("Sales App")),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('spark_leads')
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
                          child: GestureDetector(
                            onTap: () {
                              _setdata(int.parse(document['Mobile']));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Leadpage(
                                            n: document.id,
                                            num: document['Mobile'],
                                          )
                                      // CallLogs(
                                      //       n: document.id,
                                      //       num: document['Mobile'],
                                      //     )
                                      ));
                            },
                            child: Material(
                                elevation: 30,
                                borderRadius: BorderRadius.circular(10),
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
                                              document['Name']
                                                  .toString()
                                                  .toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                              document['Status']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF0c039e),
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                                document['Project']
                                                    .toString()
                                                    .toUpperCase(),
                                                overflow: TextOverflow.ellipsis,
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
                                        document['Mobile'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Source: ${document['Source']}"),
                                          GestureDetector(
                                            onTap: () {
                                              addStringToSF(document['Mobile'],
                                                  document.id);
                                              _addlog();
                                              _callNumber(document['Mobile']);
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
                                                  child: Text(
                                                "Call",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
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

_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}

_addlog() {
  print("done");
  FirebaseFirestore.instance
      .collection('spark_leads_log')
      .doc("987654321")
      .collection(DateTime.now().microsecondsSinceEpoch.toString())
      .doc("logs")
      .set({"time": DateTime.now().microsecondsSinceEpoch});
}

_setdata(int n) {
  Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
  for (CallLogEntry entry in _callLogEntries) {
    if (n == entry.number) {
      print(true);
      int? a = entry.timestamp;
      FirebaseFirestore.instance
          .collection('spark_leads_log')
          .doc(n.toString())
          .collection(DateTime.fromMillisecondsSinceEpoch(a!).toString())
          .doc("logs")
          .set({
        "time": DateTime.fromMillisecondsSinceEpoch(a).toString(),
        "type": entry.callType.toString(),
        "duration": entry.duration
      });
    } else {
      print(false);
    }
  }
}
