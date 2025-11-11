using HarmonyLib;
using MGSC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
using static HarmonyLib.Code;

namespace CommandAlly
{
    /// <summary>
    /// Adds the ability to use the context menu on allies that are spotted via signal (the *).
    /// This requires the other patch which always shows the signal for allies.
    /// </summary>
    [HarmonyPatch(typeof(PlayerInteractionSystem), nameof(PlayerInteractionSystem.EvaluateSecondaryCursorAction))]
    public static class PlayerInteractionSystem_EvaluateSecondaryCursorAction_Patch
    {

        public static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
        {

            List<CodeInstruction> instructionList = instructions.ToList();

            var output = new CodeMatcher(instructionList)
                //Find the GetMonster call.  There is only one in the function.
                //  IL_0052: callvirt instance class MGSC.Monster MGSC.Creatures::GetMonster(int32, int32)
                //  IL_0057: stloc.3
                .MatchEndForward(
                    new CodeMatch[]
                    {
                        new CodeMatch(OpCodes.Callvirt, AccessTools.Method(typeof(Creatures), nameof(Creatures.GetMonster))),
                        new CodeMatch(OpCodes.Stloc_3),
                    })
                .ThrowIfNotMatch("Did not find the GetMonster call")
                .Advance(1)

                //Try to set the creature variable if the monster is an ally
                //  Calling before the if that checks IsSeenByPlayer as it would require changing jumps otherwise.
                //  The outcome is identical as the original code and this new call changes the same variable with the same value
                //  if either of them are valid.

                //Call SetCreatureAlly
                .InsertAndAdvance(
                    new CodeInstruction(OpCodes.Ldloca_S, 1), // Load the address of the creature local
                    new CodeInstruction(OpCodes.Ldloc_3),    // Load the monster local (loc.3)
                    new CodeInstruction(OpCodes.Call, AccessTools.Method(typeof(PlayerInteractionSystem_EvaluateSecondaryCursorAction_Patch), nameof(SetCreatureAlly)))
                )
                .InstructionEnumeration();

            return output;

        }


        /// <summary>
        /// Sets the creature instance if it is not already set and is an ally.
        /// Used to allow the context menu to see the creature as a valid target.
        /// </summary>
        /// <param name="creature"></param>
        /// <param name="monster"></param>
        private static void SetCreatureAlly(ref Creature creature, Monster monster)
        {
            Creatures creatures = Plugin.State.Get<Creatures>();

            if (creature == null && monster != null && monster.IsAlly(creatures.Player))
            {
                creature = monster;
            }

        }
    }
}
