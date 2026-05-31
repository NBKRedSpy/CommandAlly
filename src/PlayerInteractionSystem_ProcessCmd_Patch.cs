using HarmonyLib;
using MGSC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using UnityEngine;
using static HarmonyLib.Code;

namespace CommandAlly
{
    /// <summary>
    /// Changes the ProcessCmd to not clear the command queue if the target is an ally that 
    /// is not seen by the player.
    /// </summary>
    [HarmonyPatch(typeof(PlayerInteractionSystem), nameof(PlayerInteractionSystem.ProcessCmd))]
    public static class PlayerInteractionSystem_ProcessCmd_Patch
    {

        public static bool Prepare()
        {
            //Currently only needed for the beta version as the clear queue is new
            return Plugin.IsBeta;
        }

        public static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
        {

            List<CodeInstruction> instructionList = instructions.ToList();


            //Swap out the seen call with our check.
            //  IL_03d8: ldfld class MGSC.Creature MGSC.ShowOptionsMonsterCommand::target
            //  IL_03dd: callvirt instance bool MGSC.Creature::get_IsSeenByPlayer()

                //  There is only one get_IsSeenByPlayer in the method.
                var output = new CodeMatcher(instructionList)
                .MatchEndForward(
                    CodeMatch.LoadsField(AccessTools.DeclaredField(typeof(ShowOptionsMonsterCommand), nameof(ShowOptionsMonsterCommand.target))),
                    CodeMatch.Calls( AccessTools.DeclaredProperty(typeof(Creature), nameof(Creature.IsSeenByPlayer)).GetGetMethod())
                )
                .ThrowIfNotMatch("Could not find IsSeenByPlayer.")
                .SetInstruction(CodeInstruction.Call(() => ShouldClearQueue(default)))
                .InstructionEnumeration().ToList();

            return output;

        }


        /// <summary>
        /// Replaces the game's clear queue check with one that also checks if the target is an ally follower. 
        /// If it is an ally follower, then we want to keep the queue even if they are not seen by the player.
        /// </summary>
        /// <param name="creature"></param>
        /// <returns></returns>
        private static bool ShouldClearQueue(Creature creature)
        {
            if(creature.IsSeenByPlayer) return true;

            Creatures creatures = Plugin.State.Get<Creatures>();

            //Either a follower or the default of not seen.
            return PlayerInteractionSystem.IsFollowerAlly(creatures, creature);
        }
    }
}
