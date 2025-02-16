import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final russianRoulette = ChatCommand(
  "russian-roulette",
  "play a game of coin toss(IF YOU LOSE, YOU GET KICKED!)",
  id("russian-roulette", (ChatContext context) async {}),
);
