import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/review_list.dart';
import '../utils/config.dart';

class ReviewListPage extends StatefulWidget {
  ReviewListPage({super.key});

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  final ScrollController _scrollController = ScrollController();
  bool showShadow = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      showShadow = _scrollController.offset > 44;
    });
  }

  // double appBarHeight = constraints.biggest.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: showShadow ? 2 : 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: BackButton(color: Config.primaryColor),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  'Dr Username',
                  style: GoogleFonts.rubik(
                    textStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _FixedHeaderDelegate(),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                // height: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Reviews',
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ReviewList(
                  route: 'doc_specific_appointment',
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  margin: EdgeInsets.only(bottom: 0),
                  border: Border(
                    bottom: BorderSide(color: Colors.transparent),
                  ),
                  dividerWidth: MediaQuery.of(context).size.width,
                  divider: Divider(color: Colors.grey[200], thickness: 8.0),
                ),
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// width: MediaQuery.of(context).size.width,
//               child: Divider(
//                 color: Colors.blue, // Customize the color of the line
//                 thickness: 8.0, // Customize the thickness of the line
class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  List<String> tabItems = [
    "All",
    "Newest",
    "Oldest",
  ];

  int current = 0;
  @override
  double get minExtent => 45.0;
  @override
  double get maxExtent => 45.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          child: ListView.builder(
            // separatorBuilder: (BuildContext context, int index) {
            //   return SizedBox(
            //       width:
            //           MediaQuery.of(context).size.width * 1 / tabItems.length);
            // },
            scrollDirection: Axis.horizontal,
            itemCount: tabItems.length,
            itemBuilder: (context, index) => Row(
              children: [
                Material(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: Ink(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width *
                              1 /
                              tabItems.length,
                          // margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: current == index
                                ? Colors.white70
                                : Colors.white54,
                            border: current == index
                                ? Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  )
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              tabItems[index],
                              style: GoogleFonts.rubik(
                                fontWeight: current == index
                                    ? FontWeight.w800
                                    : FontWeight.normal,
                                color: current == index
                                    ? Color.fromRGBO(0, 0, 0, 1)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )

          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     SizedBox(
          //       child: Text(
          //         'All',
          //         style: GoogleFonts.rubik(),
          //       ),
          //     ),
          //     SizedBox(
          //       child: Text(
          //         'Newest',
          //         style: GoogleFonts.rubik(),
          //       ),
          //     ),
          //     SizedBox(
          //       child: Text(
          //         'Oldest',
          //         style: GoogleFonts.rubik(),
          //       ),
          //     )
          //   ],
          // ),
          );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
