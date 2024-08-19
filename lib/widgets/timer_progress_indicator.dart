part of 'widgets.dart';

class TimerProgressIndicator extends StatefulWidget {
  const TimerProgressIndicator({
    super.key,
    required this.progressNotifier,
    this.messageNotifier,
  });

  final ValueNotifier<double?> progressNotifier;
  final ValueNotifier<String?>? messageNotifier;

  @override
  State<TimerProgressIndicator> createState() => _TimerProgressIndicatorState();
}

class _TimerProgressIndicatorState extends State<TimerProgressIndicator> {
  final ValueNotifier<String> timeElapsedNotifier = ValueNotifier(Language.getInstance().getValue('{0} Seconds', ['00'])!);

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(
        () {
          Duration timeElapsed = Duration(seconds: timer.tick);
          String formattedTime = formatDuration(timeElapsed);
          timeElapsedNotifier.value = formattedTime;
        },
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: SizedBox(
            width: responsiveDialogWidth(MediaQuery.sizeOf(context)),
            height: 44.0 + (widget.messageNotifier != null ? 20.0 : 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: widget.progressNotifier,
                    builder: (context, value, child) => Row(
                      children: [
                        Expanded(child: LinearProgressIndicator(value: value)),
                        const SizedBox(width: 8.0),
                        Text(Language.getInstance().getValue('{0}%', [((value ?? 0.0) * 100.0).round()])!),
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
