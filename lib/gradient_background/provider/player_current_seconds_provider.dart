import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_current_seconds_provider.g.dart';

@Riverpod(keepAlive: true)
class PlayerCurrentSeconds extends _$PlayerCurrentSeconds {
  @override
  int build() {
    return 0;
  }

  void change(int newSeconds) {
    state = newSeconds;
  }
}