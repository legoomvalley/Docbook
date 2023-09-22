import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/dio_provider.dart';
import 'doctor_details_page.dart';

class Search extends StatefulWidget {
  final String? initialQuery;

  const Search({Key? key, this.initialQuery}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Map<String, dynamic> user = {};
  List<dynamic> doctors = [];
  List<dynamic> searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  // String _searchInput = "";

  Future getData({String? query}) async {
    // get token from share preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      // get user data
      final response = await DioProvider().getUserPatient(token);
      if (response != '') {
        user = jsonDecode(response);
        doctors = user['doctor'];

        searchResults = doctors.map((d) => d).toList();
        if (query != null) {
          searchResults = doctors
              .where((e) =>
                  e['doctor_name'].toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        return searchResults;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery ?? '';
    getData(query: widget.initialQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: FutureBuilder(
        future: getData(query: _searchController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            // Display search results using ListView.builder
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Material(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorDetails(doctor: searchResults[index]),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: const FittedBox(
                                // ignore: sort_child_properties_last
                                child: Image(
                                  image: AssetImage('assets/user.jpg'),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // sentence
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // SizedBox(height: 5),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  'Dr ${searchResults[index]['doctor_name']}',
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
                                searchResults[index]['specialization_name'],
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(168, 168, 168, 1),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DoctorDetails(
                                            doctor: searchResults[index]),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    backgroundColor: Colors.green.shade50,
                                  ),
                                  child: const Text(
                                    'details',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
