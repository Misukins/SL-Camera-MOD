key id;
key TP2CAM_Texture  = "0383398b-2847-5294-54a6-864270036ab0";

string objName      = "[{Amy}]Camera Mod v3.1 - TP2CAM";
string copy         = "copyright: Amy (Misukins)";

doTeleport(key id)
{
    llRequestPermissions(id, PERMISSION_TELEPORT | PERMISSION_TRACK_CAMERA);
}

default
{
    state_entry()
    {
        llSetObjectDesc(copy);
        llSetObjectName(objName);
    }

    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }

    touch_start(integer total_num)
    {
        id = llGetOwner();
        doTeleport(id);
    }

    link_message(integer from,integer to,string msg,key id)
    {
      if (msg == "RESET"){
          llOwnerSay("Resetting - Teleport 2 Camera Script!");
          llResetScript();
        }
    }

    run_time_permissions(integer perm)
    {
        id = llGetOwner();
        if (perm & (PERMISSION_TELEPORT | PERMISSION_TRACK_CAMERA)){
            vector CamPos = llGetCameraPos();
            rotation CamRot = llGetCameraRot();
            vector CamFoc = CamPos + llRot2Fwd(CamRot);
            llTeleportAgent(id, "", CamPos, CamFoc);
        }
        else{
           llResetScript();
        }
    }
}