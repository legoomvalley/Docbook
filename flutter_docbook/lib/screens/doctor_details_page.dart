import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/review_list.dart';
import 'package:flutter_docbook/models/datetime_converter.dart';
import 'package:flutter_docbook/providers/dio_provider.dart';
import 'package:flutter_docbook/screens/patient_make_appointment_page.dart';
import 'package:flutter_docbook/screens/review_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../components/doctor_home_list_card.dart';
import '../utils/config.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails({Key? key, this.doctor}) : super(key: key);

  final Map? doctor;
  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  late String token;
  List<dynamic> comments = [];
  Future<void> getComments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    final data = await DioProvider()
        .getCommentsForDoctor(widget.doctor?['doc_id'], token);
    final decodeData = json.decode(data);
    setState(() {
      comments = decodeData.length == 0 ? ['no data'] : decodeData;
    });

    // print(comments[0]);
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get argument passed from doctor card
    // final doctor = ModalRoute.of(context)!.settings.arguments;
    print(widget.doctor);
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              expandedHeight: 80,
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
                                    Container(
                                      width: 250,
                                      child: Text(
                                        'Dr ${widget.doctor?['doctor_name']}',
                                        // overflow: TextOverflow.clip,
                                        style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${widget.doctor?['specialization_name']}',
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
                                      'Experience year : ${widget.doctor?['experience_year']}',
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
                                  vertical: 30, horizontal: 10),
                              width: double.infinity,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(249, 249, 255, 1),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                              color: Color.fromRGBO(
                                                  168, 168, 168, 1),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      width: 70,
                                      child: VerticalDivider(
                                        color:
                                            Color.fromARGB(255, 218, 218, 228),
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
                                          'Patients',
                                          style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  168, 168, 168, 1),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      width: 70,
                                      child: VerticalDivider(
                                        color:
                                            Color.fromARGB(255, 218, 218, 228),
                                        thickness: 1,
                                      ),
                                    ),
                                    Container(
                                      child: Column(children: [
                                        Text(
                                          widget.doctor?['status'],
                                          style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Status',
                                          style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  168, 168, 168, 1),
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
                                  widget.doctor?['bio_data'],
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
                                    comments.length < 4
                                        ? SizedBox()
                                        : Material(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReviewListPage(
                                                            comments: comments),
                                                  ),
                                                );
                                                //                           //   Navigator.of(context).pushNamed(
                                                //     "review_list",
                                                //   );
                                              },
                                              child: Text(
                                                'see all',
                                                style: GoogleFonts.rubik(
                                                  textStyle: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                comments.isEmpty
                                    ? const Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          SizedBox(height: 30),
                                        ],
                                      )
                                    : comments[0] == 'no data'
                                        ? Container(
                                            child: Text(
                                              'this doctor dont have review',
                                              style: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      168, 168, 168, 1),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: List.generate(3, (index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    ReviewList(
                                                      patientName:
                                                          "${comments[index]['patientName']}",
                                                      date: DateConverter
                                                          .formatDate(comments[
                                                                  index]
                                                              ['created_at']),
                                                      comment: comments[index]
                                                          ['comment'],
                                                      padding: EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          bottom: 20),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20),
                                                      border: Border.all(
                                                        color: Color.fromRGBO(
                                                            228, 228, 228, 1),
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                Button(
                                    margin: EdgeInsets.only(
                                        bottom: 120,
                                        top: comments.isEmpty ||
                                                comments[0] == 'no data'
                                            ? 120
                                            : 0),
                                    padding: EdgeInsets.symmetric(vertical: 13),
                                    width: double.infinity,
                                    title: "Book Now!",
                                    disable: false,
                                    color: Colors.white,
                                    backgroundColor: Config.primaryColor,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PatientMakeAppointment(
                                                  doctor: widget.doctor),
                                        ),
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
