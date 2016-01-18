#define FILTERSCRIPT 
#include <a_samp>  
#define CLOTHING 42
#define PRESSED(%0)             (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

// limitations
#define MAX_GLASSES 0.25
#define MIN_GLASSES 0.75
#define MAX_HEAD 0.25
#define MIN_HEAD 0.75
#define MAX_MASK 0
#define MIN_MASK -0.50
#define MAX_BODY 0
#define MIN_BODY 3.75

// string
#define CANCELCLOTHING "Du hast die Auswahl abgebrochen."
#define ADJUSTROTATION "Auswahl bestaetigt, passe nun die Rotation des Items an."
#define ADJUSTPOSX "Auswahl bestaetigt, passe nun die X-Achse des Items an."
#define ADJUSTPOSY "Auswahl bestaetigt, passe nun die Y-Achse des Items an."
#define ADJUSTPOSZ "Auswahl bestaetigt, passe nun die Z-Achse des Items an."
#define STARTONE "Du kannst mit NUMPAD 4 und NUMPAD 6 zwischen den verschiedenen Items zu waehlen."
#define STARTTWO  "Benutze ENTER um die Auswahl zu bestaetigen. Benutze LEERTASTE um die Auswahl abzubrechen."

// slots
#define GLASSES 1
#define HEAD 2
#define MASK 3
#define BODY 4


#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
  print("\n--------------------------------------");
  print(" Filterscript initalisiert");
  print("--------------------------------------\n");
  return 1;
}

#endif

new selected;
new Float:oldposx, Float:oldposy, Float:oldposz;
new Float:adjustx, Float:adjusty, Float:adjustz;
new Float:rotatex, Float:rotatey, Float:rotatez;


//Arrays
new glasses[34] = {19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19030, 19031, 19032, 19033, 19034, 19035, 19138, 19139, 19140};
new head[34] = {18891, 18892, 18893, 18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910, 18936, 18937, 18938, 18926, 18927, 18928, 18929, 18930, 18931, 18932, 18933, 18934, 18935 };
new mask[10] = { 18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920 };
new body[10] = { 18926, 18927, 18928, 18929, 18930, 18931, 18932, 18933, 18934, 18935 };



public OnPlayerCommandText(playerid, cmdtext[])
{
  if ((strcmp("/test", cmdtext, true, 10) == 0) && (GetPlayerInterior(playerid) != 15) )
  { 
    GetPlayerPos (playerid, oldposx, oldposy, oldposz);
    SetPlayerInterior(playerid, 15);
    SetPlayerPos (playerid, 207.737991,-109.019996,1005.132812);
    Create3DTextLabel("Kleidungsladen\nBenutze N", -1 , 207.737991, -100.519996, 1006.132812 , 15 , 0, 0);
    CreateObject(1318, 207.737991,-100.519996,1005.132812 , 0, 0, 96, 15);
    Create3DTextLabel("Ausgang\nBenutze Enter", -1 , 207.737991,-109.019996,1006.132812 , 15 , 0, 0);
    CreateObject(1318, 207.737991,-109.019996,1005.132812 , 0, 0, 96, 15);
    return 1;
  }

  return 0;
}

 

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

// ##################################################################### BRILLEN ANFANG ###########################################################################


 if ((GetPVarInt(playerid,"rotating") == 1) && (GetPVarInt(playerid,"glasses") != 0)) {

  
    if (PRESSED(KEY_ANALOG_RIGHT)) {
        rotatey = (rotatey + 1); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if (PRESSED(KEY_ANALOG_LEFT)) {
        rotatey = (rotatey - 1); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        ResetClothing(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,GLASSES);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingz") == 1) && (GetPVarInt(playerid,"glasses") != 0)) {

  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustz < MAX_GLASSES)) {
        adjustz = (adjustz + 0.001); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_GLASSES < adjustz)) {
        adjustz = (adjustz - 0.001); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustRot(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,GLASSES);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingy") == 1)  && (GetPVarInt(playerid,"glasses") != 0)) {
  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjusty < MAX_GLASSES)) {
        adjusty = (adjusty + 0.001); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_GLASSES < adjusty)) {
        adjusty = (adjusty - 0.001); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustZ(playerid); 
    } 

    if (PRESSED(KEY_SPRINT)) {
       CancelClothing(playerid,GLASSES);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingx") == 1) && (GetPVarInt(playerid,"glasses") != 0)) {

  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustx < MAX_GLASSES)) {
        adjustx = (adjustx + 0.001); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_GLASSES < adjustx)) {
        adjustx = (adjustx - 0.001); 
        SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustY(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,GLASSES);
    }
   
 }


 if ((GetPVarInt(playerid,"selecting") == 1) && (GetPVarInt(playerid,"glasses") != 0)) {

    if ((PRESSED(KEY_ANALOG_RIGHT)) && (selected <= 32)) {
       SelectItem(playerid,GLASSES,1);
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (selected >= 0)) {
       SelectItem(playerid,GLASSES,-1);
    }
   
    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustX(playerid);
      
        //Standart Brillen-Position
        adjustx = 0.097999; adjusty = 0.028999; adjustz = 0.0;
        rotatex = 5.50; rotatey = 84.60; rotatez = 83.7;
    } 
   
    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,GLASSES); 
    }
   
 }

// ##################################################################### KOPF ANFANG ---- BRILLEN ENDE ###########################################################################




 if ((GetPVarInt(playerid,"rotating") == 1) && (GetPVarInt(playerid,"head") != 0)) {

  
    if (PRESSED(KEY_ANALOG_RIGHT)) {
        rotatey = (rotatey + 1);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if (PRESSED(KEY_ANALOG_LEFT)) {
        rotatey = (rotatey - 1);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        ResetClothing(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,HEAD);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingz") == 1) && (GetPVarInt(playerid,"head") != 0)) {

  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustz < MAX_HEAD)) {
        adjustz = (adjustz + 0.001);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_HEAD < adjustz)) {
        adjustz = (adjustz - 0.001);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustRot(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,HEAD);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingy") == 1)  && (GetPVarInt(playerid,"head") != 0)) {
  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjusty < MAX_HEAD)) {
        adjusty = (adjusty + 0.001);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_HEAD < adjusty)) {
        adjusty = (adjusty - 0.001);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustZ(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,HEAD);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingx") == 1) && (GetPVarInt(playerid,"head") != 0)) {

  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustx < MAX_HEAD)) {
        adjustx = (adjustx + 0.001);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_HEAD < adjustx)) {
        adjustx = (adjustx - 0.001);
        SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustY(playerid); 
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,HEAD);
    }
   
 }


 if ((GetPVarInt(playerid,"selecting") == 1) && (GetPVarInt(playerid,"head") != 0)) {

    if ((PRESSED(KEY_ANALOG_RIGHT)) && (selected <= 32)) {
        SelectItem(playerid,HEAD,1);
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (selected >= 0)) {
        SelectItem(playerid,HEAD,-1);
    }
   
    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustX(playerid);
        
        //Standart Hut-Position
        adjustx = 0.097999; adjusty = 0.028999; adjustz = 0.0;
        rotatex = 5.50; rotatey = 84.60; rotatez = 83.7;
    } 
   
    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,HEAD);  
    }
   
 }


// ##################################################################### MASKEN ANFANG ---- KOPF ENDE ###########################################################################


 if ((GetPVarInt(playerid,"rotating") == 1) && (GetPVarInt(playerid,"mask") != 0)) {

  
    if (PRESSED(KEY_ANALOG_RIGHT)) {
        rotatey = (rotatey + 1);
        SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if (PRESSED(KEY_ANALOG_LEFT)) {
        rotatey = (rotatey - 1);
        SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        ResetClothing(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,MASK);  
    }
   
 }


 if ((GetPVarInt(playerid,"adjustingz") == 1) && (GetPVarInt(playerid,"mask") != 0)) {

    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustz < MAX_MASK)) {
        adjustz = (adjustz + 0.001);
        SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_MASK < adjustz)) {
        adjustz = (adjustz - 0.001);
        SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustRot(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,MASK);  
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingy") == 1)  && (GetPVarInt(playerid,"mask") != 0)) {
  
  if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjusty < MAX_MASK)) {
      adjusty = (adjusty + 0.001);
      SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
  }

  if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_MASK < adjusty)) {
      adjusty = (adjusty - 0.001);
      SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
  } 

  if (PRESSED(KEY_SECONDARY_ATTACK)) {
      AdjustZ(playerid);
  } 

  if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,MASK);   
  }
   
 }

 if ((GetPVarInt(playerid,"adjustingx") == 1) && (GetPVarInt(playerid,"mask") != 0)) {

  
  if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustx < MAX_MASK)) {
      adjustx = (adjustx + 0.001);
      SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
  }

  if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_MASK < adjustx)) {
      adjustx = (adjustx - 0.001);
      SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
  } 

  if (PRESSED(KEY_SECONDARY_ATTACK)) {
      AdjustY(playerid);
  } 

  if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,MASK);   
  }
   
 }


 if ((GetPVarInt(playerid,"selecting") == 1) && (GetPVarInt(playerid,"mask") != 0)) {

   if ((PRESSED(KEY_ANALOG_RIGHT)) && (selected <= 10)) {
        SelectItem(playerid,MASK,1);
   }  

   if ((PRESSED(KEY_ANALOG_LEFT)) && (selected >= 0)) {
        SelectItem(playerid,MASK,-1);
   }
     
   if (PRESSED(KEY_SECONDARY_ATTACK)) {
        AdjustX(playerid);
        
        //Standart Masken-Position
        adjustx = -0.024; adjusty = -0.024; adjustz = 0.003999;
        rotatex = -90; rotatey = -30; rotatez = 93.099967;

   } 
     
   if (PRESSED(KEY_SPRINT)) {
        CancelClothing(playerid,MASK);    
   }
     
 }



// ##################################################################### KOERPER ANFANG ---- MASKEN ENDE ###########################################################################



 if ((GetPVarInt(playerid,"rotating") == 1) && (GetPVarInt(playerid,"body") != 0)) {

  
    if (PRESSED(KEY_ANALOG_RIGHT)) {
      rotatey = (rotatey + 1);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if (PRESSED(KEY_ANALOG_LEFT)) {
      rotatey = (rotatey - 1);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
      ResetClothing(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,BODY);
    }
   
 }


  if ((GetPVarInt(playerid,"adjustingz") == 1) && (GetPVarInt(playerid,"body") != 0)) {

  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustz < MAX_BODY)) {
      adjustz = (adjustz + 0.001);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_BODY < adjustz)) {
      adjustz = (adjustz - 0.001);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
    } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
      AdjustRot(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,BODY);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingy") == 1)  && (GetPVarInt(playerid,"body") != 0)) {
  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjusty < MAX_BODY)) {
      adjusty = (adjusty + 0.001);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_BODY < adjusty)) {
      adjusty = (adjusty - 0.001);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
  } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
      AdjustZ(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,BODY);
    }
   
 }

 if ((GetPVarInt(playerid,"adjustingx") == 1) && (GetPVarInt(playerid,"body") != 0)) {

  
    if ((PRESSED(KEY_ANALOG_RIGHT)) && (adjustx < MAX_BODY)) {
      adjustx = (adjustx + 0.001);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);     
    }

    if ((PRESSED(KEY_ANALOG_LEFT)) && (MIN_BODY < adjustx)) {
      adjustx = (adjustx - 0.001);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, adjustx, adjusty, adjustz, rotatex, rotatey, rotatez, 1, 1, 1, -1);      
  } 

    if (PRESSED(KEY_SECONDARY_ATTACK)) {
      AdjustY(playerid);
    } 

    if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,BODY);
    }
   
 }


 if ((GetPVarInt(playerid,"selecting") == 1) && (GetPVarInt(playerid,"body") != 0)) {

    if ((PRESSED(KEY_ANALOG_RIGHT)) && (selected <= 10)) {
      SelectItem(playerid,BODY,1);
    }
    
    if ((PRESSED(KEY_ANALOG_LEFT)) && (selected >= 0)) {
      SelectItem(playerid,BODY,-1);
    }
   
    if (PRESSED(KEY_SECONDARY_ATTACK)) {
      AdjustX(playerid);
      
      //Standart Körper-Position
      adjustx = 0.119; adjusty = 0.0; adjustz = 0.0;
      rotatex = 113.9; rotatey = 170.6; rotatez = 77;

    } 
   
    if (PRESSED(KEY_SPRINT)) {
      CancelClothing(playerid,BODY);   
    }
   
 }


// ##################################################################### KOERPER ENDE ###########################################################################



 if (IsPlayerInRangeOfPoint(playerid, 3.0, 207.737991,-100.519996,1005.132812)) {

  if (PRESSED(KEY_NO)){
    ShowPlayerDialog(playerid, CLOTHING, DIALOG_STYLE_LIST, "Waehle eine Kleidungsart", " Brillen\n Kopfbedeckung\n Masken\n Koerper", "Waehlen", "Schliessen");
  }
   
 }

 if (IsPlayerInRangeOfPoint(playerid, 3.0, 207.737991,-109.019996,1005.132812)) {

  if (PRESSED(KEY_SECONDARY_ATTACK)){
    SetPlayerPos (playerid, oldposx, oldposy, oldposz);
    SetPlayerInterior(playerid, 0);
  }
   
 }
}



public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  if(dialogid == CLOTHING)
  {
    if(response)
    {
        if(listitem == 0)
        {
        SelectItem(playerid,GLASSES,0);
          return 1;
      }
      if(listitem == 1)
      {
        SelectItem(playerid,HEAD,0);
          return 1;
      }
      if(listitem == 2)
      {
        SelectItem(playerid,MASK,0);
          return 1;
          }
          if(listitem == 3)
      {
        SelectItem(playerid,BODY,0);
          return 1;
          }
    }
  }
  return 1;
}

public AdjustX(playerid)
{
      SendClientMessage(playerid, -1, ADJUSTPOSX); 
      DeletePVar(playerid, "selecting");
      SetPVarInt(playerid, "adjustingx",1);
}

public AdjustY(playerid)
{
      SetPVarInt(playerid, "adjustingx",0);
      SetPVarInt(playerid, "adjustingy",1);
      SendClientMessage(playerid, -1, ADJUSTPOSY); 
}

public AdjustZ(playerid)
{
      SetPVarInt(playerid, "adjustingy",0);
      SetPVarInt(playerid, "adjustingz",1);
      SendClientMessage(playerid, -1, ADJUSTPOSZ); 
}

public AdjustRot(playerid)
{
      SetPVarInt(playerid, "adjustingz",0);
      SetPVarInt(playerid, "rotating",1);
      SendClientMessage(playerid, -1, ADJUSTROTATION); 
}

public CancelClothing(playerid,part)
{
      DeletePVar(playerid, "selecting");
      SetPVarInt(playerid, "adjustingx",0);
      SetPVarInt(playerid, "adjustingy",0);
      SetPVarInt(playerid, "adjustingz",0);
      SetPVarInt(playerid, "rotating",0);
      SetPVarInt(playerid, "glasses", 0);
      SetPVarInt(playerid, "head", 0);
      SetPVarInt(playerid, "mask", 0);
      SetPVarInt(playerid, "body", 0);
      SetCameraBehindPlayer(playerid);
      TogglePlayerControllable(playerid,1);
      RemovePlayerAttachedObject(playerid, part);
      SendClientMessage(playerid, -1, CANCELCLOTHING); 
}

public ResetClothing(playerid)
{
      DeletePVar(playerid, "selecting");
      SetPVarInt(playerid, "adjustingx",0);
      SetPVarInt(playerid, "adjustingy",0);
      SetPVarInt(playerid, "adjustingz",0);
      SetPVarInt(playerid, "rotating",0);
      SetPVarInt(playerid, "glasses", 0);
      SetPVarInt(playerid, "head", 0);
      SetPVarInt(playerid, "mask", 0);
      SetPVarInt(playerid, "body", 0);
      SetCameraBehindPlayer(playerid);
      TogglePlayerControllable(playerid,1);}

public SetupSelection(playerid)
{
      TogglePlayerControllable(playerid,0);
      SetPlayerPos(playerid,210.737991,-100.519996,1005.132812);
      SetPlayerCameraPos(playerid, 212.037991,-99.519996,1006.032812 );
      SetPlayerCameraLookAt(playerid, 210.737991,-100.519996,1005.732812);
      SetPlayerFacingAngle( playerid, 270 );
      SendClientMessage(playerid, -1, STARTONE);
      SendClientMessage(playerid, -1, STARTTWO);

}

public SelectItem(playerid,type,next)
{
  if (type == GLASSES) {

    if (next == 0) {

      selected = 1;
      GameTextForPlayer(playerid, "Waehle eine Brille", 3000, 3);
      SetupSelection(playerid);
      SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, 0.097999, 0.028999, 0.0, 5.50, 84.60, 83.7, 1, 1, 1, -1);
      SetPVarInt(playerid,"selecting",1); 
      SetPVarInt(playerid,"glasses",glasses[selected]);
      return 1;
    }


    if (next == 1) {

      selected++;
      RemovePlayerAttachedObject(playerid, GLASSES);
      SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, 0.097999, 0.028999, 0.0, 5.50, 84.60, 83.7, 1, 1, 1, -1);
      SetPVarInt(playerid,"glasses",glasses[selected]);
      return 1;
    }

    if (next == -1) {

      selected--;
      RemovePlayerAttachedObject(playerid, GLASSES);
      SetPlayerAttachedObject(playerid, GLASSES, glasses[selected], 2, 0.097999, 0.028999, 0.0, 5.50, 84.60, 83.7, 1, 1, 1, -1);
      SetPVarInt(playerid,"glasses",glasses[selected]); 
      return 1;
    }

    return 0;

  }

  if (type == HEAD) {

    if (next == 0) {

      selected = 1;
      GameTextForPlayer(playerid, "Waehle eine Kopfbedeckung", 3000, 3);
      SetupSelection(playerid);
      SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, 0.119, -0.0, 0.0, 113.9, 170.6, 77, 1, 1, 1, -1);
      SetPVarInt(playerid,"selecting",1); 
      SetPVarInt(playerid,"head",head[selected]); 
      
      return 1;
    }


    if (next == 1) {

      selected++;
      RemovePlayerAttachedObject(playerid, HEAD);
      SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, 0.119, -0.0, 0.0, 113.9, 170.6, 77, 1, 1, 1, -1);
      SetPVarInt(playerid,"head",head[selected]); 
      return 1;
    }

    if (next == -1) {

      selected--;
      RemovePlayerAttachedObject(playerid, HEAD);
      SetPlayerAttachedObject(playerid, HEAD, head[selected], 2, 0.119, -0.0, 0.0, 113.9, 170.6, 77, 1, 1, 1, -1);
      SetPVarInt(playerid,"head",head[selected]); 
      return 1;
    }
    return 0;

  }

  if (type == MASK) {

    if (next == 0) {

      selected = 1;
      GameTextForPlayer(playerid, "Waehle eine Maske", 3000, 3);
      SetupSelection(playerid);
      SetPlayerAttachedObject(playerid, MASK, mask[selected], 2, -0.024, -0.024, 0.003999,  -90, -30, 93.099967, 1, 1, 1, -1);
      SetPVarInt(playerid,"selecting",1); 
      SetPVarInt(playerid,"mask",mask[selected]); 
      
      return 1;
    }


    if (next == 1) {

      selected++;
      RemovePlayerAttachedObject(playerid, MASK);
      SetPlayerAttachedObject(playerid, MASK, mask[selected],  2, -0.024, -0.024, 0.003999,  -90, -30, 93.099967, 1, 1, 1, -1);
      SetPVarInt(playerid,"mask",mask[selected]); 
      return 1;
    }

    if (next == -1) {

      selected--;
      RemovePlayerAttachedObject(playerid, MASK);
      SetPlayerAttachedObject(playerid, MASK, mask[selected],  2, -0.024, -0.024, 0.003999,  -90, -30, 93.099967, 1, 1, 1, -1);
      SetPVarInt(playerid,"mask",mask[selected]); 
      return 1;
    }
    return 0;

  }


  if (type == BODY) {

    if (next == 0) {

      selected = 1;
      GameTextForPlayer(playerid, "Waehle einen Koeperschmuck", 3000, 3);
      SetupSelection(playerid);
      SetPlayerAttachedObject(playerid, BODY, body[selected], 2, 0.16, 0.0019999, 0.0, 177.9, 174.69, 175.7, 1, 1, 1, -1);
      SetPVarInt(playerid,"selecting",1); 
      SetPVarInt(playerid,"body",body[selected]); 
      
      return 1;
    }


    if (next == 1) {

      selected++;
      RemovePlayerAttachedObject(playerid, BODY);
      SetPlayerAttachedObject(playerid, BODY, body[selected],  2, 0.16, 0.0019999, 0.0, 177.9, 174.69, 175.7, 1, 1, 1, -1);
      SetPVarInt(playerid,"body",body[selected]); 
      return 1;
    }

    if (next == -1) {

      selected--;
      RemovePlayerAttachedObject(playerid, BODY);
      SetPlayerAttachedObject(playerid, BODY, body[selected],  2, 0.16, 0.0019999, 0.0, 177.9, 174.69, 175.7, 1, 1, 1, -1);
      SetPVarInt(playerid,"body",body[selected]); 
      return 1;
    }
    return 0;

  }

  return 0;
}

