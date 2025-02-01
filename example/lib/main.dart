import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart' as cached;
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
  Widget build(BuildContext context) => MWidgetDynamicColorBuilder(
        builder: (context, theme, darkTheme, themeMode, colorScheme, darkColorScheme) => MaterialApp(
          navigatorKey: navigatorKey,
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: 'MWidget',
          theme: theme.copyWith(
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56.0),
                textStyle: kTextTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textControllerDropdownField = TextEditingController();
  final TextEditingControllerThousandFormat _textControllerThousandFormat = TextEditingControllerThousandFormat(invertThousandSeparator: true);

  final double imageHeight = 400.0;

  final SubmitFocusNode _submitFocusNode = SubmitFocusNode();

  final NumberPickerController _controller = NumberPickerController()..addListener(() => debugPrint('controllerListener'));

  DateTimeRange currentDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 30)));

  Uint8List? imageData;

  TimerController timerController = TimerController(duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('MWidget'),
                bottom: TabBar(tabs: ['First Tab', 'Second Tab'].map((e) => Tab(text: e)).toList()),
                actions: [
                  const ThemeSwitcher.iconButton(),
                  IconButton(
                    onPressed: () => NavigationHelper.to(
                      AdaptiveDialogRoute(
                        builder: (context) => ChooseDialog(
                          data: () => [
                            'Sapi',
                            'Kerbau',
                            'Kucing',
                            'Harimau',
                          ]
                              .map(
                                (e) => ChooseData(
                                  value: e,
                                  searchValue: e,
                                  title: Text(e),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.access_time),
                  ),
                  IconButton(
                    onPressed: () => ImageContainer.handleChangeImage(
                      showDelete: false,
                      allowPickImageFromGallery: true,
                      forceUsingSheet: true,
                    ).then((value) async {
                      imageData = await value.image?.readAsBytes();
                      setState(() {});
                    }),
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
              body: TabBarView(
                children: [
                  // First Tab
                  ListView(
                    padding: responsivePadding(MediaQuery.sizeOf(context)),
                    children: [
                      TimerProgressIndicator(
                        controller: timerController,
                        progressNotifier: ValueNotifier(0.35),
                        messageNotifier: ValueNotifier('Hey'),
                      ),
                      DropdownField(
                        controller: _textControllerDropdownField,
                        items: FieldItem.values
                            .map(
                              (e) => PopupMenuItem(
                                value: e,
                                child: Text(e.value),
                              ),
                            )
                            .toList(),
                        readOnly: true,
                        onSelected: (value) => _textControllerDropdownField.text = value?.value ?? '?',
                      ),
                      TextField(
                        controller: _textControllerThousandFormat,
                      ),
                      FilledButton(
                        onPressed: () => showErrorDialog('Hello', primaryFilledButton: true),
                        child: const Text('Hello'),
                      ),
                      ListTile(
                        title: const Text('test'),
                        selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
                        selected: true,
                        onTap: () {},
                      ),
                      const SizedBox(height: 16.0),
                      DateRangeField(
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        value: currentDateRange,
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
                        key: UniqueKey(),
                        tag: 'hero',
                        width: double.infinity,
                        height: 400.0,
                        // borderRadius: BorderRadius.zero,
                        // containerGradient: const LinearGradient(
                        //   begin: AlignmentDirectional.topCenter,
                        //   end: AlignmentDirectional.bottomCenter,
                        //   colors: [
                        //     Colors.black,
                        //     Colors.transparent,
                        //     Colors.transparent,
                        //   ],
                        // ),
                        // dialogGradient: const LinearGradient(
                        //   begin: AlignmentDirectional.topCenter,
                        //   end: AlignmentDirectional.bottomCenter,
                        //   colors: [
                        //     Colors.transparent,
                        //     Colors.transparent,
                        //     Colors.transparent,
                        //   ],
                        // ),
                        // image: const NetworkImage('https://plus.unsplash.com/premium_photo-1691338312403-e9f7f7984eeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80'),
                        // image: const AssetImage('assets/purple-image.jpg'),
                        // image: const cached.CachedNetworkImageProvider('https://dev-sirama.properiideal.id/storage/profile/shark.png'),
                        // image: const cached.CachedNetworkImageProvider('https://avatars.githubusercontent.com/u/116476102?v=4'),
                        image: imageData != null ? MemoryImage(imageData!) : null,
                        containerBackgroundColor: Colors.red,
                        // cachedNetworkImageError: (e) => const AssetImage('assets/purple-image.jpg'),
                        // dialogFit: BoxFit.contain,
                        extendedAppBar: AppBar(
                          title: const Text('Detail image'),
                        ),
                        // useDynamicColor: true,
                        // skipDialog: true,
                        child: const Center(child: Text('Gambar kosong bro!')),
                      ),
                      const SizedBox(height: 16.0),
                      ImageContainer.hero(
                        tag: 'ASDF',
                        height: 400.0,
                        icon: Icons.abc,
                        containerIconColor: Theme.of(context).colorScheme.surface,
                        dialogIconColor: Colors.red,
                        containerIconSize: 48.0,
                        dialogIconSize: 96.0,
                        containerBackgroundColor: Theme.of(context).colorScheme.onSurface,
                        dialogBackgroundColor: Colors.blue,
                        extendedAppBar: AppBar(
                          title: const Text('Hello'),
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
                      const SizedBox(height: 90),
                    ],
                  ),
                  // Second Tab
                  ListView(
                    children: [
                      TimerProgressIndicator(
                        controller: timerController,
                        progressNotifier: ValueNotifier(0.35),
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ],
              ),
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
            builder: (context, scrollController, animation, children) => DraggableScrollableBody(
              themeMode: MWidget.themeValue.themeMode,
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.lerp(
                BorderRadius.zero,
                const BorderRadius.vertical(
                  top: Radius.circular(kShapeExtraLarge),
                ),
                animation.value,
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

enum FieldItem {
  sapi('sapi'),
  kerbau('kerbau'),
  kucing('kucing'),
  harimau('harimau');

  const FieldItem(this.value);
  final String value;
}
