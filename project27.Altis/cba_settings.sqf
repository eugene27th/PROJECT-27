// ACE Advanced Ballistics
force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force ace_advanced_ballistics_bulletTraceEnabled = true;
force ace_advanced_ballistics_enabled = true;
force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force ace_advanced_ballistics_simulationInterval = 0.05;

// ACE Advanced Fatigue
force ace_advanced_fatigue_enabled = true;
force ace_advanced_fatigue_enableStaminaBar = true;
force ace_advanced_fatigue_fadeStaminaBar = true;
force ace_advanced_fatigue_loadFactor = 1;
force ace_advanced_fatigue_performanceFactor = 1;
force ace_advanced_fatigue_recoveryFactor = 1;
force ace_advanced_fatigue_swayFactor = 1;
force ace_advanced_fatigue_terrainGradientFactor = 1;

// ACE Advanced Throwing
force ace_advanced_throwing_enabled = true;
force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = true;
force ace_advanced_throwing_showMouseControls = true;
force ace_advanced_throwing_showThrowArc = true;

// ACE Arsenal
force ace_arsenal_allowDefaultLoadouts = true;
force ace_arsenal_allowSharedLoadouts = true;
ace_arsenal_camInverted = false;
force ace_arsenal_enableIdentityTabs = true;
ace_arsenal_enableModIcons = true;
ace_arsenal_EnableRPTLog = false;
ace_arsenal_fontHeight = 4.5;

// ACE Artillery
force ace_artillerytables_advancedCorrections = true;
force ace_artillerytables_disableArtilleryComputer = false;
force ace_mk6mortar_airResistanceEnabled = true;
force ace_mk6mortar_allowCompass = true;
force ace_mk6mortar_allowComputerRangefinder = false;
force ace_mk6mortar_useAmmoHandling = true;

// ACE Captives
force ace_captives_allowHandcuffOwnSide = true;
force ace_captives_allowSurrender = true;
force ace_captives_requireSurrender = 0;
force ace_captives_requireSurrenderAi = false;

// ACE Common
force ace_common_allowFadeMusic = true;
force ace_common_checkPBOsAction = 0;
force ace_common_checkPBOsCheckAll = false;
force ace_common_checkPBOsWhitelist = "[]";
ace_common_displayTextColor = [0,0,0,0.1];
ace_common_displayTextFontColor = [1,1,1,1];
ace_common_settingFeedbackIcons = 1;
ace_common_settingProgressBarLocation = 0;
force ace_noradio_enabled = true;
ace_parachute_hideAltimeter = true;

// ACE Crew Served Weapons
force ace_csw_ammoHandling = 2;
force ace_csw_defaultAssemblyMode = false;
ace_csw_dragAfterDeploy = false;
force ace_csw_handleExtraMagazines = true;
force ace_csw_progressBarTimeCoefficent = 1;

// ACE Explosives
ace_explosives_customTimerDefault = 30;
force ace_explosives_customTimerMax = 900;
force ace_explosives_customTimerMin = 5;
force ace_explosives_explodeOnDefuse = true;
force ace_explosives_punishNonSpecialists = true;
force ace_explosives_requireSpecialist = false;

// ACE Fragmentation Simulation
force ace_frag_enabled = true;
force ace_frag_maxTrack = 10;
force ace_frag_maxTrackPerFrame = 10;
force ace_frag_reflectionsEnabled = true;
force ace_frag_spallEnabled = true;

// ACE G-Forces
force ace_gforces_coef = 1;
force ace_gforces_enabledFor = 0;

// ACE Goggles
ace_goggles_effects = 2;
ace_goggles_showClearGlasses = true;
ace_goggles_showInThirdPerson = true;

// ACE Grenades
force ace_grenades_convertExplosives = true;

// ACE Hearing
force ace_hearing_autoAddEarplugsToUnits = true;
force ace_hearing_disableEarRinging = false;
force ace_hearing_earplugsVolume = 0.5;
force force ace_hearing_enableCombatDeafness = true;
force ace_hearing_enabledForZeusUnits = true;
force ace_hearing_unconsciousnessVolume = 0.4;

// ACE Interaction
force ace_interaction_disableNegativeRating = true;
ace_interaction_enableMagazinePassing = true;
force ace_interaction_enableTeamManagement = true;

// ACE Interaction Menu
ace_gestures_showOnInteractionMenu = 2;
ace_interact_menu_actionOnKeyRelease = true;
ace_interact_menu_addBuildingActions = false;
ace_interact_menu_alwaysUseCursorInteraction = false;
ace_interact_menu_alwaysUseCursorSelfInteraction = true;
ace_interact_menu_colorShadowMax = [0,0,0,1];
ace_interact_menu_colorShadowMin = [0,0,0,0.25];
ace_interact_menu_colorTextMax = [1,1,1,1];
ace_interact_menu_colorTextMin = [1,1,1,0.25];
ace_interact_menu_cursorKeepCentered = false;
ace_interact_menu_cursorKeepCenteredSelfInteraction = false;
ace_interact_menu_menuAnimationSpeed = 0;
ace_interact_menu_menuBackground = 0;
ace_interact_menu_menuBackgroundSelf = 0;
ace_interact_menu_selectorColor = [1,0,0];
ace_interact_menu_shadowSetting = 2;
ace_interact_menu_textSize = 2;
ace_interact_menu_useListMenu = false;
ace_interact_menu_useListMenuSelf = false;

// ACE Logistics
force ace_cargo_enable = true;
force ace_cargo_loadTimeCoefficient = 5;
force ace_cargo_paradropTimeCoefficent = 2.5;
force ace_rearm_distance = 20;
force ace_rearm_level = 1;
force ace_rearm_supply = 0;
force ace_refuel_hoseLength = 12;
force ace_refuel_rate = 1;
force ace_repair_addSpareParts = true;
force ace_repair_autoShutOffEngineWhenStartingRepair = true;
force ace_repair_consumeItem_toolKit = 0;
force ace_repair_displayTextOnRepair = true;
force ace_repair_engineerSetting_fullRepair = 1;
force ace_repair_engineerSetting_repair = 1;
force ace_repair_engineerSetting_wheel = 0;
force ace_repair_fullRepairLocation = 3;
force ace_repair_fullRepairRequiredItems = ["ToolKit"];
force ace_repair_miscRepairRequiredItems = ["ToolKit"];
force ace_repair_repairDamageThreshold = 0.6;
force ace_repair_repairDamageThreshold_engineer = 0.4;
force ace_repair_wheelRepairRequiredItems = ["ToolKit"];

// ACE Magazine Repack
force ace_magazinerepack_timePerAmmo = 1.5;
force ace_magazinerepack_timePerBeltLink = 8;
force ace_magazinerepack_timePerMagazine = 2;

// ACE Map
force ace_map_BFT_Enabled = false;
force ace_map_BFT_HideAiGroups = false;
force ace_map_BFT_Interval = 1;
force ace_map_BFT_ShowPlayerNames = true;
force ace_map_DefaultChannel = 1;
force ace_map_mapGlow = true;
force ace_map_mapIllumination = true;
force ace_map_mapLimitZoom = false;
force ace_map_mapShake = true;
force ace_map_mapShowCursorCoordinates = false;
force ace_markers_moveRestriction = 0;
ace_markers_timestampEnabled = true;
ace_markers_timestampFormat = "HH:MM";
ace_markers_timestampHourFormat = 24;

// ACE Map Gestures
ace_map_gestures_defaultColor = [1,0.88,0,0.7];
ace_map_gestures_defaultLeadColor = [1,0.88,0,0.95];
force ace_map_gestures_enabled = true;
force ace_map_gestures_interval = 0.03;
force ace_map_gestures_maxRange = 7;
ace_map_gestures_nameTextColor = [0.2,0.2,0.2,0.3];

// ACE Map Tools
force ace_maptools_drawStraightLines = true;
force ace_maptools_rotateModifierKey = 1;

// ACE Name Tags
ace_nametags_defaultNametagColor = [0.77,0.51,0.08,1];
ace_nametags_nametagColorBlue = [0.67,0.67,1,1];
ace_nametags_nametagColorGreen = [0.67,1,0.67,1];
ace_nametags_nametagColorMain = [1,1,1,1];
ace_nametags_nametagColorRed = [1,0.67,0.67,1];
ace_nametags_nametagColorYellow = [1,1,0.67,1];
force ace_nametags_playerNamesMaxAlpha = 0.8;
force ace_nametags_playerNamesViewDistance = 5;
force ace_nametags_showCursorTagForVehicles = false;
force ace_nametags_showNamesForAI = false;
force ace_nametags_showPlayerNames = 0;
force ace_nametags_showPlayerRanks = true;
ace_nametags_showSoundWaves = 2;
force ace_nametags_showVehicleCrewInfo = true;
ace_nametags_tagSize = 2;

// ACE Nightvision
force ace_nightvision_aimDownSightsBlur = 0.25;
force ace_nightvision_disableNVGsWithSights = false;
force ace_nightvision_effectScaling = 0.25;
force ace_nightvision_fogScaling = 0.25;
force ace_nightvision_noiseScaling = 0.25;
force ace_nightvision_shutterEffects = true;

// ACE Overheating
force ace_overheating_displayTextOnJam = true;
force ace_overheating_enabled = true;
force ace_overheating_overheatingDispersion = true;
force ace_overheating_showParticleEffects = true;
ace_overheating_showParticleEffectsForEveryone = false;
force ace_overheating_unJamFailChance = 0.300331;
force ace_overheating_unJamOnreload = false;

// ACE Pointing
force ace_finger_enabled = true;
ace_finger_indicatorColor = [0.83,0.68,0.21,0.75];
force ace_finger_indicatorForSelf = true;
force ace_finger_maxRange = 11.5;

// ACE Pylons
force ace_pylons_enabledForZeus = true;
force ace_pylons_enabledFromAmmoTrucks = true;
force ace_pylons_rearmNewPylons = true;
force ace_pylons_requireEngineer = false;
force ace_pylons_requireToolkit = false;
force ace_pylons_searchDistance = 15;
force ace_pylons_timePerPylon = 5;

// ACE Quick Mount
force ace_quickmount_distance = 3;
force ace_quickmount_enabled = true;
ace_quickmount_enableMenu = 3;
force ace_quickmount_priority = 0;
force ace_quickmount_speed = 18;

// ACE Respawn
force ace_respawn_removeDeadBodiesDisconnected = true;
force ace_respawn_savePreDeathGear = true;

// ACE Scopes
force ace_scopes_correctZeroing = true;
force ace_scopes_deduceBarometricPressureFromTerrainAltitude = true;
force ace_scopes_defaultZeroRange = 100;
force ace_scopes_enabled = true;
force ace_scopes_forceUseOfAdjustmentTurrets = false;
force ace_scopes_overwriteZeroRange = false;
force ace_scopes_simplifiedZeroing = false;
ace_scopes_useLegacyUI = false;
force ace_scopes_zeroReferenceBarometricPressure = 1013.25;
force ace_scopes_zeroReferenceHumidity = 0;
force ace_scopes_zeroReferenceTemperature = 15;

// ACE Spectator
force ace_spectator_enableAI = false;
ace_spectator_maxFollowDistance = 5;
force ace_spectator_restrictModes = 0;
force ace_spectator_restrictVisions = 0;

// ACE Switch Units
force ace_switchunits_enableSafeZone = true;
force ace_switchunits_enableSwitchUnits = false;
force ace_switchunits_safeZoneRadius = 100;
force ace_switchunits_switchToCivilian = false;
force ace_switchunits_switchToEast = false;
force ace_switchunits_switchToIndependent = false;
force ace_switchunits_switchToWest = false;

// ACE Trenches
force ace_trenches_bigEnvelopeDigDuration = 25;
force ace_trenches_bigEnvelopeRemoveDuration = 15;
force ace_trenches_smallEnvelopeDigDuration = 20;
force ace_trenches_smallEnvelopeRemoveDuration = 12;

// ACE Uncategorized
force ace_gunbag_swapGunbagEnabled = true;
force ace_fastroping_requireRopeItems = true;
force ace_hitreactions_minDamageToTrigger = 0.1;
ace_inventory_inventoryDisplaySize = 0;
force ace_laser_dispersionCount = 2;
force ace_microdagr_mapDataAvailable = 2;
force ace_microdagr_waypointPrecision = 3;
ace_optionsmenu_showNewsOnMainMenu = true;
force ace_overpressure_distanceCoefficient = 1;
force ace_tagging_quickTag = 1;

// ACE Vehicle Lock
force ace_vehiclelock_defaultLockpickStrength = 10;
force ace_vehiclelock_lockVehicleInventory = true;
force ace_vehiclelock_vehicleStartingLockState = -1;

// ACE Cook off
force ace_cookoff_ammoCookoffDuration = 0;
force ace_cookoff_enable = 0;
force ace_cookoff_enableAmmobox = false;
force ace_cookoff_enableAmmoCookoff = false;
force ace_cookoff_probabilityCoef = 0;

// ACE Zeus
force ace_zeus_autoAddObjects = false;
force ace_zeus_canCreateZeus = -1;
force ace_zeus_radioOrdnance = false;
force ace_zeus_remoteWind = false;
force ace_zeus_revealMines = 0;
force ace_zeus_zeusAscension = false;
force ace_zeus_zeusBird = false;

// ACE User Interface
force ace_ui_allowSelectiveUI = false;
force ace_ui_ammoCount = false;
force ace_ui_ammoType = true;
force ace_ui_commandMenu = true;
force ace_ui_firingMode = true;
force ace_ui_groupBar = true;
force ace_ui_gunnerAmmoCount = true;
force ace_ui_gunnerAmmoType = true;
force ace_ui_gunnerFiringMode = true;
force ace_ui_gunnerLaunchableCount = true;
force ace_ui_gunnerLaunchableName = true;
force ace_ui_gunnerMagCount = true;
force ace_ui_gunnerWeaponLowerInfoBackground = true;
force ace_ui_gunnerWeaponName = true;
force ace_ui_gunnerWeaponNameBackground = true;
force ace_ui_gunnerZeroing = true;
force ace_ui_magCount = true;
force ace_ui_soldierVehicleWeaponInfo = true;
force ace_ui_staminaBar = true;
force ace_ui_stance = true;
force ace_ui_throwableCount = false;
force ace_ui_throwableName = true;
force ace_ui_vehicleAltitude = true;
force ace_ui_vehicleCompass = true;
force ace_ui_vehicleDamage = true;
force ace_ui_vehicleFuelBar = true;
force ace_ui_vehicleInfoBackground = true;
force ace_ui_vehicleName = true;
force ace_ui_vehicleNameBackground = true;
force ace_ui_vehicleRadar = true;
force ace_ui_vehicleSpeed = true;
force ace_ui_weaponLowerInfoBackground = true;
force ace_ui_weaponName = true;
force ace_ui_weaponNameBackground = true;
force ace_ui_zeroing = true;

// ACE View Distance Limiter
force ace_viewdistance_enabled = true;
force ace_viewdistance_limitViewDistance = 12000;
ace_viewdistance_objectViewDistanceCoeff = 0;
ace_viewdistance_viewDistanceAirVehicle = 0;
ace_viewdistance_viewDistanceLandVehicle = 0;
ace_viewdistance_viewDistanceOnFoot = 0;

// ACE Vehicles
ace_vehicles_hideEjectAction = false;
force ace_vehicles_keepEngineRunning = false;
ace_vehicles_speedLimiterStep = 5;

// ACE Weapons
force ace_common_persistentLaserEnabled = true;
force ace_laserpointer_enabled = true;
force ace_reload_displayText = true;
ace_reload_showCheckAmmoSelf = false;
force ace_weaponselect_displayText = true;

// ACE Weather
force ace_weather_enabled = true;
ace_weather_showCheckAirTemperature = true;
force ace_weather_updateInterval = 60;
force ace_weather_windSimulation = true;

// ACE Wind Deflection
force ace_winddeflection_enabled = true;
force ace_winddeflection_simulationInterval = 0.05;
force ace_winddeflection_vehicleEnabled = true;

// ACEX Field Rations
force acex_field_rations_affectAdvancedFatigue = true;
force acex_field_rations_enabled = true;
acex_field_rations_hudShowLevel = 50;
acex_field_rations_hudTransparency = -1;
acex_field_rations_hudType = 1;
force acex_field_rations_hungerSatiated = 1;
force acex_field_rations_terrainObjectActions = true;
force acex_field_rations_thirstQuenched = 1;
force acex_field_rations_timeWithoutFood = 10;
force acex_field_rations_timeWithoutWater = 10;
force acex_field_rations_waterSourceActions = 2;

// ACEX Fortify
acex_fortify_settingHint = 2;

// ACEX Headless
force acex_headless_delay = 15;
force acex_headless_enabled = false;
force acex_headless_endMission = 0;
force acex_headless_log = false;
force acex_headless_transferLoadout = 0;

// ACEX Sitting
force acex_sitting_enable = true;

// ACEX View Restriction
force acex_viewrestriction_mode = 0;
force acex_viewrestriction_modeSelectiveAir = 0;
force acex_viewrestriction_modeSelectiveFoot = 0;
force acex_viewrestriction_modeSelectiveLand = 0;
force acex_viewrestriction_modeSelectiveSea = 0;
acex_viewrestriction_preserveView = false;

// ACEX Volume
acex_volume_enabled = false;
acex_volume_fadeDelay = 1;
acex_volume_lowerInVehicles = false;
acex_volume_reduction = 5;
acex_volume_remindIfLowered = false;
acex_volume_showNotification = true;

// CBA UI
cba_ui_notifyLifetime = 4;
cba_ui_StorePasswords = 1;

// ACE Medical
force ace_medical_ai_enabledFor = 2;
force ace_medical_AIDamageThreshold = 1;
force ace_medical_bleedingCoefficient = 1;
force ace_medical_blood_bloodLifetime = 300;
force ace_medical_blood_enabledFor = 2;
force ace_medical_blood_maxBloodObjects = 50;
force ace_medical_fatalDamageSource = 1;
force ace_medical_feedback_bloodVolumeEffectType = 2;
force ace_medical_feedback_painEffectType = 2;
force ace_medical_fractureChance = 0.5;
force ace_medical_fractures = 3;
ace_medical_gui_enableActions = 0;
force ace_medical_gui_enableMedicalMenu = 1;
force ace_medical_gui_enableSelfActions = true;
ace_medical_gui_interactionMenuShowTriage = 1;
force ace_medical_gui_maxDistance = 3;
ace_medical_gui_openAfterTreatment = true;
force ace_medical_ivFlowRate = 1;
force ace_medical_limping = 1;
force ace_medical_painCoefficient = 1;
force ace_medical_playerDamageThreshold = 1;
force ace_medical_spontaneousWakeUpChance = 0.8;
force ace_medical_spontaneousWakeUpEpinephrineBoost = 3.4;
force ace_medical_statemachine_AIUnconsciousness = false;
force ace_medical_statemachine_cardiacArrestBleedoutEnabled = true;
force ace_medical_statemachine_cardiacArrestTime = 300;
force ace_medical_statemachine_fatalInjuriesAI = 0;
force ace_medical_statemachine_fatalInjuriesPlayer = 2;
force ace_medical_treatment_advancedBandages = 2;
force ace_medical_treatment_advancedDiagnose = true;
force ace_medical_treatment_advancedMedication = true;
force ace_medical_treatment_allowBodyBagUnconscious = false;
force ace_medical_treatment_allowLitterCreation = true;
force ace_medical_treatment_allowSelfIV = 0;
force ace_medical_treatment_allowSelfPAK = 1;
force ace_medical_treatment_consumeSurgicalKit = 1;
force ace_medical_treatment_allowSelfStitch = 0;
force ace_medical_treatment_allowSharedEquipment = 0;
force ace_medical_treatment_clearTraumaAfterBandage = false;
force ace_medical_treatment_consumePAK = 1;
force ace_medical_treatment_convertItems = 0;
force ace_medical_treatment_cprSuccessChance = 0.8;
force ace_medical_treatment_holsterRequired = 0;
force ace_medical_treatment_litterCleanupDelay = 180;
force ace_medical_treatment_locationEpinephrine = 0;
force ace_medical_treatment_locationPAK = 0;
force ace_medical_treatment_locationsBoostTraining = true;
force ace_medical_treatment_locationSurgicalKit = 0;
force ace_medical_treatment_maxLitterObjects = 50;
force ace_medical_treatment_medicEpinephrine = 1;
force ace_medical_treatment_medicIV = 0;
force ace_medical_treatment_medicPAK = 1;
force ace_medical_treatment_medicSurgicalKit = 1;
force ace_medical_treatment_timeCoefficientPAK = 1;
force ace_medical_treatment_treatmentTimeAutoinjector = 5;
force ace_medical_treatment_treatmentTimeBodyBag = 15;
force ace_medical_treatment_treatmentTimeCPR = 15;
force ace_medical_treatment_treatmentTimeIV = 12;
force ace_medical_treatment_treatmentTimeSplint = 7;
force ace_medical_treatment_treatmentTimeTourniquet = 7;
force ace_medical_treatment_woundReopenChance = 1;
force ace_medical_treatment_woundStitchTime = 5;

// CBA Weapons
cba_disposable_dropUsedLauncher = 2;
force cba_disposable_replaceDisposableLauncher = true;
cba_events_repetitionMode = 1;
cba_optics_usePipOptics = true;

// Task Force Arrowhead Radio
TF_default_radioVolume = 9;
force TF_give_microdagr_to_soldier = true;
force TF_give_personal_radio_to_regular_soldier = true;
force TF_no_auto_long_range_radio = true;
force TF_same_dd_frequencies_for_side = false;
force TF_same_lr_frequencies_for_side = false;
force TF_same_sw_frequencies_for_side = false;