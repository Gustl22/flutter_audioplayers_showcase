import 'package:flutter_audioplayers_showcase/ui/settings/preferences.dart';
import 'package:flutter_audioplayers_showcase/util/environment.dart';

import 'stub_audio_player.dart'
    if (dart.library.js) 'web_audio_player.dart'
    if (dart.library.io) 'default_audio_player.dart';

class HornSound {
  late Playable audioPlayer;
  late Future<void> isSourceSet;

  factory HornSound() {
    return HornSound._fromPreference();
  }
  
  factory HornSound.source(String source) {
    return HornSound._fromSource(source);
  }

  Future<void> play() async {
    await isSourceSet;
    await audioPlayer.play();
  }

  Future<void> dispose() async {
    await isSourceSet;
    await audioPlayer.dispose();
  }

  HornSound._fromSource(String source) {
    audioPlayer = getAudioPlayer();
    isSourceSet = audioPlayer.setSource(source);
  }
  
  HornSound._fromPreference() {
    audioPlayer = getAudioPlayer();
    isSourceSet = Preferences.getString(Preferences.keyBellSound)
        .then((value) => audioPlayer.setSource(value ?? env(bellSoundPath)));
    Preferences.onChangeBellSound.stream.listen((event) {
      isSourceSet = audioPlayer.setSource(event);
    });
  }
}

abstract class Playable {
  Future<void> play();

  Future<void> setSource(String url);

  Future<void> dispose();
}
