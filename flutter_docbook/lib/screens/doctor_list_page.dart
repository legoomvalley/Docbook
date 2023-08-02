import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/doctor_card.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  // this controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Material(
                elevation: 15.0,
                borderRadius: BorderRadius.circular(7.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
              SizedBox(height: 20),
              Column(
                children: List.generate(10, (index) {
                  return DoctorCard();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
