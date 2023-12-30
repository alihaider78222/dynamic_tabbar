import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  List<TabData> tabs = [];

  @override
  void initState() {
    super.initState();

    getCategoriesFromApi();
  }

  Future<void> getCategoriesFromApi() async {
    Future.delayed(const Duration(seconds: 1), () {
      //
      // Example of category response from API
      //
      dynamic responseFromApi = [
        {"category": "Vegetables", "items": [], 'index': 1},
        {"category": "Fruits", "items": [], 'index': 2},
        {"category": "Bakery", "items": [], 'index': 3},
        {"category": "Fish", "items": [], 'index': 4},
        {"category": "Poultry", "items": [], 'index': 5},
        {"category": "Dry Fruits", "items": [], 'index': 6},
      ];

      //
      // Now mapping that response into our tab property
      //
      for (var element in responseFromApi) {
        tabs.add(TabData(
          index: element['index'],
          title: Tab(text: element['category']),
          content: SecondScreen(title: element['category']),
        ));
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Yay! Tabs data fetched from API :)'),
      ));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example 2 for Dynamic TabBar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: tabs.isNotEmpty
                ? DynamicTabBarWidget(
                    dynamicTabs: tabs,
                    isScrollable: true,
                    onAddTabMoveTo: MoveToTab.last,
                    onTabControllerUpdated: (TabController) {},
                  )
                : const Text('Need at-least 1 tab to show on screen'),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String title;
  const SecondScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Show content for $title'),
      ),
    );
  }
}
