import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:genshinfan/resources/utils/config.dart';
import 'package:get_storage/get_storage.dart';

init() async {
  await GetStorage.init();
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 2),
  ));
  await remoteConfig.setDefaults(<String, dynamic>{
    Config.keyLinkDiscord: Config.linkJoinDiscord,
    Config.keyLinkContributeTranslation: "https://google.com/",
  });
}
