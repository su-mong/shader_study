import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/playlist_song_color_model.dart';
import '../model/playlist_song_model.dart';

part 'playlist_provider.g.dart';

@riverpod
class Playlist extends _$Playlist {
  @override
  List<PlaylistSongModel> build() {
    return const [
      PlaylistSongModel(
        '0', artistName: 'Otonose Kanade', songImageUrl: 's_cheerful_vibes_echo.jpg', title: 'Cheerful Vibes Echo', albumName: 'Cheerful Vibes Echo (Otonose Kanade SOLO)',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFFFE7B5), secondary: Color(0xFFFFD8B5), accent1: Color(0xFFFFE0C2), accent2: Color(0xFFFFCB9A)),
      ),
      PlaylistSongModel(
        '1', artistName: 'Juufuutei Raden', songImageUrl: 's_otoshi_banashi.jpg', title: 'Otoshi Banashi', albumName: 'Otoshi Banashi (Juufuutei Raden SOLO)',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF3D7C71), secondary: Color(0xFF2F6A63), accent1: Color(0xFF5A9C94), accent2: Color(0xFFA8DADC)),
      ),
      PlaylistSongModel(
        '2', artistName: 'Ichijou Ririka', songImageUrl: 's_happiness_phenomenon.jpg', title: 'Happiness phenomenon', albumName: 'Happiness phenomenon (Ichijou Ririka SOLO)',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFF47EA9), secondary: Color(0xFFFF9EC2), accent1: Color(0xFFFF78B5), accent2: Color(0xFFFF5A9F)),
      ),
      PlaylistSongModel(
        '3', artistName: 'Todoroki Hajime', songImageUrl: 's_countach.jpg', title: 'Countach', albumName: 'Countach',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFB7B9FF), secondary: Color(0xFFD8BFD8), accent1: Color(0xFFE0BBE4), accent2: Color(0xFFCDB4DB)),
      ),
      PlaylistSongModel(
        '4', artistName: 'Sakura Miko', songImageUrl: 's_flower_rhapsody.jpg', title: 'flower rhapsody', albumName: 'flower rhapsody',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFFF4C74), secondary: Color(0xFFFF6B6B), accent1: Color(0xFFFF4C60), accent2: Color(0xFFFF3366)),
      ),
      PlaylistSongModel(
        '5', artistName: 'Nekomata Okayu', songImageUrl: 's_poisonya_syndrome.jpg', title: 'KAMISAMA・NEKOSAMA', albumName: 'POISONYA SYNDROME',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFB190FA), secondary: Color(0xFFD7BDE2), accent1: Color(0xFFC9A8D8), accent2: Color(0xFFB39DDB)),
      ),
      PlaylistSongModel(
        '6', artistName: 'Kazama Iroha', songImageUrl: 's_kazewo_aogishi_reiyona.jpg', title: 'Kazewo Aogishi Reiyona', albumName: 'Kazewo Aogishi Reiyona',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF44BFB8), secondary: Color(0xFF2E9C95), accent1: Color(0xFF5FD1C9), accent2: Color(0xFFA8E4E0)),
      ),
      PlaylistSongModel(
        '7', artistName: 'Shirakami Fubuki', songImageUrl: 's_fbkingdom_blessing.jpg', title: 'SUPERNOVA', albumName: 'FBKINGDOM “Blessing”',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF54C8EA), secondary: Color(0xFF3AB8D8), accent1: Color(0xFF6DD5FA), accent2: Color(0xFFA5E8F5)),
      ),
      PlaylistSongModel(
        '8', artistName: 'Hoshimachi Suisei', songImageUrl: 's_shinsei_mokuroku.jpg', title: 'BIBBIDIBA', albumName: 'SHINSEI MOKUROKU',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF454A93), secondary: Color(0xFF3A3F7A), accent1: Color(0xFF5C63A8), accent2: Color(0xFF7C82C2)),
      ),
      PlaylistSongModel(
        '9', artistName: 'Momosuzu Nene', songImageUrl: 's_nenechis_giragira_fan_meeting.jpg', title: 'Nenechi\'s Giragira Fan Meeting', albumName: 'Nenechi\'s Giragira Fan Meeting',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFFFB65D), secondary: Color(0xFFFF9E5A), accent1: Color(0xFFFFCB8A), accent2: Color(0xFFFFD9A8)),
      ),
      PlaylistSongModel(
        '10', artistName: 'Oozora Subaru', songImageUrl: 's_starlight.jpg', title: 'starlight', albumName: 'starlight',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFBEE717), secondary: Color(0xFFD9FF2E), accent1: Color(0xFFFFFF66), accent2: Color(0xFFFFFACD)),
      ),
      PlaylistSongModel(
        '11', artistName: 'Takane Lui', songImageUrl: 's_holohawk.jpg', title: 'HoloHawk', albumName: 'HoloHawk',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF28030D), secondary: Color(0xFF3C0A15), accent1: Color(0xFF50101F), accent2: Color(0xFF1A0005)),
      ),
      PlaylistSongModel(
        '12', artistName: 'Houshou Marine', songImageUrl: 's_ahoy_youre_all_pirates.jpg', title: 'A Horny Money World 〜legendary night〜', albumName: 'Ahoy!! You\'re All Pirates♡',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFA82313), secondary: Color(0xFFC2182C), accent1: Color(0xFFE53935), accent2: Color(0xFF7F0000)),
      ),
    ];
  }
}