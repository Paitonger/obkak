-- 17.04
hook.Add("InitPostEntity","NoWidgets",function()
 timer.Simple(60, function()
 	-- Usually the cause of some if not most lag.
 	DarkRP.removeChatCommand("cheque")
 	DarkRP.removeChatCommand("check")
  	DarkRP.removeChatCommand("freerpname")
 	
 	hook.Remove("PlayerTick", "TickWidgets")
 
 	if SERVER then
 		if timer.Exists("CheckHookTimes") then
 			timer.Remove("CheckHookTimes")
 		end

    for k, v in pairs(ents.FindByClass("env_fire")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("trigger_hurt")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("prop_physics")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("prop_ragdoll")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("light")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("spotlight_end")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("beam")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("point_spotlight")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("env_sprite")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("func_tracktrain")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("light_spot")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("point_template")) do v:Remove() end
    for k, v in pairs(ents.FindByClass("env_soundscape")) do v:Remove() end   

 	end
	
 	hook.Remove("PlayerTick","TickWidgets")
	hook.Remove( "Think", "CheckSchedules")
	timer.Destroy("HostnameThink")
	hook.Remove("LoadGModSave", "LoadGModSave")
	
	// Remove a bunch of useless map stuff 
	
	
     if CLIENT then
         
        local commands = {
            'r_3dsky 0',
            'r_lightaverage 0',
            'r_decal_cullsize 20',
            'r_decals 1',
            'r_drawbatchdecals 1',
            'r_drawmodeldecals 0',
            'r_flex 0',
            'r_ForceWaterLeaf 0',
            'r_fastzreject -1',
            'r_teeth 0', 
            'r_cheapwaterstart 1',
            'r_cheapwaterend 1',
            'r_waterforceexpensive 0',
            'r_WaterDrawReflection 0',
            'r_dopixelvisibility 1',
            'r_pixelvisibility_partial 0',
            'r_ropetranslucent 0',
            'r_flashlightmodels 1',
            'r_flashlightrendermodels 0',
            'r_flashlightrenderworld 0',
            'r_DrawSpecificStaticProp 0',
            'r_eyes 1',
            'r_eyeglintlodpixels 0',
            'r_eyegloss 0',
            'r_eyemove 0',
            'r_eyeshift_x 0',
            'r_eyeshift_y 0',
            'r_eyeshift_z 0',
            'r_eyesize 0',
            'r_occlusion 0',
            'r_maxmodeldecal 0',
            'r_minnewsamples 0',
            'r_maxsampledist 0',
            'r_spray_lifetime 1',
            'r_mmx 1', 
            'r_sse 1',
            'r_sse2 1',
            'r_3dnow 1',
            'r_phong 0',
            'r_PhysPropStaticLighting 0',
        --    'r_dynamic 0', 
            'r_updaterefracttexture 0',
            'r_renderoverlayfragment 0',
         --   'r_worldlights 0',
            'rope_smooth 0',
            'rope_wind_dist 0',
            'rope_shake 0',
            'rope_smooth_maxalphawidth 0',
            'rope_smooth_maxalpha 0',
            'rope_smooth_enlarge 0',
            'rope_subdiv 0',
            'rope_smooth_minwidth 0',
            'rope_smooth_minalpha 0',
            'rope_averagelight 0',
            'rope_collide 0',
        --    'mat_specular 0',
            'r_shadows 0',
            'ss_render_range 400',
            'studio_queue_mode 1',
            'r_queued_ropes 1',
            'r_threaded_renderables 1',
            'r_threaded_client_shadow_manager 1',
            'cl_threaded_client_leaf_system 1',
            'cl_threaded_bone_setup 1',
            'fov_desired 90',
            'violence_hgibs 0', 
            'violence_agibs 0',
            'r_propsmaxdist 0',
            'props_break_max_pieces 0',
            'cl_phys_props_max 0',
            'r_shadowrendertotexture 0',
            'r_shadowmaxrendered 0',
            'mat_shadowstate 0',
            'cl_phys_props_enable 0',
            'cl_phys_props_max 0',
            'gmod_mcore_test 1',
            'datacachesize 512',
            'r_fastzreject -1',
            'cl_ejectbrass 0',
            'Muzzleflash_light 0',
            'in_usekeyboardsampletime 0',
            'mat_disable_ps_patch 1',
            'cl_playerspraydisable 1',
            'mat_disable_fancy_blending 1',
            'r_decal_cullsize 0',
            'r_decals 0',
            'mp_decals 30',
            'mat_forceaniso 0',
            'mat_disable_bloom 0',
            'r_threaded_particles 1',
            'r_threaded_renderables 1',
            'r_queued_ropes 1',
            'joystick 0',
            'violence_ablood 0',
            'violence_hblood 1',
            'cl_show_splashes 0',
            'r_WaterDrawRefraction 0',
            'mat_wateroverlaysize 4',
            'r_lod 0',
            'r_shadowrendertotexture 0',
            'r_shadowmaxrendered 0',
            'cl_detaildist 0',
            'mat_bloomscale 0',
            'mat_hdr_enabled',
            'mat_hdr_level 0',
            'mat_disable_lightwarp 1',
            'mat_queue_mode 2',
            'cl_forcepreload 1',
            'voice_recordtofile 0',
            'cl_detail_avoid_radius 0',
            'net_compressvoice 1',
            'r_drawdetailprops 0',
            'snd_mix_async 1',
            'r_drawflecks 0',
            'cl_showhelp 0',
            'demo_avellimit 0',
        }
        
        local i = 1
        
        timer.Create('compliteCommands', 1, #table.GetKeys(commands), function()
            LocalPlayer():ConCommand(commands[i])
            print(commands[i])
            i = i + 1
        end)

        hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
        hook.Remove("RenderScreenspaceEffects", "RenderBloom")
        hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
        hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
        hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
        hook.Remove("RenderScreenspaceEffects", "RenderSobel")
        hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
        hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
        hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
        hook.Remove("RenderScene", "RenderStereoscopy")
        hook.Remove("RenderScene", "RenderSuperDoF")
        hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
        hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
        hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
        hook.Remove("PostRender", "RenderFrameBlend")
        hook.Remove("PreRender", "PreRenderFrameBlend")
        hook.Remove("Think", "DOFThink")
        hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
        hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
        hook.Remove("PostDrawEffects", "RenderWidgets")         -- We don't need this, but what the hell.
        hook.Remove("PostDrawEffects", "RenderHalos")       -- If you have pointshop issues, then delete this line.

        LocalPlayer():ConCommand('snd_restart; cl_drawmonitors 0; cl_tree_sway_dir .5 .5;')
        hook.Remove("StartChat", "StartChatIndicator")
        hook.Remove("FinishChat", "EndChatIndicator")
 		
        local mountMdl = util.GetModelMeshes("models/props/CS_militia/gun_cabinet.mdl")
        
        if mountMdl == nil then
        	chat.AddText( Color( 255, 0, 0 ), "[CSS] Мы заметили что у тебя не установлен контент CSS")
        	chat.AddText( Color( 255, 0, 0 ), "[CSS] Ссылка с исправлением: https://vk.cc/ariHzh")
        	chat.AddText( Color( 255, 0, 0 ), "[CSS] Открывай лучше на сервере в стим браузере. ( Shift + Tab )")
        
        	gui.OpenURL('https://docs.google.com/document/d/1ikX4qrMcMv7-rHxW-jiGd4oc_OQpJfM5qtqolFhYb-A')
        end
 	end
 end)
end)

hook.Add("OnEntityCreated","WidgetInit",function(ent) -- C+P from Facepunch
	if ent:IsWidget() then
		hook.Add( "PlayerTick", "TickWidgets", function( pl, mv ) widgets.PlayerTick( pl, mv ) end ) -- needed code.
		hook.Remove("OnEntityCreated","WidgetInit") -- calls it only once
	end
end)


 