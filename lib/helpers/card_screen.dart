import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatelessWidget {
  CardScreen(
      {super.key,
      required this.boxColor,
      required this.contColor,
      required this.goalColor,
      required this.onBoxTap,
      required this.ongoalTap,
      required this.onContTap,
      required this.name1,
      required this.name2,
      required this.name3});
  String name1;
  String name2;
  String name3;
  Color boxColor;
  Color goalColor;
  Color contColor;
  void Function()? onBoxTap;
  void Function()? ongoalTap;
  void Function()? onContTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.0450,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              PhysicalModel(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                elevation: 3,
                child: InkWell(
                  onTap: onBoxTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.020,
                        vertical: MediaQuery.of(context).size.height * 0.010),
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: boxColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name1,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              PhysicalModel(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                elevation: 3,
                child: InkWell(
                  onTap: ongoalTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.020,
                        vertical: MediaQuery.of(context).size.height * 0.010),
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: goalColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name2,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              PhysicalModel(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                elevation: 3,
                child: InkWell(
                  onTap: onContTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.020,
                        vertical: MediaQuery.of(context).size.height * 0.010),
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: contColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name3,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
