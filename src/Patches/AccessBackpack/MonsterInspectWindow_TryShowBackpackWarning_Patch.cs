using HarmonyLib;
using MGSC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using UnityEngine.Rendering;

namespace CommandAlly.Patches.AccessBackpack
{
    /// <summary>
    /// Adds the ability to open follower Ally backpacks further than 1 cell distance.
    /// </summary>
    [HarmonyPatch(typeof(PlayerInteractionSystem), nameof(PlayerInteractionSystem.CanOpenAllyInventory))]
    public class MonsterInspectWindow_TryShowBackpackWarning
    {
        public static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
        {

            List<CodeInstruction> instructionList = instructions.ToList();

            //Utils.LogIL(instructionList, @"C:\work\s.il");

            var output = new CodeMatcher(instructionList)

                //Match IsAdjacent call
	            //IL_000b: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	            //IL_0010: ldflda valuetype MGSC.CellPosition MGSC.CreatureData::Position
	            //IL_0015: ldarg.1
	            //IL_0016: ldfld class MGSC.CreatureData MGSC.Creature::CreatureData
	            //IL_001b: ldfld valuetype MGSC.CellPosition MGSC.CreatureData::Position
	            //IL_0020: call instance bool MGSC.CellPosition::IsAdjacent(valuetype MGSC.CellPosition)

                .MatchEndForward(
                    new CodeMatch[]
                    {
                        new CodeMatch(OpCodes.Ldfld, AccessTools.Field(typeof(Creature), nameof(Creature.CreatureData))),
                        new CodeMatch(OpCodes.Ldflda, AccessTools.Field(typeof(CreatureData), nameof(CreatureData.Position))),
                        new CodeMatch(OpCodes.Ldarg_1),
                        new CodeMatch(OpCodes.Ldfld, AccessTools.Field(typeof(Creature), nameof(Creature.CreatureData))),
                        new CodeMatch(OpCodes.Ldfld, AccessTools.Field(typeof(CreatureData), nameof(CreatureData.Position))),
                        new CodeMatch(OpCodes.Call, AccessTools.Method(typeof(CellPosition), nameof(CellPosition.IsAdjacent), 
                            new[] { typeof(CellPosition) }))
                    })
                .ThrowIfNotMatch("Did not find The IsAdjacent call")
                .RemoveInstruction()
                .Insert(
                    CodeInstruction.Call(typeof(MonsterInspectWindow_TryShowBackpackWarning), nameof(IsNearby),
                        new[] { typeof(CellPosition).MakeByRefType(), typeof(CellPosition) })       
                )
                .InstructionEnumeration();

            return output;
        }

        /// <summary>
        /// Determines if a cell position is close to the source cell
        /// </summary>
        /// <param name="sourcePosition"></param>
        /// <param name="otherCellPosition"></param>
        /// <returns></returns>
        private static bool IsNearby(ref CellPosition sourcePosition, CellPosition otherCellPosition)
        {
            float distance = sourcePosition.Distance(otherCellPosition);
            return distance != 0 && (int) distance <= Plugin.Config.FollowerBackpackAccessDistance;
        }
    }
}
