import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_service_demo/services/habits_manager.dart';
import 'package:flutter_audio_service_demo/services/pet_manager.dart';
import 'package:flutter_audio_service_demo/services/shop_manager.dart';

import '../page_manager.dart';
import 'audio_handler.dart';
import 'playlist_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(() => PlaylistRepository());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());

  getIt.registerLazySingleton<ShopManager>(() => ShopManager());

  getIt.registerLazySingleton<HabitsManager>(() => HabitsManager());

  getIt.registerLazySingleton<PetManager>(() => PetManager());
}
