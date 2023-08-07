import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/review_list.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/doctor_home_list_card.dart';
import '../utils/config.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              expandedHeight: 70,
              title: Text('Doctor Details'),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // image
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: FittedBox(
                                      // ignore: sort_child_properties_last
                                      child: Image(
                                        image: AssetImage('assets/user.jpg'),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // sentence
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // SizedBox(height: 5),
                                    Text(
                                      'Dr UserName',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Dr Specialist',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(168, 168, 168, 1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Dr Reviews',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(168, 168, 168, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 20,
                              ),
                              width: double.infinity,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(249, 249, 255, 1),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Row(children: [
                                Container(
                                  child: Column(children: [
                                    Text(
                                      '127',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Reviews',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(168, 168, 168, 1),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 70,
                                  child: VerticalDivider(
                                    color: Color.fromARGB(255, 218, 218, 228),
                                    thickness: 1,
                                  ),
                                ),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      '127',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Reviews',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(168, 168, 168, 1),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 70,
                                  child: VerticalDivider(
                                    color: Color.fromARGB(255, 218, 218, 228),
                                    thickness: 1,
                                  ),
                                ),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      '127',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Reviews',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(168, 168, 168, 1),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ]),
                            ),
                            SizedBox(height: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Experience',
                                  style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                  style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(168, 168, 168, 1),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Reviews',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          "review_list",
                                        );
                                      },
                                      child: Text(
                                        'see all',
                                        style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  height: 400,
                                  child: ListView.builder(
                                    primary: false,
                                    // separatorBuilder: (context, _) => SizedBox(width: 10),
                                    itemBuilder: (context, index) => ReviewList(
                                      route: 'doc_specific_appointment',
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      margin: EdgeInsets.only(bottom: 20),
                                      border: Border.all(
                                        color: Color.fromRGBO(228, 228, 228, 1),
                                        width: 1,
                                      ),
                                    ),
                                    itemCount: 3,
                                  ),
                                ),
                                Button(
                                    padding: EdgeInsets.symmetric(vertical: 13),
                                    width: double.infinity,
                                    title: "Book Now!",
                                    disable: false,
                                    color: Colors.white,
                                    backgroundColor: Config.primaryColor,
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        "doc_specific_appointment",
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(20)),
                                SizedBox(height: 20),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
