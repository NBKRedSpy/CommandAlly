using CommandAlly.Mcm;
using ModConfigMenu;
using ModConfigMenu.Contracts;
using System.Collections.Generic;

namespace CommandAlly
{
    /// <summary>
    /// Responsible for mapping the ModConfig to the MCM configuration menu.  
    /// </summary>
    internal class McmConfiguration : McmConfigurationBase
    {

        public McmConfiguration(ModConfig config) : base (config) { }

        /// <summary>
        /// Registers the mod configuration with the Mod Config Menu API. This method is called when the mod is 
        /// loaded and allows you to define the configuration options that will be available to users 
        /// in the mod configuration menu.
        /// </summary>
        public override void Configure()
        {

            ModConfig defaults = new ModConfig();

            ModConfigMenuAPI.RegisterModConfig("Command Ally", new List<IConfigValue>()
            {
                //Note that MCM does support color codes, as shown below.

                CreateConfigProperty(nameof(ModConfig.FollowerBackpackAccessDistance),
                    "The distance that a merc can access the inventory of a \"follower ally\".",
                    "Follower Backpack Access Distance", 1, 50),
            }, OnSave);
        }
         
    }
}
