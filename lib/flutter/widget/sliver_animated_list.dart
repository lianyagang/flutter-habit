library sliver_animated_list;

import 'package:collection/collection.dart' show binarySearch;
import 'package:flutter/material.dart';

// The default insert/remove animation duration.
const Duration _kDuration = Duration(milliseconds: 300);

// Incoming and outgoing AnimatedList items.
class _ActiveItem implements Comparable<_ActiveItem> {
  _ActiveItem.incoming(this.controller, this.itemIndex)
      : removedItemBuilder = null;

  _ActiveItem.outgoing(
      this.controller, this.itemIndex, this.removedItemBuilder);

  _ActiveItem.index(this.itemIndex)
      : controller = null,
        removedItemBuilder = null;

  final AnimationController controller;
  final AnimatedListRemovedItemBuilder removedItemBuilder;
  int itemIndex;

  @override
  int compareTo(_ActiveItem other) => itemIndex - other.itemIndex;
}

/// A sliver that animates items when they are inserted or removed.
///
/// This widget's [SliverAnimatedListState] can be used to dynamically insert or
/// remove items. To refer to the [SliverAnimatedListState] either provide a
/// [GlobalKey] or use the static [SliverAnimatedList.of] method from an item's
/// input callback.
///
/// See also:
/// * [SliverList], which does not animate items when they are inserted or removed.
class SliverAnimatedList extends StatefulWidget {
  /// Creates a sliver that animates items when they are inserted or removed.
  const SliverAnimatedList({
    Key key,
    @required this.itemBuilder,
    this.initialItemCount = 0,
    this.reverse = false,
  })  : assert(itemBuilder != null),
        assert(initialItemCount != null && initialItemCount >= 0),
        super(key: key);

  /// Called, as needed, to build list item widgets.
  ///
  /// List items are only built when they're scrolled into view.
  ///
  /// The [AnimatedListItemBuilder] index parameter indicates the item's
  /// position in the list. The value of the index parameter will be between 0
  /// and [initialItemCount] plus the total number of items that have been
  /// inserted with [SliverAnimatedListState.insertItem] and less the total
  /// number of items that have been removed with
  /// [SliverAnimatedListState.removeItem].
  ///
  /// Implementations of this callback should assume that
  /// [SliverAnimatedListState.removeItem] removes an item immediately.
  final AnimatedListItemBuilder itemBuilder;

  /// {@macro flutter.widgets.animatedList.initialItemCount}
  final int initialItemCount;

  final bool reverse;

  @override
  SliverAnimatedListState createState() => SliverAnimatedListState();

  /// The state from the closest instance of this class that encloses the given context.
  ///
  /// This method is typically used by [SliverAnimatedList] item widgets that
  /// insert or remove items in response to user input.
  ///
  /// ```dart
  /// SliverAnimatedListState animatedList = SliverAnimatedList.of(context);
  /// ```
  static SliverAnimatedListState of(BuildContext context,
      {bool nullOk = false}) {
    assert(context != null);
    assert(nullOk != null);
    final SliverAnimatedListState result = context
        .ancestorStateOfType(const TypeMatcher<SliverAnimatedListState>());
    if (nullOk || result != null) return result;
    throw FlutterError(
        'SliverAnimatedList.of() called with a context that does not contain a SliverAnimatedList.\n'
        'No SliverAnimatedListState ancestor could be found starting from the '
        'context that was passed to SliverAnimatedListState.of(). '
        'This can happen when the context provided is from the same StatefulWidget that '
        'built the AnimatedList. Please see the SliverAnimatedList documentation '
        'for examples of how to refer to an AnimatedListState object: '
        '  https://docs.flutter.io/flutter/widgets/SliverAnimatedListState-class.html \n'
        'The context used was:\n'
        '  $context');
  }
}

/// The state for a sliver that animates items when they are
/// inserted or removed.
///
/// When an item is inserted with [insertItem] an animation begins running. The
/// animation is passed to [SliverAnimatedList.itemBuilder] whenever the item's
/// .widget is needed.
///
/// When an item is removed with [removeItem] its animation is reversed.
/// The removed item's animation is passed to the [removeItem] builder
/// parameter.
///
/// An app that needs to insert or remove items in response to an event
/// can refer to the [SliverAnimatedList]'s state with a global key:
///
/// ```dart
/// GlobalKey<SliverAnimatedListState> listKey = GlobalKey<SliverAnimatedListState>();
/// ...
/// SliverAnimatedList(key: listKey, ...);
/// ...
/// listKey.currentState.insert(123);
/// ```
///
/// [SliverAnimatedList] item input handlers can also refer to their
/// [SliverAnimatedListState] with the static [SliverAnimatedList.of] method.
class SliverAnimatedListState extends State<SliverAnimatedList>
    with TickerProviderStateMixin {
  final List<_ActiveItem> _incomingItems = <_ActiveItem>[];
  final List<_ActiveItem> _outgoingItems = <_ActiveItem>[];
  int _itemsCount = 0;

  @override
  void initState() {
    super.initState();
    _itemsCount = widget.initialItemCount;
  }

  @override
  void dispose() {
    for (_ActiveItem item in _incomingItems.followedBy(_outgoingItems)) {
      item.controller.dispose();
    }
    super.dispose();
  }

  _ActiveItem _removeActiveItemAt(List<_ActiveItem> items, int itemIndex) {
    final int i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items.removeAt(i);
  }

  _ActiveItem _activeItemAt(List<_ActiveItem> items, int itemIndex) {
    final int i = binarySearch(items, _ActiveItem.index(itemIndex));
    return i == -1 ? null : items[i];
  }

  // The insertItem() and removeItem() index parameters are defined as if the
  // removeItem() operation removed the corresponding list entry immediately.
  // The entry is only actually removed from the ListView when the remove animation
  // finishes. The entry is added to _outgoingItems when removeItem is called
  // and removed from _outgoingItems when the remove animation finishes.

  int _indexToItemIndex(int index) {
    int itemIndex = index;
    for (_ActiveItem item in _outgoingItems) {
      if (item.itemIndex <= itemIndex)
        itemIndex += 1;
      else
        break;
    }
    return itemIndex;
  }

  int _itemIndexToIndex(int itemIndex) {
    int index = itemIndex;
    for (_ActiveItem item in _outgoingItems) {
      assert(item.itemIndex != itemIndex);
      if (item.itemIndex < itemIndex)
        index -= 1;
      else
        break;
    }
    return index;
  }

  SliverChildDelegate _createDelegate() {
    return SliverChildBuilderDelegate(_itemBuilder, childCount: _itemsCount);
  }

  /// Insert an item at [index] and start an animation that will be passed to
  /// [SliverAnimatedList.itemBuilder] when the item is visible.
  ///
  /// This method's semantics are the same as Dart's [List.insert] method:
  /// it increases the length of the list by one and shifts all items at or
  /// after [index] towards the end of the list.
  void insertItem(int index, {Duration duration = _kDuration}) {
    assert(index != null && index >= 0);
    assert(duration != null);

    final int itemIndex = _indexToItemIndex(index);
    assert(itemIndex >= 0 && itemIndex <= _itemsCount);

    // Increment the incoming and outgoing item indices to account
    // for the insertion.
    for (_ActiveItem item in _incomingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += 1;
    }
    for (_ActiveItem item in _outgoingItems) {
      if (item.itemIndex >= itemIndex) item.itemIndex += 1;
    }

    final AnimationController controller =
        AnimationController(duration: duration,  vsync: this);
    final _ActiveItem incomingItem =
        _ActiveItem.incoming(controller, itemIndex);
    setState(() {
      _incomingItems
        ..add(incomingItem)
        ..sort();
      _itemsCount += 1;
    });

    controller.forward().then<void>((_) {
      _removeActiveItemAt(_incomingItems, incomingItem.itemIndex)
          .controller
          .dispose();
    });
  }

  /// Remove the item at [index] and start an animation that will be passed
  /// to [builder] when the item is visible.
  ///
  /// Items are removed immediately. After an item has been removed, its index
  /// will no longer be passed to the [SliverAnimatedList.itemBuilder]. However
  /// the item will still appear in the list for [duration] and during that time
  /// [builder] must construct its widget as needed.
  ///
  /// This method's semantics are the same as Dart's [List.remove] method:
  /// it decreases the length of the list by one and shifts all items at or
  /// before [index] towards the beginning of the list.
  void removeItem(int index, AnimatedListRemovedItemBuilder builder,
      {Duration duration = _kDuration}) {
    assert(index != null && index >= 0);
    assert(builder != null);
    assert(duration != null);

    final int itemIndex = _indexToItemIndex(index);
    assert(itemIndex >= 0 && itemIndex < _itemsCount);
    assert(_activeItemAt(_outgoingItems, itemIndex) == null);

    final _ActiveItem incomingItem =
        _removeActiveItemAt(_incomingItems, itemIndex);
    final AnimationController controller = incomingItem?.controller ??
        AnimationController(duration: duration, value: 1.0);
    final _ActiveItem outgoingItem =
        _ActiveItem.outgoing(controller, itemIndex, builder);
    setState(() {
      _outgoingItems
        ..add(outgoingItem)
        ..sort();
    });

    controller.reverse().then<void>((void value) {
      _removeActiveItemAt(_outgoingItems, outgoingItem.itemIndex)
          .controller
          .dispose();

      // Decrement the incoming and outgoing item indices to account
      // for the removal.
      for (_ActiveItem item in _incomingItems) {
        if (item.itemIndex > outgoingItem.itemIndex) item.itemIndex -= 1;
      }
      for (_ActiveItem item in _outgoingItems) {
        if (item.itemIndex > outgoingItem.itemIndex) item.itemIndex -= 1;
      }

      setState(() {
        _itemsCount -= 1;
      });
    });
  }

  Widget _itemBuilder(BuildContext context, int itemIndex) {
    final _ActiveItem outgoingItem = _activeItemAt(_outgoingItems, itemIndex);
    if (outgoingItem != null)
      return outgoingItem.removedItemBuilder(
          context, outgoingItem.controller.view);

    final _ActiveItem incomingItem = _activeItemAt(_incomingItems, itemIndex);
    final Animation<double> animation =
        incomingItem?.controller?.view ?? kAlwaysCompleteAnimation;
    return widget.itemBuilder(context, _itemIndexToIndex(itemIndex), animation);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: _createDelegate(),
    );
  }
}
