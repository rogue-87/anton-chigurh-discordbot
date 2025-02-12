import 'package:dotenv/dotenv.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:bot/bot.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: false, quiet: false)..load();

	if (env["BOT_TOKEN"] == null) {
		print("No bot token found in .env file.");
		return;
	}

	final commands = CommandsPlugin(
		prefix: null,
		options: CommandsOptions(logErrors: true, type: CommandType.slashOnly)
	);

	commands
		..addCommand(ping)
		..addCommand(tossCoin);

	commands.onCommandError.listen((error) async {
		if (error is ConverterFailedException) {
			// ConverterFailedException can be thrown during autocompletion, in which case we can't
      // respond with an error. This check makes sure we can respond.
			if (error.context case InteractiveContext context) {
				await context.respond(MessageBuilder(
					content: "Invalid input: `${error.input.remaining}`"
				));
			} else {
				print("Uncaught error: $error");
			}
		}
	});

	final client = await Nyxx.connectGateway(
		env["BOT_TOKEN"]!,
		GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
		options: GatewayClientOptions(plugins: [logging, cliIntegration, commands])
	);

	final botUser = await client.users.fetchCurrentUser();
	
	// TODO: make it so that when the bot gets pinged, it replies with a list of all the commands.
	client.onMessageCreate.listen((event) async {
		if (event.mentions.contains(botUser)) {
			await event.message.channel.sendMessage(MessageBuilder(
				content: "What's the most you ever lost on a coin toss?",
				referencedMessage: MessageReferenceBuilder.reply(messageId: event.message.id),
			));
		}
	});
}
