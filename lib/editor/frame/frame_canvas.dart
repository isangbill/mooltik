import 'package:flutter/material.dart';

import '../toolbar/tools.dart';
import 'frame_painter.dart';
import 'frame.dart';
import 'canvas_gesture_detector.dart';

class FrameCanvas extends StatefulWidget {
  FrameCanvas({
    Key key,
    @required this.frame,
    @required this.selectedTool,
  }) : super(key: key);

  final Frame frame;
  final Tool selectedTool;

  @override
  _FrameCanvasState createState() => _FrameCanvasState();
}

class _FrameCanvasState extends State<FrameCanvas> {
  double _topOffset = 0;
  Offset _lastFocal;

  @override
  Widget build(BuildContext context) {
    return CanvasGestureDetector(
      onStrokeStart: (Offset position) {
        setState(() {
          if (widget.selectedTool == Tool.pencil) {
            widget.frame.startPencilStroke(position);
          } else if (widget.selectedTool == Tool.eraser) {
            widget.frame.startEraserStroke(position);
          }
        });
      },
      onStrokeUpdate: (Offset position) {
        setState(() {
          widget.frame.extendLastStroke(position);
        });
      },
      onScaleStart: (ScaleStartDetails details) {
        _lastFocal = details.localFocalPoint;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        final diff = details.localFocalPoint - _lastFocal;
        _lastFocal = details.localFocalPoint;

        setState(() {
          _topOffset += diff.dy;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.transparent),
          Positioned(
            top: _topOffset,
            width: widget.frame.width,
            height: widget.frame.height,
            child: CustomPaint(
              foregroundPainter: FramePainter(widget.frame),
              child: Container(
                color: Colors.white,
                height: widget.frame.height,
                width: widget.frame.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
