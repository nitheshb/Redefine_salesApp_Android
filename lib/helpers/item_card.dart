import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {super.key,
      required this.itemName,
      required this.addTap,
      required this.removeTap,
      required this.qty,
      required this.size});

  final String itemName;
  void Function()? addTap;
  void Function()? removeTap;
  final String size;
  final int qty;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        elevation: 3,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.020,
              vertical: MediaQuery.of(context).size.height * 0.010),
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      // const TextSpan(
                      //   text: 'Name : ',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w700, color: Colors.black),
                      // ),
                      TextSpan(
                        text: itemName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF50555C)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Size : ',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    TextSpan(
                      text: size,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF50555C)),
                    ),
                  ],
                )),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: addTap,
              child: CircleAvatar(
                  backgroundColor: Color(0xFF0c039e),
                  maxRadius: MediaQuery.of(context).size.height * 0.016,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              qty.toString(),
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            InkWell(
              onTap: removeTap,
              child: CircleAvatar(
                  backgroundColor: Colors.red[300],
                  maxRadius: MediaQuery.of(context).size.height * 0.016,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  )),
            )
          ]),
        ));
  }
}
