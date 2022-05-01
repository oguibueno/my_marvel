// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NestedTabBar extends StatefulWidget {
  final Map<Tab, Widget> tabs;

  const NestedTabBar(this.tabs);

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.grey[900],
          labelColor: Colors.grey[900],
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: widget.tabs.keys.map((tab) => tab).toList(),
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: widget.tabs.values.map((widget) => widget).toList(),
          ),
        )
      ],
    );
  }
}
