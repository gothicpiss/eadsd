import lightbulb
import hikari
import datetime
import logging
from discord_webhook_logging import DiscordWebhookHandler

bot = lightbulb.BotApp(
  token=
  "MTA0MjU0MTEwMDIzMTA0NTE3MQ.GfGTZn.4VMWsSHiDV5QWe09ca3PRoxnsmvKxlPHD_FyIs",
  prefix="/")
embed = hikari.Embed()

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
handler = DiscordWebhookHandler(webhook_url='<your webhook url>')
logger.addHandler(handler)




@bot.command
@lightbulb.command("info", "gives small insight into us ")
@lightbulb.implements(lightbulb.SlashCommand)
async def ping(ctx: lightbulb.Context) -> None:
  await ctx.respond("Info about server / text")

@bot.command
@lightbulb.command("buy", "Follow the steps")
@lightbulb.implements(lightbulb.SlashCommand)
async def embed1(ctx: lightbulb.Context) -> None:
    embed = hikari.Embed(title="Guide to buying", description="test")
    embed = add_field("Test h1 is a fat smelly fuck", "test")
    embed.set_thumbnail("")
    embed.set_footer("")
    await ctx.respond(embed)



@bot.command
@lightbulb.command("test", "Follow the steps")
@lightbulb.implements(lightbulb.SlashCommand)
async def embed_command(ctx: lightbulb.Context) -> None:
    embed = hikari.Embed()
    embed.add_field("Guide to buying","__First go to __<#1042552069510418502>__To decide how much you wan’t to buy__ \n__Then open a ticket in __<#1042551995455770634>__and state how much you wan’t to buy__\n **__Wait for somebody with the __<@&1042555829670379530> __role to respond and be patient__**")
    await ctx.respond(embed)  # or respond(embed=embed)


@bot.command
@lightbulb.command("cun", "Follow the steps")
@lightbulb.implements(lightbulb.SlashCommand)
async def embed_command(ctx: lightbulb.Context) -> None:
    embed = hikari.Embed()
    embed.add_field("Guide to buying","First go to <#1042552069510418502> To decide how much you wan’t to buy \n Then open a ticket in <#1042551995455770634> and state how much you wan’t to buy \n ** Wait for somebody with the <@&1042555829670379530> role to respond and be patient**")
    await ctx.respond(embed)  # or respond(embed=embed)




@bot.command()
@lightbulb.option("reason", "Reason for the ban", required=False)
@lightbulb.option("user", "The user to ban.", type=hikari.User)
@lightbulb.command("ban", "Ban a user from the server.")
@lightbulb.implements(lightbulb.SlashCommand)
async def ban(ctx: lightbulb.SlashContext) -> None:
    if not ctx.guild_id:
        await ctx.respond("This command can only be used in a guild.")
        return
    await ctx.respond(hikari.ResponseType.DEFERRED_MESSAGE_CREATE)
    # Perform the ban
    await ctx.app.rest.ban_user(ctx.guild_id, ctx.options.user.id, reason=ctx.options.reason or hikari.UNDEFINED)
    # Provide feedback to the moderator
    await ctx.respond(f"Banned {ctx.options.user.mention}.\n**Reason:** {ctx.options.reason or 'No reason provided.'}")





@bot.command()
@lightbulb.option("reason", "Reason for the kick", required=False)
@lightbulb.option("user", "The user to kick.", type=hikari.User)
@lightbulb.command("kick", "kicks a user from the server.",)
@lightbulb.implements(lightbulb.SlashCommand)
async def kick_member(ctx: lightbulb.SlashContext) -> None:
       if not ctx.guild_id:
        await ctx.respond("This command can only be used in a guild.")
        return
        await ctx.respond(hikari.ResponseType.DEFERRED_MESSAGE_CREATE)
        await ctx.app.rest.kick_user(ctx.guild_id, ctx.options.user.id, reason=ctx.options.reason or hikari.UNDEFINED)
        await ctx.respond(f"Kicked {ctx.options.user.mention}.\n**Reason:** {ctx.options.reason or 'No reason provided.'}")


@bot.command()
@lightbulb.option("count", "The amount of messages to purge.", type=int, max_value=100, min_value=1)
@lightbulb.command("purge", "Purge a certain amount of messages from a channel.", pass_options=True)
@lightbulb.implements(lightbulb.SlashCommand)
async def purge(ctx: lightbulb.SlashContext, count: int) -> None:
    """Purge a certain amount of messages from a channel."""
    if not ctx.guild_id:
        await ctx.respond("This command can only be used in a server.")
        return
    messages = (
        await ctx.app.rest.fetch_messages(ctx.channel_id)
        .take_until(lambda m: datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(days=14) > m.created_at)
        .limit(count)
    )
    if messages:
            await ctx.app.rest.delete_messages(ctx.channel_id, messages)
            await ctx.respond(f"Purged {len(messages)} messages.")
    else:
        await ctx.respond("Could not find any messages younger than 14 days!")


@bot.command
@lightbulb.command("echo", "h1")
@lightbulb.implements(lightbulb.SlashCommand)
async def callback(self, ctx):
        await ctx.respond(ctx.options.text)








bot.run()
