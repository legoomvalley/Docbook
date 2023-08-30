import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/doctor_card.dart';
import 'package:flutter_docbook/screens/search_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/filter_specialization.dart';
import '../models/auth_model.dart';
import '../providers/dio_provider.dart';
import '../utils/config.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({Key? key, this.specialization}) : super(key: key);

  final String? specialization;
  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  Map<String, dynamic> user = {};
  List<dynamic> doctors = [];
  FilterSpecialization specialization = FilterSpecialization.all;

  @override
  void initState() {
    specialization = FilterSpecialization.values.firstWhere(
        (spec) => spec.value == widget.specialization,
        orElse: () => FilterSpecialization.all);

    super.initState();
  }

  // this controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    doctors = user['doctor'];
    List<dynamic> filteredSpecializations = doctors.where((var doctor) {
      return specialization == FilterSpecialization.all ||
          doctor['specialization_name'] == specialization.value;
    }).toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      // filled: fale,
                      hintText: 'Search Doctor...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(
                                    initialQuery: _searchController.text),
                              ));
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          for (FilterSpecialization filterSpecialization
                              in FilterSpecialization.values)
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: filterSpecialization.value ==
                                        specialization.value
                                    ? Config.primaryColor
                                    : Colors.blue.shade50,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    setState(() {
                                      if (filterSpecialization ==
                                          FilterSpecialization.pediatrics) {
                                        specialization =
                                            FilterSpecialization.pediatrics;
                                      } else if (filterSpecialization ==
                                          FilterSpecialization
                                              .generalMedicine) {
                                        specialization = FilterSpecialization
                                            .generalMedicine;
                                      } else if (filterSpecialization ==
                                          FilterSpecialization.orthopedics) {
                                        specialization =
                                            FilterSpecialization.orthopedics;
                                      } else if (filterSpecialization ==
                                          FilterSpecialization.eyeSpecialist) {
                                        specialization =
                                            FilterSpecialization.eyeSpecialist;
                                      } else {
                                        specialization =
                                            FilterSpecialization.all;
                                      }
                                    });
                                    print(specialization);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    height: 60,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                      child: Text(
                                        filterSpecialization.value,
                                        style: TextStyle(
                                            color: filterSpecialization.value ==
                                                    specialization.value
                                                ? Colors.white
                                                : Config.primaryColor,
                                            fontSize: 14,
                                            fontWeight:
                                                filterSpecialization.value ==
                                                        specialization.value
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: filteredSpecializations.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 150),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : Column(
                      children: List.generate(filteredSpecializations.length,
                          (index) {
                        var doctor = filteredSpecializations[index];
                        return DoctorCard(
                            doctor: doctor, route: 'doctor_details');
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
