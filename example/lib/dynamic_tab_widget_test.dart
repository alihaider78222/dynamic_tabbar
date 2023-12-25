import 'package:flutter/material.dart';

class TabData {
  final String title;
  final Widget content;

  TabData({required this.title, required this.content});
}

/// Dynamic Tabs.
class DynamicTabsWidget extends StatefulWidget {
  final List<TabData> tabs;
  final Function(TabController) onTabControllerUpdated;
  final Function(TabController)? onTabChanged;
  final int? moveTo;
  final bool? isScrollable;

  const DynamicTabsWidget({
    Key? key,
    required this.tabs,
    required this.onTabControllerUpdated,
    this.onTabChanged,
    this.moveTo,
    this.isScrollable,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DynamicTabsWidgetState createState() => _DynamicTabsWidgetState();
}

class _DynamicTabsWidgetState extends State<DynamicTabsWidget>
    with TickerProviderStateMixin {
  // Tab Controller
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = getTabController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies');
    // widget.onTabControllerUpdated(_tabController = getTabController());

    // if not using controller Tab then
    // then wrap your widget with DefaultTabController to overcome error
    // _tabController = getTabController();

    // But
    // We can't animate or move to the desired Tab

    if (widget.moveTo != null) {
      print('moveTo : ${widget.moveTo}');
    }
  }

  @override
  void didUpdateWidget(covariant DynamicTabsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('moveTo didUpdateWidget : ${widget.moveTo}');

    if (_tabController?.length != widget.tabs.length) {
      debugPrint('Tab controller updated');
      _tabController = getTabController(initialIndex: widget.tabs.length - 1);

      Future.delayed(const Duration(milliseconds: 50), () {
        _tabController?.animateTo(
          widget.moveTo! - 1,
          // duration: Duration(milliseconds: 200),
        );
      });
    } else {
      debugPrint('NOOOOO Tab controller updated');
    }
  }

  TabController getTabController({int initialIndex = 0}) {
    return TabController(
        // initialIndex: initialIndex,
        length: widget.tabs.length,
        vsync: this as TickerProvider);
    // ..addListener(_updatePage);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: widget.isScrollable ?? false,
            tabs: widget.tabs.map((tab) => Tab(text: tab.title)).toList(),
          ),
          SizedBox(
            height: 200, // Set the desired height for tab content
            child: TabBarView(
              controller: _tabController,
              children: widget.tabs.map((tab) => tab.content).toList(),
            ),
          ),
          Text('tabController length ${_tabController?.length}'),
          Text('tabs length ${widget.tabs.length}')
        ],
      ),
    );
  }
}
