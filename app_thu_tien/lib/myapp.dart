import 'package:app_thu_tien/admin/dashboard.dart';
import 'package:app_thu_tien/client/auth.dart';
import 'package:app_thu_tien/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: CupertinoColors.black.withOpacity(.3),
      overlayWidgetBuilder: (_) {
        return const Center(
          child: CupertinoActivityIndicator(
            color: CupertinoColors.white,
            radius: 20,
          ),
        );
      },
      child: GetCupertinoApp(
        title: 'Money Management',
        home: Const.isAdmin ? const DashboardPage() : const AuthPage(),
        debugShowCheckedModeBanner: false,
        onInit: () async {},
        onReady: () {},
      ),
    );
  }
}
