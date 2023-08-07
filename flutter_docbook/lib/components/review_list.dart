// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_docbook/components/expanded_widget.dart';

class ReviewList extends StatefulWidget {
  const ReviewList(
      {super.key,
      required this.route,
      required this.padding,
      required this.margin,
      required this.border,
      this.dividerWidth,
      this.divider});

  final String route;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Border? border;
  final double? dividerWidth;
  final Divider? divider;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  bool isReadMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(border: widget.border),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              Text(
                "Patient Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              ExpandedWidget(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: widget.dividerWidth,
              child: widget.divider,
            ),
          ],
        ),
      ],
    );
  }
}
