import 'dart:math' as math;
import 'package:flutter/material.dart';

const EdgeInsets _kAlignedMenuMargin = EdgeInsets.zero;
const EdgeInsetsGeometry _kUnalignedMenuMargin = EdgeInsetsDirectional.only(start: 16.0, end: 24.0);
const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = 48.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.all(16.0);
const double _kMaxItemWidthBasedOnButtonRatio = 1.5;

class ButtonMenuItem<T> extends StatelessWidget {
  const ButtonMenuItem({
    Key key,
    this.value,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final T value;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class ButtonMenu<T> extends StatefulWidget {
  ButtonMenu({
    Key key,
    @required this.items,
    @required this.onChanged,
    @required this.child,
    this.elevation = 8.0,
    this.style,
    this.openingDirection = VerticalDirection.up,
    this.itemHeight = _kMenuItemHeight,
    this.padding = _kMenuItemPadding,
    this.maxItemWithBasedOnButtonRatio = _kMaxItemWidthBasedOnButtonRatio,
  })  : assert(items != null),
        assert(child != null),
        super(key: key);

  final List<ButtonMenuItem<T>> items;
  final ValueChanged<T> onChanged;
  final double elevation;
  final TextStyle style;
  final Widget child;
  final VerticalDirection openingDirection;
  final double itemHeight;
  final EdgeInsets padding;
  final double maxItemWithBasedOnButtonRatio;

  @override
  _ButtonMenuState<T> createState() => _ButtonMenuState<T>();
}

class _ButtonMenuState<T> extends State<ButtonMenu<T>>
    with WidgetsBindingObserver {
  _ButtonMenuRoute<T> _dropdownRoute;

  @override
  void initState() {
    super.initState();
    // Simply to detect device orientation change
    WidgetsBinding.instance.addObserver(this);
  }

  ///
  /// If the device orientation changes,
  /// we need to remove the Route
  ///
  @override
  void didChangeMetrics() {
    _removeButtonDialerRoute();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeButtonDialerRoute();
    super.dispose();
  }

  bool get _enabled =>
      widget.items != null &&
      widget.items.isNotEmpty &&
      widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));

    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: _enabled ? _handleTap : null,
        behavior: HitTestBehavior.opaque,
        child: widget.child,
      ),
    );
  }

  ///
  /// Routes related
  ///
  void _removeButtonDialerRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
  }

  TextStyle get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.subhead;

  void _handleTap() {
    final RenderBox itemBox = context.findRenderObject();
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);
    final EdgeInsetsGeometry menuMargin =
        ButtonTheme.of(context).alignedDropdown
            ? _kAlignedMenuMargin
            : _kUnalignedMenuMargin;

    assert(_dropdownRoute == null);

    _dropdownRoute = _ButtonMenuRoute(
      items: widget.items,
      itemHeight: widget.itemHeight,
      buttonRect: menuMargin.resolve(textDirection).inflateRect(itemRect),
      padding: widget.padding.resolve(textDirection),
      elevation: widget.elevation,
      theme: Theme.of(context, shadowThemeOnly: true),
      style: _textStyle,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      openingDirection: widget.openingDirection,
      maxItemWithBasedOnButtonRatio: widget.maxItemWithBasedOnButtonRatio,
    );

    Navigator.push(context, _dropdownRoute)
        .then<void>((_ButtonMenuRouteResult<T> newValue) {
      _dropdownRoute = null;
      if (!mounted || newValue == null) {
        return;
      }
      if (widget.onChanged != null) {
        widget.onChanged(newValue.result);
      }
    });
  }
}

class _ButtonMenuRoute<T> extends PopupRoute<_ButtonMenuRouteResult<T>> {
  _ButtonMenuRoute({
    this.items,
    this.itemHeight,
    this.padding,
    this.buttonRect,
    this.elevation = 8.0,
    this.theme,
    @required this.style,
    this.barrierLabel,
    this.openingDirection,
    this.maxItemWithBasedOnButtonRatio,
  });

  final List<ButtonMenuItem> items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final double elevation;
  final ThemeData theme;
  final TextStyle style;
  final double itemHeight;
  final VerticalDirection openingDirection;
  final double maxItemWithBasedOnButtonRatio;

  ScrollController scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    assert(debugCheckHasDirectionality(context));
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final double screenHeight = mediaQueryData.size.height;
    final double minMenuHeight = 2.0 * itemHeight;
    final double maxMenuHeight = screenHeight - minMenuHeight;
    final double buttonTop = buttonRect.top;
    final double buttonBottom = buttonRect.bottom;

    // The topLimit depends on the visibility of the device top bar (cfr. SafeArea)
    final double topLimit = mediaQueryData.padding.top;

    // The bottomLimit depends on the visibility of the device bottom bar (cfr. SafeArea)
    final double bottomLimit = screenHeight - mediaQueryData.padding.bottom;

    final int numberOfItems = items.length;
    final double totalMenuHeight = itemHeight * numberOfItems;

    final double preferredMenuHeight =
        totalMenuHeight + kMaterialListPadding.vertical;

    // If there are too many elements in the menu, we need to shrink it down
    // so it is at most the maxMenuHeight.
    double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);

    VerticalDirection actualOpeningDirection = openingDirection;

    double menuTop;

    void _checkAbove() {
      // If we want to open the menu on top of the button, we need to
      // ensure there is enough space on top of the button
      menuTop = math.max(buttonTop - preferredMenuHeight, topLimit);
      if ((menuTop + menuHeight) > buttonTop) {
        // There is not enough space on top to display the whole menu,
        // so let's try to reduce it
        menuTop = math.max(buttonTop - minMenuHeight, topLimit);
        if ((menuTop + minMenuHeight) > buttonTop) {
          // There is definitely not enough space to display it on top
          // therefore, let's display it below
          menuTop = buttonBottom;
          menuHeight = minMenuHeight;

          // we need to display it below
          actualOpeningDirection = VerticalDirection.down;
        } else {
          menuHeight =
              ((buttonTop - menuTop) / itemHeight).floorToDouble() * itemHeight;
        }
      }
    }

    void _checkBelow() {
      menuTop = buttonBottom;

      // Check if there is enough space below to display the whole menu
      if ((menuTop + preferredMenuHeight) > bottomLimit) {
        // Not enough space to display the whole menu, so let's
        // check if we can display at least the smallest menu
        if ((menuTop + minMenuHeight) > bottomLimit) {
          // we need to display it above
          actualOpeningDirection = VerticalDirection.up;
          // There is definitely not enough space, so let's try to
          // show it above
          _checkAbove();
        } else {
          menuHeight = minMenuHeight;
        }
      } else {
        menuHeight =
            ((bottomLimit - menuTop) / itemHeight).floorToDouble() * itemHeight;
      }
    }

    // We need to compute the position of the menu, based on the desired
    // opening direction and position of the button on the screen
    if (openingDirection == VerticalDirection.up) {
      _checkAbove();
    } else {
      _checkBelow();
    }

    //TODO: when I will have the time => find a solution to force the dimensions of the menu

    if (scrollController == null) {
      scrollController = ScrollController(initialScrollOffset: 0.0);
    }

    final TextDirection textDirection = Directionality.of(context);
    Widget menu = _ButtonMenuMenu<T>(
      route: this,
      padding: padding.resolve(textDirection),
      openingDirection: actualOpeningDirection,
      itemHeight: itemHeight,
      elevation: elevation,
    );

    if (theme != null) {
      menu = Theme(data: theme, child: menu);
    }

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _ButtonMenuRouteLayout<T>(
              buttonRect: buttonRect,
              menuTop: menuTop,
              menuHeight: menuHeight,
              textDirection: textDirection,
              itemHeight: itemHeight,
              maxItemWithBasedOnButtonRatio: maxItemWithBasedOnButtonRatio,
            ),
            child: menu,
          );
        },
      ),
    );
  }

  void _dismiss() {
    navigator?.removeRoute(this);
  }
}

class _ButtonMenuRouteResult<T> {
  const _ButtonMenuRouteResult(this.result);

  final T result;

  @override
  bool operator ==(dynamic other) {
    if (other is! _ButtonMenuRouteResult<T>) return false;
    final _ButtonMenuRouteResult<T> typedOther = other;
    return result == typedOther.result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _ButtonMenuMenu<T> extends StatefulWidget {
  const _ButtonMenuMenu({
    Key key,
    this.padding,
    this.route,
    this.openingDirection,
    this.itemHeight,
    this.elevation = 8.0,
  }) : super(key: key);

  final _ButtonMenuRoute<T> route;
  final EdgeInsets padding;
  final VerticalDirection openingDirection;
  final double itemHeight;
  final double elevation;

  @override
  _ButtonMenuMenuState<T> createState() => _ButtonMenuMenuState<T>();
}

class _ButtonMenuMenuState<T> extends State<_ButtonMenuMenu<T>> {
  CurvedAnimation _fadeOpacity;

  @override
  void initState() {
    super.initState();
    // We need to hold these animations as state because of their curve
    // direction. When the route's animation reverses, if we were to recreate
    // the CurvedAnimation objects in build, we'd lose
    // CurvedAnimation._curveDirection.
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The menu is shown in three stages (unit timing in brackets):
    // [0s - 0.25s] - Fade in a rect-sized menu container with the selected item.
    // [0.25s - 0.5s] - Grow the otherwise empty menu container from the center
    //   until it's big enough for as many items as we're going to show.
    // [0.5s - 1.0s] Fade in the remaining visible items from top to bottom.
    //
    // When the menu is dismissed we just fade the entire thing out
    // in the first 0.25s.
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final _ButtonMenuRoute<T> route = widget.route;
    final List<ButtonMenuItem> items = List.from(route.items);
    final int nbItems = items.length;
    final double unit = 0.5 / (nbItems + 1.5);

    //
    // Build the children
    //
    final List<Widget> children = <Widget>[];

    for (int itemIndex = 0; itemIndex < nbItems; itemIndex++) {
      // Compute the opacity animations
      int itemDelay = itemIndex + 1;

      // If we are showing the items bottom-up, we need to reverse
      // the display sequence order
      if (widget.openingDirection == VerticalDirection.up) {
        itemDelay = nbItems - itemIndex;
      }
      final double start = (0.5 + itemDelay * unit).clamp(0.0, 1.0);
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      CurvedAnimation opacity =
          CurvedAnimation(parent: route.animation, curve: Interval(start, end));
      
      children.add(
        ScaleTransition(
          scale: opacity,
          child: InkWell(
            onTap: () => Navigator.pop(
                  context,
                  _ButtonMenuRouteResult<T>(items[itemIndex].value),
                ),
            child: Container(
                padding: widget.padding,
                child: Material(
                  elevation: widget.elevation,
                  color: Colors.transparent,
                  shape: const StadiumBorder(),
                  clipBehavior: Clip.hardEdge,
                  type: MaterialType.button,
                  child: route.items[itemIndex].child,
                ),
              ),
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _fadeOpacity,
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        label: localizations.popupMenuLabel,
        child: Material(
          type: MaterialType.transparency,
          textStyle: route.style,
          child: ScrollConfiguration(
            behavior: const _ButtonMenuScrollBehavior(),
            child: Scrollbar(
              child: ListView(
                controller: widget.route.scrollController,
                padding: kMaterialListPadding,
                itemExtent: widget.itemHeight,
                shrinkWrap: true,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _ButtonMenuRouteLayout({
    @required this.buttonRect,
    @required this.menuTop,
    @required this.menuHeight,
    @required this.textDirection,
    @required this.itemHeight,
    @required this.maxItemWithBasedOnButtonRatio,
  });

  final Rect buttonRect;
  final double menuTop;
  final double menuHeight;
  final double itemHeight;
  final TextDirection textDirection;
  final double maxItemWithBasedOnButtonRatio;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The maximum height of a simple menu should be one or more rows less than
    // the view height. This ensures a tappable area outside of the simple menu
    // with which to dismiss the menu.
    //   -- https://material.google.com/components/menus.html#menus-simple-menus
    final double maxHeight =
        math.max(0.0, constraints.maxHeight - 2 * itemHeight);
    // The width of a menu should be at most the view width. This ensures that
    // the menu does not extend past the left and right edges of the screen.
    final double width = math.min(constraints.maxWidth, buttonRect.width * maxItemWithBasedOnButtonRatio);
    return BoxConstraints(
      minWidth: buttonRect.width,
      maxWidth: width,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        // If the button was entirely on-screen, then verify
        // that the menu is also on-screen.
        // If the button was a bit off-screen, then, oh well.
        assert(menuTop >= 0.0);
        assert(menuTop + menuHeight <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect.left.clamp(0.0, size.width - childSize.width);
        break;
    }
    return Offset(left, menuTop);
  }

  @override
  bool shouldRelayout(_ButtonMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        menuTop != oldDelegate.menuTop ||
        menuHeight != oldDelegate.menuHeight ||
        textDirection != oldDelegate.textDirection;
  }
}

class _ButtonMenuScrollBehavior extends ScrollBehavior {
  const _ButtonMenuScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) =>
      Theme.of(context).platform;

  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
