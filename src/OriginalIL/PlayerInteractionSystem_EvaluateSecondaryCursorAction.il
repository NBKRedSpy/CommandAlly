	.method private hidebysig static 
		void EvaluateSecondaryCursorAction (
			class MGSC.PlayerCommandQueue playerCommandQueue,
			class MGSC.GameCamera gameCam,
			class MGSC.MapRenderer mapRenderer,
			class MGSC.MapGrid mapGrid,
			class MGSC.Creatures creatures,
			class MGSC.ItemsOnFloor itemsOnFloor,
			class MGSC.MapObstacles mapObstacles,
			class MGSC.MapEntities mapEntities
		) cil managed 
	{
		// Method begins at RVA 0xa3700
		// Header size: 12
		// Code size: 299 (0x12b)
		.maxstack 7
		.locals init (
			[0] class MGSC.MapObstacle,
			[1] class MGSC.Creature,
			[2] valuetype MGSC.CellPosition,
			[3] class MGSC.Monster
		)

		// 	MapSystem.RaycastUnderCursor(gameCam, creatures, itemsOnFloor, mapObstacles, mapEntities, out var mapObj, out var creature);
		IL_0000: ldarg.1
		IL_0001: ldarg.s creatures
		IL_0003: ldarg.s itemsOnFloor
		IL_0005: ldarg.s mapObstacles
		IL_0007: ldarg.s mapEntities
		IL_0009: ldloca.s 0
		IL_000b: ldloca.s 1
		IL_000d: call void MGSC.MapSystem::RaycastUnderCursor(class MGSC.GameCamera, class MGSC.Creatures, class MGSC.ItemsOnFloor, class MGSC.MapObstacles, class MGSC.MapEntities, class MGSC.MapObstacle&, class MGSC.Creature&)
		// 	CellPosition cellUnderCursor = mapRenderer.GetCellUnderCursor();
		IL_0012: ldarg.2
		IL_0013: callvirt instance valuetype MGSC.CellPosition MGSC.MapRenderer::GetCellUnderCursor()
		IL_0018: stloc.2
		// 	cellUnderCursor = ((mapObj == null) ? cellUnderCursor : mapObj.GetPosition(cellUnderCursor));
		IL_0019: ldloc.0
		IL_001a: ldnull
		IL_001b: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Equality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_0020: brtrue.s IL_002b

		IL_0022: ldloc.0
		IL_0023: ldloc.2
		IL_0024: callvirt instance valuetype MGSC.CellPosition MGSC.MapObstacle::GetPosition(valuetype MGSC.CellPosition)
		IL_0029: br.s IL_002c

		// 	if (creature != null)
		IL_002b: ldloc.2

		IL_002c: stloc.2
		IL_002d: ldloc.1
		IL_002e: ldnull
		IL_002f: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_0034: brfalse.s IL_0044

		// 		cellUnderCursor = creature.CreatureData.Position;
		IL_0036: ldloc.1
		IL_0037: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
		IL_003c: ldfld valuetype MGSC.CellPosition MGSC.CreatureData::Position
		IL_0041: stloc.2
		// 		Monster monster = creatures.GetMonster(cellUnderCursor.X, cellUnderCursor.Y);
		IL_0042: br.s IL_0073

		IL_0044: ldarg.s creatures
		IL_0046: ldloc.2
		IL_0047: ldfld int32 MGSC.CellPosition::X
		IL_004c: ldloc.2
		IL_004d: ldfld int32 MGSC.CellPosition::Y
		IL_0052: callvirt instance class MGSC.Monster MGSC.Creatures::GetMonster(int32, int32)
		IL_0057: stloc.3
		// 		if (monster != null && (monster.IsSeenByPlayer || monster.IsSensorRevealed))
		IL_0058: ldloc.3
		IL_0059: ldnull
		IL_005a: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_005f: brfalse.s IL_0073

		IL_0061: ldloc.3
		IL_0062: callvirt instance bool MGSC.Creature::get_IsSeenByPlayer()
		IL_0067: brtrue.s IL_0071

		// 			creature = monster;
		IL_0069: ldloc.3
		IL_006a: callvirt instance bool MGSC.Monster::get_IsSensorRevealed()
		IL_006f: brfalse.s IL_0073

		IL_0071: ldloc.3
		IL_0072: stloc.1

		// 	if (creatures.Player.ChangeDirection(cellUnderCursor))
		IL_0073: ldarg.s creatures
		IL_0075: ldfld class MGSC.Player MGSC.Creatures::Player
		IL_007a: ldloc.2
		IL_007b: ldc.i4.1
		IL_007c: ldc.i4.1
		IL_007d: ldc.i4.0
		IL_007e: callvirt instance bool MGSC.Creature::ChangeDirection(valuetype MGSC.CellPosition, bool, bool, bool)
		IL_0083: brfalse.s IL_0086

		// }
		IL_0085: ret

		// 	if (creature != null && creature != creatures.Player)
		IL_0086: ldloc.1
		IL_0087: ldnull
		IL_0088: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_008d: brfalse.s IL_00ac

		IL_008f: ldloc.1
		IL_0090: ldarg.s creatures
		IL_0092: ldfld class MGSC.Player MGSC.Creatures::Player
		IL_0097: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_009c: brfalse.s IL_00ac

		// 		playerCommandQueue.Add(new ShowOptionsMonsterCommand(creature, fallbackSelectShoot: false));
		IL_009e: ldarg.0
		IL_009f: ldloc.1
		IL_00a0: ldc.i4.0
		IL_00a1: newobj instance void MGSC.ShowOptionsMonsterCommand::.ctor(class MGSC.Creature, bool)
		IL_00a6: callvirt instance void MGSC.PlayerCommandQueue::Add(class MGSC.ICommand)
		// 	else if (mapObj != null && mapObj.Door != null && MapSystem.IsAdjacent(cellUnderCursor, creatures.Player.CreatureData.Position))
		IL_00ab: ret

		IL_00ac: ldloc.0
		IL_00ad: ldnull
		IL_00ae: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_00b3: brfalse.s IL_012a

		IL_00b5: ldloc.0
		IL_00b6: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
		IL_00bb: ldnull
		IL_00bc: call bool [UnityEngine.CoreModule]UnityEngine.Object::op_Inequality(class [UnityEngine.CoreModule]UnityEngine.Object, class [UnityEngine.CoreModule]UnityEngine.Object)
		IL_00c1: brfalse.s IL_012a

		// 		if (mapObj.Door.State == Door.DoorState.Closed)
		IL_00c3: ldloc.2
		IL_00c4: ldarg.s creatures
		IL_00c6: ldfld class MGSC.Player MGSC.Creatures::Player
		IL_00cb: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
		IL_00d0: ldfld valuetype MGSC.CellPosition MGSC.CreatureData::Position
		IL_00d5: call bool MGSC.MapSystem::IsAdjacent(valuetype MGSC.CellPosition, valuetype MGSC.CellPosition)
		IL_00da: brfalse.s IL_012a

		IL_00dc: ldloc.0
		IL_00dd: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
		IL_00e2: callvirt instance valuetype MGSC.Door/DoorState MGSC.Door::get_State()
		IL_00e7: brtrue.s IL_00fb

		// 			playerCommandQueue.Add(new ShowDoorActionsListCommand(mapObj.Door));
		IL_00e9: ldarg.0
		IL_00ea: ldloc.0
		IL_00eb: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
		IL_00f0: newobj instance void MGSC.ShowDoorActionsListCommand::.ctor(class MGSC.Door)
		IL_00f5: callvirt instance void MGSC.PlayerCommandQueue::Add(class MGSC.ICommand)
		// 		else if (mapObj.Door.State == Door.DoorState.Opened && MapObstacleSystem.IsValidDoorPositionToInteract(creatures, itemsOnFloor, mapEntities, mapObstacles, mapObj))
		IL_00fa: ret

		IL_00fb: ldloc.0
		IL_00fc: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
		IL_0101: callvirt instance valuetype MGSC.Door/DoorState MGSC.Door::get_State()
		IL_0106: ldc.i4.1
		IL_0107: bne.un.s IL_012a

		IL_0109: ldarg.s creatures
		IL_010b: ldarg.s itemsOnFloor
		IL_010d: ldarg.s mapEntities
		IL_010f: ldarg.s mapObstacles
		IL_0111: ldloc.0
		IL_0112: call bool MGSC.MapObstacleSystem::IsValidDoorPositionToInteract(class MGSC.Creatures, class MGSC.ItemsOnFloor, class MGSC.MapEntities, class MGSC.MapObstacles, class MGSC.MapObstacle)
		IL_0117: brfalse.s IL_012a

		// 			playerCommandQueue.Add(new CloseDoorCommand(mapObj.Door));
		IL_0119: ldarg.0
		IL_011a: ldloc.0
		IL_011b: callvirt instance class MGSC.Door MGSC.MapObstacle::get_Door()
		IL_0120: newobj instance void MGSC.CloseDoorCommand::.ctor(class MGSC.Door)
		IL_0125: callvirt instance void MGSC.PlayerCommandQueue::Add(class MGSC.ICommand)

		// (no C# code)
		IL_012a: ret
	} // end of method PlayerInteractionSystem::EvaluateSecondaryCursorAction