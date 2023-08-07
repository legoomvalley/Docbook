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
            // SliverAppBar(
            //   automaticallyImplyLeading: false,
            //   pinned: true,
            //   backgroundColor: Colors.white,
            //   centerTitle: true,
            //   leading: null,
            //   elevation: 0,
            //   bottom: PreferredSize(
            //     preferredSize: const Size.fromHeight(0.0),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         border: Border(
            //           bottom: BorderSide(
            //             color: Colors.black,
            //             width: 1,
            //           ),
            //         ),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           SizedBox(
            //             child: Text("All"),
            //           ),
            //           SizedBox(
            //             child: Text("Newest"),
            //           ),
            //           SizedBox(
            //             child: Text("Oldest"),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
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
  @override
  double get minExtent => 45.0;
  @override
  double get maxExtent => 45.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Text(
              'All',
              style: GoogleFonts.rubik(),
            ),
          ),
          SizedBox(
            child: Text(
              'Newest',
              style: GoogleFonts.rubik(),
            ),
          ),
          SizedBox(
            child: Text(
              'Oldest',
              style: GoogleFonts.rubik(),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

// SliverToBoxAdapter(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         child: Text("All"),
//                       ),
//                       SizedBox(
//                         child: Text("Newest"),
//                       ),
//                       SizedBox(
//                         child: Text("Oldest"),
//                       )
//                     ],
//                   ),
//                 ),
//               ),