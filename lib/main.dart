

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:samples/di.dart';
import 'package:samples/firebase_options.dart';
import 'package:samples/music_module/view/music_main_home_screen.dart';
import 'package:samples/src/posts/view/posts_screen.dart';
import 'package:samples/utils/mutli_provider.dart';

final navKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Platform.isIOS
  //     ? await Firebase.initializeApp(
  //         options: DefaultFirebaseOptions.currentPlatform)
  //     : await Firebase.initializeApp();

  initDependencyInjection();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderList.providers,
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              navigatorObservers: <NavigatorObserver>[observer],
              navigatorKey: navKey,
              routes: {
                "/next": (_) => const MusicMainHomeScreen(),
              },

              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  useMaterial3: true,
                  brightness: Brightness.dark),
              //home: const FileDownloadHomeScreen(),
              //home: const SampleStreamHomeScreen(),
              //home: const PainterScreen(),
              // home: const FilterScreen(),
              // home: const CustomLoader(
              //   duration: Duration(milliseconds: 600),
              //   size: Size(180, 180),
              //   strokewidth: 25,
              // ),
              /*<------------------Image List Home Screen-------------------->*/
              //home: const VideoListingHomeScreen(),
              //home: const SplashScreen(),
              //home: const EnterDetailsScreen(),
              // home: const TicketBookCustomPainterScreen(),
              /*    home: MainHomeScreen(
                leftIcon: IconItem(
                    onTap: () => navigateToNextScreen(navKey.currentContext!),
                    svg: Assets.svgAlertSvg,
                    title: "Alert"),
                rightIcon: IconItem(
                    onTap: () => navigateToNextScreen(navKey.currentContext!),
                    svg: Assets.svgConvertSvg,
                    title: "Convert"),
                topIcon: IconItem(
                    onTap: () => navigateToNextScreen(navKey.currentContext!),
                    svg: Assets.svgLoyaltySvg,
                    title: "Loyalty"),
              ),  */
              // home: const InfographicPainterScreen(),
              //home: const SolarSystemPainterScreen(),
              // home: const MusicMainHomeScreen(),
              //home: const UniLinkScreen(),
              //home: const HomeScreen(),
              //home: const BilbleHomeScreen(),
              //home: const FinanceCardPainterScreen(),

              // home: const SensorHomeScreen(),
              home: const PostsScreen(),
              // home: const GridPaperScreen(),
              //home: const RiverPodSampleHomeScreen(),
            );
          }),
    );
  }

  navigateToNextScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      "/next",
    );
  }
}
