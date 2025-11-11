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
        public static bool Prefix(Monster __instance, ref bool __result)
        {
            if(!__instance.IsSeenByPlayer && __instance.IsAlly(__instance._creatures.Player))
            {
                __result = true;
                return false;
            }

            return true;
        }
    }
}
