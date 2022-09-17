key _sound_on ="e9a0c36a-dffc-eca0-27b5-3ba4d527dfad";
key _sound_off = "de58f2a6-ba96-d252-7351-ca839d847196";

integer listener;
integer channel;
integer link_num;

integer cameraOn            = FALSE;
integer adultcamOn          = FALSE;
integer teencamOn           = FALSE;
integer childcamOn          = FALSE;
integer petitecamOn         = FALSE;
//integer cinematiccamOn      = FALSE;  //!UNUSED
integer sitcamOn            = FALSE;
//integer sitOverride       = FALSE; // COMING SOON!!!!

//NOTE (neu) COMING SOON I HOPE
integer g_CMFollower        = FALSE;
integer g_CMTPCAM           = FALSE;
integer g_CMANTIPUSH        = FALSE;
integer g_CMTPAVI           = FALSE;

integer DEBUG               = TRUE;

integer _camera;
integer _follower;
integer _tp2avi;
integer _tp2cam;
integer _antipush;

string CAMERA_              = "[{Amy}]Camera Mod v3";
string FOLLOWER_            = "[{Amy}]Camera Mod v3 - Follower";
string TP2AVI_              = "[{Amy}]Camera Mod v3 - TP2AVI";
string TP2CAM_              = "[{Amy}]Camera Mod v3 - TP2CAM";
string ANTIPUSH_            = "[{Amy}]Camera Mod v3 - AntiPush";

vector _greenState = <0.000, 0.502, 0.000>;
vector _redState = <0.502, 0.000, 0.000>;

debug(string message)
{
     llOwnerSay("[DEBUG] " + message);
}

info(string message)
{
    llOwnerSay("[INFO] " + message);
}

menu(key id)
{
    if (cameraOn == FALSE){
        list main_menu = [ "■ Off ■", "□ Cinema □", "□ Adult □", "□ Teen □", "□ Child □", "□ Petite □", "† STOP †", "† Reset †", "† Features †", "† Exit †" ];
        llListenRemove(listener);
        channel = -1000000000 - (integer)(llFrand(1000000000));
        listener = llListen(channel, "", "", "");
        llDialog(id, "Choose an option...", main_menu, channel);
    }
    else if ((adultcamOn == TRUE) && (cameraOn == TRUE)){
        list main_menu = [ "□ Off □", "□ Cinema □", "■ Adult ■", "□ Teen □", "□ Child □", "□ Petite □", "† STOP †", "† Reset †", "† Features †", "† Exit †" ];
        llListenRemove(listener);
        channel = -1000000000 - (integer)(llFrand(1000000000));
        listener = llListen(channel, "", "", "");
        llDialog(id, "Choose an option...", main_menu, channel);
    }
    else if ((teencamOn == TRUE) && (cameraOn == TRUE)){
        list main_menu = [ "□ Off □", "□ Cinema □", "□ Adult □", "■ Teen ■", "□ Child □", "□ Petite □", "† STOP †", "† Reset †", "† Features †", "† Exit †" ];
        llListenRemove(listener);
        channel = -1000000000 - (integer)(llFrand(1000000000));
        listener = llListen(channel, "", "", "");
        llDialog(id, "Choose an option...", main_menu, channel);
    }
    else if ((childcamOn == TRUE) && (cameraOn == TRUE)){
        list main_menu = [ "□ Off □", "□ Cinema □", "□ Adult □", "□ Teen □", "■ Child ■", "□ Petite □", "† STOP †", "† Reset †", "† Features †", "† Exit †" ];
        llListenRemove(listener);
        channel = -1000000000 - (integer)(llFrand(1000000000));
        listener = llListen(channel, "", "", "");
        llDialog(id, "Choose an option...", main_menu, channel);
    }
    else if ((petitecamOn == TRUE) && (cameraOn == TRUE)){
        list main_menu = [ "□ Off □", "□ Cinema □", "□ Adult □", "□ Teen □", "□ Child □", "■ Petite ■", "† STOP †", "† Reset †", "† Features †", "† Exit †" ];
        llListenRemove(listener);
        channel = -1000000000 - (integer)(llFrand(1000000000));
        listener = llListen(channel, "", "", "");
        llDialog(id, "Choose an option...", main_menu, channel);
    }
    /* else if ((cinematiccamOn == TRUE) && (cameraOn == TRUE)){
        list main_menu = [ "□ Off □", "■ Cinema ■", "□ Adult □", "□ Teen □", "□ Child □", "□ Petite □", "† STOP †", "† Reset †", "† Features †", "† Exit †" ];
        llListenRemove(listener);
        channel = -1000000000 - (integer)(llFrand(1000000000));
        listener = llListen(channel, "", "", "");
        llDialog(id, "Choose an option...", main_menu, channel);
    } */
}

default_cam()
{
    llClearCameraParams();
    llSetCameraParams([CAMERA_ACTIVE, 1]);
}

off_cam()
{
    llSetLinkColor(LINK_THIS, _redState, ALL_SIDES);
    llPlaySound(_sound_off, 0.4);
    info("Camera Mod Disabled.");
    llSetCameraParams([CAMERA_ACTIVE, 0]);
    llClearCameraParams();
    cameraOn = FALSE;
}

/* cinematic_cam()
{
    vector camPos = llGetPos();
    vector camFocus = llGetPos();
    llSetLinkColor(LINK_THIS, _greenState, ALL_SIDES);
    info("Cinematic Camera Enabled.");
    default_cam();
    llSetCameraParams([
        CAMERA_ACTIVE, 1,
        CAMERA_FOCUS, camFocus,
        CAMERA_FOCUS_LOCKED, FALSE,
        CAMERA_POSITION, camPos,
        CAMERA_POSITION_LOCKED, FALSE
    ]);
    cameraOn        = TRUE;
    adultcamOn      = FALSE;
    teencamOn       = FALSE;
    childcamOn      = FALSE;
    petitecamOn     = FALSE;
    sitcamOn        = FALSE;
    cinematiccamOn  = TRUE;
} */

adult_cam()
{
    llSetLinkColor(LINK_THIS, _greenState, ALL_SIDES);
    info("Adult Camera Enabled.");
    default_cam();
    llSetCameraParams([
        CAMERA_ACTIVE, 1,
        CAMERA_BEHINDNESS_ANGLE, 0.0,
        CAMERA_BEHINDNESS_LAG, 0.0,
        CAMERA_DISTANCE, 1.5,
        CAMERA_FOCUS_LAG, 0.01 ,
        CAMERA_FOCUS_LOCKED, FALSE,
        CAMERA_FOCUS_THRESHOLD, 0.0,
        CAMERA_PITCH, 10.0,
        CAMERA_POSITION_LAG, 0.1,
        CAMERA_POSITION_LOCKED, FALSE,
        CAMERA_POSITION_THRESHOLD, 0.0,
        CAMERA_FOCUS_OFFSET, <-0.5,0,0.50>
    ]);
    cameraOn        = TRUE;
    adultcamOn      = TRUE;
    teencamOn       = FALSE;
    childcamOn      = FALSE;
    petitecamOn     = FALSE;
    sitcamOn        = FALSE;
    //cinematiccamOn  = FALSE; //!UNUSED
}

teen_cam()
{
    llSetLinkColor(LINK_THIS, _greenState, ALL_SIDES);
    info("Teen Camera Enabled.");
    default_cam();
    llSetCameraParams([
        CAMERA_ACTIVE, 1,
        CAMERA_BEHINDNESS_ANGLE, 0.0,
        CAMERA_BEHINDNESS_LAG, 0.0,
        CAMERA_DISTANCE, 1.5,
        CAMERA_FOCUS_LAG, 0.01,
        CAMERA_FOCUS_LOCKED, FALSE,
        CAMERA_FOCUS_THRESHOLD, 0.0,
        CAMERA_PITCH, 5.0,
        CAMERA_POSITION_LAG, 0.1,
        CAMERA_POSITION_LOCKED, FALSE,
        CAMERA_POSITION_THRESHOLD, 0.0,
        CAMERA_FOCUS_OFFSET, <-0.5,0,0.40>
    ]);
    cameraOn        = TRUE;
    adultcamOn      = FALSE;
    teencamOn       = TRUE;
    childcamOn      = FALSE;
    petitecamOn     = FALSE;
    sitcamOn        = FALSE;
    //cinematiccamOn  = FALSE; //!UNUSED
}

child_cam()
{
    llSetLinkColor(LINK_THIS, _greenState, ALL_SIDES);
    info("Child Camera Enabled.");
    default_cam();
    llSetCameraParams([
        CAMERA_ACTIVE, 1,
        CAMERA_BEHINDNESS_ANGLE, 0.0,
        CAMERA_BEHINDNESS_LAG, 0.0,
        CAMERA_DISTANCE, 1.0,
        CAMERA_FOCUS_LAG, 0.01 ,
        CAMERA_FOCUS_LOCKED, FALSE,
        CAMERA_FOCUS_THRESHOLD, 0.0,
        CAMERA_PITCH, 10.0,
        CAMERA_POSITION_LAG, 0.1,
        CAMERA_POSITION_LOCKED, FALSE,
        CAMERA_POSITION_THRESHOLD, 0.0,
        CAMERA_FOCUS_OFFSET, <-0.5,0,0.25>
    ]);
    cameraOn        = TRUE;
    adultcamOn      = FALSE;
    teencamOn       = FALSE;
    childcamOn      = TRUE;
    petitecamOn     = FALSE;
    sitcamOn        = FALSE;
    //cinematiccamOn  = FALSE; //!UNUSED
}

petite_cam()
{
    llSetLinkColor(LINK_THIS, _greenState, ALL_SIDES);
    info("Petite Camera Enabled.");
    default_cam();
    llSetCameraParams([
        CAMERA_ACTIVE, 1,
        CAMERA_BEHINDNESS_ANGLE, 0.0,
        CAMERA_BEHINDNESS_LAG, 0.0,
        CAMERA_DISTANCE, 1.0,
        CAMERA_FOCUS_LAG, 0.01 ,
        CAMERA_FOCUS_LOCKED, FALSE,
        CAMERA_FOCUS_THRESHOLD, 0.0,
        CAMERA_PITCH, 10.0,
        CAMERA_POSITION_LAG, 0.1,
        CAMERA_POSITION_LOCKED, FALSE,
        CAMERA_POSITION_THRESHOLD, 0.0,
        CAMERA_FOCUS_OFFSET, <-0.1,0,0.0001>
    ]);
    cameraOn        = TRUE;
    adultcamOn      = FALSE;
    teencamOn       = FALSE;
    childcamOn      = FALSE;
    petitecamOn     = TRUE;
    sitcamOn        = FALSE;
    //cinematiccamOn  = FALSE; //!UNUSED
}

/* 
!TODO
sitting()
{
    string curAnimState = llGetAnimation(llGetOwner());
    if (curAnimState == "Sitting"){
        debug("Sitting");
        sit_cam();
    }
}

sit_cam()
{
    llSetLinkColor(LINK_THIS, _redState, ALL_SIDES);
    info("Sitting Camera Enabled.");
    default_cam();
    llSetCameraParams([
        CAMERA_ACTIVE, 1,
        CAMERA_BEHINDNESS_ANGLE, 0.0,
        CAMERA_BEHINDNESS_LAG, 0.0,
        CAMERA_DISTANCE, 1.5,
        CAMERA_FOCUS_LAG, 0.01 ,
        CAMERA_FOCUS_LOCKED, FALSE,
        CAMERA_FOCUS_THRESHOLD, 0.0,
        CAMERA_PITCH, 10.0,
        CAMERA_POSITION_LAG, 0.1,
        CAMERA_POSITION_LOCKED, TRUE,
        CAMERA_POSITION_THRESHOLD, 0.0,
        CAMERA_FOCUS_OFFSET, <-0.5,0,0.50>
    ]);
    cameraOn        = TRUE;
    adultcamOn      = FALSE;
    teencamOn       = FALSE;
    childcamOn      = FALSE;
    petitecamOn     = FALSE;
    sitcamOn        = TRUE;
    //cinematiccamOn  = FALSE; //!UNUSED
}
*/

reset_cam()
{
    info("Camera Reset.");
    llResetScript();
}

features(key id)
{
    list main_menu = [];
    if((g_CMANTIPUSH) && (g_CMFollower) && (g_CMTPAVI) && (g_CMTPCAM))
        main_menu = [ "√ Follower", "√ TP2Cam", "√ TP2Avi", "√ AntiPush", "√ Everything", "† Back †", "† Exit †" ];
    else
        main_menu = [ "Follower", "TP2Cam", "TP2Avi", "AntiPush", "Everything", "† Back †", "† Exit †" ];
    llListenRemove(listener);
    channel = -1000000000 - (integer)(llFrand(1000000000));
    listener = llListen(channel, "", "", "");
    llDialog(id, "Choose an option...", main_menu, channel);
}

determine_cameraMOD_links()
{
    integer i = link_num;
    integer found = 0;
    do {
        if(llGetLinkName(i) == CAMERA_){
            _camera = i;
            found++;
        }
        else if (llGetLinkName(i) == FOLLOWER_){
            _follower = i;
            found++;
        }
        else if (llGetLinkName(i) == TP2AVI_){
            _tp2avi = i;
            found++;
        }
        else if(llGetLinkName(i) == TP2CAM_){
            _tp2cam = i;
            found++;
        }
        else if(llGetLinkName(i) == ANTIPUSH_){
            _antipush = i;
            found++;
        }
    }
    while (i-- && found < 5);
}

default
{
    state_entry()
    {
        link_num = llGetNumberOfPrims();
        llSetObjectName(CAMERA_);
        llSitTarget(<0.0, 0.0, 0.1>, ZERO_ROTATION);
        llPreloadSound(_sound_on);
        llPreloadSound(_sound_off);
        determine_cameraMOD_links();
        if(g_CMFollower){
            llSetLinkAlpha(_follower,   1,    ALL_SIDES);
            llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <0.00000, -0.03000, 0.00000>]);
        }
        else if (g_CMTPAVI){
            llSetLinkAlpha(_tp2avi,     1,    ALL_SIDES);
            llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <0.00000, 0.00000, -0.05000>]);
        }
        else if (g_CMTPCAM){
            llSetLinkAlpha(_tp2cam,     1,    ALL_SIDES);
            llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <0.00000, -0.03500, -0.05000>]);
        }
        else if (g_CMANTIPUSH){
            llSetLinkAlpha(_antipush,   1,    ALL_SIDES);
            llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <0.00000, -0.08000, -0.05000>]);
        }
        else{
            llSetLinkAlpha(_follower,   0,    ALL_SIDES);
            llSetLinkAlpha(_tp2avi,     0,    ALL_SIDES);
            llSetLinkAlpha(_tp2cam,     0,    ALL_SIDES);
            llSetLinkAlpha(_antipush,   0,    ALL_SIDES);
            llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
        }
    }

    touch_start(integer total_number)
    {
        if(llDetectedKey(0) == llGetOwner())
            menu(llGetOwner());
    }

    listen(integer channel, string name, key id, string message)
    {
        llListenRemove(channel);
        if (llGetOwnerKey(id) == llGetOwner())
        {
            if (message == "□ Adult □"){
                adult_cam();
                llTriggerSound(_sound_on, 0.4);
                return;
            }
            else if (message == "□ Teen □"){
                teen_cam();
                llTriggerSound(_sound_on, 0.4);
                return;
            }
            else if (message == "□ Child □"){
                child_cam();
                llTriggerSound(_sound_on, 0.4);
                return;
            }
            else if (message == "□ Petite □"){
                petite_cam();
                llTriggerSound(_sound_on, 0.4);
                return;
            }
            /*else if (message == "□ Cinema □"){
                cinematic_cam();
                llTriggerSound(_sound_on, 0.4);
                return;
            }*/
            else if (message == "□ Off □"){
                off_cam();
                llTriggerSound(_sound_on, 0.4);
                return;
            }
            else if (message == "† Reset †"){
                llMessageLinked(LINK_SET, 0, "RESET", NULL_KEY);
                llTriggerSound(_sound_off, 0.4);
                reset_cam();
            }
            else if (message == "† STOP †"){
                llTriggerSound(_sound_on, 0.4);
                state stopAnims;
            }
            else if (message == "† Back †")
            {
                llTriggerSound(_sound_on, 0.4);
                menu(id);
            }
            else if (message == "† Features †"){
                llTriggerSound(_sound_on, 0.4);
                features(id);
            }
            else if ((message == "Follower") || (message == "√ Follower")){
                //llTriggerSound(_sound_on, 0.4);
                if(!g_CMFollower){
                    g_CMFollower = TRUE;
                    llSetLinkAlpha(_follower,   1,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <0.00000, -0.03000, 0.00000>]);
                    llOwnerSay("Follower is On!");
                }
                else{
                    g_CMFollower = FALSE;
                    llSetLinkAlpha(_follower,   0,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Follower is Off!");
                }
                features(id);
            }
            else if ((message == "TP2Cam") || (message == "√ TP2Cam")){
                //llTriggerSound(_sound_on, 0.4);
                if(!g_CMTPCAM){
                    g_CMTPCAM = TRUE;
                    llSetLinkAlpha(_tp2cam,     1,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <0.00000, -0.03500, -0.05000>]);
                    llOwnerSay("Teleport to Camera is On!");
                }
                else{
                    g_CMTPCAM = FALSE;
                    llSetLinkAlpha(_tp2cam,   0,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Teleport to Camera is Off!");
                }
                features(id);
            }
            else if ((message == "TP2Avi") || (message == "√ TP2Avi")){
                //llTriggerSound(_sound_on, 0.4);
                if(!g_CMTPAVI){
                    g_CMTPAVI = TRUE;
                    llSetLinkAlpha(_tp2avi,     1,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <0.00000, 0.00000, -0.05000>]);
                    llOwnerSay("Teleport to Avatar is On!");
                }
                else{
                    g_CMTPAVI = FALSE;
                    llSetLinkAlpha(_tp2avi,   0,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Teleport to Avatar is Off!");
                }
                features(id);
            }
            else if ((message == "AntiPush") || (message == "√ AntiPush")){
                //llTriggerSound(_sound_on, 0.4);
                if(!g_CMANTIPUSH){
                    g_CMANTIPUSH = TRUE;
                    llSetLinkAlpha(_antipush,     1,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <0.00000, -0.08000, -0.05000>]);
                    llOwnerSay("AntiPush is On!");
                }
                else{
                    g_CMANTIPUSH = FALSE;
                    llSetLinkAlpha(_antipush,   0,    ALL_SIDES);
                    llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("AntiPush is Off!");
                }
                features(id);
            }
            else if (message == "Everything"){
                g_CMFollower    = TRUE;
                g_CMTPCAM       = TRUE;
                g_CMTPAVI       = TRUE;
                g_CMANTIPUSH    = TRUE;
                llSetLinkAlpha(_follower,   1,    ALL_SIDES);
                llSetLinkAlpha(_tp2cam,     1,    ALL_SIDES);
                llSetLinkAlpha(_tp2avi,     1,    ALL_SIDES);
                llSetLinkAlpha(_antipush,   1,    ALL_SIDES);
                llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <0.00000, -0.03000, 0.00000>]);
                llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <0.00000, -0.03500, -0.05000>]);
                llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <0.00000, 0.00000, -0.05000>]);
                llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <0.00000, -0.08000, -0.05000>]);
                llOwnerSay("Every Features are on!");
                menu(id);
            }
            else if (message == "√ Everything"){
                g_CMFollower    = FALSE;
                g_CMTPCAM       = FALSE;
                g_CMTPAVI       = FALSE;
                g_CMANTIPUSH    = FALSE;
                llSetLinkAlpha(_follower,   0,    ALL_SIDES);
                llSetLinkAlpha(_tp2cam,     0,    ALL_SIDES);
                llSetLinkAlpha(_tp2avi,     0,    ALL_SIDES);
                llSetLinkAlpha(_antipush,   0,    ALL_SIDES);
                llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llOwnerSay("Every Features are off!");
                menu(id);
            }
            else{
                llTriggerSound(_sound_off, 0.4);
                return;
            }
        }
        else
            return;
    }

    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_CONTROL_CAMERA)
            llSetCameraParams([CAMERA_ACTIVE, 1]);
        else
           llResetScript();
    }

    changed(integer change)
    {
        //if (change & CHANGED_OWNER)
        //    llResetScript();
        if (change & CHANGED_LINK){
            key agent = llAvatarOnSitTarget();
            if (agent){
                llRequestPermissions(agent, PERMISSION_CONTROL_CAMERA);
                //!sit_cam();
            }
            else{
                llRequestPermissions(agent, PERMISSION_CONTROL_CAMERA);
                if(adultcamOn == TRUE)
                    adult_cam();
                else if (teencamOn == TRUE)
                    teen_cam();
                else if (childcamOn == TRUE)
                    child_cam();
                else if (petitecamOn == TRUE)
                    petite_cam();
                /* else if(cinematiccamOn == TRUE)
                    cinematic_cam(); */
                else
                    off_cam();
            }
        }
    }

    attach(key agent)
    {
        if (agent){
            llRequestPermissions(agent, PERMISSION_CONTROL_CAMERA);
            if(adultcamOn == TRUE)
                adult_cam();
            else if (teencamOn == TRUE)
                teen_cam();
            else if (childcamOn == TRUE)
                child_cam();
            else if (petitecamOn == TRUE)
                petite_cam();
            /* else if(cinematiccamOn == TRUE)
                cinematic_cam(); */
            else
                off_cam();
        }
    }
}

state stopAnims
{
    state_entry()
    {
        llRequestPermissions(llGetOwner(), PERMISSION_TRIGGER_ANIMATION);
    }

    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TRIGGER_ANIMATION){
            list anims = llGetAnimationList(llGetOwner());
            integer n;
            for(n = 0; n < llGetListLength(anims) ;n++){
                llStopAnimation(llList2String(anims, n));
                llSleep(0.2);
            }
            llOwnerSay((string)n + " Animations Stopped");
            state default;
        }
        else{
            llOwnerSay("Sorry, i need permission to be able to stop the animations");
            state default;
        }
    }
}