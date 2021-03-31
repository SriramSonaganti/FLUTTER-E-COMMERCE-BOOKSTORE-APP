import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab,this.tabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;


  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: Color(0XFFDCDCDC),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
           // spreadRadius: 0.5,
            blurRadius:2.0,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TabButton(
            imagepath: "assets/images/home.png",
            selected: _selectedTab == 0 ? true : false,
            onPressed: (){
              widget.tabPressed(0);
            },
          ),
          TabButton(
            imagepath: "assets/images/search.png",
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          TabButton(
            imagepath: "assets/images/saved.png",
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          TabButton(
            imagepath: "assets/images/user.png",
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              setState(() {
                widget.tabPressed(3);
                //_selectedTab = 3;
              },);
            },
          ),
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {

  final String imagepath;
  final bool selected;
  final Function onPressed;

  TabButton({this.imagepath,this.selected,this.onPressed});

  @override
  Widget build(BuildContext context) {

    //this is for marking the selected tab icon
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Colors.deepOrange : Colors.transparent,
              width: 3.0,
            )
          )
        ),
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(
              imagepath ?? "assets/images/home.png",
          ),
          width: 25.0,
          height: 23.0,
          color: _selected ? Colors.deepOrange : Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
