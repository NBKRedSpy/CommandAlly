.method public hidebysig static 
	bool CanOpenAllyInventory (
		class MGSC.Creatures creatures,
		class MGSC.Creature creature,
		[out] valuetype MGSC.LimitsTooltip/LimitType& limitType
	) cil managed 
{
	// Method begins at RVA 0xe4038
	// Header size: 12
	// Code size: 97 (0x61)
	.maxstack 2
	.locals init (
		[0] class MGSC.Player
	)

	// 	Player player = creatures.Player;
	IL_0000: ldarg.0
	IL_0001: ldfld class MGSC.Player MGSC.Creatures::Player
	IL_0006: stloc.0
	// 	limitType = LimitsTooltip.LimitType.NoInventory;
	IL_0007: ldarg.2
	IL_0008: ldc.i4.0
	IL_0009: stind.i4
	// 	if (!player.CreatureData.Position.IsAdjacent(creature.CreatureData.Position) || !IsFollowerAlly(creatures, creature))
	IL_000a: ldloc.0
	IL_000b: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	IL_0010: ldflda valuetype MGSC.CellPosition MGSC.CreatureData::Position
	IL_0015: ldarg.1
	IL_0016: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	IL_001b: ldfld valuetype MGSC.CellPosition MGSC.CreatureData::Position
	IL_0020: call instance bool MGSC.CellPosition::IsAdjacent(valuetype MGSC.CellPosition)
	IL_0025: brfalse.s IL_0030

	IL_0027: ldarg.0
	IL_0028: ldarg.1
	IL_0029: call bool MGSC.PlayerInteractionSystem::IsFollowerAlly(class MGSC.Creatures, class MGSC.Creature)
	IL_002e: brtrue.s IL_0032

	// 		return false;
	IL_0030: ldc.i4.0
	IL_0031: ret

	// 	if (player.MovementState == CreatureMovementState.Run && !PerkSystem.GetPerkParameterBool(player.CreatureData, "BRunActions"))
	IL_0032: ldloc.0
	IL_0033: callvirt instance valuetype MGSC.CreatureMovementState MGSC.Creature::get_MovementState()
	IL_0038: ldc.i4.2
	IL_0039: bne.un.s IL_0052

	IL_003b: ldloc.0
	IL_003c: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	IL_0041: ldstr "BRunActions"
	IL_0046: call bool MGSC.PerkSystem::GetPerkParameterBool(class MGSC.CreatureData, string)
	IL_004b: brtrue.s IL_0052

	// 		limitType = LimitsTooltip.LimitType.RunNoObstacles;
	IL_004d: ldarg.2
	IL_004e: ldc.i4.1
	IL_004f: stind.i4
	// 		return false;
	IL_0050: ldc.i4.0
	IL_0051: ret

	// 	if (player.ChangedMercenary)
	IL_0052: ldloc.0
	IL_0053: callvirt instance bool MGSC.Player::get_ChangedMercenary()
	IL_0058: brfalse.s IL_005f

	// 		limitType = LimitsTooltip.LimitType.ChangedMercenary;
	IL_005a: ldarg.2
	IL_005b: ldc.i4.4
	IL_005c: stind.i4
	// 		return false;
	IL_005d: ldc.i4.0
	IL_005e: ret

	// 	return true;
	IL_005f: ldc.i4.1
	IL_0060: ret
} // end of method PlayerInteractionSystem::CanOpenAllyInventory
