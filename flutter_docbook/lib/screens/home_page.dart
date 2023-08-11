// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/doctor_home_list_card.dart';
import '../providers/dio_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// class CardItem {
//   final String urlImg;
//   final String title;
//   final String specialist;

//   const CardItem({
//     required this.urlImg,
//     required this.title,
//     required this.specialist,
//   });
// }

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  // List<CardItem> doctorCardLists = [
  //   CardItem(
  //     urlImg: 'assets/doctor.jpg',
  //     title: "doctor 1",
  //     specialist: "specialist",
  //   ),
  //   CardItem(
  //     urlImg: 'assets/doctor.jpg',
  //     title: "doctor 2",
  //     specialist: "specialist",
  //   ),
  //   CardItem(
  //     urlImg: 'assets/doctor.jpg',
  //     title: "doctor 3",
  //     specialist: "specialist",
  //   ),
  //   CardItem(
  //     urlImg: 'assets/doctor.jpg',
  //     title: "doctor 4",
  //     specialist: "specialist",
  //   ),
  // ];
  Future<void> getData() async {
    // get token from share preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      // get user data
      final response = await DioProvider().getUser(token);
      if (response != null) {
        setState(() {
          //json

          user = json.decode(response);
          print(user);
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  // this controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  // color: Config.primaryColor,
                  height: 150.0,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Config.primaryColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi UserName!',
                                style: GoogleFonts.openSans(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'Find Your Doctor',
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/user.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120),
                  width: double.infinity,
                  // color: Colors.black12,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 20.0,
                    borderRadius: BorderRadius.circular(7.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Doctor...',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 40),
                    child: Text(
                      'Doctor\'s specialization',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(children: <Widget>[
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(100.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                              child: FaIcon(FontAwesomeIcons.baby),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Pediatrics',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(123, 137, 171, 1)
                              // color: Colors.white,
                              ),
                        ),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(100.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromRGBO(250, 250, 250, 0),
                              child: FaIcon(FontAwesomeIcons.stethoscope),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'General Medicine',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(123, 137, 171, 1)
                              // color: Colors.white,
                              ),
                        ),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(100.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromRGBO(250, 250, 250, 0),
                              child: FaIcon(FontAwesomeIcons.bone),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Orthopedics',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(123, 137, 171, 1)
                              // color: Colors.white,
                              ),
                        ),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(100.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromRGBO(250, 250, 250, 0),
                              child: FaIcon(FontAwesomeIcons.eye),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Eye',
                          style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(123, 137, 171, 1)
                              // color: Colors.white,
                              ),
                        ),
                      ]),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 40),
                    child: Text(
                      'Doctors',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    // padding: EdgeInsets.all(16),
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // separatorBuilder: (context, _) => SizedBox(width: 10),
                      itemBuilder: (context, index) => DoctorHomeListCard(
                        route: 'doc_specific_appointment',
                      ),
                      itemCount: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget doctorHomeListCard({required CardItem doctorCardList}) => Container(
//       padding: EdgeInsets.only(left: 19, bottom: 25),
//       child: SizedBox(
//         child: Material(
//           elevation: 10,
//           borderRadius: BorderRadius.circular(10),
//           child: Column(
//             children: [
//               Expanded(
//                 child: AspectRatio(
//                   aspectRatio: 4 / 4,
//                   child: ClipRRect(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(10.0)),
//                     child: Image.asset(
//                       doctorCardList.urlImg,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),

//               // const SizedBox(height: 4),
//               SizedBox(height: 8),
//               Text(doctorCardList.title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   )),
//               SizedBox(height: 5),
//               Text(
//                 doctorCardList.specialist,
//                 style: TextStyle(
//                   fontSize: 12,
//                 ),
//               ),
//               SizedBox(height: 5),
//             ],
//           ),
//         ),
//       ),
//     );

// islogin boolean,
// list view
// item builder
// stream builder fetch data real time, continously upload data
// future builder for one time upload data
// connection state for
// snapshot handle data from backend
// cardview
