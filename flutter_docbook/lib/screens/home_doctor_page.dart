import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/border_card.dart';
import 'package:flutter_docbook/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/confirmation_dialog.dart';
import '../models/auth_model.dart';
import '../components/datetime_converter.dart';
import '../providers/dio_provider.dart';
import 'appointment_details.dart';
import 'doctor_profile_page.dart';

class HomeDoctorPage extends StatefulWidget {
  const HomeDoctorPage({super.key});

  @override
  State<HomeDoctorPage> createState() => _HomeDoctorPageState();
}

class _HomeDoctorPageState extends State<HomeDoctorPage> {
  dynamic user;
  List<dynamic> appointments = [];
  List<dynamic> todayAppointments = [];

  late List<dynamic> pendingAppointments;
  late List<dynamic> rejectedAppointments;
  String token = '';

  Future<void> getData() async {
    setState(() {
      user = Provider.of<AuthModel>(context, listen: false).getUser;
      token = Provider.of<AuthModel>(context, listen: false).getToken;

      appointments = user['patient'];
      todayAppointments = user['today_app'];

      List<dynamic> filterAppointmentsByStatus(String status) {
        return appointments
            .where((appointment) => appointment['status'] == status)
            .toList();
      }

      pendingAppointments = filterAppointmentsByStatus('pending');
      rejectedAppointments = filterAppointmentsByStatus('not approved');
    });
  }

  void updateHomePageData(Map<String, dynamic> updatedData) {
    setState(() {
      user = updatedData;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.doctorTheme,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'all',
                child: Text('Profile'),
              ),
            ];
          }, onSelected: (value) async {
            final updatedUserData = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorProfilePage(userData: user)),
            );

            // Update your homepage data with the received updated data
            if (updatedUserData != null) {
              updateHomePageData(updatedUserData);
            }
          })
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Config.spaceSmall,
                    Text(
                      'Hello, ${user['name']}',
                      style: GoogleFonts.rubik(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome!',
                      style: GoogleFonts.rubik(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    Config.spaceSmall,
                    Row(
                      children: [
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '${appointments.length}',
                                style: const TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                              ),
                            ],
                            btmWidget: const [
                              SizedBox(height: 15),
                              Text(
                                'Total Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '${todayAppointments.length}',
                                style: const TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                child: const Icon(
                                  Icons.today_outlined,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                            btmWidget: const [
                              SizedBox(height: 15),
                              Text(
                                'Today Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '${pendingAppointments.length}',
                                style: const TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.pending_actions_outlined,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                              ),
                            ],
                            btmWidget: const [
                              SizedBox(height: 15),
                              Text(
                                'Pending Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BorderCard(
                            cardHeader: Container(),
                            topWidget: [
                              Text(
                                '${rejectedAppointments.length}',
                                style: const TextStyle(
                                  color: Config.doctorTheme,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(94, 94, 184, 0.2),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.cancel_presentation,
                                  color: Config.doctorTheme,
                                  size: 18,
                                ),
                              ),
                            ],
                            btmWidget: const [
                              SizedBox(height: 15),
                              Text(
                                'Rejected Appointment',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Config.spaceSmall,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Today Appointment',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            todayAppointments.isEmpty
                ? SliverToBoxAdapter(
                    child: SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Stack(alignment: Alignment.center, children: [
                        SizedBox(
                          height: 130,
                          width: 150,
                          child: Image.asset(
                            'assets/no_appointment.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          child: Text(
                            'No Appointments Available',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ]),
                    ),
                  )
                : SliverList.separated(
                    itemCount: todayAppointments.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                    itemBuilder: (context, index) {
                      var todayAppointment = todayAppointments[index];
                      return SizedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: BorderCard(
                            cardHeader: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                color: Color.fromRGBO(94, 94, 184, 0.3),
                              ),
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                          backgroundColor: Colors.yellow[50],
                                          side: BorderSide(
                                              color: Colors.red.shade600,
                                              width: 2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          )),
                                      child: Icon(
                                        Icons.delete_forever_outlined,
                                        size: 17,
                                        color: Colors.red[600],
                                      ),
                                      onPressed: () async {
                                        await showConfirmationDialog(context,
                                            'are you sure to remove this appointment',
                                            () async {
                                          final response = await DioProvider()
                                              .deleteDoctorAppointment(
                                                  todayAppointment['id'],
                                                  token);
                                          if (response) {
                                            setState(() {
                                              todayAppointments
                                                  .remove(todayAppointment);
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width: todayAppointment['status'] ==
                                              "completed"
                                          ? 0
                                          : 10),
                                  todayAppointment['status'] == "completed"
                                      ? const SizedBox()
                                      : SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                backgroundColor:
                                                    Colors.yellow[50],
                                                side: BorderSide(
                                                    color:
                                                        Colors.yellow.shade600,
                                                    width: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                )),
                                            child: Icon(
                                              Icons.edit_calendar_sharp,
                                              size: 17,
                                              color: Colors.yellow[600],
                                            ),
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AppointmentDetails(
                                                          appointment:
                                                              todayAppointment,
                                                          token: token,
                                                          index: index),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            topWidget: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Patient Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green[100],
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            'Approved',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      todayAppointment['full_name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            btmWidget: [
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Date & time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${DateConverter.formatDate2(todayAppointment['date'])} At ${todayAppointment['time']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Disease',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          todayAppointment['disease'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      );
                    }),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }
}
