import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_service_demo/screens/HabitsScreen/HabitsScreen.dart';
import 'package:flutter_audio_service_demo/screens/MusicScreen/MusicScreen.dart';
import 'package:flutter_audio_service_demo/screens/PetScreen/PetScreen.dart';
import 'package:flutter_audio_service_demo/screens/ShopScreen/ShopScreen.dart';
import 'package:flutter_audio_service_demo/screens/TodoScreen/TodoScreen.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';
import 'package:flutter_audio_service_demo/theme/theme.dart';
import 'package:flutter_audio_service_demo/widgets/NowPlayingBar/NowPlayingBar.dart';
import 'package:flutter_audio_service_demo/widgets/PetStats/PetStats.dart';
import 'page_manager.dart';
import 'services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await setupServiceLocator();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState(savedThemeMode: savedThemeMode);
}

class _MyAppState extends State<MyApp> {
  final AdaptiveThemeMode? savedThemeMode;

  _MyAppState({
    this.savedThemeMode,
  });

  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
    getIt<HabitsManager>().init();
    getIt<ShopManager>().init();
    getIt<PetManager>().init();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightThemeData,
      dark: darkThemeData,
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  ShopManager shopManager = getIt<ShopManager>();
  late TabController _tabController;

  @override
  void initState() {
    shopManager.applySavedTheme(context);
    _tabController = TabController(
        length: 5,
        initialIndex: 2,
        vsync: this); // Set the initially active tab index (2 is centered)

    super.initState();
  }

  final List<Widget> _pages = [
    const HabitsScreen(),
    const TodoScreen(),
    const MusicScreen(),
    const PetScreen(),
    const ShopScreen(),
  ];

  @override
  build(BuildContext context) {
    TabItem<dynamic> getTabItem(IconData icon, {double iconSize = 28}) {
      final activeColor = Theme.of(context).colorScheme.primary;
      final restColor = Theme.of(context).disabledColor;
      return TabItem(
          icon: Icon(icon, size: iconSize, color: restColor),
          activeIcon: Icon(icon, size: iconSize, color: activeColor));
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PetStats(),
            Expanded(
              child: TabBarView(controller: _tabController, children: _pages),
            ),
            const NowPlayingBar()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ConvexAppBar(
            elevation: 0,
            style: TabStyle.fixedCircle,
            height: 50,
            top: -20,
            curveSize: 100,
            controller: _tabController,
            items: [
              getTabItem(Icons.home),
              getTabItem(Icons.task_alt),
              const TabItem(icon: Icons.music_note),
              getTabItem(Icons.pets),
              getTabItem(Icons.shopping_cart),
            ],
            onTap: (int index) {
              // Handle tab item tap here
            },
            backgroundColor: Theme.of(context).colorScheme.background,
            activeColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
    );
  }
}
