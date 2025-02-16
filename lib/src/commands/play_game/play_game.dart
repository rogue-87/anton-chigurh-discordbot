import 'package:bot/src/commands/play_game/games/russian_roulette.dart';
import 'package:bot/src/commands/play_game/games/toss_coin.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final playGame = ChatGroup("play", "play a game", children: [tossCoin, russianRoulette]);
