import 'dart:math';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final _random = Random();

final tossCoin = ChatCommand(
  "toss-coin",
  "play a game of coin toss",
  id("toss-coin", (
    ChatContext context,
    // dart format off
    @Name("side")
		@Choices({"heads": 0, "tails": 1})
		@Description("Call it.")
		int choice,
		// dart format on
  ) async {
    const Map<String, List<String>> phrases = {
      "win": [
        "Don't put that coin in your pocket sir.",
        "Well done. You knew the coin would land this way, didn't you?",
        "The coin has spoken. Fortune favors you—this time.",
        "You got lucky. But luck isn’t something you can count on.",
        "This moment was always coming. You just didn’t know it.",
        "You stood to win everything. And you did.",
      ],
      "lose": [
        "You should admit your situation. There would be more dignity in it.",
        "The coin decided. You were just here to see it happen.",
        "If the rule you followed brought you to this, of what use was the rule?",
        "It’s not the coin’s fault. It had no say in the matter.",
        "You don’t have to do this. People always say the same thing.",
      ],
    };

    final result = _random.nextInt(2);
    if (choice == result) {
      await context.respond(
        MessageBuilder(
          embeds: [
            EmbedBuilder(
              title: "you win!",
              description: phrases["win"]![_random.nextInt(phrases['win']!.length)],
              color: DiscordColor.parseHexString("#00FF00"),
            ),
          ],
        ),
      );
    } else {
      await context.respond(
        MessageBuilder(
          embeds: [
            EmbedBuilder(
              title: "you lose!",
              description: phrases["lose"]![_random.nextInt(phrases['lose']!.length)],
              color: DiscordColor.parseHexString("#FF0000"),
            ),
          ],
        ),
      );
    }
  }),
);
