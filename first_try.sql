CREATE DATABASE AD_LAB_1
DROP DATABASE AD_LAB_0
USE AD_LAB_1

CREATE TABLE stage_Weapon_stats (
	Weapon_Name nvarchar(20),
	Weapon_Type nvarchar(50),
	Bullet_Type nvarchar(5),
	Damage int,
	Magazine_Capacity int,
	[Range] int,
	Bullet_Speed int,
	Rate_of_Fire decimal(5,4),
	Shots_to_Kill__Chest int,
	Shots_to_Kill__Head int,
	Damage_per_Second int,
	Fire_Mode nvarchar(50),
	BDMG_0 decimal(5,2),
	BDMG_1 decimal(5,2),
	BDMG_2 decimal(5,2),
	BDMG_3 decimal(5,2),
	HDMG_0 decimal(5,2),
	HDMG_1 decimal(5,2),
	HDMG_2 decimal(5,2),
	HDMG_3 decimal(5,2)
);

CREATE TABLE stage_agg_match_stats (
	[date] nvarchar(50),
	game_size int,
	match_id nvarchar(50),
	match_mode nvarchar(5),
	party_size int,
	player_assists int,
	player_dbno int,
	player_dist_ride decimal,
	player_dist_walk decimal,
	player_dmg int,
	player_kills int,
	player_name nvarchar(150),
	player_survive_time decimal,
	team_id int,
	team_placement int
);

CREATE TABLE stage_kill_match_stats (
	killed_by nvarchar(50),
	killer_name nvarchar(50),
	killer_placement int,
	killer_position_x decimal,
	killer_position_y decimal,
	map nvarchar(15),
	match_id nvarchar(50),
	[time] int,
	victim_name nvarchar(50),
	victim_placement int,
	victim_position_x decimal,
	victim_position_y decimal
);

-----------------------------------------------

CREATE TABLE Dates (
	ID_date INT PRIMARY KEY IDENTITY,
	[Year] int,
	[Month] int,
	[Day] int,
	[Time] time,
	FullDate smalldatetime
);

CREATE TABLE Game (
	ID_game INT PRIMARY KEY IDENTITY,
	unic_code nvarchar(50),
	Map nvarchar(15),
	game_size int,
	match_mode nvarchar(3),
	party_size int,
	ID_date INT UNIQUE FOREIGN KEY REFERENCES Dates(ID_date)
);

CREATE TABLE Weapon (
	ID_weapon INT PRIMARY KEY IDENTITY,
	Weapon_Name nvarchar(15),
	Weapon_Type nvarchar(50),
	Bullet_Type nvarchar(5),
	Damage int,
	Magazine_Capacity int,
	[Range] int,
	Bullet_Speed int,
	Rate_of_Fire decimal(5,4),
	Shots_to_Kill__Chest int,
	Shots_to_Kill__Head int,
	Damage_per_Second int,
	Fire_Mode nvarchar(50),
	BDMG_0 decimal(5,2),
	BDMG_1 decimal(5,2),
	BDMG_2 decimal(5,2),
	BDMG_3 decimal(5,2),
	HDMG_0 decimal(5,2),
	HDMG_1 decimal(5,2),
	HDMG_2 decimal(5,2),
	HDMG_3 decimal(5,2)
);

CREATE TABLE Player (
	ID_player INT PRIMARY KEY IDENTITY,
	player_assists int,
	player_dbno int,
	player_dist_ride decimal,
	player_dist_walk decimal,
	player_dmg int,
	player_kills int,
	player_name nvarchar(150),
	player_survive_time decimal,
	placement int
);

CREATE TABLE Fact (
	ID_weapon INT FOREIGN KEY REFERENCES Weapon(ID_weapon),
	ID_killer INT FOREIGN KEY REFERENCES Player(ID_player),
	ID_game INT FOREIGN KEY REFERENCES Game(ID_game),
	ID_victim INT FOREIGN KEY REFERENCES Player(ID_player)
);

--INSERT INTO Weapon(ID_weapon,Weapon_Name,Weapon_Type,Bullet_Type,Damage,Magazine_Capacity,[Range],Bullet_Speed,Rate_of_Fire,Shots_to_Kill__Chest,Shots_to_Kill__Head,Damage_per_Second,Fire_Mode,BDMG_0,BDMG_1,BDMG_2,BDMG_3,HDMG_0,HDMG_1,HDMG_2,HDMG_3)
--SELECT DISCTINCT 
--FROM stage_Weapon_stats

--INSERT INTO Weapon(Weapon_Name)
--VALUES (500, (SELECT Weapon_Name FROM stage_Weapon_stats));

INSERT INTO Weapon SELECT * FROM stage_Weapon_stats
SELECT * FROM Weapon

--CREATE TABLE Dates (
--	ID_date INT PRIMARY KEY IDENTITY,
--	[Year] int,
--	[Month] int,
--	[Day] int,
--	[Time] time,
--	FullDate smalldatetime
--);

INSERT INTO Dates SELECT YEAR([date]), MONTH([date]), DAY([date]), CONVERT(time, [date]), [date] FROM stage_agg_match_stats
--select CONVERT(datetime, [date]) from stage_agg_match_stats
SELECT * FROM stage_Weapon_stats
SELECT * FROM stage_kill_match_stats
SELECT * FROM stage_agg_match_stats