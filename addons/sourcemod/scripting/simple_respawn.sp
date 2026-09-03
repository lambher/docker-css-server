#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <gungame>

public Plugin myinfo = 
{
    name = "Simple Respawn",
    author = "Gemini CLI",
    description = "Automatically respawns dead players and blocks round ends until someone wins GunGame",
    version = "1.2",
    url = ""
};

bool g_bGameWinnerDecided = false;

public void OnPluginStart()
{
    HookEvent("player_death", Event_PlayerDeath);
}

public void OnMapStart()
{
    g_bGameWinnerDecided = false;
}

public int GG_OnWinner(int client, const char[] weapon, int victim)
{
    g_bGameWinnerDecided = true;
    return 0;
}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("userid"));
    if (client > 0 && IsClientInGame(client) && !IsPlayerAlive(client))
    {
        int team = GetClientTeam(client);
        if (team == 2 || team == 3) // Terrorists (2) or CTs (3)
        {
            CreateTimer(1.5, Timer_Respawn, event.GetInt("userid"), TIMER_FLAG_NO_MAPCHANGE);
        }
    }
}

public Action Timer_Respawn(Handle timer, int userid)
{
    int client = GetClientOfUserId(userid);
    if (client > 0 && IsClientInGame(client) && !IsPlayerAlive(client))
    {
        int team = GetClientTeam(client);
        if (team == 2 || team == 3)
        {
            CS_RespawnPlayer(client);
        }
    }
    return Plugin_Continue;
}

public Action CS_OnTerminateRound(float &delay, CSRoundEndReason &reason)
{
    // If someone has won the GunGame match, we ALLOW the round to end
    // so GunGame can complete its victory sequence and change the map.
    if (g_bGameWinnerDecided)
    {
        return Plugin_Continue;
    }

    // Otherwise, block ALL round end conditions (team wipes, objective timeouts, draws)
    // to keep the deathmatch gameplay completely continuous.
    return Plugin_Handled;
}
