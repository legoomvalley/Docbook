import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/datetime_converter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/review_list.dart';
import '../utils/config.dart';

class ReviewListPage extends StatefulWidget {
  const ReviewListPage({Key? key, this.comments}) : super(key: key);

  final List? comments;
  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  bool newestToOldest = true;
  int currentTabIndex = 0;

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

  void sortComments(bool newestToOldest) {
    widget.comments?.sort((a, b) {
      final aTime = DateTime.parse(a['created_at']);
      final bTime = DateTime.parse(b['created_at']);
      return newestToOldest ? bTime.compareTo(aTime) : aTime.compareTo(bTime);
    });
  }

  void onTabTap(int tabIndex) {
    setState(() {
      newestToOldest = tabIndex == 0;
      currentTabIndex = tabIndex;
      sortComments(newestToOldest);
    });
  }

  void _scrollListener() {
    setState(() {
      showShadow = _scrollController.offset > 44;
    });
  }

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
              leading: const BackButton(color: Config.primaryColor),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  'Dr Username',
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _FixedHeaderDelegate(
                comments: widget.comments,
                newestToOldest: newestToOldest,
                onTabTap: onTabTap,
                currentTabIndex: currentTabIndex,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Reviews',
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ReviewList(
                  comment: widget.comments?[index]['comment'],
                  patientName: "${widget.comments?[index]['patientName']}",
                  date: DateConverter.formatDate(
                      widget.comments?[index]['created_at']),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  margin: const EdgeInsets.only(bottom: 0),
                  border: const Border(
                    bottom: BorderSide(color: Colors.transparent),
                  ),
                  dividerWidth: MediaQuery.of(context).size.width,
                  divider: Divider(color: Colors.grey[200], thickness: 8.0),
                ),
                childCount: widget.comments?.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List? comments;
  final bool newestToOldest;

  final Function(int) onTabTap;
  int currentTabIndex; // Receive the current tab index

  _FixedHeaderDelegate(
      {required this.comments,
      required this.newestToOldest,
      required this.onTabTap,
      required this.currentTabIndex});
  List<String> tabItems = [
    "Newest",
    "Oldest",
  ];

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
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabItems.length,
            itemBuilder: (context, index) => Row(
              children: [
                Material(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          currentTabIndex = index;
                        });
                        onTabTap(index);
                      },
                      child: Ink(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: MediaQuery.of(context).size.width *
                              1 /
                              tabItems.length,
                          decoration: BoxDecoration(
                            color: index == currentTabIndex
                                ? Colors.white70
                                : Colors.white54,
                            border: currentTabIndex == index
                                ? const Border(
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
                                fontWeight: index == currentTabIndex
                                    ? FontWeight.w800
                                    : FontWeight.normal,
                                color: currentTabIndex == index
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ));
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
