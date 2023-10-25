import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:m_widget/m_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MWidget.initialize(
    defaultLanguage: LanguageType.indonesiaIndonesian,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();

  final double imageHeight = 400.0;

  final SubmitFocusNode _submitFocusNode = SubmitFocusNode();

  final NumberPickerController _controller = NumberPickerController()
    ..addListener(() {
      debugPrint('controllerListener');
    });

  DateTimeRange currentDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 30)));

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Example App'),
              actions: [
                IconButton(
                  onPressed: () => ImageContainer.handleChangeImage(
                    showDelete: false,
                    allowPickImageFromGallery: true,
                    forceUsingSheet: true,
                  ),
                  icon: const Icon(Icons.photo_camera),
                ),
                IconButton(
                  onPressed: () => NavigationHelper.showModalBottomSheet(
                    builder: (context) => SheetImageSource(
                      showGallery: false,
                      showDelete: false,
                      title: Text(Language.getInstance().getValue('Change logo')!),
                    ),
                  ),
                  icon: const Icon(Icons.question_mark),
                ),
              ],
            ),
            body: ListView(
              padding: responsivePadding(MediaQuery.sizeOf(context)),
              children: [
                const SizedBox(height: 16.0),
                DateRangeField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                  dateRange: currentDateRange,
                  onDateChanged: (value) => setState(() => value != null ? currentDateRange = value : null),
                ),
                const SizedBox(height: 16.0),
                ButtonEdit(
                  onCancelDisabledPressed: () => debugPrint('onCancelDisabledPressed'),
                ),
                const SizedBox(height: 16.0),
                DropdownField(
                  controller: _textController,
                  items: ['Hello', 'World']
                      .map(
                        (e) => PopupMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Dropdown field',
                  ),
                ),
                const SizedBox(height: 16.0),
                ImageContainer.hero(
                  tag: 'hero',
                  width: double.infinity,
                  height: 400.0,
                  border: const Border(),
                  iconSize: 24.0,
                  // borderRadius: BorderRadius.zero,
                  containerGradient: const LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                  dialogGradient: const LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                  image: const NetworkImage('https://plus.unsplash.com/premium_photo-1691338312403-e9f7f7984eeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80'),
                  extendedAppBar: AppBar(
                    title: const Text('Detail image'),
                  ),
                ),
                const SizedBox(height: 16.0),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    width: double.infinity,
                    height: 200.0,
                  ),
                  child: TextField(
                    focusNode: _submitFocusNode,
                    expands: true,
                    maxLines: null,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    onSubmitted: (value) {
                      debugPrint('submitted $value');
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                NumberPicker(
                  controller: _controller,
                  onChanged: (value) => debugPrint('onChanged $value'),
                ),
                const SizedBox(height: 16.0),
                NumberPicker(
                  controller: _controller,
                ),
                const SizedBox(height: 16.0),
                NumberPicker(
                  controller: _controller,
                ),
                const SizedBox(height: 16.0),
                NumberPicker(
                  controller: _controller,
                ),
                const SizedBox(height: 16.0),
                NumberPicker(
                  controller: _controller,
                ),
                const SizedBox(height: 16.0),
                FilledButton(
                  onPressed: () => NavigationHelper.to(
                    AdaptiveDialogRoute(
                      builder: (context) => ChooseDialog(
                        data: () => [],
                      ),
                    ),
                  ),
                  child: const Text('Show Choose Dialog'),
                ),
              ],
            ),
          ),
          AnimatedDraggableScrollableSheet(
            minChildSize: 90 / MediaQuery.sizeOf(context).height,
            snap: true,
            snapAnimationDuration: const Duration(milliseconds: 150),
            transitions: [
              SingleChildSheetDraggableTransition(
                tag: 'top',
                startTransition: 0.7,
                endTransition: 1.0,
                transitionCurve: SheetDraggableTransitionCurves.end,
                child: const Text(
                  'Hello',
                  // style: Theme.of(context).textTheme.headlineLarge,
                ),
                transitionBuilder: (context, animation, curvedAnimation, child) {
                  return FadeTransition(
                    opacity: curvedAnimation,
                    child: Align(
                      child: SizedBox(
                        // height: ((MediaQuery.sizeOf(context).height - imageHeight) / 2 - 24.0) * animation.value,
                        child: child,
                      ),
                    ),
                  );
                },
                alwaysVisible: false,
              ),
              SingleChildSheetDraggableTransition(
                tag: 'top',
                startTransition: 0.0,
                endTransition: 0.3,
                transitionCurve: SheetDraggableTransitionCurves.start,
                child: const Text(
                  'World',
                  // style: Theme.of(context).textTheme.headlineLarge,
                ),
                transitionBuilder: (context, animation, curvedAnimation, child) {
                  return FadeTransition(
                    opacity: curvedAnimation,
                    child: Align(
                      child: SizedBox(
                        // height: (MediaQuery.sizeOf(context).height) * animation.value,
                        child: child,
                      ),
                    ),
                  );
                },
                alwaysVisible: false,
              ),
              // SingleChildSheetDraggableTransition(
              //   tag: 'bottom',
              //   startTransition: 0.7,
              //   endTransition: 1.0,
              //   transitionCurve: SheetDraggableTransitionCurves.end,
              //   child: Text(
              //     'World',
              //     style: Theme.of(context).textTheme.headlineLarge,
              //   ),
              //   transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
              //     opacity: curvedAnimation,
              //     child: Align(
              //       child: SizedBox(
              //         height: ((MediaQuery.sizeOf(context).height - imageHeight) / 2 - 24.0) * animation.value,
              //         child: child,
              //       ),
              //     ),
              //   ),
              // ),
              // SingleChildSheetDraggableTransition(
              //   tag: 'beside image',
              //   startTransition: 0.0,
              //   endTransition: 0.3,
              //   transitionCurve: SheetDraggableTransitionCurves.start,
              //   child: Text(
              //     'Hello There',
              //     style: Theme.of(context).textTheme.headlineLarge,
              //   ),
              //   transitionBuilder: (context, animation, curvedAnimation, child) => Positioned(
              //     left: 32.0 + 48.0,
              //     child: FadeTransition(
              //       opacity: curvedAnimation,
              //       child: child,
              //     ),
              //   ),
              // ),
            ],
            builder: (context, scrollController, animation, children) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.lerp(
                  BorderRadius.zero,
                  const BorderRadius.vertical(
                    top: Radius.circular(kShapeExtraLarge),
                  ),
                  animation.value,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior.all,
                  child: Stack(
                    children: [
                      ListView(
                        controller: scrollController,
                        children: [
                          Align(
                            child: Container(
                              width: 32.0,
                              height: 4.0,
                              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                          ...children?.where((element) => element.tag == 'top').map((e) => e.child) ?? [],
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Container(
                          //     width: Tween(begin: 48.0, end: MediaQuery.sizeOf(context).width).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)).value,
                          //     height: Tween(begin: 48.0, end: imageHeight).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)).value,
                          //     margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          //     color: Colors.blue[50],
                          //     child: const FlutterLogo(),
                          //   ),
                          // ),
                          ...children?.where((element) => element.tag == 'bottom').map((e) => e.child) ?? [],
                        ],
                      ),
                      ...children?.where((element) => element.tag == 'beside image').map((e) => e.child) ?? [],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
