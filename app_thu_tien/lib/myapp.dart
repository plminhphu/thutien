import 'package:money_management/admin/dashboard.dart';
import 'package:money_management/client/auth.dart';
import 'package:money_management/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.black87,
      overlayWidgetBuilder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
      child: GetMaterialApp(
        title: 'Money Management',
        home: Const.isAdmin ? const DashboardPage() : const AuthPage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          applyElevationOverlayColor: true,
          primaryColor: Colors.blue.shade900,
          useMaterial3: false,
        ),
      ),
    );
  }
}
