import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mooltik/editing/ui/timeline/view/sliver/sliver.dart';

class ImageSliver extends Sliver {
  ImageSliver({
    @required Rect area,
    @required this.thumbnail,
    @required SliverId id,
    this.opacity = 1,
  }) : super(area, id);

  final ui.Image thumbnail;
  final double opacity;

  @override
  void paint(Canvas canvas) {
    final paint = Paint()..color = Colors.white.withOpacity(opacity);
    canvas.drawRRect(rrect, paint);

    if (thumbnail != null) _paintThumbnail(canvas, paint);
  }

  void _paintThumbnail(Canvas canvas, Paint paint) {
    canvas.save();
    canvas.clipRRect(rrect);
    canvas.translate(area.left, area.top);
    final double scaleFactor = area.height / thumbnail.height;
    canvas.scale(scaleFactor);

    final sliverWidth = rrect.width / scaleFactor;

    if (thumbnail.width > sliverWidth) {
      // Center thumbnail if it overflows sliver.
      final xOffset = (sliverWidth - thumbnail.width) / 2;
      canvas.drawImage(thumbnail, Offset(xOffset, 0), paint);
    } else {
      // Repeat thumbnails until overflow.
      for (double xOffset = 0;
          xOffset < sliverWidth;
          xOffset += thumbnail.width) {
        canvas.drawImage(thumbnail, Offset(xOffset, 0), paint);
      }
    }

    canvas.restore();
  }
}
