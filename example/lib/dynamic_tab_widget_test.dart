import 'package:flutter/material.dart';

class TabData {
  final int index;
  final String title;
  final Widget content;

  TabData({required this.index, required this.title, required this.content});
}

enum MoveToTab {
  IDOL,
  // NEXT,
  // PREVIOUS,
  // FIRST,
  LAST,
}

/// Dynamic Tabs.
class DynamicTabsWidget extends StatefulWidget {
  final List<TabData> tabs;
  final Function(TabController) onTabControllerUpdated;
  final Function(TabController)? onTabChanged;
  final MoveToTab? onAddTabMoveTo;
  final bool? isScrollable;
  final Widget? backIcon;
  final Widget? nextIcon;
  final bool? showBackIcon;
  final bool? showNextIcon;

  const DynamicTabsWidget({
    Key? key,
    required this.tabs,
    required this.onTabControllerUpdated,
    this.onTabChanged,
    this.onAddTabMoveTo,
    this.isScrollable,
    this.backIcon,
    this.nextIcon,
    this.showBackIcon,
    this.showNextIcon,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DynamicTabsWidgetState createState() => _DynamicTabsWidgetState();
}

class _DynamicTabsWidgetState extends State<DynamicTabsWidget>
    with TickerProviderStateMixin {
  // Tab Controller
  TabController? _tabController;

  int activeTab = 0;

  @override
  void initState() {
    super.initState();
    // _tabController = getTabController();
    // var activeTab = getActiveTab();
    debugPrint('initState _tabController');
    _tabController = getTabController(initialIndex: activeTab);

    // _tabController?.addListener(() {
    //   setState(() {
    //     activeTab = _tabController?.index ?? 0;
    //   });
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    debugPrint('didChangeDependencies');
    // _tabController = getTabController(initialIndex: widget.tabs.length - 1);
    // widget.onTabControllerUpdated(_tabController = getTabController());

    if (widget.onAddTabMoveTo != null) {
      debugPrint('moveTo : ${widget.onAddTabMoveTo}');
    }
  }

  @override
  void didUpdateWidget(covariant DynamicTabsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('moveTo didUpdateWidget : ${widget.onAddTabMoveTo}');

    if (_tabController?.length != widget.tabs.length) {
      debugPrint('Tab controller updated');
      var activeTabIndex = getActiveTab();
      debugPrint('activeTab : $activeTabIndex');
      debugPrint('didUpdateWidget _tabController');
      _tabController = getTabController(initialIndex: activeTabIndex);

      var tabIndex = getOnAddMoveToTab(widget.onAddTabMoveTo);
      if (tabIndex != null) {
        Future.delayed(const Duration(milliseconds: 50), () {
          _tabController?.animateTo(
            tabIndex,
          );
          setState(() {
            activeTab = tabIndex;
          });
        });
      }
    } else {
      debugPrint('NOOOOO Tab controller updated');
    }
  }

  TabController getTabController({int initialIndex = 0}) {
    return TabController(
      initialIndex: initialIndex,
      length: widget.tabs.length,
      vsync: this as TickerProvider,
    )
      // ..addListener(_updatePage);
      ..addListener(() {
        setState(() {
          activeTab = _tabController?.index ?? 0;
        });
      });
  }

  int getActiveTab() {
    debugPrint('activeTab :  $activeTab');
    debugPrint('tabs.length :  ${widget.tabs.length}');

    // when there are No tabs
    if (activeTab == 0 && widget.tabs.isEmpty) {
      return 0;
    }
    if (activeTab == widget.tabs.length) {
      return widget.tabs.length - 1;
    }
    if (activeTab < widget.tabs.length) {
      return activeTab;
    }
    return widget.tabs.length;
  }

  // ignore: body_might_complete_normally_nullable
  int? getOnAddMoveToTab(MoveToTab? moveToTab) {
    switch (moveToTab) {
      // case MoveToTab.NEXT:
      //   return widget.tabs.length - 1;

      // case MoveToTab.PREVIOUS:
      //   return widget.tabs.length - 2;

      // case MoveToTab.FIRST:
      //   return 1;

      case MoveToTab.LAST:
        return widget.tabs.length - 1;

      case MoveToTab.IDOL:
        return null;

      case null:
        // move to Last Tab
        return widget.tabs.length - 1;
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _tabController = getTabController(initialIndex: widget.tabs.length - 1);
    return DefaultTabController(
      length: widget.tabs.length,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              if (widget.isScrollable == true && widget.showBackIcon == true)
                IconButton(
                  icon: widget.backIcon ??
                      const Icon(
                        Icons.arrow_back_ios,
                      ),
                  onPressed: _moveToPreviousTab,
                ),
              Expanded(
                child: TabBar(
                  isScrollable: widget.isScrollable ?? false,
                  controller: _tabController,
                  // // labelStyle: TextStyle(color: Colors.black),
                  // unselectedLabelColor: Colors.white.withOpacity(0.4),
                  // labelColor: Colors.white,
                  // // Size of bottom indicator
                  // indicatorSize: TabBarIndicatorSize.label,
                  tabs: widget.tabs.map((tab) => Tab(text: tab.title)).toList(),
                ),
              ),
              if (widget.isScrollable == true && widget.showNextIcon == true)
                IconButton(
                  icon: widget.nextIcon ??
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                  onPressed: _moveToNextTab,
                ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.tabs.map((tab) => tab.content).toList(),
            ),
          ),
          // Text('tabController length ${_tabController?.length}'),
          // Text('tabs length ${widget.tabs.length}')
          // Text('Active Tab ${activeTab + 1}'),
          // Text('_tabController.index ${_tabController!.index + 1}')
        ],
      ),
    );
  }

  _moveToNextTab() {
    if (_tabController != null &&
        _tabController!.index + 1 < _tabController!.length) {
      _tabController!.animateTo(_tabController!.index + 1);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Can't move forward"),
      // ));
    }
  }

  _moveToPreviousTab() {
    if (_tabController != null && _tabController!.index > 0) {
      _tabController!.animateTo(_tabController!.index - 1);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Can't go back"),
      // ));
    }
  }
}
