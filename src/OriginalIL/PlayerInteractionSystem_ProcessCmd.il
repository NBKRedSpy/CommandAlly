.method public hidebysig static 
	void ProcessCmd (
		class MGSC.Scenarios scenarios,
		class MGSC.MapGrid mapGrid,
		class MGSC.MapMetadata mapMetadata,
		class MGSC.MapRenderer mapRenderer,
		class MGSC.MapController mapController,
		class MGSC.Creatures creatures,
		class MGSC.ItemsOnFloor itemsOnFloor,
		class MGSC.MapObstacles mapObstacles,
		class MGSC.MapEntities mapEntities,
		class MGSC.PlayerCommandQueue cmdQueue,
		class MGSC.TurnMetadata turnMetadata,
		class MGSC.RaidMetadata raidMetadata,
		class MGSC.CombatLog combatLog,
		class MGSC.ICommand cmd,
		class MGSC.FireController fireController,
		class MGSC.Visibilities visibilities,
		[out] bool& clearCmdQueue
	) cil managed 
{
	// Method begins at RVA 0xd8e08
	// Header size: 12
	// Code size: 1315 (0x523)
	.maxstack 18
	.locals init (
		[0] bool,
		[1] class MGSC.Monster,
		[2] class MGSC.MoveCommand,
		[3] class MGSC.InteractObjCommand,
		[4] class MGSC.MeleeObjCommand,
		[5] class MGSC.MapObstacle,
		[6] class MGSC.ThrowCommand,
		[7] valuetype MGSC.LimitsTooltip/LimitType,
		[8] class MGSC.ChangeFiremodeCommand,
		[9] class MGSC.ShootCommand,
		[10] class MGSC.UseThrowingWeaponCommand,
		[11] class MGSC.BasePickupItem,
		[12] class MGSC.CloseDoorCommand,
		[13] class MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_0',
		[14] valuetype MGSC.LimitsTooltip/LimitType,
		[15] class MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1',
		[16] class MGSC.UseVestSlotCommand,
		[17] class MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_2'
	)

	// bool flag = false;
	IL_0000: ldc.i4.0
	IL_0001: stloc.0
	// clearCmdQueue = false;
	IL_0002: ldarg.s clearCmdQueue
	IL_0004: ldc.i4.0
	IL_0005: stind.i1
	// if (cmd.Type == CmdType.PushAlly)
	IL_0006: ldarg.s cmd
	IL_0008: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_000d: ldc.i4.s 16
	IL_000f: bne.un.s IL_0041

	// Monster target = (cmd as PushAllyCommand).target;
	IL_0011: ldarg.s cmd
	IL_0013: isinst MGSC.PushAllyCommand
	IL_0018: ldfld class MGSC.Monster MGSC.PushAllyCommand::target
	IL_001d: stloc.1
	// TryPushAlly(mapGrid, mapMetadata, mapRenderer, mapController, creatures, itemsOnFloor, mapObstacles, cmdQueue, turnMetadata, raidMetadata, combatLog, scenarios, fireController, visibilities, mapEntities, target);
	IL_001e: ldarg.1
	IL_001f: ldarg.2
	IL_0020: ldarg.3
	IL_0021: ldarg.s mapController
	IL_0023: ldarg.s creatures
	IL_0025: ldarg.s itemsOnFloor
	IL_0027: ldarg.s mapObstacles
	IL_0029: ldarg.s cmdQueue
	IL_002b: ldarg.s turnMetadata
	IL_002d: ldarg.s raidMetadata
	IL_002f: ldarg.s combatLog
	IL_0031: ldarg.0
	IL_0032: ldarg.s fireController
	IL_0034: ldarg.s visibilities
	IL_0036: ldarg.s mapEntities
	IL_0038: ldloc.1
	IL_0039: call bool MGSC.PlayerInteractionSystem::TryPushAlly(class MGSC.MapGrid, class MGSC.MapMetadata, class MGSC.MapRenderer, class MGSC.MapController, class MGSC.Creatures, class MGSC.ItemsOnFloor, class MGSC.MapObstacles, class MGSC.PlayerCommandQueue, class MGSC.TurnMetadata, class MGSC.RaidMetadata, class MGSC.CombatLog, class MGSC.Scenarios, class MGSC.FireController, class MGSC.Visibilities, class MGSC.MapEntities, class MGSC.Monster)
	IL_003e: pop
	// flag = true;
	IL_003f: ldc.i4.1
	IL_0040: stloc.0

	// if (cmd.Type == CmdType.Move)
	IL_0041: ldarg.s cmd
	IL_0043: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_0048: brtrue.s IL_00c0

	// MoveCommand moveCommand = cmd as MoveCommand;
	IL_004a: ldarg.s cmd
	IL_004c: isinst MGSC.MoveCommand
	IL_0051: stloc.2
	// if ((!MovePlayer(mapGrid, mapMetadata, mapRenderer, mapController, creatures, itemsOnFloor, mapObstacles, cmdQueue, turnMetadata, raidMetadata, combatLog, scenarios, fireController, visibilities, mapEntities, moveCommand.target.X, moveCommand.target.Y) || CreatureSystem.IsSeeMonsters(creatures, mapGrid) || WoundSystem.HasAnyDotWound(creatures.Player.CreatureData.EffectsController)) && !creatures.Player.PreviousTurnSkiped)
	IL_0052: ldarg.1
	IL_0053: ldarg.2
	IL_0054: ldarg.3
	IL_0055: ldarg.s mapController
	IL_0057: ldarg.s creatures
	IL_0059: ldarg.s itemsOnFloor
	IL_005b: ldarg.s mapObstacles
	IL_005d: ldarg.s cmdQueue
	IL_005f: ldarg.s turnMetadata
	IL_0061: ldarg.s raidMetadata
	IL_0063: ldarg.s combatLog
	IL_0065: ldarg.0
	IL_0066: ldarg.s fireController
	IL_0068: ldarg.s visibilities
	IL_006a: ldarg.s mapEntities
	IL_006c: ldloc.2
	IL_006d: ldflda valuetype MGSC.CellPosition MGSC.MoveCommand::target
	IL_0072: ldfld int32 MGSC.CellPosition::X
	IL_0077: ldloc.2
	IL_0078: ldflda valuetype MGSC.CellPosition MGSC.MoveCommand::target
	IL_007d: ldfld int32 MGSC.CellPosition::Y
	IL_0082: ldc.i4.0
	IL_0083: call bool MGSC.PlayerInteractionSystem::MovePlayer(class MGSC.MapGrid, class MGSC.MapMetadata, class MGSC.MapRenderer, class MGSC.MapController, class MGSC.Creatures, class MGSC.ItemsOnFloor, class MGSC.MapObstacles, class MGSC.PlayerCommandQueue, class MGSC.TurnMetadata, class MGSC.RaidMetadata, class MGSC.CombatLog, class MGSC.Scenarios, class MGSC.FireController, class MGSC.Visibilities, class MGSC.MapEntities, int32, int32, bool)
	IL_0088: brfalse.s IL_00ac

	IL_008a: ldarg.s creatures
	IL_008c: ldarg.1
	IL_008d: call bool MGSC.CreatureSystem::IsSeeMonsters(class MGSC.Creatures, class MGSC.MapGrid)
	IL_0092: brtrue.s IL_00ac

	// (no C# code)
	IL_0094: ldarg.s creatures
	IL_0096: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_009b: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	IL_00a0: ldfld class MGSC.EffectsController MGSC.CreatureData::EffectsController
	IL_00a5: call bool MGSC.WoundSystem::HasAnyDotWound(class MGSC.EffectsController)
	IL_00aa: brfalse.s IL_00be

	// clearCmdQueue = true;
	IL_00ac: ldarg.s creatures
	IL_00ae: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_00b3: ldfld bool MGSC.Player::PreviousTurnSkiped
	IL_00b8: brtrue.s IL_00be

	IL_00ba: ldarg.s clearCmdQueue
	IL_00bc: ldc.i4.1
	IL_00bd: stind.i1

	// flag = true;
	IL_00be: ldc.i4.1
	IL_00bf: stloc.0

	// if (cmd.Type == CmdType.InteractObstacle)
	IL_00c0: ldarg.s cmd
	IL_00c2: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_00c7: ldc.i4.6
	IL_00c8: bne.un.s IL_00e6

	// InteractObjCommand interactObjCommand = cmd as InteractObjCommand;
	IL_00ca: ldarg.s cmd
	IL_00cc: isinst MGSC.InteractObjCommand
	IL_00d1: stloc.3
	// InteractObstacle(creatures, scenarios, interactObjCommand.target);
	IL_00d2: ldarg.s creatures
	IL_00d4: ldarg.0
	IL_00d5: ldloc.3
	IL_00d6: ldfld class MGSC.MapObstacle MGSC.InteractObjCommand::target
	IL_00db: call void MGSC.PlayerInteractionSystem::InteractObstacle(class MGSC.Creatures, class MGSC.Scenarios, class MGSC.MapObstacle)
	// clearCmdQueue = true;
	IL_00e0: ldarg.s clearCmdQueue
	IL_00e2: ldc.i4.1
	IL_00e3: stind.i1
	// flag = true;
	IL_00e4: ldc.i4.1
	IL_00e5: stloc.0

	// if (cmd.Type == CmdType.MeleeObject)
	IL_00e6: ldarg.s cmd
	IL_00e8: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_00ed: ldc.i4.s 11
	IL_00ef: bne.un.s IL_016e

	// MeleeObjCommand meleeObjCommand = cmd as MeleeObjCommand;
	IL_00f1: ldarg.s cmd
	IL_00f3: isinst MGSC.MeleeObjCommand
	IL_00f8: stloc.s 4
	// MapObstacle mapObstacle = mapObstacles.Get(meleeObjCommand.target.X, meleeObjCommand.target.Y, interactable: false, destroyable: true);
	IL_00fa: ldarg.s mapObstacles
	IL_00fc: ldloc.s 4
	IL_00fe: ldflda valuetype MGSC.CellPosition MGSC.MeleeObjCommand::target
	IL_0103: ldfld int32 MGSC.CellPosition::X
	IL_0108: ldloc.s 4
	IL_010a: ldflda valuetype MGSC.CellPosition MGSC.MeleeObjCommand::target
	IL_010f: ldfld int32 MGSC.CellPosition::Y
	IL_0114: ldc.i4.0
	IL_0115: ldc.i4.1
	IL_0116: callvirt instance class MGSC.MapObstacle MGSC.MapObstacles::Get(int32, int32, bool, bool)
	IL_011b: stloc.s 5
	// if (mapObstacle != null)
	IL_011d: ldloc.s 5
	IL_011f: ldnull
	IL_0120: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
	IL_0125: brfalse.s IL_0168

	// if (mapObstacle.Door != null)
	IL_0127: ldloc.s 5
	IL_0129: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
	IL_012e: ldnull
	IL_012f: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
	IL_0134: brfalse.s IL_0146

	// MeleeAttackTheDoor(creatures, mapObstacle.Door);
	IL_0136: ldarg.s creatures
	IL_0138: ldloc.s 5
	IL_013a: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
	IL_013f: call void MGSC.PlayerInteractionSystem::MeleeAttackTheDoor(class MGSC.Creatures, class MGSC.Door)
	// MeleeAttackTheObj(creatures, meleeObjCommand.target.X, meleeObjCommand.target.Y, mapObstacle);
	IL_0144: br.s IL_0168

	IL_0146: ldarg.s creatures
	IL_0148: ldloc.s 4
	IL_014a: ldflda valuetype MGSC.CellPosition MGSC.MeleeObjCommand::target
	IL_014f: ldfld int32 MGSC.CellPosition::X
	IL_0154: ldloc.s 4
	IL_0156: ldflda valuetype MGSC.CellPosition MGSC.MeleeObjCommand::target
	IL_015b: ldfld int32 MGSC.CellPosition::Y
	IL_0160: ldloc.s 5
	IL_0162: call bool MGSC.PlayerInteractionSystem::MeleeAttackTheObj(class MGSC.Creatures, int32, int32, class MGSC.MapObstacle)
	IL_0167: pop

	// clearCmdQueue = true;
	IL_0168: ldarg.s clearCmdQueue
	IL_016a: ldc.i4.1
	IL_016b: stind.i1
	// flag = true;
	IL_016c: ldc.i4.1
	IL_016d: stloc.0

	// if (cmd.Type == CmdType.ThrowCommand)
	IL_016e: ldarg.s cmd
	IL_0170: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_0175: ldc.i4.s 10
	IL_0177: bne.un.s IL_01ac

	// ThrowCommand throwCommand = cmd as ThrowCommand;
	IL_0179: ldarg.s cmd
	IL_017b: isinst MGSC.ThrowCommand
	IL_0180: stloc.s 6
	// creatures.Player.Throw(throwCommand.target.X, throwCommand.target.Y);
	IL_0182: ldarg.s creatures
	IL_0184: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_0189: ldloc.s 6
	IL_018b: ldflda valuetype MGSC.CellPosition MGSC.ThrowCommand::target
	IL_0190: ldfld int32 MGSC.CellPosition::X
	IL_0195: ldloc.s 6
	IL_0197: ldflda valuetype MGSC.CellPosition MGSC.ThrowCommand::target
	IL_019c: ldfld int32 MGSC.CellPosition::Y
	IL_01a1: callvirt instance void MGSC.Player::Throw(int32, int32)
	// clearCmdQueue = true;
	IL_01a6: ldarg.s clearCmdQueue
	IL_01a8: ldc.i4.1
	IL_01a9: stind.i1
	// flag = true;
	IL_01aa: ldc.i4.1
	IL_01ab: stloc.0

	// if (cmd.Type == CmdType.TakeItem)
	IL_01ac: ldarg.s cmd
	IL_01ae: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_01b3: ldc.i4.1
	IL_01b4: bne.un.s IL_01ed

	// if (!CanUseInventory(creatures, out var limitType))
	IL_01b6: ldarg.s creatures
	IL_01b8: ldloca.s 7
	IL_01ba: call bool MGSC.PlayerInteractionSystem::CanUseInventory(class MGSC.Creatures, valuetype MGSC.LimitsTooltip/LimitType&)
	IL_01bf: brtrue.s IL_01cf

	// SingletonMonoBehaviour<TooltipFactory>.Instance.ShowLimitsTooltip(limitType);
	IL_01c1: call !0 class MGSC.SingletonMonoBehaviour`1<class MGSC.TooltipFactory>::get_Instance()
	IL_01c6: ldloc.s 7
	IL_01c8: callvirt instance void MGSC.TooltipFactory::ShowLimitsTooltip(valuetype MGSC.LimitsTooltip/LimitType)
	// ItemOnFloorSystem.TakeItemFromFloor(itemsOnFloor, creatures.Player.CreatureData.Position);
	IL_01cd: br.s IL_01e7

	IL_01cf: ldarg.s itemsOnFloor
	IL_01d1: ldarg.s creatures
	IL_01d3: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_01d8: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	IL_01dd: ldfld valuetype MGSC.CellPosition MGSC.CreatureData::Position
	IL_01e2: call void MGSC.ItemOnFloorSystem::TakeItemFromFloor(class MGSC.ItemsOnFloor, valuetype MGSC.CellPosition)

	// clearCmdQueue = true;
	IL_01e7: ldarg.s clearCmdQueue
	IL_01e9: ldc.i4.1
	IL_01ea: stind.i1
	// flag = true;
	IL_01eb: ldc.i4.1
	IL_01ec: stloc.0

	// if (cmd.Type == CmdType.ReloadWeapon)
	IL_01ed: ldarg.s cmd
	IL_01ef: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_01f4: ldc.i4.3
	IL_01f5: bne.un.s IL_0205

	// Reload(creatures);
	IL_01f7: ldarg.s creatures
	IL_01f9: ldnull
	IL_01fa: call void MGSC.PlayerInteractionSystem::Reload(class MGSC.Creatures, class MGSC.BasePickupItem)
	// clearCmdQueue = true;
	IL_01ff: ldarg.s clearCmdQueue
	IL_0201: ldc.i4.1
	IL_0202: stind.i1
	// flag = true;
	IL_0203: ldc.i4.1
	IL_0204: stloc.0

	// if (cmd.Type == CmdType.SwapWeapon)
	IL_0205: ldarg.s cmd
	IL_0207: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_020c: ldc.i4.4
	IL_020d: bne.un.s IL_021c

	// SwapWeapon(creatures);
	IL_020f: ldarg.s creatures
	IL_0211: call void MGSC.PlayerInteractionSystem::SwapWeapon(class MGSC.Creatures)
	// clearCmdQueue = true;
	IL_0216: ldarg.s clearCmdQueue
	IL_0218: ldc.i4.1
	IL_0219: stind.i1
	// flag = true;
	IL_021a: ldc.i4.1
	IL_021b: stloc.0

	// if (cmd.Type == CmdType.ChangeFiremode)
	IL_021c: ldarg.s cmd
	IL_021e: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_0223: ldc.i4.s 12
	IL_0225: bne.un.s IL_0244

	// ChangeFiremodeCommand changeFiremodeCommand = cmd as ChangeFiremodeCommand;
	IL_0227: ldarg.s cmd
	IL_0229: isinst MGSC.ChangeFiremodeCommand
	IL_022e: stloc.s 8
	// ChangeFiremode(creatures, changeFiremodeCommand.firemodeId);
	IL_0230: ldarg.s creatures
	IL_0232: ldloc.s 8
	IL_0234: ldfld string MGSC.ChangeFiremodeCommand::firemodeId
	IL_0239: call void MGSC.PlayerInteractionSystem::ChangeFiremode(class MGSC.Creatures, string)
	// clearCmdQueue = true;
	IL_023e: ldarg.s clearCmdQueue
	IL_0240: ldc.i4.1
	IL_0241: stind.i1
	// flag = true;
	IL_0242: ldc.i4.1
	IL_0243: stloc.0

	// if (cmd.Type == CmdType.Shoot)
	IL_0244: ldarg.s cmd
	IL_0246: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_024b: ldc.i4.2
	IL_024c: bne.un.s IL_0283

	// ShootCommand shootCommand = cmd as ShootCommand;
	IL_024e: ldarg.s cmd
	IL_0250: isinst MGSC.ShootCommand
	IL_0255: stloc.s 9
	// creatures.Player.Shoot(shootCommand.target.X, shootCommand.target.Y);
	IL_0257: ldarg.s creatures
	IL_0259: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_025e: ldloc.s 9
	IL_0260: ldflda valuetype MGSC.CellPosition MGSC.ShootCommand::target
	IL_0265: ldfld int32 MGSC.CellPosition::X
	IL_026a: ldloc.s 9
	IL_026c: ldflda valuetype MGSC.CellPosition MGSC.ShootCommand::target
	IL_0271: ldfld int32 MGSC.CellPosition::Y
	IL_0276: ldc.i4.0
	IL_0277: callvirt instance bool MGSC.Creature::Shoot(int32, int32, bool)
	IL_027c: pop
	// clearCmdQueue = true;
	IL_027d: ldarg.s clearCmdQueue
	IL_027f: ldc.i4.1
	IL_0280: stind.i1
	// flag = true;
	IL_0281: ldc.i4.1
	IL_0282: stloc.0

	// if (cmd.Type == CmdType.UseThrowingWeapon)
	IL_0283: ldarg.s cmd
	IL_0285: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_028a: ldc.i4.s 17
	IL_028c: bne.un.s IL_02da

	// UseThrowingWeaponCommand useThrowingWeaponCommand = cmd as UseThrowingWeaponCommand;
	IL_028e: ldarg.s cmd
	IL_0290: isinst MGSC.UseThrowingWeaponCommand
	IL_0295: stloc.s 10
	// BasePickupItem itemByIndex = creatures.Player.CreatureData.Inventory.VestStore.GetItemByIndex(useThrowingWeaponCommand.slotIndex - 1);
	IL_0297: ldarg.s creatures
	IL_0299: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_029e: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	IL_02a3: ldfld class MGSC.Inventory MGSC.CreatureData::Inventory
	IL_02a8: ldfld class MGSC.ItemStorage MGSC.Inventory::VestStore
	IL_02ad: ldloc.s 10
	IL_02af: ldfld int32 MGSC.UseThrowingWeaponCommand::slotIndex
	IL_02b4: ldc.i4.1
	IL_02b5: sub
	IL_02b6: callvirt instance class MGSC.BasePickupItem MGSC.ItemStorage::GetItemByIndex(int32)
	IL_02bb: stloc.s 11
	// creatures.Player.UseThrowingWeapon(itemByIndex, useThrowingWeaponCommand.target);
	IL_02bd: ldarg.s creatures
	IL_02bf: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_02c4: ldloc.s 11
	IL_02c6: ldloc.s 10
	IL_02c8: ldfld valuetype MGSC.CellPosition MGSC.UseThrowingWeaponCommand::target
	IL_02cd: ldc.i4.0
	IL_02ce: callvirt instance bool MGSC.Creature::UseThrowingWeapon(class MGSC.BasePickupItem, valuetype MGSC.CellPosition, bool)
	IL_02d3: pop
	// clearCmdQueue = true;
	IL_02d4: ldarg.s clearCmdQueue
	IL_02d6: ldc.i4.1
	IL_02d7: stind.i1
	// flag = true;
	IL_02d8: ldc.i4.1
	IL_02d9: stloc.0

	// if (cmd.Type == CmdType.CloseDoor)
	IL_02da: ldarg.s cmd
	IL_02dc: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_02e1: ldc.i4.7
	IL_02e2: bne.un.s IL_030a

	// CloseDoorCommand closeDoorCommand = cmd as CloseDoorCommand;
	IL_02e4: ldarg.s cmd
	IL_02e6: isinst MGSC.CloseDoorCommand
	IL_02eb: stloc.s 12
	// CloseTheDoor(creatures, itemsOnFloor, mapObstacles, mapEntities, scenarios, turnMetadata, closeDoorCommand.target);
	IL_02ed: ldarg.s creatures
	IL_02ef: ldarg.s itemsOnFloor
	IL_02f1: ldarg.s mapObstacles
	IL_02f3: ldarg.s mapEntities
	IL_02f5: ldarg.0
	IL_02f6: ldarg.s turnMetadata
	IL_02f8: ldloc.s 12
	IL_02fa: ldfld class MGSC.Door MGSC.CloseDoorCommand::target
	IL_02ff: call void MGSC.PlayerInteractionSystem::CloseTheDoor(class MGSC.Creatures, class MGSC.ItemsOnFloor, class MGSC.MapObstacles, class MGSC.MapEntities, class MGSC.Scenarios, class MGSC.TurnMetadata, class MGSC.Door)
	// clearCmdQueue = true;
	IL_0304: ldarg.s clearCmdQueue
	IL_0306: ldc.i4.1
	IL_0307: stind.i1
	// flag = true;
	IL_0308: ldc.i4.1
	IL_0309: stloc.0

	// if (flag)
	IL_030a: ldloc.0
	IL_030b: brfalse.s IL_030e

	// }
	IL_030d: ret

	// if (cmd.Type == CmdType.ShowDoorActionsList)
	IL_030e: ldarg.s cmd
	IL_0310: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_0315: ldc.i4.8
	IL_0316: bne.un IL_03ae

	// (no C# code)
	IL_031b: newobj instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_0'::.ctor()
	IL_0320: stloc.s 13
	// ShowDoorActionsListCommand doorCmd = cmd as ShowDoorActionsListCommand;
	IL_0322: ldloc.s 13
	IL_0324: ldarg.s cmd
	IL_0326: isinst MGSC.ShowDoorActionsListCommand
	IL_032b: stfld class MGSC.ShowDoorActionsListCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_0'::doorCmd
	// if (!CanInteractObstacles(creatures, scenarios, doorCmd.target.MapObstacle, out var limitType2))
	IL_0330: ldarg.s creatures
	IL_0332: ldarg.0
	IL_0333: ldloc.s 13
	IL_0335: ldfld class MGSC.ShowDoorActionsListCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_0'::doorCmd
	IL_033a: ldfld class MGSC.Door MGSC.ShowDoorActionsListCommand::target
	IL_033f: callvirt instance class MGSC.MapObstacle MGSC.MapObstacleComponent::get_MapObstacle()
	IL_0344: ldloca.s 14
	IL_0346: call bool MGSC.PlayerInteractionSystem::CanInteractObstacles(class MGSC.Creatures, class MGSC.Scenarios, class MGSC.MapObstacle, valuetype MGSC.LimitsTooltip/LimitType&)
	IL_034b: brtrue.s IL_035b

	// SingletonMonoBehaviour<TooltipFactory>.Instance.ShowLimitsTooltip(limitType2);
	IL_034d: call !0 class MGSC.SingletonMonoBehaviour`1<class MGSC.TooltipFactory>::get_Instance()
	IL_0352: ldloc.s 14
	IL_0354: callvirt instance void MGSC.TooltipFactory::ShowLimitsTooltip(valuetype MGSC.LimitsTooltip/LimitType)
	// else if (MapObstacleSystem.IsValidDoorPositionToInteract(creatures, itemsOnFloor, mapEntities, mapObstacles, doorCmd.target.MapObstacle))
	IL_0359: br.s IL_03aa

	IL_035b: ldarg.s creatures
	IL_035d: ldarg.s itemsOnFloor
	IL_035f: ldarg.s mapEntities
	IL_0361: ldarg.s mapObstacles
	IL_0363: ldloc.s 13
	IL_0365: ldfld class MGSC.ShowDoorActionsListCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_0'::doorCmd
	IL_036a: ldfld class MGSC.Door MGSC.ShowDoorActionsListCommand::target
	IL_036f: callvirt instance class MGSC.MapObstacle MGSC.MapObstacleComponent::get_MapObstacle()
	IL_0374: call bool MGSC.MapObstacleSystem::IsValidDoorPositionToInteract(class MGSC.Creatures, class MGSC.ItemsOnFloor, class MGSC.MapEntities, class MGSC.MapObstacles, class MGSC.MapObstacle)
	IL_0379: brfalse.s IL_03aa

	// 			UI.Chain<DoorTooltip>().Show().Invoke(delegate(DoorTooltip v)
	// 			{
	// 				v.Configure(doorCmd.target);
	// 			})
	// 				.SetBackgroundColor(Colors.Transparent)
	// 				.SetBackOnBackgroundClick(value: true);
	IL_037b: call class MGSC.UI/CmdChain`1<!!0> MGSC.UI::Chain<class MGSC.DoorTooltip>()
	IL_0380: ldc.i4.1
	IL_0381: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.DoorTooltip>::Show(bool)
	IL_0386: ldloc.s 13
	IL_0388: ldftn instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_0'::'<ProcessCmd>b__0'(class MGSC.DoorTooltip)
	IL_038e: newobj instance void class [mscorlib]System.Action`1<class MGSC.DoorTooltip>::.ctor(object, native int)
	IL_0393: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.DoorTooltip>::Invoke(class [mscorlib]System.Action`1<!0>)
	IL_0398: call valuetype [UnityEngine.CoreModule]UnityEngine.Color MGSC.Colors::get_Transparent()
	IL_039d: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.DoorTooltip>::SetBackgroundColor(valuetype [UnityEngine.CoreModule]UnityEngine.Color)
	IL_03a2: ldc.i4.1
	IL_03a3: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.DoorTooltip>::SetBackOnBackgroundClick(bool)
	// return;
	IL_03a8: pop
	IL_03a9: ret

	// clearCmdQueue = true;
	IL_03aa: ldarg.s clearCmdQueue
	IL_03ac: ldc.i4.1
	IL_03ad: stind.i1

	// if (cmd.Type == CmdType.ShowOptionsMonster)
	IL_03ae: ldarg.s cmd
	IL_03b0: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_03b5: ldc.i4.s 9
	IL_03b7: bne.un IL_045f

	// (no C# code)
	IL_03bc: newobj instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1'::.ctor()
	IL_03c1: stloc.s 15
	// ShowOptionsMonsterCommand intObjCmd = cmd as ShowOptionsMonsterCommand;
	IL_03c3: ldloc.s 15
	IL_03c5: ldarg.s cmd
	IL_03c7: isinst MGSC.ShowOptionsMonsterCommand
	IL_03cc: stfld class MGSC.ShowOptionsMonsterCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1'::intObjCmd
	// if (!intObjCmd.target.IsSeenByPlayer)
	IL_03d1: ldloc.s 15
	IL_03d3: ldfld class MGSC.ShowOptionsMonsterCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1'::intObjCmd
	IL_03d8: ldfld class MGSC.Creature MGSC.ShowOptionsMonsterCommand::target
	IL_03dd: callvirt instance bool MGSC.Creature::get_IsSeenByPlayer()
	IL_03e2: brtrue.s IL_03e9

	// clearCmdQueue = true;
	IL_03e4: ldarg.s clearCmdQueue
	IL_03e6: ldc.i4.1
	IL_03e7: stind.i1
	// return;
	IL_03e8: ret

	// 		UI.Chain<MonsterInspectWindow>().Invoke(delegate(MonsterInspectWindow v)
	// 		{
	// 			v.Configure(intObjCmd.target);
	// 		}).Show()
	// 			.SetBackOnBackgroundClick(value: true);
	IL_03e9: call class MGSC.UI/CmdChain`1<!!0> MGSC.UI::Chain<class MGSC.MonsterInspectWindow>()
	IL_03ee: ldloc.s 15
	IL_03f0: ldftn instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1'::'<ProcessCmd>b__1'(class MGSC.MonsterInspectWindow)
	IL_03f6: newobj instance void class [mscorlib]System.Action`1<class MGSC.MonsterInspectWindow>::.ctor(object, native int)
	IL_03fb: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.MonsterInspectWindow>::Invoke(class [mscorlib]System.Action`1<!0>)
	IL_0400: ldc.i4.1
	IL_0401: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.MonsterInspectWindow>::Show(bool)
	IL_0406: ldc.i4.1
	IL_0407: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.MonsterInspectWindow>::SetBackOnBackgroundClick(bool)
	// (no C# code)
	IL_040c: pop
	// if (intObjCmd.showAfterSelectShoot)
	IL_040d: ldloc.s 15
	IL_040f: ldfld class MGSC.ShowOptionsMonsterCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1'::intObjCmd
	IL_0414: ldfld bool MGSC.ShowOptionsMonsterCommand::showAfterSelectShoot
	IL_0419: brfalse.s IL_0426

	// UI.Chain<MonsterInspectWindow>().Fallback<SelectShootTarget>();
	IL_041b: call class MGSC.UI/CmdChain`1<!!0> MGSC.UI::Chain<class MGSC.MonsterInspectWindow>()
	IL_0420: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.MonsterInspectWindow>::Fallback<class MGSC.SelectShootTarget>()
	IL_0425: pop

	// if (UI.Get<MonsterInspectWindow>().ShouldShowAllyInventory())
	IL_0426: call !!0 MGSC.UI::Get<class MGSC.MonsterInspectWindow>()
	IL_042b: callvirt instance bool MGSC.MonsterInspectWindow::ShouldShowAllyInventory()
	IL_0430: brfalse.s IL_045b

	// 			UI.Chain<InventoryScreen>().Show().AttachToGroup<MonsterInspectWindow>()
	// 				.Invoke(delegate(InventoryScreen v)
	// 				{
	// 					v.ConfigureAllyInventory(intObjCmd.target);
	// 				})
	// 				.SetBackOnBackgroundClick(value: true);
	IL_0432: call class MGSC.UI/CmdChain`1<!!0> MGSC.UI::Chain<class MGSC.InventoryScreen>()
	IL_0437: ldc.i4.1
	IL_0438: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.InventoryScreen>::Show(bool)
	IL_043d: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.InventoryScreen>::AttachToGroup<class MGSC.MonsterInspectWindow>()
	IL_0442: ldloc.s 15
	IL_0444: ldftn instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_1'::'<ProcessCmd>b__2'(class MGSC.InventoryScreen)
	IL_044a: newobj instance void class [mscorlib]System.Action`1<class MGSC.InventoryScreen>::.ctor(object, native int)
	IL_044f: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.InventoryScreen>::Invoke(class [mscorlib]System.Action`1<!0>)
	IL_0454: ldc.i4.1
	IL_0455: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.InventoryScreen>::SetBackOnBackgroundClick(bool)
	// clearCmdQueue = true;
	IL_045a: pop

	IL_045b: ldarg.s clearCmdQueue
	IL_045d: ldc.i4.1
	IL_045e: stind.i1

	// if (cmd.Type == CmdType.UseVestSlot)
	IL_045f: ldarg.s cmd
	IL_0461: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_0466: ldc.i4.5
	IL_0467: bne.un.s IL_0486

	// UseVestSlotCommand useVestSlotCommand = cmd as UseVestSlotCommand;
	IL_0469: ldarg.s cmd
	IL_046b: isinst MGSC.UseVestSlotCommand
	IL_0470: stloc.s 16
	// InteractVestSlot(creatures, raidMetadata, useVestSlotCommand.slotIndex);
	IL_0472: ldarg.s creatures
	IL_0474: ldarg.s raidMetadata
	IL_0476: ldloc.s 16
	IL_0478: ldfld int32 MGSC.UseVestSlotCommand::slotIndex
	IL_047d: call void MGSC.PlayerInteractionSystem::InteractVestSlot(class MGSC.Creatures, class MGSC.RaidMetadata, int32)
	// clearCmdQueue = true;
	IL_0482: ldarg.s clearCmdQueue
	IL_0484: ldc.i4.1
	IL_0485: stind.i1

	// if (cmd.Type == CmdType.ChangeSpeedMode)
	IL_0486: ldarg.s cmd
	IL_0488: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_048d: ldc.i4.s 13
	IL_048f: bne.un.s IL_04be

	// if ((cmd as ChangeSpeedModeCommand).dir == Direction.Left)
	IL_0491: ldarg.s cmd
	IL_0493: isinst MGSC.ChangeSpeedModeCommand
	IL_0498: ldfld valuetype MGSC.Direction MGSC.ChangeSpeedModeCommand::dir
	IL_049d: ldc.i4.3
	IL_049e: bne.un.s IL_04ae

	// creatures.Player.ChangeMoveStateToPrev();
	IL_04a0: ldarg.s creatures
	IL_04a2: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_04a7: callvirt instance void MGSC.Player::ChangeMoveStateToPrev()
	// creatures.Player.ChangeMoveStateToNext();
	IL_04ac: br.s IL_04ba

	IL_04ae: ldarg.s creatures
	IL_04b0: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_04b5: callvirt instance void MGSC.Player::ChangeMoveStateToNext()

	// clearCmdQueue = true;
	IL_04ba: ldarg.s clearCmdQueue
	IL_04bc: ldc.i4.1
	IL_04bd: stind.i1

	// if (cmd.Type == CmdType.ActivateUltimatePerk)
	IL_04be: ldarg.s cmd
	IL_04c0: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_04c5: ldc.i4.s 14
	IL_04c7: bne.un.s IL_04d6

	// ActivateUltimatePerk(creatures, raidMetadata);
	IL_04c9: ldarg.s creatures
	IL_04cb: ldarg.s raidMetadata
	IL_04cd: call void MGSC.PlayerInteractionSystem::ActivateUltimatePerk(class MGSC.Creatures, class MGSC.RaidMetadata)
	// clearCmdQueue = true;
	IL_04d2: ldarg.s clearCmdQueue
	IL_04d4: ldc.i4.1
	IL_04d5: stind.i1

	// if (cmd.Type == CmdType.PlaceObject)
	IL_04d6: ldarg.s cmd
	IL_04d8: callvirt instance valuetype MGSC.CmdType MGSC.ICommand::get_Type()
	IL_04dd: ldc.i4.s 15
	IL_04df: bne.un.s IL_0522

	// (no C# code)
	IL_04e1: newobj instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_2'::.ctor()
	IL_04e6: stloc.s 17
	// UsePlaceableCommand usePlaceableCmd = cmd as UsePlaceableCommand;
	IL_04e8: ldloc.s 17
	IL_04ea: ldarg.s cmd
	IL_04ec: isinst MGSC.UsePlaceableCommand
	IL_04f1: stfld class MGSC.UsePlaceableCommand MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_2'::usePlaceableCmd
	// 		UI.Chain<SelectPlaceableTarget>().Invoke(delegate(SelectPlaceableTarget v)
	// 		{
	// 			v.Configure(usePlaceableCmd.Item, usePlaceableCmd.IsSpendTurn);
	// 		}).Show()
	// 			.SetBackgroundColor(Colors.Transparent);
	IL_04f6: call class MGSC.UI/CmdChain`1<!!0> MGSC.UI::Chain<class MGSC.SelectPlaceableTarget>()
	IL_04fb: ldloc.s 17
	IL_04fd: ldftn instance void MGSC.PlayerInteractionSystem/'<>c__DisplayClass7_2'::'<ProcessCmd>b__3'(class MGSC.SelectPlaceableTarget)
	IL_0503: newobj instance void class [mscorlib]System.Action`1<class MGSC.SelectPlaceableTarget>::.ctor(object, native int)
	IL_0508: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.SelectPlaceableTarget>::Invoke(class [mscorlib]System.Action`1<!0>)
	IL_050d: ldc.i4.1
	IL_050e: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.SelectPlaceableTarget>::Show(bool)
	IL_0513: call valuetype [UnityEngine.CoreModule]UnityEngine.Color MGSC.Colors::get_Transparent()
	IL_0518: callvirt instance class MGSC.UI/CmdChain`1<!0> class MGSC.UI/CmdChain`1<class MGSC.SelectPlaceableTarget>::SetBackgroundColor(valuetype [UnityEngine.CoreModule]UnityEngine.Color)
	// clearCmdQueue = true;
	IL_051d: pop
	IL_051e: ldarg.s clearCmdQueue
	IL_0520: ldc.i4.1
	IL_0521: stind.i1

	// (no C# code)
	IL_0522: ret
} // end of method PlayerInteractionSystem::ProcessCmd
