import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

String latencyTypeToString(String type) => type;

const latencyTypeConverter = SimpleConverter.fixed(
  elements: ['Basic', 'Real', 'Gateway'],
  stringify: latencyTypeToString,
);

final ping = ChatCommand(
  "ping",
  "Get the bot's latency",
  id("ping", (ChatContext context,
      [@UseConverter(latencyTypeConverter)
      @Description("The type of latency to view")
      String? selection]) async {
    selection ??= await context.getSelection<String>(
      ["Basic", "Real", "Gateway"],
      MessageBuilder(content: "Choose the latency metric you want to see"),
    );

    final latency = switch (selection) {
      "Basic" => context.client.httpHandler.latency,
      "Real" => context.client.httpHandler.realLatency,
      "Gateway" => context.client.gateway.latency,
      _ => throw StateError("Unexpected selection $selection"),
    };

    final formattedLatency =
        (latency.inMicroseconds / Duration.microsecondsPerMillisecond).toStringAsFixed(3);

    await context.respond(MessageBuilder(content: "${formattedLatency}ms"));
  }),
);
