import 'package:flutter/material.dart';

class CustomCurvedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Function(int) onTap;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final double height;
  final Duration animationDuration;

  const CustomCurvedNavigationBar({
    super.key,
    required this.items,
    this.index = 0,
    required this.onTap,
    this.color = Colors.white,
    this.buttonBackgroundColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.height = 75.0,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  _CustomCurvedNavigationBarState createState() =>
      _CustomCurvedNavigationBarState();
}

class _CustomCurvedNavigationBarState extends State<CustomCurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    _length = widget.items.length;
    _pos = widget.index / _length; // Normalized position (0.0 to 1.0ish)
    _startingPos = widget.index / _length;
    _endingIndex = widget.index;
    _icon = widget.items[widget.index];
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
      });
    });
  }

  @override
  void didUpdateWidget(CustomCurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(
        newPosition,
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Calculate the width of one item slot
    double itemWidth = size.width / _length;

    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Background Curve
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: CustomPaint(
              painter: NavPainter(
                _pos,
                _length,
                widget.color,
                Directionality.of(context),
              ),
              child: Container(height: widget.height),
            ),
          ),

          // Floating Icon Button
          Positioned(
            left: Directionality.of(context) == TextDirection.ltr
                ? _pos * size.width
                : null,
            right: Directionality.of(context) == TextDirection.rtl
                ? _pos * size.width
                : null,
            width: itemWidth,
            top: -30, // Moves the button up above the bar
            child: Center(
              child: Material(
                color: widget.buttonBackgroundColor,
                shape: const CircleBorder(),
                elevation: 4,
                child: Container(
                  width: 55,
                  height: 55,
                  padding: const EdgeInsets.all(8),
                  child: _icon,
                ),
              ),
            ),
          ),

          // Row of Icons
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: widget.height,
              child: Row(
                children: widget.items.map((item) {
                  int itemIndex = widget.items.indexOf(item);
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.onTap(itemIndex);
                      },
                      child: Center(
                        // Hide the item if it matches the CURRENTLY SELECTED index
                        // So it disappears from the row and appears in the bubble
                        child: itemIndex == _endingIndex
                            ? const SizedBox() // Hidden
                            : item,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavPainter(
    double startingLoc,
    int itemsLength,
    this.color,
    this.textDirection,
  ) {
    s = 0.2; // Curve size related
    // Normalized center of the item curve
    loc = startingLoc + (1.0 / itemsLength) / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);

    // Calculate actual pixel position for the notch center
    double x = 0;
    if (textDirection == TextDirection.rtl) {
      x = size.width - (loc * size.width);
    } else {
      x = loc * size.width;
    }

    // Smoother Curve Logic
    double top = 0;
    double bottom = 35.0; // Slightly deeper for better look
    double width = 90.0; // Wider curve for clearer separation

    path.lineTo(x - width / 2, top);

    // P0: (x - width/2, 0)
    // P1: (x - width/3, 0) -- Control point for top flatness
    // P2: (x - width/4, bottom) -- Control point for the drop
    // P3: (x, bottom) -- Bottom center

    path.cubicTo(x - (width / 3), top, x - (width / 4), bottom, x, bottom);

    path.cubicTo(
      x + (width / 4),
      bottom,
      x + (width / 3),
      top,
      x + width / 2,
      top,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
