import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import 'audio.dart';

class DefaultAudioPlayer implements Playable {
  static AudioCache cache = AudioCache(prefix: '');
  String url = '';

  DefaultAudioPlayer();

  @override
  Future<void> play() async {
    final player = await cache.play(url);
    player.onPlayerCompletion.listen((_) {
      print('onPlayerCompletion');
      player.dispose();
    });
  }

  @override
  Future<void> setSource(String url) async {
    this.url = url;
    await cache.load(url);
  }

  @override
  Future<void> dispose() async {
    await cache.clearAll();
  }
}

Playable getAudioPlayer() => DefaultAudioPlayer();
