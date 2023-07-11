import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class LoaderWidget extends StatefulWidget {
  final bool start;
  const LoaderWidget({
    super.key,
    required this.start,
  });

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with TickerProviderStateMixin {
  late AnimationController? controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        if (controller?.value != null && controller?.value != 0.0) {
          setState(() {});
        }
      });
    // controller!.repeat();
    if (widget.start) {
      controller!.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStateBloc, AppStateProps>(
        builder: (context, appSettingsProps) {
      if (controller!.value == 1.0) {
        var appStateBloc = context.read<AppStateBloc>();
        appSettingsProps.points.add(false);
        appStateBloc.add(const SetPointsEvent());
        controller!.reset();
        controller!.forward();
      }
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: LinearProgressIndicator(
                  value: controller!.value,
                  minHeight: 40,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: const Icon(
              Icons.lock_clock,
              color: Colors.white,
            ),
          )
        ],
      );
    });
  }
}
