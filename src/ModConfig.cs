using MGSC;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
using CommandAlly.Mcm;

namespace CommandAlly
{
    public class ModConfig : PersistentConfig<ModConfig>
    {
        public ModConfig()
        {
        }

        public ModConfig(string configPath) : base(configPath)
        {

        }


        /// <summary>
        /// The distance that a merc can access the inventory of a "follower ally".
        /// For instance, a VIP, robot, etc.
        /// The game's default is 1.
        /// </summary>
        public int FollowerBackpackAccessDistance { get; set; } = 2;

        public void Save(string configPath)
        {
            string json = JsonConvert.SerializeObject(this, SerializerSettings);
            File.WriteAllText(Plugin.ConfigDirectories.ConfigPath, json);
        }
    }
}
