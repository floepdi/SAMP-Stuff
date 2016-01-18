#define FILTERSCRIPT
#include <a_samp>
#define START 1
#define ENDE 2
#define COLOR_RED 0xAA3333AA

new gangzone[MAX_GANG_ZONES];
new Float:x,Float:y,Float:z;
new Float:minx,Float:miny,Float:maxx,Float:maxy;

public OnFilterScriptInit() 
{
	print("\n--------------------------------------");
	print(" gangzonecreator.amx initalisiert");
	print("--------------------------------------\n");
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnPlayerCommandText(playerid, cmdtext[])
{

	new cmd[128], idx;
	cmd = strtok(cmdtext, idx);
 	 
	if(strcmp(cmd, "/createzone", true) == 0)
	{
		new tmp[128];
		tmp = strtok(cmdtext, idx);
		SendClientMessage(playerid, 0xFFCC66, "Positioniere dich an die sued-westlichste Ecke des Feldes und benutze /accept");
 		SetPVarInt(playerid,"creation",1);
 		return 1;
	}

	if((strcmp(cmd, "/accept", true) == 0) && (GetPVarInt(playerid, "creation") == 1))
	{
		new tmp[128];
		tmp = strtok(cmdtext, idx);
		GetPlayerPos(playerid, x, y, z);
 		CreateZone(playerid, START,x,y);
 		SetPVarInt(playerid,"creation",2);
 		return 1;
	}

	if((strcmp(cmd, "/accept", true) == 0) && (GetPVarInt(playerid, "creation") == 2))
	{
		new tmp[128];
		tmp = strtok(cmdtext, idx);
		GetPlayerPos(playerid, x, y, z);
 		CreateZone(playerid, ENDE,x,y);
 		DeletePVar(playerid,"creation");
 		return 1;
	}
	return 0;
}

public CreateZone(playerid, PROGRESS,Float:setx,Float:sety)
{
	if (PROGRESS == START) {
		minx = setx;
		miny = sety;
		SendClientMessage(playerid, 0xFFCC66, "Sued-Westliche Ecke festgelegt. Positioniere dich an die nord-oestlichste Stelle des Feldes und benutze /accept");
	}
	if (PROGRESS == ENDE) {
		maxx = setx;
		maxy = sety;
		new i = 0;
		while (i < sizeof (gangzone) && gangzone[i])
		{
			i++;
		}
		if (i == sizeof (gangzone))
		{
			printf("Du hast bereits 1024 Gangzones erstellt");
			return 0;
		}
		gangzone[i] = GangZoneCreate(minx, miny, maxx, maxy);
		GangZoneShowForAll(gangzone[i],COLOR_RED);
		new string[120];
		format(string, sizeof(string), "Gangzone erstellt. Befehl: GangZoneCreate(%f, %f, %f, %f); ", minx,miny,maxx,maxy);
		SendClientMessage(playerid, 0xFFCC66, string);
		return 1;
	}
	return 1;
}