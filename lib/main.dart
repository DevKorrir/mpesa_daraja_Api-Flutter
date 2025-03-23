import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart' as di;

import 'core/presentation/pages/payment_page.dart';
import 'core/presentation/providers/payment_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable performance profiling if needed
  debugProfileBuildsEnabled = true;
  debugProfilePaintsEnabled = true;

  // Initialize dependency injection
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<PaymentProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'M-PESA Payment',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const PaymentPage(),
      ),
    );
  }
}
