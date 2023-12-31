import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/button.dart';
import 'package:flutter_docbook/components/review_list.dart';
import 'package:flutter_docbook/components/datetime_converter.dart';
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
  List<dynamic> totalPatient = [];
  List<dynamic> totalReview = [];
  Future<void> getComments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    final data = await DioProvider()
        .getCommentsForDoctor(widget.doctor?['doc_id'], token);
    final decodeData = json.decode(data);
    setState(() {
      totalReview = decodeData['comment'];
      comments = decodeData['comment'].length == 0
          ? ['no data']
          : decodeData['comment'];
      totalPatient = decodeData['appointments'];
    });
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 25),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // image
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image(
                                        image:
                                            widget.doctor?['doctor_profile'] ==
                                                    null
                                                ? const AssetImage(
                                                    'assets/user.jpg')
                                                : NetworkImage(
                                                    'http://10.0.2.2:8000/storage/${widget.doctor?['doctor_profile']}',
                                                  ) as ImageProvider<Object>,
                                      ),
                                    ),
                                  ),
                                ),
                                // sentence
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // SizedBox(height: 5),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        'Dr ${widget.doctor?['doctor_name']}',
                                        // overflow: TextOverflow.clip,
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${widget.doctor?['specialization_name']}',
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(168, 168, 168, 1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Total Experience : ${widget.doctor?['experience_year']} year',
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
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
                            const SizedBox(height: 25),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 10),
                              width: double.infinity,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(249, 249, 255, 1),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Text(
                                        '${totalReview.length}',
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Reviews',
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                168, 168, 168, 1),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 35,
                                      width: 70,
                                      child: VerticalDivider(
                                        color:
                                            Color.fromARGB(255, 218, 218, 228),
                                        thickness: 1,
                                      ),
                                    ),
                                    Column(children: [
                                      Text(
                                        "${totalPatient.length}",
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Patients',
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                168, 168, 168, 1),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 35,
                                      width: 70,
                                      child: VerticalDivider(
                                        color:
                                            Color.fromARGB(255, 218, 218, 228),
                                        thickness: 1,
                                      ),
                                    ),
                                    Column(children: [
                                      Text(
                                        widget.doctor?['status'],
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Status',
                                        style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                168, 168, 168, 1),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ),
                            const SizedBox(height: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bio data',
                                  style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  widget.doctor?['bio_data'],
                                  style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(168, 168, 168, 1),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Reviews',
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    comments.length < 4
                                        ? const SizedBox()
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
                                                  textStyle: const TextStyle(
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
                                const SizedBox(height: 15),
                                comments.isEmpty == true
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
                                        ? Text(
                                            'this doctor dont have review',
                                            style: GoogleFonts.rubik(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    168, 168, 168, 1),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: List.generate(
                                                comments.length, (index) {
                                              return Column(
                                                children: [
                                                  ReviewList(
                                                    patientName:
                                                        "${comments[index]['patientName']}",
                                                    date: DateConverter
                                                        .formatDate(
                                                            comments[index]
                                                                ['created_at']),
                                                    comment: comments[index]
                                                        ['comment'],
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 20),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              228, 228, 228, 1),
                                                      width: 1,
                                                    ),
                                                  ),
                                                ],
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
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
                                const SizedBox(height: 20),
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
