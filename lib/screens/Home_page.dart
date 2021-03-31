import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/tabs/home_tab.dart';
import 'package:e_bookstore/tabs/profile_tab.dart';
import 'package:e_bookstore/tabs/saved_tab.dart';
import 'package:e_bookstore/tabs/search_tab.dart';
import 'package:e_bookstore/widgets/Bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  //to control page switching
  PageController _tabsController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabsController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  //each container for each page
                  HomeTab(),
                  SearchTab(),
                  SavedTab(),
                  ProfileTab(),
                ],
              ),
            ),
            BottomTabs(
              selectedTab: _selectedTab,
              tabPressed: (num) {
                _tabsController.animateToPage(
                    num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              },
            ),
          ],
        ),
    );
  }
}

