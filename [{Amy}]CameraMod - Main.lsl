key _sound_on               = "e9a0c36a-dffc-eca0-27b5-3ba4d527dfad";
key _sound_off              = "de58f2a6-ba96-d252-7351-ca839d847196";

key CAMERA_Texture          = "a6f1942a-8bec-bdce-5a87-f0d7f95f943f";
key CAM2AVI_Texture         = "27205b1b-232b-59cf-8137-08a93e65156e";
key FOLLOWER_Texture        = "c43bf1f3-d5dc-aa9e-c8d9-58c9ea346448";
key TP2AVI_Texture          = "0d4a4d94-8b14-2197-0366-8904dc365642";
key TP2CAM_Texture          = "bf266087-dea1-1dcd-f90e-59d67d6e2a08";

integer cameraOn            = FALSE;
integer adultcamOn          = FALSE;
integer teencamOn           = FALSE;
integer childcamOn          = FALSE;
integer petitecamOn         = FALSE;
integer g_CMFollower        = FALSE;
integer g_CMTPCAM           = FALSE;
integer g_CMANTIPUSH        = FALSE;
integer g_CMTPAVI           = FALSE;
integer g_CMCAMAVI          = FALSE;
integer DEBUG               = FALSE;

integer listener;
integer channel;
integer link_num;

integer _camera;
integer _follower;
integer _tp2avi;
integer _tp2cam;
integer _antipush;
integer _cam2avi;

list color_menu             = [];
list trans_menu             = [];
list features_menu          = [];
list main_menu              = [];

string CAMERA_              = "[{Amy}]Camera Mod v3.1";
string FOLLOWER_            = "[{Amy}]Camera Mod v3.1 - Follower";
string TP2AVI_              = "[{Amy}]Camera Mod v3.1 - TP2AVI";
string TP2CAM_              = "[{Amy}]Camera Mod v3.1 - TP2CAM";
string ANTIPUSH_            = "[{Amy}]Camera Mod v3.1 - AntiPush";
string CAM2AVI_             = "[{Amy}]Camera Mod v3.1 - Cam2Avi";
string copy                 = "copyright: Amy (Misukins)";

vector _greenState          = <0.000, 0.502, 0.000>;
vector _redState            = <0.502, 0.000, 0.000>;

debug(string message){
    llOwnerSay("[DEBUG] " + message);
}

info(string message){
    llOwnerSay("[INFO] " + message);
}

menu(key id){
    if (cameraOn == FALSE)
        main_menu = [ "■ Off ■", "□ Adult □", "□ Teen □", "□ Child □", "□ Petite □", "† StopAnims †", "† Reset †", "† Features †", "† Exit †" ];
    else if ((adultcamOn == TRUE) && (cameraOn == TRUE))
        main_menu = [ "□ Off □", "■ Adult ■", "□ Teen □", "□ Child □", "□ Petite □", "† StopAnims †", "† Reset †", "† Features †", "† Exit †" ];
    else if ((teencamOn == TRUE) && (cameraOn == TRUE))
        main_menu = [ "□ Off □", "□ Adult □", "■ Teen ■", "□ Child □", "□ Petite □", "† StopAnims †", "† Reset †", "† Features †", "† Exit †" ];
    else if ((childcamOn == TRUE) && (cameraOn == TRUE))
        main_menu = [ "□ Off □", "□ Adult □", "□ Teen □", "■ Child ■", "□ Petite □", "† StopAnims †", "† Reset †", "† Features †", "† Exit †" ];
    else if ((petitecamOn == TRUE) && (cameraOn == TRUE))
        main_menu = [ "□ Off □", "□ Adult □", "□ Teen □", "□ Child □", "■ Petite ■", "† StopAnims †", "† Reset †", "† Features †", "† Exit †" ];
    llListenRemove(listener);
    channel = -1000000000 - (integer)(llFrand(1000000000));
    listener = llListen(channel, "", "", "");
    llDialog(id, "Choose an option...", main_menu, channel);
}

features(key id){ //!
    if ((g_CMANTIPUSH) && (g_CMFollower) && (g_CMTPAVI) && (g_CMTPCAM) && (g_CMCAMAVI))
        features_menu = [ "√ Follower", "√ TP2Cam", "√ TP2Avi", "√ Cam2Avi", "√ AntiPush", "√ Everything", "† Back †", "† Exit †" ];
    else
        features_menu = [ "Follower", "TP2Cam", "TP2Avi", "Cam2Avi", "AntiPush", "Everything", "† Back †", "† Exit †" ];
    llListenRemove(listener);
    channel = -1000000000 - (integer)(llFrand(1000000000));
    listener = llListen(channel, "", "", "");
    llDialog(id, "Choose an option...", features_menu, channel);
}

default_cam(){
    llClearCameraParams();
    llSetCameraParams([CAMERA_ACTIVE, 1]);
}

off_cam(){
    llSetLinkColor(LINK_THIS, _redState, ALL_SIDES);
    llPlaySound(_sound_off, 0.4);
    info("Camera Mod Disabled.");
    llSetCameraParams([CAMERA_ACTIVE, 0]);
    llClearCameraParams();
    cameraOn = FALSE;
}

adult_cam(){
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
}

teen_cam(){
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
}

child_cam(){
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
}

petite_cam(){
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
}

reset_cam(){
    info("Camera Reset.");
    llResetScript();
}

determine_cameraMOD_links(){
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
        else if (llGetLinkName(i) == CAM2AVI_){
            _cam2avi = i;
            found++;
        }
    }
    while (i-- && found < 6);
}

default
{
    state_entry()
    {
        link_num = llGetNumberOfPrims();
        llSetObjectName(CAMERA_);
        llSetObjectDesc(copy);
        llSetLinkAlpha(_camera, 0.55, ALL_SIDES);
        llPreloadSound(_sound_on);
        llPreloadSound(_sound_off);
        determine_cameraMOD_links();
        if(g_CMFollower){
            llSetLinkAlpha(_follower, 0.55, ALL_SIDES);
            llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <0.00000, -0.03000, 0.00000>]);
            llMessageLinked(LINK_SET, 0, "Follower ON",    NULL_KEY);
        }
        else if (g_CMTPAVI){
            llSetLinkAlpha(_tp2avi, 0.55, ALL_SIDES);
            llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <0.00000, 0.00000, -0.05000>]);
            llMessageLinked(LINK_SET, 0, "Tp2Avi ON",      NULL_KEY);
        }
        else if (g_CMTPCAM){
            llSetLinkAlpha(_tp2cam, 0.55, ALL_SIDES);
            llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <0.00000, -0.03500, -0.05000>]);
            llMessageLinked(LINK_SET, 0, "Tp2Cam ON",      NULL_KEY);
        }
        else if (g_CMANTIPUSH){
            llSetLinkAlpha(_antipush, 0.55, ALL_SIDES);
            llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <0.00000, -0.05000, 0.00000>]);
            llMessageLinked(LINK_SET, 0, "AntiPush ON",    NULL_KEY);
        }
        else if (g_CMCAMAVI){
            llSetLinkAlpha(_cam2avi, 0.55, ALL_SIDES);
            llSetLinkPrimitiveParams(_cam2avi, [PRIM_POS_LOCAL, <0.00000, -0.07000, -0.05000>]);
            llMessageLinked(LINK_SET, 0, "Cam2Avi ON",     NULL_KEY);
        }
        else{
            llSetLinkAlpha(_follower, 0,    ALL_SIDES);
            llSetLinkAlpha(_tp2avi,   0,    ALL_SIDES);
            llSetLinkAlpha(_tp2cam,   0,    ALL_SIDES);
            llSetLinkAlpha(_antipush, 0,    ALL_SIDES);
            llSetLinkAlpha(_cam2avi,  0,    ALL_SIDES);
            llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_tp2avi,   [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_tp2cam,   [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
            llSetLinkPrimitiveParams(_cam2avi,  [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);

            //!TEST
            //llMessageLinked(LINK_SET, 0, "AntiPush OFF",    NULL_KEY);
            //llMessageLinked(LINK_SET, 0, "Cam2Avi OFF",     NULL_KEY);
            //llMessageLinked(LINK_SET, 0, "Follower OFF",    NULL_KEY);
            //llMessageLinked(LINK_SET, 0, "Tp2Avi OFF",      NULL_KEY);
            //llMessageLinked(LINK_SET, 0, "Tp2Cam OFF",      NULL_KEY);

        /*
            llSetScriptState("[{Amy}]CameraMod - AntiPush", FALSE);
            llSetScriptState("[{Amy}]CameraMod - Cam2Avi",  FALSE);
            llSetScriptState("[{Amy}]CameraMod - Follower", FALSE);
            llSetScriptState("[{Amy}]CameraMod - Tp2Avi",   FALSE);
            llSetScriptState("[{Amy}]CameraMod - Tp2Cam",   FALSE);
    	*/
        }
        llSetLinkTexture(_camera,   CAMERA_Texture,     ALL_SIDES);
        llSetLinkTexture(_tp2cam,   TP2CAM_Texture,     ALL_SIDES);
        llSetLinkTexture(_tp2avi,   TP2AVI_Texture,     ALL_SIDES);
        llSetLinkTexture(_follower, FOLLOWER_Texture,   ALL_SIDES);
        llSetLinkTexture(_cam2avi,  CAM2AVI_Texture,    ALL_SIDES);
    }

    touch_start(integer total_number)
    {
        if(llDetectedKey(0) == llGetOwner())
            menu(llGetOwner());
    }

    listen(integer channel, string name, key id, string message)
    {
        llListenRemove(channel);
        if (llGetOwnerKey(id) == llGetOwner()) //!
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
            else if (message == "† StopAnims †"){
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
                if(!g_CMFollower){
                    g_CMFollower = TRUE;
                    llSetLinkAlpha(_follower, 0.55, ALL_SIDES);
                    llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <0.00000, -0.03000, 0.00000>]);
                    llOwnerSay("Follower is On!");
                }
                else{
                    g_CMFollower = FALSE;
                    llSetLinkAlpha(_follower, 0, ALL_SIDES);
                    llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Follower is Off!");
                }
                features(id);
            }
            else if ((message == "TP2Cam") || (message == "√ TP2Cam")){
                if(!g_CMTPCAM){
                    g_CMTPCAM = TRUE;
                    llSetLinkAlpha(_tp2cam, 0.55, ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <0.00000, -0.03500, -0.05000>]);
                    llOwnerSay("Teleport to Camera is On!");
                }
                else{
                    g_CMTPCAM = FALSE;
                    llSetLinkAlpha(_tp2cam, 0, ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2cam, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Teleport to Camera is Off!");
                }
                features(id);
            }
            else if ((message == "TP2Avi") || (message == "√ TP2Avi")){
                if(!g_CMTPAVI){
                    g_CMTPAVI = TRUE;
                    llSetLinkAlpha(_tp2avi, 0.55, ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <0.00000, 0.00000, -0.05000>]);
                    llOwnerSay("Teleport to Avatar is On!");
                }
                else{
                    g_CMTPAVI = FALSE;
                    llSetLinkAlpha(_tp2avi, 0, ALL_SIDES);
                    llSetLinkPrimitiveParams(_tp2avi, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Teleport to Avatar is Off!");
                }
                features(id);
            }
            else if ((message == "AntiPush") || (message == "√ AntiPush")){
                if(!g_CMANTIPUSH){
                    g_CMANTIPUSH = TRUE;
                    llSetLinkAlpha(_antipush, 0.55, ALL_SIDES);
                    llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <0.00000, -0.06000, -0.00000>]);
                    llOwnerSay("AntiPush is On!");
                }
                else{
                    g_CMANTIPUSH = FALSE;
                    llSetLinkAlpha(_antipush, 0, ALL_SIDES);
                    llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("AntiPush is Off!");
                }
                features(id);
            }
            else if ((message == "Cam2Avi") || (message == "√ Cam2Avi")){
                if(!g_CMCAMAVI){
                    g_CMCAMAVI = TRUE;
                    llSetLinkAlpha(_cam2avi, 0.55, ALL_SIDES);
                    llSetLinkPrimitiveParams(_cam2avi, [PRIM_POS_LOCAL, <0.00000, -0.07000, 0.05000>]);
                    llOwnerSay("Camera to Avatar is On!");
                }
                else{
                    g_CMCAMAVI = FALSE;
                    llSetLinkAlpha(_cam2avi, 0, ALL_SIDES);
                    llSetLinkPrimitiveParams(_cam2avi, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                    llOwnerSay("Camera to Avatar is Off!");
                }
                features(id);
            }
            else if (message == "Everything"){
                g_CMFollower    = TRUE;
                g_CMTPCAM       = TRUE;
                g_CMTPAVI       = TRUE;
                g_CMANTIPUSH    = TRUE;
                g_CMCAMAVI      = TRUE;
                llSetLinkAlpha(_follower,   0.55, ALL_SIDES);
                llSetLinkAlpha(_tp2cam,     0.55, ALL_SIDES);
                llSetLinkAlpha(_tp2avi,     0.55, ALL_SIDES);
                llSetLinkAlpha(_antipush,   0.55, ALL_SIDES);
                llSetLinkAlpha(_cam2avi,    0.55, ALL_SIDES);
                llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL,    <0.00000, -0.03000,  0.00000>]);
                llSetLinkPrimitiveParams(_tp2cam,   [PRIM_POS_LOCAL,    <0.00000, -0.03500, -0.05000>]);
                llSetLinkPrimitiveParams(_tp2avi,   [PRIM_POS_LOCAL,    <0.00000,  0.00000, -0.05000>]);
                llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL,    <0.00000, -0.06000,  0.00000>]);
                llSetLinkPrimitiveParams(_cam2avi,  [PRIM_POS_LOCAL,    <0.00000, -0.07000, -0.05000>]);

                //!TEST
                //llMessageLinked(LINK_SET, 0, "AntiPush ON",    NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Cam2Avi ON",     NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Follower ON",    NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Tp2Avi ON",      NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Tp2Cam ON",      NULL_KEY);

                llOwnerSay("Every Features are on!");
                menu(id);
            }
            else if (message == "√ Everything"){
                g_CMFollower    = FALSE;
                g_CMTPCAM       = FALSE;
                g_CMTPAVI       = FALSE;
                g_CMANTIPUSH    = FALSE;
                g_CMCAMAVI      = FALSE;
                llSetLinkAlpha(_follower, 0,  ALL_SIDES);
                llSetLinkAlpha(_tp2cam,   0,  ALL_SIDES);
                llSetLinkAlpha(_tp2avi,   0,  ALL_SIDES);
                llSetLinkAlpha(_antipush, 0,  ALL_SIDES);
                llSetLinkAlpha(_cam2avi,  0,  ALL_SIDES);
                llSetLinkPrimitiveParams(_follower, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_tp2cam,   [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_tp2avi,   [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_antipush, [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);
                llSetLinkPrimitiveParams(_cam2avi,  [PRIM_POS_LOCAL, <1.00000, 0.27930, -0.24437>]);

                //!TEST
                //llMessageLinked(LINK_SET, 0, "AntiPush OFF",    NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Cam2Avi OFF",     NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Follower OFF",    NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Tp2Avi OFF",      NULL_KEY);
                //llMessageLinked(LINK_SET, 0, "Tp2Cam OFF",      NULL_KEY);

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
        if (change & CHANGED_LINK){
            key agent = llAvatarOnSitTarget();
            if (agent)
                llRequestPermissions(agent, PERMISSION_CONTROL_CAMERA);
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