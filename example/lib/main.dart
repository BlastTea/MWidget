import 'package:flutter/material.dart';
import 'package:m_widget/m_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final double imageHeight = 400.0;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Example App'),
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
                child: Text(
                  'Hello',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
                  opacity: curvedAnimation,
                  child: Align(
                    child: SizedBox(
                      height: ((MediaQuery.sizeOf(context).height - imageHeight) / 2 - 24.0) * animation.value,
                      child: child,
                    ),
                  ),
                ),
              ),
              SingleChildSheetDraggableTransition(
                tag: 'bottom',
                startTransition: 0.7,
                endTransition: 1.0,
                transitionCurve: SheetDraggableTransitionCurves.end,
                child: Text(
                  'World',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
                  opacity: curvedAnimation,
                  child: Align(
                    child: SizedBox(
                      height: ((MediaQuery.sizeOf(context).height - imageHeight) / 2 - 24.0) * animation.value,
                      child: child,
                    ),
                  ),
                ),
              ),
              SingleChildSheetDraggableTransition(
                tag: 'beside image',
                startTransition: 0.0,
                endTransition: 0.3,
                transitionCurve: SheetDraggableTransitionCurves.start,
                child: Text(
                  'Hello There',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                transitionBuilder: (context, animation, curvedAnimation, child) => FadeTransition(
                  opacity: curvedAnimation,
                  child: Positioned(
                    left: 32.0 + 48.0,
                    child: child,
                  ),
                ),
              ),
            ],
            builder: (context, scrollController, animation, children) => Container(
              decoration: BoxDecoration(
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
                              margin: const EdgeInsets.only(top: 8.0, bottom: 22.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                          ...children?.where((element) => element.tag == 'top').map((e) => e.child) ?? [],
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: Tween(begin: 48.0, end: MediaQuery.sizeOf(context).width).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)).value,
                              height: Tween(begin: 48.0, end: imageHeight).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)).value,
                              margin: const EdgeInsets.symmetric(horizontal: 16.0),
                              color: Colors.blue[50],
                              child: const FlutterLogo(),
                            ),
                          ),
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
      );
}
