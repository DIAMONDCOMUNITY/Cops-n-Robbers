
--[[
  Cops and Robbers Shared Dependencies
  Created by Michael Harris (mike@harrisonline.us)
  05/11/2019
  
  This file contains all information that will be stored, used, and
  manipulated by any CNR scripts in the gamemode that are shared
  between the client and the server. For example, locations of
  important places. Keep in mind, that the server has no functionality
  of natives, only what FiveM has defined in the documentation which is
  located at: https://docs.fivem.net/
  
  Permission is granted only for executing this script for the purposes
  of playing the gamemode as intended by the developer.
--]]

zoneByName = {
  ["AIRP"]    = {name = 'Los Santos Airport', z = 1},
  ["ALAMO"]   = {name = 'Alamo Sea', z = 2},
  ["ALTA"]    = {name = 'Alta', z = 1},
  ["ARMYB"]   = {name = 'Fort Zancudo', z = 4},
  ["BANHAMC"] = {name = 'Banham Canyon Dr', z = 4},
  ["BANNING"] = {name = 'Banning', z = 4},
  ["BEACH"]   = {name = 'Vespucci Beach', z = 1},
  ["BHAMCA"]  = {name = 'Banham Canyon', z = 4},
  ["BRADP"]   = {name = 'Braddock Pass', z = 3},
  ["BRADT"]   = {name = 'Braddock Tunnel', z = 3},
  ["BURTON"]  = {name = 'Burton', z = 1},
  ["CALAFB"]  = {name = 'Calafia Bridge', z = 4},
  ["CANNY"]   = {name = 'Raton Canyon', z = 4},
  ["CCREAK"]  = {name = 'Cassidy Creek', z = 3},
  ["CHAMH"]   = {name = 'Chamberlain Hills', z = 1},
  ["CHIL"]    = {name = 'Vinewood Hills', z = 4},
  ["CHU"]     = {name = 'Chumash', z = 4},
  ["CMSW"]    = {name = 'Chiliad Mountain State Wilderness', z = 3},
  ["CYPRE"]   = {name = 'Cypress Flats', z = 1},
  ["DAVIS"]   = {name = 'Davis', z = 1},
  ["DELBE"]   = {name = 'Del Perro Beach', z = 1},
  ["DELPE"]   = {name = 'Del Perro', z = 1},
  ["DELSOL"]  = {name = 'La Puerta', z = 1},
  ["DESRT"]   = {name = 'Grand Senora Desert', z = 2},
  ["DOWNT"]   = {name = 'Downtown', z = 1},
  ["DTVINE"]  = {name = 'Downtown Vinewood', z = 1},
  ["EAST_V"]  = {name = 'East Vinewood', z = 1},
  ["EBURO"]   = {name = 'El Burro Heights', z = 2},
  ["ELGORL"]  = {name = 'El Gordo Lighthouse', z = 2},
  ["ELYSIAN"] = {name = 'Elysian Island', z = 1},
  ["GALFISH"] = {name = 'Galilee', z = 3},
  ["GOLF"]    = {name = 'Golfing Society', z = 1},
  ["GRAPES"]  = {name = 'Grapeseed', z = 3},
  ["GREATC"]  = {name = 'Great Chaparral', z = 4},
  ["HARMO"]   = {name = 'Harmony', z = 2},
  ["HAWICK"]  = {name = 'Hawick', z = 1},
  ["HORS"]    = {name = 'Vinewood Racetrack', z = 1},
  ["HUMLAB"]  = {name = 'Humane Labs and Research', z = 2},
  ["JAIL"]    = {name = 'Bolingbroke Penitentiary', z = 2},
  ["KOREAT"]  = {name = 'Little Seoul', z = 1},
  ["LACT"]    = {name = 'Land Act Reservoir', z = 2},
  ["LAGO"]    = {name = 'Lago Zancudo', z = 4},
  ["LDAM"]    = {name = 'Land Act Dam', z = 2},
  ["LEGSQU"]  = {name = 'Legion Square', z = 1},
  ["LMESA"]   = {name = 'La Mesa', z = 1},
  ["LOSPUER"] = {name = 'La Puerta', z = 1},
  ["MIRR"]    = {name = 'Mirror Park', z = 1},
  ["MORN"]    = {name = 'Morningwood', z = 1},
  ["MOVIE"]   = {name = 'Richards Majestic', z = 1},
  ["MTCHIL"]  = {name = 'Mount Chiliad', z = 3},
  ["MTGORDO"] = {name = 'Mount Gordo', z = 3},
  ["MTJOSE"]  = {name = 'Mount Josiah', z = 4},
  ["MURRI"]   = {name = 'Murrieta Heights', z = 1},
  ["NCHU"]    = {name = 'North Chumash', z = 4},
  ["NOOSE"]   = {name = 'N.O.O.S.E', z = 2},
  ["OCEANA"]  = {name = 'Pacific Ocean', z = 1},
  ["PALCOV"]  = {name = 'Paleto Cove', z = 3},
  ["PALETO"]  = {name = 'Paleto Bay', z = 3},
  ["PALFOR"]  = {name = 'Paleto Forest', z = 3},
  ["PALHIGH"] = {name = 'Palomino Highlands', z = 2},
  ["PALMPOW"] = {name = 'Palmer-Taylor Power Station', z = 2},
  ["PBLUFF"]  = {name = 'Pacific Bluffs', z = 4},
  ["PBOX"]    = {name = 'Pillbox Hill', z = 1},
  ["PROCOB"]  = {name = 'Procopio Beach', z = 3},
  ["RANCHO"]  = {name = 'Rancho', z = 1},
  ["RGLEN"]   = {name = 'Richman Glen', z = 4},
  ["RICHM"]   = {name = 'Richman', z = 1},
  ["ROCKF"]   = {name = 'Rockford Hills', z = 1},
  ["RTRAK"]   = {name = 'Redwood Lights Track', z = 1},
  ["SANAND"]  = {name = 'San Andreas', z = 1},
  ["SANCHIA"] = {name = 'San Chianski Mountain Range', z = 2},
  ["SANDY"]   = {name = 'Sandy Shores', z = 2},
  ["SKID"]    = {name = 'Mission Row', z = 1},
  ["SLAB"]    = {name = 'Stab City', z = 4},
  ["STAD"]    = {name = 'Maze Bank Arena', z = 1},
  ["STRAW"]   = {name = 'Strawberry', z = 1},
  ["TATAMO"]  = {name = 'Tataviam Mountains', z = 2},
  ["TERMINA"] = {name = 'Terminal', z = 1},
  ["TEXTI"]   = {name = 'Textile City', z = 1},
  ["TONGVAH"] = {name = 'Tongva Hills', z = 4},
  ["TONGVAV"] = {name = 'Tongva Valley', z = 4},
  ["VCANA"]   = {name = 'Vespucci Canals', z = 1},
  ["VESP"]    = {name = 'Vespucci', z = 1},
  ["VINE"]    = {name = 'Vinewood', z = 1},
  ["WINDF"]   = {name = 'Ron Alternates Wind Farm', z = 2},
  ["WVINE"]   = {name = 'West Vinewood ', z = 1},
  ["ZANCUDO"] = {name = 'Zancudo River ', z = 1},
  ["ZP_ORT"]  = {name = 'Port of South Los Santos ', z = 1},
  ["ZQ_UAR"]  = {name = 'Davis Quartz', z = 1},
}