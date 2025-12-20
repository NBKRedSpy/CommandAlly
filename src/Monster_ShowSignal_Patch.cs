using HarmonyLib;
using MGSC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

namespace CommandAlly
{
    [HarmonyPatch(typeof(Monster), nameof(Monster.ShowSignal), MethodType.Getter)]
    public static class Monster_ShowSignal_Patch
    {


        /// <summary>
        /// Show the signal (the blue star) for ally followers even if they are not seen by the player.
        /// </summary>
        /// <param name="__instance"></param>
        /// <param name="__result"></param>
        /// <returns></returns>
        public static bool Prefix(Monster __instance, ref bool __result)
        {
            if (!(PlayerInteractionSystem.IsFollowerAlly(__instance._creatures, __instance)
                && !__instance.IsSeenByPlayer)) return true;

            __result = true;
            return false;
        }
    }
}
