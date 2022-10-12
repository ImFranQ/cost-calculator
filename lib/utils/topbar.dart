import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSize {

  @override
  final Widget child;
  
  const AppTopBar({ 
    required this.child,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      color: Colors.blue,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            child,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}