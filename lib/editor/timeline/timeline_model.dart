import 'package:flutter/material.dart';

import '../frame/frame_model.dart';

class TimelineModel extends ChangeNotifier {
  TimelineModel({
    @required initialKeyframes,
  })  : assert(initialKeyframes.isNotEmpty),
        keyframes = initialKeyframes;

  List<FrameModel> keyframes;
  int _selectedKeyframeId = 0;

  int get selectedKeyframeId => _selectedKeyframeId;
  FrameModel get selectedKeyframe => keyframes[_selectedKeyframeId];

  void selectFrame(int id) {
    assert(id >= 0 && id <= keyframes.length);
    _selectedKeyframeId = id;
    notifyListeners();
  }

  void addEmptyFrame() {
    keyframes.insert(_selectedKeyframeId + 1, FrameModel());
    notifyListeners();
  }
}
