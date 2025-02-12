import 'dart:math';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';


final tossCoin = ChatCommand(
  "toss-coin",
  "play a game of coin toss(IF YOU LOSE, YOU GET KICKED!)",
  id("toss-coin", (ChatContext context) async {
    var result = Random().nextBool();
    if (result) {
      await context.respond(MessageBuilder(
          content: "you win! don't put that coin in your pocket sir.")
			);
    } else {
      await context.respond(
				MessageBuilder(content: "you lose! get kicked!")
			);
			context.member?.delete(auditLogReason: "kicked for losing a coin toss");
    }
  }),
);
