part of 'widgets.dart';

class TimerProgressIndicator extends StatefulWidget {
  const TimerProgressIndicator({
    super.key,
    this.controller,
    required this.progressNotifier,
    this.messageNotifier,
    this.width,
    this.padding,
  });

  final TimerController? controller;
  final ValueNotifier<double?> progressNotifier;
  final ValueNotifier<String?>? messageNotifier;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator> {
  final ValueNotifier<String> timeElapsedNotifier = ValueNotifier('%s Seconds'.trArgs(['00']));

  late TimerController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TimerController(duration: const Duration(seconds: 1));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _onTimerCallback());
    controller.addListener(_onTimerCallback);
  }

  @override
  void dispose() {
    controller.removeListener(_onTimerCallback);
    super.dispose();
  }

  void _onTimerCallback() => setState(
        () {
          Duration timeElapsed = Duration(seconds: controller.timer.tick);
          String formattedTime = formatDuration(timeElapsed);
          timeElapsedNotifier.value = formattedTime;
        },
      );

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: SizedBox(
            width: widget.width ?? responsiveDialogWidth(MediaQuery.sizeOf(context)),
            height: 44.0 + (widget.messageNotifier != null ? 20.0 : 0.0),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: widget.progressNotifier,
                    builder: (context, value, child) => Row(
                      children: [
                        Expanded(child: LinearProgressIndicator(value: value)),
                        const SizedBox(width: 8.0),
                        Text('%s%'.trArgs([((value ?? 0.0) * 100.0).round().toString()])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  ValueListenableBuilder(
                    valueListenable: timeElapsedNotifier,
                    builder: (context, value, child) => Text(timeElapsedNotifier.value),
                  ),
                  if (widget.messageNotifier != null)
                    ValueListenableBuilder(
                      valueListenable: widget.messageNotifier!,
                      builder: (context, value, child) => Text(widget.messageNotifier!.value ?? ''),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}

class TimerController extends ChangeNotifier {
  TimerController({Duration duration = const Duration(seconds: 1)}) {
    timer = Timer.periodic(
      duration,
      (timer) => notifyListeners(),
    );
  }

  late Timer timer;
}
