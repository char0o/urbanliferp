-- Variables that are used on both client and server
SWEP.Gun = ("m9k_uzi") -- must be the name of your swep but NO CAPITALS!

SWEP.Category				= "RP"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "UZI"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 57			-- Position in the slot
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_imi_uzi01.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_uzi_imi.mdl"	-- Weapon world model 
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound("Weapon_uzi.single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 600			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 32		-- Size of a clip
SWEP.Primary.KickUp				= 0.3		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "smg1"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 17	-- Base damage per bullet
SWEP.Primary.Spread		= .028	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .018 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.951, -2.629, 1.633)
SWEP.IronSightsAng = Vector(0.109, -0.772, 1.725)
SWEP.SightsPos = Vector(-2.951, -2.629, 1.633)
SWEP.SightsAng = Vector(0.109, -0.772, 1.725)
SWEP.RunSightsPos = Vector(3.858, -2.945, 0.057)
SWEP.RunSightsAng = Vector(-5.237, 40.471, 0)
