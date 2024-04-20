import 'dart:async';

import 'package:flutter/material.dart';

class DebounceGestureDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final int debounceTimeMs;
  final Duration duration;
  final VoidCallback? onDoubleTap;

  DebounceGestureDetector({
    required Widget child,
    required VoidCallback onTap,
    VoidCallback? onDoubleTap,
    VoidCallback? onLongPress,
    this.debounceTimeMs = 1000,
  })  : this.child = child,
        this.onTap = onTap,
        this.onLongPress = onLongPress,
        this.onDoubleTap = onDoubleTap,
        this.duration = Duration(milliseconds: debounceTimeMs);

  @override
  State<DebounceGestureDetector> createState() =>
      _DebounceGestureDetectorState();
}

class _DebounceGestureDetectorState extends State<DebounceGestureDetector> {
  late ValueNotifier<bool> _isEnabled = ValueNotifier<bool>(true);
  late Timer? _debouncer =
      Timer(widget.duration, () => _isEnabled.value = true);

  @override
  void dispose() {
    super.dispose();
    _debouncer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isEnabled,
      builder: (context, isEnabled, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isEnabled == true ? _onButtonPressed : null,
        onDoubleTap: widget.onDoubleTap != null
            ? () {
                widget.onDoubleTap!();
              }
            : null,
        onLongPress: widget.onLongPress != null
            ? () {
                widget.onLongPress!();
              }
            : null,
        child: widget.child,
      ),
    );
  }

  void _onButtonPressed() {
    _isEnabled.value = false;
    widget.onTap();
    _debouncer = Timer(widget.duration, () => _isEnabled.value = true);
  }
}
