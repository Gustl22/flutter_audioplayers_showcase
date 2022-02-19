import 'package:flutter/material.dart';
import 'package:flutter_audioplayers_showcase/util/asset.dart';
import 'package:flutter_audioplayers_showcase/util/audio/audio.dart';
import 'package:flutter_audioplayers_showcase/util/environment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSettingsScreen extends StatefulWidget {
  const CustomSettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomSettingsScreenState();
}

class CustomSettingsScreenState extends State<CustomSettingsScreen> {
  final String _bellSoundPath = env(bellSoundPath);

  String getBellNameOfPath(String value) => value.split('/').last.replaceAll('.mp3', '');

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Convert to list of entries with <String, String>, e.g. <'AirHorn', '/assets/audio/AirHorn.mp3'>

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
      ),
      body: FutureBuilder<List<String>>(
        future: getAssetList(prefix: '', filetype: '.mp3'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('loading');
          final List<MapEntry<String, String>> bellSoundValues = snapshot.data!
              .asMap()
              .map((key, value) => MapEntry<String, String>(value, getBellNameOfPath(value)))
              .entries
              .toList();
          return RadioDialog(
            values: bellSoundValues,
            initialValue: _bellSoundPath,
            onChanged: (value) async {
              if (value != null) {
                final sound = HornSound.source(value);
                await sound.play();
              }
            },
          );
        },
      ),
    );
  }
}

class RadioDialog extends StatefulWidget {
  final List<MapEntry<String?, String>> values;
  final String? initialValue;
  final void Function(String? value)? onChanged;

  const RadioDialog({
    Key? key,
    required this.values,
    required this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RadioDialog> createState() => _RadioDialogState();
}

class _RadioDialogState extends State<RadioDialog> {
  String? result;

  @override
  void initState() {
    result = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 300,
        child: ListView.builder(
          key: Key(result.toString()),
          shrinkWrap: true,
          itemCount: widget.values.length,
          itemBuilder: (context, index) {
            final entry = widget.values[index];
            return RadioListTile<String?>(
              value: entry.key,
              groupValue: result,
              onChanged: (v) {
                if (widget.onChanged != null) widget.onChanged!(v);
                setState(() {
                  result = v;
                });
              },
              title: Text(entry.value),
            );
          },
        ),
      ),
    );
  }
}
