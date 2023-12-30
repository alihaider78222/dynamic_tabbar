import 'package:flutter/material.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Example for Dynamic TabBar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isScrollable = false;
  bool showNextIcon = true;
  bool showBackIcon = true;
  // Sample data for tabs
  List<TabData> tabs = [
    TabData(
      index: 1,
      title: const Tab(
        child: Text('Tab 1'),
      ),
      content: const Center(child: Text('Content for Tab 1')),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('Tab 2'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),
    // Add more tabs as needed
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: addTab,
                  child: const Text('Add Tab'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => removeTab(tabs.length - 1),
                  child: const Text('Remove Last Tab'),
                ),
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('isScrollable'),
                    Switch.adaptive(
                      value: isScrollable,
                      onChanged: (bool val) {
                        setState(() {
                          isScrollable = !isScrollable;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('showBackIcon'),
                    Switch.adaptive(
                      value: showBackIcon,
                      onChanged: (bool val) {
                        setState(() {
                          showBackIcon = !showBackIcon;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('showNextIcon'),
                    Switch.adaptive(
                      value: showNextIcon,
                      onChanged: (bool val) {
                        setState(() {
                          showNextIcon = !showNextIcon;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DynamicTabBarWidget(
              dynamicTabs: tabs,
              isScrollable: isScrollable,
              onTabControllerUpdated: (controller) {},
              onTabChanged: (index) {},
              onAddTabMoveTo: MoveToTab.last,
              // backIcon: Icon(Icons.keyboard_double_arrow_left),
              // nextIcon: Icon(Icons.keyboard_double_arrow_right),
              showBackIcon: showBackIcon,
              showNextIcon: showNextIcon,
            ),
          ),
        ],
      ),
    );
  }

  void addTab() {
    setState(() {
      var tabNumber = tabs.length + 1;
      tabs.add(
        TabData(
          index: tabNumber,
          title: Tab(
            child: Text('Tab $tabNumber'),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dynamic Tab $tabNumber'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => removeTab(tabNumber - 1),
                child: const Text('Remove this Tab'),
              ),
            ],
          ),
        ),
      );
    });
  }

  void removeTab(int id) {
    setState(() {
      tabs.removeAt(id);
    });
  }
}
