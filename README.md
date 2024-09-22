![dynamic_tabbar](https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/banner.png)

# Dynamic TabBar

A Flutter package that simplifies the implementation of dynamic TabBar in your application.

With [`DynamicTabBarWidget`](https://pub.dev/packages/dynamic_tabbar), users can effortlessly manage and navigate through a list of [Tabs](https://api.flutter.dev/flutter/material/TabBar-class.html). The widget is designed to auto-update as <b>Tabs</b> are added or removed, providing a seamless and dynamic user experience.

🚀 Demo: [Dynamic Tabbar](https://alihaider78222.github.io/dynamic-tabbar-demo/)

## 📱 Screenshots

<p float="left">
  <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/demo_1.gif" alt="dynamic_tabbar Demo 1" width="auto" height="570">
  <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/demo_2.gif" alt="dynamic_tabbar Demo 2" width="auto" height="570">
  <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/demo_4.gif" alt="dynamic_tabbar Demo 4" width="auto" height="570">
  <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/demo_3.gif" alt="dynamic_tabbar Web Demo" height="auto">
</p>

## 🛠 Installation

1. Add dependency to `pubspec.yaml` file:</br>
Get the latest version from the 'Installing' tab on [pub.dev](https://pub.dev/packages/dynamic_tabbar/install)

```yaml
dependencies:
  dynamic_tabbar: ^latest_version
```

2. Import the package

```dart
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
```

3. Adding DynamicTabBarWidget

*With required parameters*

```dart
 DynamicTabBarWidget(
    dynamicTabs: tabs,
);
```

*With optional parameters*

```dart
 DynamicTabBarWidget(
    dynamicTabs: tabs,
    isScrollable: isScrollable,
    onTabControllerUpdated: (controller) {},
    onTabChanged: (index) {},
    onAddTabMoveTo: MoveToTab.last,
    onAddTabMoveToIndex : null,
    backIcon: Icon(Icons.arrow_back),
    nextIcon: Icon(Icons.arrow_forward),
    showBackIcon: showBackIcon,
    showNextIcon: showNextIcon,
    leading : leadingWidget,
    trailing : trailingWidget,

    // Default Tab properties can also be updated
    padding: padding,
    indicatorColor: indicatorColor,
    automaticIndicatorColorAdjustment: automaticIndicatorColorAdjustment,
    indicatorWeight: indicatorWeight,
    indicatorPadding: indicatorPadding,
    indicator: indicator,
    indicatorSize: indicatorSize,
    dividerColor: dividerColor,
    dividerHeight: dividerHeight,
    labelColor: labelColor,
    labelStyle: labelStyle,
    labelPadding: labelPadding,
    unselectedLabelColor: unselectedLabelColor,
    unselectedLabelStyle: unselectedLabelStyle,
    dragStartBehavior: dragStartBehavior,
    overlayColor: overlayColor,
    mouseCursor: mouseCursor,
    enableFeedback: enableFeedback,
    onTap: onTap,
    physics: physics,
    splashFactory: splashFactory,
    splashBorderRadius: splashBorderRadius,
    tabAlignment: tabAlignment,

    // Default TabBarView properties can also be updated
    physicsTabBarView: physicsTabBarView,
    dragStartBehaviorTabBarView: physicsTabBarView,
    viewportFractionTabBarView: viewportFractionTabBarView,
    clipBehaviorTabBarView: clipBehaviorTabBarView,
);

```

## 🌟 Features

- <b>Dynamic Tab Management</b>: Users can push or pop items in the `List<TabData> tabs` array, and the <b>DynamicTabBarWidget</b> will auto-update accordingly.

- <b>Tab Navigation</b>: Implement the `onTabChanged` callback to handle tab change events.

- <b>Customization Options</b>: Customize the appearance and behavior of the DynamicTabBarWidget using parameters like `backIcon, nextIcon, showBackIcon, and showNextIcon`.

- <b>Tab Position</b> : Specify the position to which cursor moves to after adding new Tab using the `onAddTabMoveTo` property.

### 🧰 Parameters

- <b>dynamicTabs</b>: List of TabData objects representing the dynamic tabs.

- <b>isScrollable</b>: Set to true to enable scrollable tabs.

- <b>onTabChanged</b>: Callback function triggered when a tab is changed.

- <b>onAddTabMoveTo</b>: Enum value (`MoveToTab.idol`, `MoveToTab.last`) specifying where a tab navigator should move when Tab is added.

- <b>backIcon</b>: Custom icon for the "Back" button, If `isScrollable` is false, this property is ignored.

- <b>nextIcon</b>: Custom icon for the "Next" button.

- <b>showBackIcon</b>: Boolean to show or hide the `Back icon` button, If `isScrollable` is false, this property is ignored.

- <b>showNextIcon</b>: Boolean to show or hide the `Next icon` button, If `isScrollable` is false, this property is ignored.

- <b>leading</b>: Custom `leading Widget` if needed.

- <b>trailing</b>: Custom `trailing Widget` if needed.

- `TabBar` default properties...

- and `TabBarView` default properties...

## 📚 How to use

### isScrollable

`isScrollable: false`  | `isScrollable: true`
-- | --
 <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/scrollable_false.gif" alt="isScrollable.false"> |  <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/scrollable_true.gif" alt="isScrollable.true">

### showBackIcon

If `isScrollable` is false, this property is ignored.

`showBackIcon: false`  | `showBackIcon: true`
-- | --
 <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/showBackIcon_false.png" alt="isScrollable.true"> | <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/showIcon_true.png" alt="isScrollable.true">

### showNextIcon

If `isScrollable` is false, this property is ignored.

`showNextIcon: false`  | `showNextIcon: true`
-- | --
 <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/showNextIcon_false.png" alt="isScrollable.true"> | <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/showIcon_true.png" alt="isScrollable.true">

### backIcon

We can use custom Icon for back button, If `isScrollable` is false, this property is ignored.

`backIcon: Icon()`  | `backIcon: null`
-- | --
`Icon(Icons.keyboard_double_arrow_left)`  | Default back icon will be used
 <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/backIcon_custom.gif" alt="isScrollable.true"> | <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/showIcon_true.png" alt="isScrollable.true">

### nextIcon

We can use custom Icon for next button, If `isScrollable` is false, this property is ignored.

`nextIcon: Icon()`  | `nextIcon: null`
-- | --
`Icon(Icons.keyboard_double_arrow_right)`  | Default back icon will be used
 <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/nextIcon_custom.gif" alt="nextIcon_custom"> | <img src="https://raw.githubusercontent.com/alihaider78222/dynamic_tabbar/main/screenshots/showIcon_true.png" alt="default_icons">

## 💻 Example

Check out the **example** app in the [example](example) directory for a complete example with additional parameters.

```dart
import 'package:flutter/material.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';


class DynamicTabExample extends StatefulWidget {
  const DynamicTabExample({super.key});
  @override
  State<DynamicTabExample> createState() => _DynamicTabExampleState();
}

class _DynamicTabExampleState extends State<DynamicTabExample> {
  bool isScrollable = false;
  bool showNextIcon = true;
  bool showBackIcon = true;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example for Dynamic Tab'),
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

```

## 📝Contribution

Of course the project is open source, and you can contribute to it [repository link](https://github.com/alihaider78222/dynamic_tabbar)

- If you **found a bug**, open an issue.

- If you **have a feature request**, open an issue.

- If you **want to contribute**, submit a pull request.

## 💳 License

This project is [LICENSED](https://choosealicense.com/licenses/mit/) under the MIT License. Use it freely, but let's play nice and give credit where it's due!

## 🎉 Conclusion

I will be happy to answer any questions that you may have on this approach,</br>
If you liked this package, don't forget to show some ❤️ by smashing the ⭐.
