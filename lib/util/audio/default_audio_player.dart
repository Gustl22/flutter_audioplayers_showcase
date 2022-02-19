import 'package:audioplayers/audioplayers.dart';

import 'audio.dart';

class DefaultAudioPlayer implements Playable {
  AudioCache cache = AudioCache(prefix: '');
  String url = '';

  DefaultAudioPlayer();

  @override
  Future<void> play() async {
    await cache.play(url);
  }

  @override
  Future<void> setSource(String url) async {
    this.url = url;
  }

  @override
  Future<void> dispose() async {
    await cache.clearAll();
  }
}

Playable getAudioPlayer() => DefaultAudioPlayer();
