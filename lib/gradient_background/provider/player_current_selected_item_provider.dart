import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_current_selected_item_provider.g.dart';

@riverpod
class PlayerCurrentSelectedItem extends _$PlayerCurrentSelectedItem {
  @override
  String? build() {
    return null;
  }

  void selectItem(String id) {
    state = id;
  }
}