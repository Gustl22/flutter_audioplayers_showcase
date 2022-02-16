import 'package:audioplayers/audioplayers.dart';

import 'audio.dart';

class DefaultAudioPlayer implements Playable {
  AudioCache player = AudioCache(prefix: '');
  String url = '';

  DefaultAudioPlayer();

  @override
  Future<void> play() async {
    player.play(url);
  }

  @override
  Future<void> setSource(String url) async {
    this.url = url;
  }

  @override
  void dispose() {
    player.clearAll();
  }
}

Playable getAudioPlayer() => DefaultAudioPlayer();
