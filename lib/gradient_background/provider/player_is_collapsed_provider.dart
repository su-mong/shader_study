import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_is_collapsed_provider.g.dart';

@riverpod
class PlayerIsCollapsed extends _$PlayerIsCollapsed {
  @override
  bool build() {
    return false;
  }

  void setCollapsed(bool newValue) {
    state = newValue;
  }
}