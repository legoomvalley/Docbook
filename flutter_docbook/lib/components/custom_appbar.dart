import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.appTitle, this.route, this.icon, this.actions});

  Size get preferredSize => const Size.fromHeight(60);
  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      // if icon not set, return null
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(
                        4.0,
                        5.0,
                      ),
                      blurRadius: 2.0,
                      spreadRadius: 0,
                    ),
                  ]),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  onPressed: () {
                    // if is given, then this icon btn will navigate to that route
                    if (widget.route != null) {
                      Navigator.of(context).pushNamed(widget.route!);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: widget.icon!,
                  iconSize: 16,
                  color: const Color.fromRGBO(103, 114, 148, 1),
                ),
              ))
          : null,
      // if action is not set, return null
      actions: widget.actions,
    );
  }
}
