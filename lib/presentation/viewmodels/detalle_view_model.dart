import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/lugar_turistico.dart';

class DetalleViewModel extends ChangeNotifier {
  final LugarTuristico lugar;
  final AudioPlayer _reproductor = AudioPlayer();
  StreamSubscription<void>? _finSub;
  bool reproduciendo = false;

  DetalleViewModel(this.lugar) {
    // Cuando la audioguia termina, regresamos el boton a "Escuchar".
    _finSub = _reproductor.onPlayerComplete.listen((_) {
      reproduciendo = false;
      notifyListeners();
    });
  }

  Future<void> alternarAudio() async {
    if (reproduciendo) {
      await _reproductor.pause();
    } else {
      await _reproductor.play(AssetSource(lugar.audioAsset));
    }
    reproduciendo = !reproduciendo;
    notifyListeners();
  }

  @override
  void dispose() {
    _finSub?.cancel();
    _reproductor.dispose();
    super.dispose();
  }
}
