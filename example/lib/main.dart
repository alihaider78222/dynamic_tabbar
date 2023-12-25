import 'package:dynamic_tabs/dynamic_tabs.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Example for Dynamic Tabs'),
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
  @override
  void initState() {
    super.initState();
  }

  void addTab() {
    setState(() {
      tabs.add(
        TabData(
          title: 'Tab custom',
          content: Center(child: Text('Content for Tab custom')),
        ),
      );
    });
  }

  // Sample data for tabs
  List<TabData> tabs = [
    TabData(
      title: 'Tab 1',
      content: Center(child: Text('Content for Tab 1')),
    ),
    TabData(
      title: 'Tab 2',
      content: Center(
        child: Column(
          children: [
            Text('Content for Tab 2'),
          ],
        ),
      ),
    ),
    // Add more tabs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Dynamic Tabs examples',
            ),
            // DynamicTabs(),
            Expanded(
              child: DynamicTabsWidget(
                tabs: tabs,
                isScrollable: true,
                onTabControllerUpdated: (controller) {},
                onTabChanged: (index) {},
                moveTo: tabs.length,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                addTab();
              },
              child: Text('add tab'),
            )
          ],
        ),
      ),
    );
  }
}
