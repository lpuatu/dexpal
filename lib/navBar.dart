import 'package:flutter/material.dart';

class navBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 18,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_rounded,
            ),
            label: 'PokeDex',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bug_report,
            ),
            label: 'Camera',
          ),
        ],
      ),
    );
  }
}
