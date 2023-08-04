// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// class DoctorHomeListCard extends StatefulWidget {
//   const DoctorHomeListCard({
//     Key? key,
//     required this.urlImg,
//     required this.title,
//     required this.specialist,
//   });

//   @override
//   State<DoctorHomeListCard> createState() => _DoctorHomeListCardState();
//   final String urlImg;
//   final String title;
//   final String specialist;
// }

// class _DoctorHomeListCardState extends State<DoctorHomeListCard> {
//   List<DoctorHomeListCard> doctorCardLists = [
//     DoctorHomeListCard(
//       urlImg: 'assets/doctor.jpg',
//       title: "doctor 1",
//       specialist: "specialist",
//     ),
//     DoctorHomeListCard(
//       urlImg: 'assets/doctor.jpg',
//       title: "doctor 2",
//       specialist: "specialist",
//     ),
//     DoctorHomeListCard(
//       urlImg: 'assets/doctor.jpg',
//       title: "doctor 3",
//       specialist: "specialist",
//     ),
//     DoctorHomeListCard(
//       urlImg: 'assets/doctor.jpg',
//       title: "doctor 4",
//       specialist: "specialist",
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// Widget doctorHomeListCard(
//         {required DoctorHomeListCard doctorCardList, required onTap}) =>
//     Container(
//       padding: EdgeInsets.only(left: 19, bottom: 25),
//       child: SizedBox(
//         child: GestureDetector(
//             child: Material(
//               elevation: 10,
//               borderRadius: BorderRadius.circular(10),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: AspectRatio(
//                       aspectRatio: 4 / 4,
//                       child: ClipRRect(
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(10.0)),
//                         child: Image.asset(
//                           doctorCardList.urlImg,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // const SizedBox(height: 4),
//                   SizedBox(height: 8),
//                   Text(doctorCardList.title,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   SizedBox(height: 5),
//                   Text(
//                     doctorCardList.specialist,
//                     style: TextStyle(
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                 ],
//               ),
//             ),
//             onTap: () {
//               onTap;
//             }),
//       ),
//     );

class DoctorHomeListCard extends StatelessWidget {
  const DoctorHomeListCard({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 19, bottom: 25),
      child: SizedBox(
        child: GestureDetector(
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 4 / 4,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                        child: Image.asset(
                          'assets/doctor.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 4),
                  SizedBox(height: 8),
                  Text("doctor name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(
                    "doctor specialist",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(route);
            }),
      ),
    );
  }
}
