import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/config.dart';
import '../appointment_details.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, this.appointments, required this.token});

  List<dynamic>? appointments;
  String token;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic>? searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = null;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.appointments);
    print(searchResults?.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Config.doctorTheme,
          title: Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: Center(
                  child: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search....',
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onChanged: searchAppointment,
              ))),
        ),
        body: Column(
          children: [
            searchResults != null && searchResults!.length > 0
                ? Expanded(
                    child: ListView.builder(
                        itemCount: searchResults!.length,
                        itemBuilder: (context, index) {
                          final searchResult = searchResults![index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () async {
                                print(widget.token);
                                print(searchResult);
                                print(index);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentDetails(
                                      appointment: searchResult,
                                      token: widget.token,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Material(
                                  elevation: 1,
                                  shape: CircleBorder(),
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: searchResult['photo_path']
                                              .isNotEmpty
                                          ? Image.network(
                                              'http://10.0.2.2:8000/storage/${searchResult['photo_path']}')
                                          : Image.asset(
                                              'assets/user.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(searchResult['full_name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        )),
                                    SizedBox(height: 5),
                                    Text(
                                      'Disease : ${searchResult['disease']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Container(),
          ],
        ));
  }

  void searchAppointment(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = null;
      });
    } else {
      setState(() {
        searchResults = widget.appointments!.where((appointment) {
          final fullName = appointment['full_name'] as String? ?? '';
          final disease = appointment['disease'] as String? ?? '';

          final input = query.toLowerCase();
          return fullName.toLowerCase().contains(input) ||
              disease.toLowerCase().contains(input);
        }).toList();
      });
    }
  }
}
