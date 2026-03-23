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
        'GuDq5jRf7eM', artistImage: 'kanade.jpg', artistName: 'Otonose Kanade', songImageUrl: 's_cheerful_vibes_echo.jpg',
        title: 'Cheerful Vibes Echo', albumName: 'Cheerful Vibes Echo (Otonose Kanade SOLO)',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFFFE7B5), secondary: Color(0xFFFFD8B5), accent1: Color(0xFFFFE0C2), accent2: Color(0xFFFFCB9A), text: Color(0xFF121717), isLogoWhite: false),
      ),
      PlaylistSongModel(
        'rRfcFBYRtEs', artistImage: 'raden.jpg', artistName: 'Juufuutei Raden', songImageUrl: 's_otoshi_banashi.jpg',
        title: 'Otoshi Banashi', albumName: 'Otoshi Banashi (Juufuutei Raden SOLO)',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF3D7C71), secondary: Color(0xFF2F6A63), accent1: Color(0xFF5A9C94), accent2: Color(0xFFA8DADC), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'yUBoZiJ_93o', artistImage: 'ririka.jpg', artistName: 'Ichijou Ririka', songImageUrl: 's_happiness_phenomenon.jpg',
        title: 'Happiness phenomenon', albumName: 'Happiness phenomenon (Ichijou Ririka SOLO)',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFF47EA9), secondary: Color(0xFFFF9EC2), accent1: Color(0xFFFF78B5), accent2: Color(0xFFFF5A9F), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'vvBj821BBUo', artistImage: 'hajime.jpg', artistName: 'Todoroki Hajime', songImageUrl: 's_countach.jpg',
        title: 'Countach', albumName: 'Countach',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFB7B9FF), secondary: Color(0xFFD8BFD8), accent1: Color(0xFFE0BBE4), accent2: Color(0xFFCDB4DB), text: Color(0xFF121717), isLogoWhite: false),
      ),
      PlaylistSongModel(
        'Jmy6gS7hG7I', artistImage: 'miko.jpg', artistName: 'Sakura Miko', songImageUrl: 's_flower_rhapsody.jpg',
        title: 'flower rhapsody', albumName: 'flower rhapsody',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFFF4C74), secondary: Color(0xFFFF6B6B), accent1: Color(0xFFFF4C60), accent2: Color(0xFFFF3366), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'J53Ev-HY5ao', artistImage: 'okayu.jpg', artistName: 'Nekomata Okayu', songImageUrl: 's_poisonya_syndrome.jpg',
        title: 'KAMISAMA・NEKOSAMA', albumName: 'POISONYA SYNDROME',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFB190FA), secondary: Color(0xFFD7BDE2), accent1: Color(0xFFC9A8D8), accent2: Color(0xFFB39DDB), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'DHNBUuqeXvw', artistImage: 'iroha.jpg', artistName: 'Kazama Iroha', songImageUrl: 's_kazewo_aogishi_reiyona.jpg',
        title: 'Kazewo Aogishi Reiyona', albumName: 'Kazewo Aogishi Reiyona',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF44BFB8), secondary: Color(0xFF2E9C95), accent1: Color(0xFF5FD1C9), accent2: Color(0xFFA8E4E0), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'kYw8N-3BIX8', artistImage: 'fubuki.jpg', artistName: 'Shirakami Fubuki', songImageUrl: 's_fbkingdom_blessing.jpg',
        title: 'SUPERNOVA', albumName: 'FBKINGDOM “Blessing”',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF54C8EA), secondary: Color(0xFF3AB8D8), accent1: Color(0xFF6DD5FA), accent2: Color(0xFFA5E8F5), text: Color(0xFF121717), isLogoWhite: false),
      ),
      PlaylistSongModel(
        'x44TdvQ1OJs', artistImage: 'suisei.jpg', artistName: 'Hoshimachi Suisei', songImageUrl: 's_shinsei_mokuroku.jpg',
        title: 'BIBBIDIBA', albumName: 'SHINSEI MOKUROKU',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF454A93), secondary: Color(0xFF3A3F7A), accent1: Color(0xFF5C63A8), accent2: Color(0xFF7C82C2), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'g-nOWGRwiL0', artistImage: 'nene.jpg', artistName: 'Momosuzu Nene', songImageUrl: 's_nenechis_giragira_fan_meeting.jpg',
        title: 'Nenechi\'s Giragira Fan Meeting', albumName: 'Nenechi\'s Giragira Fan Meeting',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFFFB65D), secondary: Color(0xFFFF9E5A), accent1: Color(0xFFFFCB8A), accent2: Color(0xFFFFD9A8), text: Color(0xFF121717), isLogoWhite: false),
      ),
      PlaylistSongModel(
        'riy_xiT_y84', artistImage: 'subaru.jpg', artistName: 'Oozora Subaru', songImageUrl: 's_starlight.jpg',
        title: 'starlight', albumName: 'starlight',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFBEE717), secondary: Color(0xFFD9FF2E), accent1: Color(0xFFFFFF66), accent2: Color(0xFFFFFACD), text: Color(0xFF121717), isLogoWhite: false),
      ),
      PlaylistSongModel(
        'hkJUWiVgLU4', artistImage: 'lui.jpg', artistName: 'Takane Lui', songImageUrl: 's_holohawk.jpg',
        title: 'HoloHawk', albumName: 'HoloHawk',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFF28030D), secondary: Color(0xFF3C0A15), accent1: Color(0xFF50101F), accent2: Color(0xFF1A0005), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
      PlaylistSongModel(
        'NSLYAT7sjAA', artistImage: 'marine.jpg', artistName: 'Houshou Marine', songImageUrl: 's_ahoy_youre_all_pirates.jpg',
        title: 'A Horny Money World 〜legendary night〜', albumName: 'Ahoy!! You\'re All Pirates♡',
        colorInfo: PlaylistSongColorModel(primary: Color(0xFFA82313), secondary: Color(0xFFC2182C), accent1: Color(0xFFE53935), accent2: Color(0xFF7F0000), text: Color(0xFFFFFFFF), isLogoWhite: true),
      ),
    ];
  }
}