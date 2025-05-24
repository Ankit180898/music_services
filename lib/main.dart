import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:music_services/firebase_options.dart';
import 'package:music_services/repository/music_service_repository.dart';
import 'package:music_services/view/home_screen.dart';
import 'package:music_services/view_model/music_service_view_model.dart';
import 'package:provider/provider.dart';

import 'services/firebase_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Repositories
  getIt.registerLazySingleton<MusicServiceRepository>(
    () => MusicServiceRepository(getIt<FirebaseService>()),
  );

  // ViewModels
  getIt.registerFactory<MusicServiceViewModel>(
    () => MusicServiceViewModel(getIt<MusicServiceRepository>()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set up dependencies
  setupDependencies();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<MusicServiceViewModel>()),
      ],
      child: MaterialApp(
        title: 'Music Services',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Inter',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
