library dynamic_tabbar;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabData {
  final int index;
  final Tab title;
  final Widget content;

  TabData({required this.index, required this.title, required this.content});
}

/// Defines where the Tab indicator animation moves to when new Tab is added.
///
///
enum MoveToTab {
  /// The [idol] indicator will remain on current Tab when new Tab is added.
  idol,
  // next,
  // previous,
  // first,
  /// The [last] indicator will move to the Last Tab when new Tab is added.
  last,
}

/// Dynamic Tabs.
class DynamicTabBarWidget extends TabBar {
  /// List of Tabs.
  ///
  /// TabData contains [index] of the tab and the title which is extension of [TabBar] header.
  /// and the [content] is the extension of [TabBarView] so all the page content is displayed in this section
  ///
  ///
  final List<TabData> dynamicTabs;
  final Function(TabController) onTabControllerUpdated;
  final Function(TabController)? onTabChanged;

  /// Defines where the Tab indicator animation moves to when new Tab is added.
  ///
  /// TabData contains two states at the moment [IDOL] and [LAST]
  ///
  final MoveToTab? onAddTabMoveTo;

  /// The back icon of the TabBar when [isScrollable] is true.
  ///
  /// If this parameter is null, then the default back icon is used.
  ///
  /// If [isScrollable] is false, this property is ignored.
  final Widget? backIcon;

  /// The forward icon of the TabBar when [isScrollable] is true.
  ///
  /// If this parameter is null, then the default forward icon is used.
  ///
  /// If [isScrollable] is false, this property is ignored.
  final Widget? nextIcon;

  /// The showBackIcon property of DynamicTabBarWidget is used when [isScrollable] is true.
  ///
  /// If this parameter is null, then the default value is [true].
  ///
  /// If [isScrollable] is false, this property is ignored.
  final bool? showBackIcon;

  /// The showNextIcon property of DynamicTabBarWidget is used when [isScrollable] is true.
  ///
  /// If this parameter is null, then the default value is [true].
  ///
  /// If [isScrollable] is false, this property is ignored.
  final bool? showNextIcon;

  DynamicTabBarWidget({
    super.key,
    required this.dynamicTabs,
    required this.onTabControllerUpdated,
    this.onTabChanged,
    this.onAddTabMoveTo,
    super.isScrollable,
    this.backIcon,
    this.nextIcon,
    this.showBackIcon = true,
    this.showNextIcon = true,
    // Default Tab properties :---------------------------------------
    super.padding,
    super.indicatorColor,
    super.automaticIndicatorColorAdjustment = true,
    super.indicatorWeight = 2.0,
    super.indicatorPadding = EdgeInsets.zero,
    super.indicator,
    super.indicatorSize,
    super.dividerColor,
    super.dividerHeight,
    super.labelColor,
    super.labelStyle,
    super.labelPadding,
    super.unselectedLabelColor,
    super.unselectedLabelStyle,
    super.dragStartBehavior = DragStartBehavior.start,
    super.overlayColor,
    super.mouseCursor,
    super.enableFeedback,
    super.onTap,
    super.physics,
    super.splashFactory,
    super.splashBorderRadius,
    super.tabAlignment,
  }) : super(tabs: []);

  @override
  // ignore: library_private_types_in_public_api
  _DynamicTabBarWidgetState createState() => _DynamicTabBarWidgetState();
}

class _DynamicTabBarWidgetState extends State<DynamicTabBarWidget>
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
    _tabController =
        getTabController(initialIndex: widget.dynamicTabs.length - 1);
    widget.onTabControllerUpdated(_tabController = getTabController());

    if (widget.onAddTabMoveTo != null) {
      debugPrint('moveTo : ${widget.onAddTabMoveTo}');
    }
  }

  @override
  void didUpdateWidget(covariant DynamicTabBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('moveTo didUpdateWidget : ${widget.onAddTabMoveTo}');

    if (_tabController?.length != widget.dynamicTabs.length) {
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
      length: widget.dynamicTabs.length,
      vsync: this,
    )..addListener(() {
        setState(() {
          activeTab = _tabController?.index ?? 0;
        });
      });
  }

  int getActiveTab() {
    debugPrint('activeTab :  $activeTab');
    debugPrint('tabs.length :  ${widget.dynamicTabs.length}');

    // when there are No tabs
    if (activeTab == 0 && widget.dynamicTabs.isEmpty) {
      return 0;
    }
    if (activeTab == widget.dynamicTabs.length) {
      return widget.dynamicTabs.length - 1;
    }
    if (activeTab < widget.dynamicTabs.length) {
      return activeTab;
    }
    return widget.dynamicTabs.length;
  }

  // ignore: body_might_complete_normally_nullable
  int? getOnAddMoveToTab(MoveToTab? moveToTab) {
    switch (moveToTab) {
      // case MoveToTab.NEXT:
      //   return widget.dynamicTabs.length - 1;

      // case MoveToTab.PREVIOUS:
      //   return widget.dynamicTabs.length - 2;

      // case MoveToTab.FIRST:
      //   return 1;

      case MoveToTab.last:
        return widget.dynamicTabs.length - 1;

      case MoveToTab.idol:
        return null;

      case null:
        // move to Last Tab
        return widget.dynamicTabs.length - 1;
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _tabController = getTabController(initialIndex: widget.dynamicTabs.length - 1);
    return DefaultTabController(
      length: widget.dynamicTabs.length,
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
                  isScrollable: widget.isScrollable,
                  controller: _tabController,
                  tabs: widget.dynamicTabs.map((tab) => tab.title).toList(),
                  // Default Tab properties :---------------------------------------
                  padding: widget.padding,
                  indicatorColor: widget.indicatorColor,
                  automaticIndicatorColorAdjustment:
                      widget.automaticIndicatorColorAdjustment,
                  indicatorWeight: widget.indicatorWeight,
                  indicatorPadding: widget.indicatorPadding,
                  indicator: widget.indicator,
                  indicatorSize: widget.indicatorSize,
                  dividerColor: widget.dividerColor,
                  dividerHeight: widget.dividerHeight,
                  labelColor: widget.labelColor,
                  labelStyle: widget.labelStyle,
                  labelPadding: widget.labelPadding,
                  unselectedLabelColor: widget.unselectedLabelColor,
                  unselectedLabelStyle: widget.unselectedLabelStyle,
                  dragStartBehavior: widget.dragStartBehavior,
                  overlayColor: widget.overlayColor,
                  mouseCursor: widget.mouseCursor,
                  enableFeedback: widget.enableFeedback,
                  onTap: widget.onTap,
                  physics: widget.physics,
                  splashFactory: widget.splashFactory,
                  splashBorderRadius: widget.splashBorderRadius,
                  tabAlignment: widget.tabAlignment,
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
              children: widget.dynamicTabs.map((tab) => tab.content).toList(),
            ),
          ),
          // Text('tabController length ${_tabController?.length}'),
          // Text('tabs length ${widget.dynamicTabs.length}'),
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
