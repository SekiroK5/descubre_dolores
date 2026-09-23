// Este archivo sustituye al widget_test.dart del contador que genera
// "flutter create", que fallaria con esta app.
// Prueba el caso de uso ObtenerLugarPorId con un Fake (sin Flutter ni multimedia).
import 'package:flutter_test/flutter_test.dart';
import 'package:descubre_dolores/domain/entities/lugar_turistico.dart';
import 'package:descubre_dolores/domain/repositories/lugares_repository.dart';
import 'package:descubre_dolores/domain/usecases/obtener_lugar_por_id.dart';

class FakeLugaresRepository implements LugaresRepository {
  final _lugares = const [
    LugarTuristico(
      id: '1',
      nombre: 'Jardin de prueba',
      descripcion: 'Descripcion',
      imagenAsset: 'x.jpg',
      audioAsset: 'x.mp3',
    ),
  ];

  @override
  Future<List<LugarTuristico>> obtenerTodos() async => _lugares;

  @override
  Future<LugarTuristico?> obtenerPorId(String id) async {
    for (final l in _lugares) {
      if (l.id == id) return l;
    }
    return null;
  }
}

void main() {
  final usecase = ObtenerLugarPorId(FakeLugaresRepository());

  test('ObtenerLugarPorId regresa el lugar cuando el id existe', () async {
    final lugar = await usecase('1');
    expect(lugar, isNotNull);
    expect(lugar!.nombre, 'Jardin de prueba');
  });

  test('ObtenerLugarPorId regresa null cuando el id no existe', () async {
    expect(await usecase('999'), isNull);
  });
}
