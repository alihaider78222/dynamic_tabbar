import 'package:flutter/material.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic TabBar Demo',
      theme: ThemeData(
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

  // Leading icon
  Widget? leading;

  // Trailing icon
  Widget? trailing;

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
              children: [
                ElevatedButton(
                  onPressed: addTab,
                  child: const Text('Add Tab'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
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
                const SizedBox(width: 22),
                ElevatedButton(
                  onPressed: addLeadingWidget,
                  child: const Text('Add Leading Widget'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: removeLeadingWidget,
                  child: const Text('remove Leading Widget'),
                ),
                const SizedBox(width: 22, height: 40),
                ElevatedButton(
                  onPressed: addTrailingWidget,
                  child: const Text('Add Trailing Widget'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: removeTrailingWidget,
                  child: const Text('remove Trailing Widget'),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            child: DynamicTabBarWidget(
              dynamicTabs: tabs,
              // optional properties :-----------------------------
              isScrollable: isScrollable,
              onTabControllerUpdated: (controller) {
                debugPrint("onTabControllerUpdated");
              },
              onTabChanged: (index) {
                debugPrint("Tab changed: $index");
              },
              onAddTabMoveTo: MoveToTab.last,
              // backIcon: Icon(Icons.keyboard_double_arrow_left),
              // nextIcon: Icon(Icons.keyboard_double_arrow_right),
              showBackIcon: showBackIcon,
              showNextIcon: showNextIcon,
              leading: leading,
              trailing: trailing,
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

  void addLeadingWidget() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Adding Icon button Widget \nYou can add any customized widget)'),
    ));

    setState(() {
      leading = Tooltip(
        message: 'Add your desired Leading widget here',
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.star_border_rounded),
        ),
      );
    });
  }

  void removeLeadingWidget() {
    setState(() {
      leading = null;
    });
  }

  void addTrailingWidget() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Adding Icon button Widget \nYou can add any customized widget)'),
    ));

    setState(() {
      trailing = Tooltip(
        message: 'Add your desired Trailing widget here',
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz_rounded),
        ),
      );
    });
  }

  void removeTrailingWidget() {
    setState(() {
      trailing = null;
    });
  }
}
