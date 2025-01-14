import 'package:flutter/material.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/widgets/icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'project_dropdown.dart';

class ProjectsDropdownWidget extends StatelessWidget {
  const ProjectsDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OverlayEntry? overlayEntry;
    final GlobalKey buttonkey = LabeledGlobalKey("drop_down_key");

    void removeOverlay() {
      if (overlayEntry != null) overlayEntry?.remove();
      overlayEntry = null;
    }

    return SmartTaskIconButtonWidget(
      key: buttonkey,
      width: 24.w,
      height: 24.w,
      svgPath: AppAssets.arrowDown,
      onPressed: () {
        removeOverlay();
        overlayEntry = _createOverlayEntry(buttonkey, removeOverlay);
        Overlay.of(context).insert(overlayEntry!);
      },
    );
  }

  OverlayEntry _createOverlayEntry(GlobalKey key, VoidCallback dismiss) {
    RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
          left: 0,
          top: position.dy + size.height,
          width: 1.sw,
          child: DropdownListWidget(dismiss: dismiss)),
    );
  }
}
