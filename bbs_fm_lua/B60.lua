workVec = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
PLBBASE_CHARACTER_ID_VENT = 0
PLBBASE_CHARACTER_ID_TERR = 1
PLBBASE_CHARACTER_ID_AQUA = 2
PLBBASE_CHARACTER_ID_TERR_XEHANORT1 = 3
PLBBASE_CHARACTER_ID_TERR_XEHANORT2 = 4
PLBBASE_COMMAND_BATTLEIDLING = 0
PLBBASE_COMMAND_BATTLEWALK = 1
PLBBASE_COMMAND_BATTLEDASH = 2
PLBBASE_COMMAND_JUMP = 3
PLBBASE_COMMAND_ATTACKCOM1 = 4
PLBBASE_COMMAND_ATTACKCOM2 = 5
PLBBASE_COMMAND_ATTACKCOM3 = 6
PLBBASE_COMMAND_FINISH = 7
PLBBASE_COMMAND_GRAND_ATTACK1 = 8
PLBBASE_COMMAND_GRAND_ATTACK2 = 9
PLBBASE_COMMAND_GRAND_ATTACK3 = 10
PLBBASE_COMMAND_AIR_ATTACK1 = 11
PLBBASE_COMMAND_AIR_ATTACK2 = 12
PLBBASE_COMMAND_AIR_ATTACK3 = 13
PLBBASE_COMMAND_AIR_ATTACK4 = 14
PLBBASE_COMMAND_EVASION = 15
PLBBASE_COMMAND_KEAL = 16
PLBBASE_COMMAND_SPECIAL0 = 17
PLBBASE_COMMAND_SPECIAL1 = 18
PLBBASE_COMMAND_SPECIAL2 = 19
PLBBASE_COMMAND_SPECIAL3 = 20
PLBBASE_COMMAND_SPECIAL4 = 21
PLBBASE_COMMAND_SPECIAL5 = 22
PLBBASE_COMMAND_SPECIAL6 = 23
PLBBASE_COMMAND_SPECIAL7 = 24
PLBBASE_COMMAND_SPECIAL8 = 25
PLBBASE_COMMAND_SPECIAL9 = 26
PLBBASE_COMMAND_MAX = 20
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_BATTLEIDLING] = {
  Name = "BattleIdling",
  MotionName = "002",
  Wait = 60,
  Speed = 0,
  Time = 50
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_BATTLEWALK] = {
  Name = "Move",
  MotionName = "003",
  Wait = 60,
  Speed = 0.023333,
  Time = 360
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_BATTLEDASH] = {
  Name = "Move",
  MotionName = "004",
  Wait = 60,
  Speed = 0.105,
  Time = 240
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_JUMP] = {
  Name = "Jump",
  MotionName = "005",
  MotionName1 = "006",
  MotionName2 = "007",
  Wait = 60
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM1] = {
  Name = "Aero",
  MotionName = "317",
  GroupNum = 134,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0,
  Rate = 1,
  Time = 80,
  ScriptName = "b60_Bullet",
  FepName = "m_ex_air_00",
  BulletEffect = "M_EX_AIR_WIN1_0",
  HitEffect = "M_EX_AIR_HIT0_0",
  BgHitEffect = "",
  ShootEffect = "M_EX_AIR_FIR0_0",
  BulletType = 3,
  AttackID = 7,
  CallSize = 2.5,
  UpDateTime = 0,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM2] = {
  Name = "Rush",
  MotionName = "330",
  MotionName1 = "331",
  GroupNum = 134,
  Wait = 60,
  Speed = 0.305,
  Delay = 120,
  CancelTime = 10,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM3] = {
  Name = "StrikeReid",
  MotionName = "361",
  MotionName1 = "362",
  MotionName2 = "363",
  GroupNum = 351,
  Wait = 60,
  Delay = 120,
  CancelTime = 10,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_FINISH] = {
  Name = "StrikeReid",
  MotionName = "320",
  GroupNum = 868,
  Wait = 60,
  HomingDiv = 12,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_GRAND_ATTACK1] = {
  Name = "Grand_Attack1",
  MotionName = "300",
  Wait = 80,
  Delay = 120,
  HomingDiv = 4,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_GRAND_ATTACK2] = {
  Name = "Grand_Attack2",
  MotionName = "301",
  Wait = 100,
  HomingDiv = 4,
  Delay = 120,
  CancelTime = 20,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_GRAND_ATTACK3] = {
  Name = "Grand_Attack3",
  MotionName = "303",
  Wait = 80,
  HomingDiv = 4,
  Delay = 20,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_AIR_ATTACK1] = {
  Name = "Air_Attack1",
  MotionName = "306",
  Wait = 80,
  HomingRate = 180,
  HomingDist = 16,
  HomingDiv = 10000,
  Delay = 120,
  CancelTime = 10,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK2
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_AIR_ATTACK2] = {
  Name = "Air_Attack2",
  MotionName = "305",
  Wait = 80,
  HomingRate = 180,
  HomingDiv = 10000,
  CancelTime = 10,
  Delay = 120,
  HomingDist = 16,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4,
  NextAttack2 = PLBBASE_COMMAND_AIR_ATTACK3
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_AIR_ATTACK3] = {
  Name = "Air_Attack3",
  MotionName = "307",
  Wait = 80,
  Speed = 0.06125,
  HomingDiv = 10000,
  HomingDist = 16,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_AIR_ATTACK4] = {
  Name = "Air_Attack4",
  MotionName = "308",
  Wait = 80,
  Speed = 0.03125,
  HomingDiv = 10000,
  HomingDist = 16,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_EVASION] = {
  Name = "Evasion",
  MotionName = "008",
  MotionName1 = "009"
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_SPECIAL0] = {
  Name = "BlackOut",
  MotionName = "317",
  MotionName2 = "318",
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0,
  Rate = 0,
  Time = 30,
  ScriptName = "b60_Bullet",
  FepName = "m_sa_bko_00",
  BulletEffect = "M_SA_BKO_SPH0_0",
  HitEffect = "",
  BgHitEffect = "",
  ShootEffect = "M_SA_BKO_FIR0_0",
  BulletType = 4,
  AttackID = 13,
  CallSize = 5.25,
  UpDateTime = 0,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_BATTLEIDLING] = {
  Name = "BattleIdling",
  MotionName = "002",
  Wait = 60,
  Speed = 0,
  Time = 120
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_BATTLEWALK] = {
  Name = "Move",
  MotionName = "003",
  Wait = 60,
  Speed = 0.023333,
  Time = 240
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_BATTLEDASH] = {
  Name = "Move",
  MotionName = "004",
  Wait = 60,
  Speed = 0.105,
  Time = 240
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_JUMP] = {
  Name = "Jump",
  MotionName = "005",
  MotionName1 = "006",
  MotionName2 = "007",
  Wait = 60
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM1] = {
  Name = "Guardimpact",
  MotionName = "355",
  GroupNum = 252,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Rate = 1,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM2] = {
  Name = "Sonicimpact",
  MotionName = "008",
  MotionName1 = "015",
  Wait = 60,
  Speed = 0.18,
  Delay = 120,
  CancelTime = 30,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM3] = {
  Name = "Brutus_force",
  MotionName = "370",
  MotionName1 = "371",
  Wait = 60,
  Time = 300,
  ScriptName = "buletal",
  AttackID = 7,
  AttackID2 = 10,
  CallSize = 2.5,
  CallSize2 = 3,
  UpDateTime = 0,
  Delay = 120,
  CancelTime = 10,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_FINISH] = {
  Name = "StrikeReid",
  MotionName = "320",
  GroupNum = 881,
  Wait = 60,
  HomingDiv = 13,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_GRAND_ATTACK1] = {
  Name = "Grand_Attack1",
  MotionName = "300",
  Wait = 60,
  Delay = 120,
  HomingDiv = 8,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_GRAND_ATTACK2] = {
  Name = "Grand_Attack2",
  MotionName = "301",
  Wait = 60,
  Delay = 120,
  HomingDiv = 8,
  CancelTime = 20,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_GRAND_ATTACK3] = {
  Name = "Grand_Attack3",
  MotionName = "303",
  Wait = 60,
  Delay = 20,
  HomingDiv = 8,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_AIR_ATTACK1] = {
  Name = "Air_Attack1",
  MotionName = "306",
  HomingRate = 180,
  HomingDist = 16,
  HomingDiv = 10000,
  Delay = 120,
  CancelTime = 10,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK3
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_AIR_ATTACK2] = {
  Name = "Air_Attack2",
  MotionName = "305",
  Wait = 60,
  HomingRate = 180,
  HomingDiv = 10000,
  CancelTime = 10,
  Delay = 120,
  HomingDist = 16,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_AIR_ATTACK3] = {
  Name = "Air_Attack3",
  MotionName = "307",
  Wait = 60,
  HomingRate = 180,
  HomingDiv = 10000,
  CancelTime = 10,
  Delay = 120,
  HomingDist = 16,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_AIR_ATTACK4] = {
  Name = "Air_Attack4",
  MotionName = "308",
  Wait = 60,
  Speed = 0,
  HomingDiv = 10000,
  HomingDist = 16,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_EVASION] = {
  Name = "Guard",
  MotionName = "354",
  GroupNum = 92
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_SPECIAL0] = {
  Name = "BlackOut",
  MotionName = "317",
  MotionName2 = "318",
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0,
  Rate = 0,
  Time = 30,
  ScriptName = "b60_Bullet",
  FepName = "m_sa_bko_00",
  BulletEffect = "M_SA_BKO_SPH0_0",
  HitEffect = "",
  BgHitEffect = "",
  ShootEffect = "M_SA_BKO_FIR0_0",
  BulletType = 4,
  AttackID = 11,
  CallSize = 5.25,
  UpDateTime = 0,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_BATTLEIDLING] = {
  Name = "BattleIdling",
  MotionName = "002",
  Wait = 60,
  Speed = 0,
  Time = 120
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_BATTLEWALK] = {
  Name = "Move",
  MotionName = "003",
  Wait = 60,
  Speed = 0.023333,
  Time = 240
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_BATTLEDASH] = {
  Name = "Move",
  MotionName = "004",
  Wait = 60,
  Speed = 0.105,
  Time = 240
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_JUMP] = {
  Name = "Jump",
  MotionName = "005",
  MotionName1 = "006",
  MotionName2 = "007",
  Wait = 60
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_ATTACKCOM1] = {
  Name = "Guardimpact",
  MotionName = "355",
  GroupNum = 252,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Rate = 1,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_ATTACKCOM2] = {
  Name = "Sonicimpact",
  MotionName = "008",
  MotionName1 = "015",
  Wait = 60,
  Speed = 0.18,
  Speed2 = 0.24,
  Delay = 120,
  CancelTime = 30,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_ATTACKCOM3] = {
  Name = "Quake",
  MotionName = "390",
  GroupNum = 171,
  Wait = 60,
  Rate = 0.5,
  Speed = 0,
  Delay = 120,
  CancelTime = 10,
  Time = 300,
  ScriptName = "b60_Bullet",
  FepName = "m_hi_qua_00",
  BulletEffect = "M_HI_QUA_ROC0_0",
  HitEffect = "M_HI_QUA_HIT0_0",
  BgHitEffect = "",
  ShootEffect = "",
  BulletType = 5,
  CallSize = 5.25,
  UpDateTime = 0,
  AttackID = 12,
  AttackID2 = 26,
  CallSize = 2.5,
  CallSize2 = 3,
  UpDateTime = 0,
  Delay = 120,
  CancelTime = 10,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_FINISH] = {
  Name = "StrikeReid",
  MotionName = "320",
  GroupNum = 881,
  Wait = 60,
  HomingDiv = 6,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_GRAND_ATTACK1] = {
  Name = "Grand_Attack1",
  MotionName = "300",
  Wait = 60,
  Delay = 120,
  HomingDiv = 8,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_GRAND_ATTACK2] = {
  Name = "Grand_Attack2",
  MotionName = "301",
  Wait = 60,
  Delay = 120,
  HomingDiv = 8,
  CancelTime = 20,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_GRAND_ATTACK3] = {
  Name = "Grand_Attack3",
  MotionName = "303",
  Wait = 60,
  Delay = 20,
  HomingDiv = 8,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_AIR_ATTACK1] = {
  Name = "Air_Attack1",
  MotionName = "306",
  HomingRate = 180,
  HomingDist = 16,
  HomingDiv = 10000,
  Delay = 120,
  CancelTime = 10,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK3
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_AIR_ATTACK2] = {
  Name = "Air_Attack2",
  MotionName = "305",
  Wait = 60,
  HomingRate = 180,
  HomingDiv = 10000,
  CancelTime = 10,
  Delay = 120,
  HomingDist = 16,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_AIR_ATTACK3] = {
  Name = "Air_Attack3",
  MotionName = "307",
  Wait = 60,
  HomingRate = 180,
  HomingDiv = 10000,
  CancelTime = 10,
  Delay = 120,
  HomingDist = 16,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_AIR_ATTACK4] = {
  Name = "Air_Attack4",
  MotionName = "308",
  Wait = 60,
  Speed = 0,
  HomingDiv = 1000000,
  HomingDist = 16,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_EVASION] = {
  Name = "Guard",
  MotionName = "354",
  GroupNum = 92
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL0] = {
  Name = "Meteor",
  MotionName = "390",
  GroupNum = 173,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0.05,
  Rate = 0,
  Time = 600,
  ScriptName = "b60_Bullet",
  FepName = "m_hi_met_00",
  BulletEffect = "M_HI_MET_BLT0_0",
  HitEffect = "M_HI_MET_HIT1_0",
  BgHitEffect = "",
  ShootEffect = "",
  BulletType = 6,
  AttackID = 13,
  CallSize = 2.25,
  UpDateTime = 0,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL1] = {
  Name = "Midareuti",
  MotionName = "377",
  MotionName1 = "378",
  MotionName2 = "379",
  MotionName3 = "380",
  GroupNum = 337,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0,
  Rate = 0,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL2] = {
  Name = "DarkImpulse",
  MotionName = "402",
  MotionName1 = "459",
  MotionName2 = "461",
  MotionName3 = "462",
  MotionName4 = "463",
  MotionName5 = "464",
  GroupNum = 415,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0,
  Rate = 0,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL3] = {
  Name = "DarkVolley",
  MotionName = "500",
  MotionName1 = "512",
  MotionName2 = "506",
  MotionName3 = "506",
  GroupNum = 505,
  Wait = 5,
  Speed = 0.25,
  Delay = 120,
  CancelTime = 10,
  Rate = 0,
  Time = 8,
  ScriptName = "b60_DarkVoll",
  FepName = "p_sl_dav_00",
  BulletEffect = "P_SL_DAV_BLT0_0",
  HitEffect = "P_SL_DAV_HIT0_0",
  BgHitEffect = "P_SL_DAV_WAL0_0",
  ShootEffect = "P_SL_DAV_FIR0_0",
  BulletType = 7,
  AttackID = 25,
  CallSize = 0.25,
  UpDateTime = 0,
  HomingDiv = 180,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL4] = {
  Name = "UltimaCannon",
  MotionName = "520",
  MotionName1 = "521",
  MotionName2 = "522",
  MotionName3 = "523",
  GroupNum = 531,
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0.15,
  Rate = 0,
  Time = 8,
  ScriptName = "b60_Ultima",
  FepName = "p_ss_ult_00",
  BulletEffect = "P_SS_ULT_BLT0_0",
  HitEffect = "P_SS_ULT_EXP1_0",
  BgHitEffect = "",
  ShootEffect = "",
  BulletType = 8,
  AttackID = 22,
  CallSize = 1.5,
  CallSize2 = 1.5,
  UpDateTime = 0,
  HomingDiv = 180,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL5] = {
  Name = "Rockstorm",
  MotionName = "390",
  GroupNum = 815,
  Wait = 60,
  Rate = 0.6,
  Speed = 0.7,
  Time = 300,
  ScriptName = "RockStrormB",
  FepName = "b50ex00",
  BulletEffect = "B026_RCK_BLT0_0",
  HitEffect = "B026_RCK_HIT1_0",
  BgHitEffect = "B026_RCK_HIT0_0",
  ShootEffect = "B026_RCK_FIR0_0",
  BulletType = 0,
  UpDateTime = 0,
  AttackID = 7,
  AttackID2 = 8,
  CallSize = 1,
  CallSize2 = 1,
  UpDateTime = 0,
  Delay = 120,
  CancelTime = 10,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL6] = {
  Name = "DarkVolleyLvMax",
  MotionName = "500",
  MotionName1 = "510",
  MotionName2 = "511",
  MotionName3 = "512",
  MotionName4 = "503",
  MotionName5 = "513",
  MotionName6 = "506",
  MotionName7 = "506",
  GroupNum = 505,
  Wait = 17,
  Wait2 = 20,
  Speed = 0.3,
  Delay = 120,
  CancelTime = 10,
  Rate = 0,
  Time = 50,
  ScriptName = "b60_DarkVoll",
  FepName = "p_sl_dav_00",
  BulletEffect = "P_SL_DAV_BLT0_0",
  HitEffect = "P_SL_DAV_HIT0_0",
  BgHitEffect = "P_SL_DAV_WAL0_0",
  ShootEffect = "P_SL_DAV_FIR0_0",
  BulletType = 7,
  AttackID = 25,
  CallSize = 0.4,
  UpDateTime = 10,
  HomingDiv = 5,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL7] = {Name = "DashVolley"}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL8] = {Name = "DashVolley"}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_SPECIAL9] = {
  Name = "Sonicimpact2"
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_TERR_XEHANORT1][PLBBASE_COMMAND_KEAL] = {
  Name = "Kealg",
  MotionName = "317",
  Rate = 0.5,
  FepName = "m_ex_cur_00",
  Effect1 = "P_MA_BL3_BLT0_0",
  Effect2 = "P_MA_CU1_CUR1_0",
  Effect3 = "P_MA_CUR_FIR0_0",
  GroupNum = 127,
  RecoveryAmon = 30,
  RecoveryHPR = 0.5,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_BATTLEIDLING] = {
  Name = "BattleIdling",
  MotionName = "002",
  Wait = 60,
  Speed = 0,
  Time = 35
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_BATTLEWALK] = {
  Name = "Move",
  MotionName = "003",
  Wait = 60,
  Speed = 0.02416667,
  Time = 120
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_BATTLEDASH] = {
  Name = "Move",
  MotionName = "004",
  Wait = 60,
  Speed = 0.10666667,
  Time = 120
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_JUMP] = {
  Name = "Jump",
  MotionName = "014",
  MotionName1 = "006",
  MotionName2 = "007",
  Wait = 60
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM1] = {
  Name = "Rifrectobritts",
  MotionName = "350",
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0.05,
  Rate = 1,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM2] = {
  Name = "Faira",
  MotionName = "315",
  Wait = 10,
  Speed = 0.15,
  Delay = 120,
  CancelTime = 10,
  Time = 300,
  ScriptName = "b60_Bullet",
  FepName = "m_ex_fir_00",
  BulletEffect = "P_MA_FI1_BLT0_0",
  HitEffect = "P_MA_FI2_HIT0_0",
  BgHitEffect = "P_MA_FIR_WAL0_0",
  ShootEffect = "P_MA_FI2_FIR0_0",
  BulletType = 1,
  AttackID = 7,
  CallSize = 0.25,
  UpDateTime = 0,
  HomingDiv = 2.5,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM3] = {
  Name = "Brizara",
  MotionName = "315",
  Wait = 60,
  Delay = 120,
  CancelTime = 10,
  Time = 300,
  Speed = 0.25,
  ScriptName = "b60_Bullet",
  FepName = "m_ex_blz_00",
  BulletEffect = "P_MA_BL3_BLT0_0",
  HitEffect = "P_MA_BL2_HIT0_0",
  BgHitEffect = "P_MA_BLZ_WAL0_0",
  ShootEffect = "P_MA_BL2_FIR0_0",
  BulletType = 2,
  AttackID = 8,
  CallSize = 0.25,
  HomingDiv = 0,
  UpDateTime = 30,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_FINISH] = {
  Name = "StrikeReid",
  MotionName = "320",
  GroupNum = 874,
  Wait = 60,
  HomingDiv = 10000,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_GRAND_ATTACK1] = {
  Name = "Grand_Attack1",
  MotionName = "300",
  Wait = 60,
  HomingDiv = 4,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_GRAND_ATTACK2] = {
  Name = "Grand_Attack2",
  MotionName = "301",
  Wait = 60,
  HomingDiv = 12,
  Delay = 120,
  CancelTime = 30,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_GRAND_ATTACK3] = {
  Name = "Grand_Attack3",
  MotionName = "303",
  Wait = 60,
  HomingDiv = 4,
  Delay = 20,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_AIR_ATTACK1] = {
  Name = "Air_Attack1",
  MotionName = "306",
  Wait = 60,
  HomingRate = 180,
  HomingDist = 16,
  HomingDiv = 10000,
  Delay = 120,
  CancelTime = 20,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK2
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_AIR_ATTACK2] = {
  Name = "Air_Attack2",
  MotionName = "305",
  Wait = 60,
  HomingRate = 180,
  HomingDiv = 10000,
  CancelTime = 20,
  Delay = 120,
  HomingDist = 16,
  Speed = 0.03125,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4,
  NextAttack2 = PLBBASE_COMMAND_AIR_ATTACK3
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_AIR_ATTACK3] = {
  Name = "Air_Attack3",
  MotionName = "307",
  Wait = 60,
  Speed = 0.06125,
  HomingDiv = 10000,
  HomingDist = 16,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180,
  NextAttack = PLBBASE_COMMAND_AIR_ATTACK4
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_AIR_ATTACK4] = {
  Name = "Air_Attack4",
  MotionName = "308",
  Wait = 20,
  Speed = 0,
  HomingDiv = 10000,
  HomingDist = 16,
  Delay = 120,
  CancelTime = 10,
  HomingRate = 180
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_EVASION] = {
  Name = "DodgeRoll",
  MotionName = "008",
  MotionName1 = "009"
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL] = {
  Name = "DodgeRoll",
  MotionName = "317",
  Rate = 0.5,
  FepName = "m_ex_cur_00",
  Effect1 = "P_MA_BL3_BLT0_0",
  Effect2 = "P_MA_CU1_CUR1_0",
  Effect3 = "P_MA_CUR_FIR0_0",
  RecoveryAmon = 30,
  RecoveryHPR = 0.3,
  State = 0
}
{
  [PLBBASE_CHARACTER_ID_VENT] = {
    Name = "Ventus",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 64,
    WalkOrRun_Dist = 4,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.7,
    Rate_DeckCombo = 0.9,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 9,
    RetrunTime = 3600
  },
  [PLBBASE_CHARACTER_ID_TERR_XEHANORT1] = {
    Name = "Terra",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    ChangeModeHPRate0 = 0.5,
    ChangeModeHPRate1 = 0.25,
    BulletNum = 8,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.5,
    Rate_Escape = 1,
    Rate_DistAttack1 = 1.1,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0.6,
    Rate_AerialCombo = 1.11,
    Rate_Deckcommand = 0.5,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.23,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 900,
    RockSpeed1 = 0.7,
    RockSpeed2 = 0.6,
    RockY = 5
  },
  [PLBBASE_CHARACTER_ID_AQUA] = {
    Name = "Aqua",
    WalkSpeed = 0.023333,
    RunSpeed = 0.105,
    ComboMax = 3,
    IdlingTime = 180,
    BattleIdlingTime = 180,
    Rate_Combo = 0.6,
    Rate_DeckCombo = 0.15,
    Rate_Escape = 0.25,
    Rate_DistAttack1 = 0.6,
    Rate_DistAttack2 = 0.4,
    Rate_AirEvasion = 0,
    Rate_GrandEvasion = 0.5,
    Rate_GuradRate = 0,
    Rate_AerialCombo = 0.75,
    Rate_Deckcommand = 0.75,
    AttackCommand = 0,
    EvasionCommand = 0,
    JampPow = 0.28,
    Gravitiy = 0.008,
    Action1_Dist = 4,
    Action2_Dist = 36,
    WalkOrRun_Dist = 64,
    RetrunTime = 3600
  }
}[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_SPECIAL0] = {
  Name = "BlackOut",
  MotionName = "317",
  MotionName2 = "318",
  Wait = 60,
  Delay = 120,
  CancelTime = 20,
  Speed = 0,
  Rate = 0,
  Time = 30,
  ScriptName = "b60_Bullet",
  FepName = "m_sa_bko_00",
  BulletEffect = "M_SA_BKO_SPH0_0",
  HitEffect = "",
  BgHitEffect = "",
  ShootEffect = "M_SA_BKO_FIR0_0",
  BulletType = 4,
  AttackID = 11,
  CallSize = 5.25,
  UpDateTime = 0,
  State = 0
}
b60 = {}
b60_base_mt = {__index = __StateMachine}
setmetatable(b60, b60_base_mt)
b60_mt = {__index = b60}
function b60.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b60_mt)
end
b60.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      print(Entity.GetName(_ARG_0_.myHandle) .. ":Appear\n")
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      _ARG_0_:GotoState("BattleIdling")
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) + Script.Random() * (_ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) / 2) - _ARG_0_.SubTime)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_:GotoState("Move")
    end
  },
  BattleIdling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) + Script.Random() * (_ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) / 2) - _ARG_0_.SubTime)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.stack:clear()
      _ARG_0_.RockStormCount = _ARG_0_.RockStormCount + 1
      _ARG_0_.evadeFlag = false
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.GoseAppFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.attackDelay = _ARG_0_.attackDelay - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_:GetName() == "Terra" and _ARG_0_:Defense() then
        return
      end
      if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" or Entity.GetName(_ARG_0_.myHandle) == "b52ex00" then
        if _ARG_0_.KealCnt < 3 and Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _ARG_0_:GetRecoveryHPR(PLBBASE_COMMAND_KEAL) and Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_KEAL) then
          _ARG_0_.KealCnt = _ARG_0_.KealCnt + 1
          _ARG_0_.stack:push("BattleIdling")
          _ARG_0_.stack:push("KealCommand")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_:IsPlShootShot() then
          _ARG_0_.stack:push("BattleIdling")
          _ARG_0_.stack:push("DistanceAttackCommand2")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_:Defense() then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() + 9 then
          _ARG_0_:EnableActionSelect()
          return
        end
      end
      if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, DegToRad(10)) == false then
        _ARG_0_:GotoState("Front_Move")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_:EnableActionSelect()
    end
  },
  EvasionTime = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, 900)
      _ARG_0_.step = 0
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.SubTime = 0
      _ARG_0_.GoseAppFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      if _ARG_0_.targetPos:gety() < 6 then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return
      end
      _ARG_0_:EnableActionSelect()
    end
  },
  BattleSearchIdling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) + Script.Random() * (_ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) / 2) - _ARG_0_.SubTime)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_FAR)
      if _ARG_0_.targetHandle ~= NULL_HANDLE then
        _ARG_0_:GotoState("Move")
        return
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) + Script.Random() * (_ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEIDLING) / 2) - _ARG_0_.SubTime)
        return
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _ARG_0_:GetWalkOrRun() then
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEDASH))
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEDASH)
        _ARG_0_.MoveFlag = _UPVALUE0_
      else
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEWALK))
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEWALK)
        _ARG_0_.MoveFlag = _UPVALUE1_
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      _ARG_0_.GoseAppFlag = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("BattleIdling")
        Entity.ClearSpeed(_ARG_0_.myHandle)
        return
      end
      if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" or Entity.GetName(_ARG_0_.myHandle) == "b52ex00" then
        if _ARG_0_:IsPlShootShot() then
          _ARG_0_.stack:push("BattleIdling")
          _ARG_0_.stack:push("DistanceAttackCommand2")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_:Defense() then
          return
        end
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
        _ARG_0_:EnableActionSelect()
        return
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
        _ARG_0_:EnableActionSelect()
        return
      end
      if _ARG_0_.MoveFlag == _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEWALK))
      elseif _ARG_0_.MoveFlag == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEDASH))
      end
    end
  },
  Approache = {
    OnBeginState = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > _ARG_0_:GetWalkOrRun() / 2 then
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEDASH))
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEDASH)
        _ARG_0_.MoveFlag = _UPVALUE0_
      else
        Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_:GetTime(PLBBASE_COMMAND_BATTLEWALK))
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEWALK)
        _ARG_0_.MoveFlag = _UPVALUE1_
      end
      _ARG_0_.GoseAppFlag = 1
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" or Entity.GetName(_ARG_0_.myHandle) == "b52ex00" then
        if _ARG_0_:IsPlShootShot() then
          _ARG_0_.stack:push("BattleIdling")
          _ARG_0_.stack:push("DistanceAttackCommand2")
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if _ARG_0_:Defense() == true then
          return
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() - 0.010000001 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        return
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() - 0.010000001 then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        return
      end
      if _ARG_0_.MoveFlag == _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEWALK))
      elseif _ARG_0_.MoveFlag == _UPVALUE1_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEDASH))
      end
    end
  },
  Front_Move = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEWALK)
      if Script.Random() < 0.5 then
        _ARG_0_.SubTime = _UPVALUE0_
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 12)
      _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEWALK))
      if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        _ARG_0_:EnableActionSelect()
      end
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if _ARG_0_.targetHandle == NULL_HANDLE then
        _ARG_0_:GotoState("BattleSearchIdling")
        return
      end
    end
  },
  Goes_away = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEDASH)
      _ARG_0_.MoveFlag = _UPVALUE0_
      _ARG_0_.away = 7
      _ARG_0_.WorkVec:set(0, 0, 0)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getx()))
      _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getz()))
      _ARG_0_.WorkTime = 30
      _ARG_0_.GoseAppFlag = 1
      Entity.SetTimer(_ARG_0_.myHandle, 60)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < _UPVALUE0_ then
        Entity.SetTimer(_ARG_0_.myHandle, 0)
        _ARG_0_.WorkTime = -1
      end
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
      _ARG_0_:Move(_ARG_0_:GetSpeed(PLBBASE_COMMAND_BATTLEDASH))
      if _ARG_0_.WorkTime < 0 or Entity.IsWall(_ARG_0_.myHandle) then
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          Entity.ClearSpeed(_ARG_0_.myHandle)
          return
        end
      end
    end
  },
  WarpMove = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 0, 20)
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      end
      Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_APP0_0", workVec, workVec1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 1, 20)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_.step = 1
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
            _ARG_0_:WarpGoesAway()
          else
            _ARG_0_:WarpApproachMove()
          end
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
        Entity.SetupModelFade(_ARG_0_.keyHandle, 0, 1, 20)
        Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
        Entity.GetRot(workVec1, _ARG_0_.myHandle)
        if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
        end
        Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_LST0_0", workVec, workVec1)
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 2 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.EnableShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  WarpMoveIn = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 0, 20)
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      end
      Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_APP0_0", workVec, workVec1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 1, 20)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_.step = 1
          _ARG_0_:WarpApproachMove()
          _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
        Entity.SetupModelFade(_ARG_0_.keyHandle, 0, 1, 20)
        Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
        Entity.GetRot(workVec1, _ARG_0_.myHandle)
        if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
        end
        Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_LST0_0", workVec, workVec1)
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 2 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.EnableShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  WarpMoveOut = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 0, 20)
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      end
      Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_APP0_0", workVec, workVec1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.SetupModelFade(_ARG_0_.myHandle, 1, 1, 20)
      Entity.SetupModelFade(_ARG_0_.keyHandle, 1, 1, 20)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_.step = 1
          _ARG_0_:WarpDistOut()
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 20)
        Entity.SetupModelFade(_ARG_0_.keyHandle, 0, 1, 20)
        Entity.GetWorldPos(workVec, _ARG_0_.myHandle, 1)
        Entity.GetRot(workVec1, _ARG_0_.myHandle)
        if Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
        end
        Entity.SetEffect(_ARG_0_.myHandle, "b50ex00", "B026_WRP_LST0_0", workVec, workVec1)
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 2 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.EnableShooton(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Fall = {
    OnBeginState = function(_ARG_0_)
      if Entity.IsGround(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion_2(PLBBASE_COMMAND_JUMP)
        _ARG_0_.step = 1
      else
        _ARG_0_:SetMotion_1(PLBBASE_COMMAND_JUMP)
        _ARG_0_.step = 0
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion_2(PLBBASE_COMMAND_JUMP)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("BattleIdling")
        return
      end
    end
  },
  Combo = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      _ARG_0_.GoseAppFlag = 1
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_:ComboInit()
      elseif _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_:GrandCombo()
      elseif _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_:AirCombo()
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_:JumpCombo()
      elseif _ARG_0_.step == _UPVALUE4_ then
        _ARG_0_:Finish()
      end
    end
  },
  ShortDistAttackCommand = {
    OnBeginState = function(_ARG_0_)
      print(Entity.GetName(_ARG_0_.myHandle) .. ":ShortDistAttackCommand\n")
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM1)
    end
  },
  SpecialCommandAttack0 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL0)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL0)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL0)
    end
  },
  SpecialCommandAttack1 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL1)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL1)
    end
  },
  SpecialCommandAttack2 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL2)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL2)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL2)
    end
  },
  SpecialCommandAttack3 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL3)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL3)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL3)
    end
  },
  SpecialCommandAttack4 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL4)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL4)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL4)
    end
  },
  SpecialCommandAttack5 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL5)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL5)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL5)
    end
  },
  SpecialCommandAttack6 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL6)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL6)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL6)
    end
  },
  SpecialCommandAttack7 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL7)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL7)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL7)
    end
  },
  SpecialCommandAttack8 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL8)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL8)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL8)
    end
  },
  SpecialCommandAttack9 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_SPECIAL9)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_SPECIAL9)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_SPECIAL9)
    end
  },
  DistanceAttackCommand2 = {
    OnBeginState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM2)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM2)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM2)
    end
  },
  DistanceAttackCommand3 = {
    OnBeginState = function(_ARG_0_)
      print(Entity.GetName(_ARG_0_.myHandle) .. ":DistanceAttackCommand3\n")
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM3)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM3)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_ATTACKCOM3)
    end
  },
  EvasionAction = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:EvasionBeginState(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:EvasionEndState(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:EvasionUpdate(_ARG_0_)
    end
  },
  KealCommand = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:AttackBeginState(_ARG_0_, PLBBASE_COMMAND_KEAL)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:AttackEndState(_ARG_0_, PLBBASE_COMMAND_KEAL)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AttackUpdate(_ARG_0_, PLBBASE_COMMAND_KEAL)
    end
  },
  LimitCommando = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      print(Entity.GetName(_ARG_0_.myHandle) .. ":LimitCommando\n")
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_.step = _UPVALUE1_
      elseif _ARG_0_.step == _UPVALUE1_ then
        if Player.JoinLimitCommand(COMMAND_KIND_TrinityLimit, _ARG_0_.myHandle) == Player.GetHandle() then
          _ARG_0_.step = _UPVALUE2_
        else
          _ARG_0_:GotoState("BattleIdling")
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if Player.GetPlayerID(Player.GetHandle()) == PLAYER_ID_AQUA then
          if _ARG_0_:GetName() == "Terra" then
          elseif _ARG_0_:GetName() == "Ventus" then
          else
          end
        elseif Player.GetPlayerID(Player.GetHandle()) == PLAYER_ID_VENTUS then
          if _ARG_0_:GetName() == "Terra" then
          elseif _ARG_0_:GetName() == "Ventus" then
          else
          end
        elseif _ARG_0_:GetName() == "Aqua" and Player.GetPlayerID(Player.GetHandle()) == PLAYER_ID_TERRA then
          if _ARG_0_:GetName() == "Terra" then
          elseif _ARG_0_:GetName() == "Ventus" then
          else
          end
        end
        Player.Limit_WarpStartPosRot(2, _ARG_0_.myHandle)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "600")
        _ARG_0_.step = _UPVALUE3_
      elseif _ARG_0_.step == _UPVALUE3_ then
        if Player.Limit_IsNowEntry() == 0 then
          _ARG_0_.step = _UPVALUE4_
        end
        if Player.GetLimitCommand() == 0 then
          _ARG_0_:GotoState("BattleIdling")
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        if Player.GetPlayerID(Player.GetHandle()) == PLAYER_ID_AQUA then
          if _ARG_0_:GetName() == "Terra" then
          elseif _ARG_0_:GetName() == "Ventus" then
          else
          end
        elseif Player.GetPlayerID(Player.GetHandle()) == PLAYER_ID_VENTUS then
          if _ARG_0_:GetName() == "Terra" then
          elseif _ARG_0_:GetName() == "Ventus" then
          else
          end
        elseif _ARG_0_:GetName() == "Aqua" and Player.GetPlayerID(Player.GetHandle()) == PLAYER_ID_TERRA then
          if _ARG_0_:GetName() == "Terra" then
          elseif _ARG_0_:GetName() == "Ventus" then
          else
          end
        end
        Player.Limit_SetMemberState(COMMAND_KIND_TrinityLimit, 2, 1)
        _ARG_0_.step = _UPVALUE5_
      elseif _ARG_0_.step == _UPVALUE5_ then
        if Player.Limit_GetResult(COMMAND_KIND_TrinityLimit) == 2 then
          _ARG_0_.step = _UPVALUE6_
        else
          _ARG_0_.step = _UPVALUE7_
        end
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "557")
      elseif _ARG_0_.step == _UPVALUE6_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("BattleIdling")
        end
      elseif _ARG_0_.step == _UPVALUE7_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("BattleIdling")
      end
    end
  },
  Idlingforlongtime = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, "010")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  StateReflect = {
    OnBeginState = function(_ARG_0_)
      print(Entity.GetName(_ARG_0_.myHandle) .. ":StateReflect\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "208")
      Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, "208")
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_.reflectCount = _ARG_0_.reflectCount + 1
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
          Entity.SetTimer(_ARG_0_.myHandle, 20)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("BattleIdling")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
    end,
    OnEndState = function(_ARG_0_)
      if _ARG_0_.friendFlag == 1 then
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.EnableShooton(_ARG_0_.myHandle, 0)
      else
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.EnableShooton(_ARG_0_.myHandle, 1)
      end
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("BattleIdling")
        if _ARG_0_.friendFlag == 1 then
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
          Entity.EnableLockon(_ARG_0_.myHandle, 0)
          Entity.EnableShooton(_ARG_0_.myHandle, 0)
        else
          Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          Entity.EnableShooton(_ARG_0_.myHandle, 1)
        end
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.step = 0
      _ARG_0_.timer = 60
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" then
        if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
          _ARG_0_:PlayVoice(29)
          _ARG_0_.step = 1
        end
      elseif Entity.GetName(_ARG_0_.myHandle) == "b51ex00" and _ARG_0_.step == 0 then
        _ARG_0_.timer = _ARG_0_.timer - Script.GetVsyncFrameRate()
        if Sound.IsInvalidateSeCall() == 1 and 0 > _ARG_0_.timer then
          _ARG_0_:PlayVoice(28)
          _ARG_0_.step = 1
        end
      end
    end
  },
  Dead2 = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE0_)
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, -0.02)
      else
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE1_)
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, 0.02)
      end
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE0_)
          else
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _UPVALUE1_)
          end
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:SetMotion(PLBBASE_COMMAND_BATTLEIDLING)
        return
      end
    end
  },
  Dead_Friend = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_[_ARG_0_.charaID].RetrunTime)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.SetHP(_ARG_0_.myHandle, 0)
      Enemy.NotifyHp(_ARG_0_.myHandle, _ARG_0_.gaugeId)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
      Enemy.CompleteRecoveryHp(_ARG_0_.myHandle)
      Enemy.NotifyHp(_ARG_0_.myHandle, _ARG_0_.gaugeId)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Enemy.CompleteRecoveryHp(_ARG_0_.myHandle)
          Enemy.NotifyHp(_ARG_0_.myHandle, _ARG_0_.gaugeId)
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("BattleIdling")
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function b60.Move(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b60.MoveEx(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b60.isHitAttack(_ARG_0_)
  return _ARG_0_.HitAttackFlag
end
function b60.WarpApproachMove(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
  _ARG_0_.WorkVec:set(0, 0, 0)
  _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (2 * Script.Random() + 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
  _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (2 * Script.Random() + 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
  Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos)
  Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
end
function b60.WarpGoesAway(_ARG_0_)
  _ARG_0_.targetPos:set(0, 0, 0)
  _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (12 * Script.Random() + 5) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
  _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (12 * Script.Random() + 5) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos)
  Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
end
function b60.WarpDistOut(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
  _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (20 * Script.Random() + 10) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
  _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (20 * Script.Random() + 10) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.targetPos)
  Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.targetPos)
end
function b60.ComboInit(_ARG_0_)
  if _ARG_0_.FinishFlag == 0 then
    _ARG_0_.ComboCnt = 0
  end
  if _ARG_0_.ComboCnt > _ARG_0_:GetComboMax() then
    _ARG_0_.step = _UPVALUE0_
    if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180) == false then
    end
    if 0 < Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 12.25 then
    else
    end
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    _ARG_0_:SetMotionEx(PLBBASE_COMMAND_FINISH, _ARG_0_:GetGroupNum(PLBBASE_COMMAND_FINISH), -1)
    _ARG_0_.AttackCnt = 0
    _ARG_0_.ComboCnt = 0
    return 1
  else
    Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle, 0)
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 0)
    if _ARG_0_.myPos:gety() + 2 >= _ARG_0_.playerPos:gety() then
      _ARG_0_.step = _UPVALUE1_
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 120)
      if 0 < Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 12.25 then
      else
      end
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_GRAND_ATTACK1)
      _ARG_0_.AttackCnt = 0
      _ARG_0_.ComboCnt = _ARG_0_.ComboCnt + 1
      return 1
    else
      if _ARG_0_:GetAerialComboRate() == 0 then
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        _ARG_0_.step = _UPVALUE2_
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 120)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_:SetMotion(PLBBASE_COMMAND_AIR_ATTACK1)
        _ARG_0_.AttackCnt = 0
        _ARG_0_.ComboCnt = _ARG_0_.ComboCnt + 1
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetHomingDist(PLBBASE_COMMAND_AIR_ATTACK1) then
        else
        end
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.workVec:scale((_ARG_0_:GetSpeed(PLBBASE_COMMAND_AIR_ATTACK1)))
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
      else
        _ARG_0_.step = _UPVALUE3_
        _ARG_0_:SetMotion(PLBBASE_COMMAND_JUMP)
        _ARG_0_.JumpPow = _ARG_0_:GetJampPow()
        _ARG_0_.Gravity = _ARG_0_:GetGravitiy()
        _ARG_0_.AttackCnt = 0
      end
      return 1
    end
  end
end
function b60.GrandCombo(_ARG_0_)
  if _ARG_0_.AttackCnt == 0 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _ARG_0_:GetCancelTime(PLBBASE_COMMAND_GRAND_ATTACK1) and EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        if 0 < Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 6 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 6 < 12.25 then
        else
        end
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_:SetMotion(PLBBASE_COMMAND_GRAND_ATTACK2)
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
        return
      else
        _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_GRAND_ATTACK1)
        _ARG_0_:GotoState("BattleIdling")
        return
      end
    end
  elseif _ARG_0_.AttackCnt == 1 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 120)
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _ARG_0_:GetCancelTime(PLBBASE_COMMAND_GRAND_ATTACK2) and EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        if 0 < Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 6 and 12.25 > Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 6 then
        else
        end
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_:SetMotion(PLBBASE_COMMAND_GRAND_ATTACK3)
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
        return
      else
        _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_GRAND_ATTACK2)
        _ARG_0_:GotoState("BattleIdling")
        return
      end
    end
  elseif _ARG_0_.AttackCnt == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
    _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_GRAND_ATTACK3)
    _ARG_0_:GotoState("BattleIdling")
  end
end
function b60.AirCombo(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  if _ARG_0_.AttackCnt == 0 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, (_ARG_0_:GetHomingRate(PLBBASE_COMMAND_AIR_ATTACK1)))
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 10 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _ARG_0_:GetCancelTime(PLBBASE_COMMAND_AIR_ATTACK1) and EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        _ARG_0_:SetMotion((_ARG_0_:GetNextAttack(PLBBASE_COMMAND_AIR_ATTACK1)))
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetHomingDist((_ARG_0_:GetNextAttack(PLBBASE_COMMAND_AIR_ATTACK1))) then
        else
        end
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.workVec:scale((_ARG_0_:GetSpeed((_ARG_0_:GetNextAttack(PLBBASE_COMMAND_AIR_ATTACK1)))))
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
        return
      else
        _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_AIR_ATTACK1)
        _ARG_0_:GotoState("Fall")
        return
      end
    end
  elseif _ARG_0_.AttackCnt == 1 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, (_ARG_0_:GetHomingRate(PLBBASE_COMMAND_AIR_ATTACK2)))
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _ARG_0_:GetCancelTime(PLBBASE_COMMAND_AIR_ATTACK2) and EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        _ARG_0_:SetMotion((_ARG_0_:GetNextAttack(PLBBASE_COMMAND_AIR_ATTACK2)))
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetHomingDist((_ARG_0_:GetNextAttack(PLBBASE_COMMAND_AIR_ATTACK2))) then
        else
        end
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.workVec:scale((_ARG_0_:GetSpeed((_ARG_0_:GetNextAttack(PLBBASE_COMMAND_AIR_ATTACK2)))))
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 0, 0, 0)
        return
      else
        _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_AIR_ATTACK2)
        _ARG_0_:GotoState("Fall")
        return
      end
    end
  elseif _ARG_0_.AttackCnt == 2 then
    if _ARG_0_:GetName() == "Terra" then
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, (_ARG_0_:GetHomingRate(PLBBASE_COMMAND_AIR_ATTACK4)))
    if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag ~= 1 or _ARG_0_:GetName() == "Terra" then
    else
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
      _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_AIR_ATTACK4)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      if _ARG_0_:GetName() == "Terra" then
        _ARG_0_:GotoState("BattleIdling")
      else
        _ARG_0_:GotoState("Fall")
      end
    end
  end
end
function b60.JumpCombo(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.AttackCnt == 0 then
    _ARG_0_.WorkVec:set(0, _ARG_0_.JumpPow, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
    if _ARG_0_.JumpPow < 0 then
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_:SetMotion(PLBBASE_COMMAND_AIR_ATTACK2)
      _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
      EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetHomingDist(PLBBASE_COMMAND_AIR_ATTACK2) then
      else
      end
      FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
      FVECTOR3.normalize(_ARG_0_.workVec)
      _ARG_0_.workVec:scale(_ARG_0_:GetSpeed(PLBBASE_COMMAND_AIR_ATTACK2) / _ARG_0_:GetHomingDiv(PLBBASE_COMMAND_AIR_ATTACK2))
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 0, 1, 0)
    end
  elseif _ARG_0_.AttackCnt == 1 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, (_ARG_0_:GetHomingRate(PLBBASE_COMMAND_AIR_ATTACK2)))
    if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _ARG_0_:GetCancelTime(PLBBASE_COMMAND_AIR_ATTACK2) and EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        _ARG_0_:SetMotion((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK2)))
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetHomingDist((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK2))) then
        else
        end
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.workVec:scale(_ARG_0_:GetSpeed((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK2))) / _ARG_0_:GetHomingDiv((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK2))))
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
        return
      else
        _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_AIR_ATTACK2)
        _ARG_0_:GotoState("Fall")
        return
      end
    end
  elseif _ARG_0_.AttackCnt == 2 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, (_ARG_0_:GetHomingRate(PLBBASE_COMMAND_AIR_ATTACK3)))
    if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or Entity.GetMotionNowFrame(_ARG_0_.myHandle) > _ARG_0_:GetCancelTime(PLBBASE_COMMAND_AIR_ATTACK3) and EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
        EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
        _ARG_0_:SetMotion((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK3)))
        _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetHomingDist((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK3))) then
        else
        end
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.playerPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_ARG_0_.workVec)
        _ARG_0_.workVec:scale(_ARG_0_:GetSpeed((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK3))) / _ARG_0_:GetHomingDiv((_ARG_0_:GetNextAttack2(PLBBASE_COMMAND_AIR_ATTACK3))))
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec)
        return
      else
        _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_AIR_ATTACK3)
        _ARG_0_:GotoState("Fall")
        return
      end
    end
  elseif _ARG_0_.AttackCnt == 3 then
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, (_ARG_0_:GetHomingRate(PLBBASE_COMMAND_AIR_ATTACK4)))
    if EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag == 1 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
      EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
      _ARG_0_.attackDelay = _ARG_0_:GetDelayTime(PLBBASE_COMMAND_AIR_ATTACK4)
      _ARG_0_:GotoState("Fall")
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
    end
  end
end
function b60.Finish(_ARG_0_)
  if Entity.IsMotionEnd(_ARG_0_.myHandle) then
    Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
    EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
    _ARG_0_.attackDelay = 120
    _ARG_0_:GotoState("BattleIdling")
  end
end
function b60.CreateBulletEx(_ARG_0_, _ARG_1_)
  if _ARG_0_:GetBulletType(_ARG_1_) == _UPVALUE0_ then
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  else
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBulletEffect(_ARG_1_))
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetHitEffect(_ARG_1_))
  Bullet.SetHitBgEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBgHitEffect(_ARG_1_))
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetSpeed(_ARG_1_))
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), 60)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
  Entity.SetEffect(_ARG_0_.keyHandle, _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetShootEffect(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot)
  Entity.SetTimer(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetTime(_ARG_1_))
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).Speed = _ARG_0_:GetSpeed(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).HomingAng = _ARG_0_:GetHomingDiv(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).BulletType = _ARG_0_:GetBulletType(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).UpDateTime = _ARG_0_:GetUpDateTime(_ARG_1_)
end
function b60.CreateBulletVolley(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ == 0 then
    workVec:set(0, 0, 1)
    Entity.GetWorldPos2(workVec, _ARG_0_.keyHandle, workVec, 2)
    Entity.GetWorldPos(workVec1, _ARG_0_.keyHandle, 2)
    _ARG_0_.rot:set(0, 0, 0)
    FVECTOR3.Sub(workVec, workVec, workVec1)
    FVECTOR3.normalize(workVec)
    _ARG_0_.rot:sety(RoundPI((Math.Atan2(workVec:getx(), workVec:getz()))))
    _ARG_0_.rot:setx(RoundPI(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx()))))
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
  elseif _ARG_2_ == 1 then
    workVec:set(0, 1, -1)
    workVec:setx(workVec:getx() + (Script.Random() * 1 - 1 / 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    Entity.GetWorldPos2(workVec, _ARG_0_.myHandle, workVec, 1)
    Entity.GetWorldPos(workVec1, _ARG_0_.myHandle, 1)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(workVec, workVec, workVec1)
    FVECTOR3.normalize(workVec)
    _ARG_0_.rot:sety(RoundPI((Math.Atan2(workVec:getx(), workVec:getz()))))
    _ARG_0_.rot:setx(RoundPI(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx()))))
    workVec:set(0, 1, -1)
    workVec1:set(0, DegToRad(Script.Random() * 360), 0)
    Math.RotateVectorXYZ(workVec, workVec1)
    Entity.GetWorldPos2(_ARG_0_.myPos, _ARG_0_.myHandle, workVec, 1)
  elseif _ARG_2_ == 2 then
    workVec:set(-1, Script.Random(), -1)
    workVec:setx(workVec:getx() + (Script.Random() * 1 - 1 / 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    workVec:sety(workVec:gety() + (Script.Random() * 1 - 1 / 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    if workVec:gety() < -0.1 then
      workVec:sety(0)
    end
    Entity.GetWorldPos2(workVec, _ARG_0_.myHandle, workVec, 1)
    Entity.GetWorldPos(workVec1, _ARG_0_.myHandle, 1)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(workVec, workVec, workVec1)
    FVECTOR3.normalize(workVec)
    _ARG_0_.rot:sety(RoundPI((Math.Atan2(workVec:getx(), workVec:getz()))))
    _ARG_0_.rot:setx(RoundPI(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx()))))
    workVec:set(-1, 0, -1)
    workVec1:set(0, DegToRad(Script.Random() * 360), 0)
    Math.RotateVectorXYZ(workVec, workVec1)
    Entity.GetWorldPos2(_ARG_0_.myPos, _ARG_0_.myHandle, workVec, 1)
  elseif _ARG_2_ == 3 then
    workVec:set(1, Script.Random(), -1)
    workVec:setx(workVec:getx() + (Script.Random() * 1 - 1 / 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    workVec:sety(workVec:gety() + (Script.Random() * 1 - 1 / 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    if workVec:gety() < -0.1 then
      workVec:sety(0)
    end
    Entity.GetWorldPos2(workVec, _ARG_0_.myHandle, workVec, 1)
    Entity.GetWorldPos(workVec1, _ARG_0_.myHandle, 1)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(workVec, workVec, workVec1)
    FVECTOR3.normalize(workVec)
    _ARG_0_.rot:sety(RoundPI((Math.Atan2(workVec:getx(), workVec:getz()))))
    _ARG_0_.rot:setx(RoundPI(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx()))))
    workVec:set(1, 0, -1)
    workVec1:set(0, DegToRad(Script.Random() * 360), 0)
    Math.RotateVectorXYZ(workVec, workVec1)
    Entity.GetWorldPos2(_ARG_0_.myPos, _ARG_0_.myHandle, workVec, 1)
  end
  Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBulletEffect(_ARG_1_))
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetHitEffect(_ARG_1_))
  Bullet.SetHitBgEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBgHitEffect(_ARG_1_))
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetSpeed(_ARG_1_))
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), 60)
  Entity.SetEffect(_ARG_0_.keyHandle, _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetShootEffect(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).Speed = _ARG_0_:GetSpeed(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).BulletType = _ARG_0_:GetBulletType(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).UpDateTime = _ARG_0_:GetUpDateTime(_ARG_1_) + Script.Random() * 10
  if _ARG_2_ == 0 then
    EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).HomingAng = _ARG_0_:GetHomingDiv(_ARG_1_) + 2
    Entity.SetTimer(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetTime(_ARG_1_) - 5)
  else
    Entity.SetTimer(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_:GetTime(_ARG_1_))
    if _ARG_2_ == 1 then
      EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).HomingAng = (_ARG_0_:GetHomingDiv(_ARG_1_) + 1) * (Script.Random() * 2.8 + 1)
    elseif _ARG_2_ == 2 then
      EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).HomingAng = (_ARG_0_:GetHomingDiv(_ARG_1_) + 1) * (Script.Random() * 2.8 + 1)
    elseif _ARG_2_ == 3 then
      EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot))).HomingAng = (_ARG_0_:GetHomingDiv(_ARG_1_) + 1) * (Script.Random() * 2.8 + 1)
    end
  end
end
function b60.CreateBulletForQuake(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.myPos:set(0, 0, 0)
  if _ARG_2_ == 0 then
    _ARG_0_.myPos:set(0, 0, 3)
  elseif _ARG_2_ == 1 then
    _ARG_0_.myPos:set(3, 0, -1)
  elseif _ARG_2_ == 2 then
    _ARG_0_.myPos:set(-3, 0, -1)
  end
  Entity.GetWorldPos2(_ARG_0_.myPos, _ARG_0_.myHandle, _ARG_0_.myPos)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBulletEffect(_ARG_1_))
  if _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetHitEffect(_ARG_1_))
  Bullet.SetHitBgEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBgHitEffect(_ARG_1_))
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetSpeed(_ARG_1_))
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), 400)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
  Entity.SetEffect(_ARG_0_.keyHandle, _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetShootEffect(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot)
  Entity.SetTimer(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetTime(_ARG_1_))
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).Speed = _ARG_0_:GetSpeed(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).HomingAng = _ARG_0_:GetHomingDiv(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).BulletType = _ARG_0_:GetBulletType(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).UpDateTime = _ARG_0_:GetUpDateTime(_ARG_1_)
end
function b60.CreateUltima(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.workHandle, 11)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBulletEffect(_ARG_1_))
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetHitEffect(_ARG_1_))
  Bullet.SetHitBgEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBgHitEffect(_ARG_1_))
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetSpeed(_ARG_1_))
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), 400)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
  Entity.SetEffect(_ARG_0_.keyHandle, _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetShootEffect(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot)
  Entity.SetTimer(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) / _ARG_0_:GetSpeed(_ARG_1_) * 0.5)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).Speed = _ARG_0_:GetSpeed(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).HomingAng = _ARG_0_:GetHomingDiv(_ARG_1_)
end
function b60.CreateBulletForMeteor(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.targetHandle)
  _ARG_0_.myPos:sety(8)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(DegToRad(90))
  Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBulletEffect(_ARG_1_))
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetHitEffect(_ARG_1_))
  Bullet.SetHitBgEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBgHitEffect(_ARG_1_))
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetSpeed(_ARG_1_))
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), 400)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.keyHandle, 2)
  Entity.SetEffect(_ARG_0_.keyHandle, _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetShootEffect(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot)
  Entity.SetTimer(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetTime(_ARG_1_))
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).Speed = _ARG_0_:GetSpeed(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).HomingAng = _ARG_0_:GetHomingDiv(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).BulletType = _ARG_0_:GetBulletType(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).UpDateTime = _ARG_0_:GetUpDateTime(_ARG_1_)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).friendFlag = _ARG_0_.friendFlag
end
function b60.CreateBrutal(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), 400)
end
function b60.CreateBrutal2(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize2(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 15, 0, parent)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), 400)
end
function b60.CreateUltimaBomb(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  if Enemy.IsConfuse(_ARG_0_.keyHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 15, 0, parent)
  elseif _ARG_0_.friendFlag == 0 then
    Bullet.SetCollision(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), COLL_KIND_PLAYER, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), _ARG_0_.keyHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), "p_ss_ult_00", "P_SS_ULT_HIT0_0")
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b60_UltimaBomb", _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle, _ARG_0_.myHandle), 400)
end
function b60.CreateRockStorm(_ARG_0_, _ARG_1_, _ARG_2_)
  if Script.Random() < 0.1 then
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.targetHandle)
  else
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  end
  Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
  _ARG_0_.myPos:setx(_ARG_0_.myPos:getx() + (22 * Script.Random() + 2) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
  _ARG_0_.myPos:setz(_ARG_0_.myPos:getz() + (22 * Script.Random() + 2) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
  _ARG_0_.myPos:sety(-8)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(DegToRad(-90))
  Bullet.CreateEffectBullet(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetBulletEffect(_ARG_1_))
  Bullet.SetCollision(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _ARG_0_:GetCallSize(_ARG_1_), 0, _ARG_0_.myHandle)
  SetBulletAttackParam(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, _ARG_0_:GetAttackID(_ARG_1_))
  Bullet.SetAttacker(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetFepName(_ARG_1_), _ARG_0_:GetHitEffect(_ARG_1_))
  Entity.CalcVelocity(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_:GetSpeed(_ARG_1_))
  Bullet.SetMaxMoveDist(Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle), 2500)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).Speed = _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR_XEHANORT1].RockSpeed1 + Script.Random() * 0.05
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).index = _ARG_2_
  EntityManager:GetEntity((Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle))).boumAttackNum = _ARG_0_:GetAttackID2(_ARG_1_)
  _ARG_0_.RockstormBullet[_ARG_2_].handle = Bullet.CreateBullet(_ARG_0_:GetScriptName(_ARG_1_), _ARG_0_.myPos, _ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.RockstormBullet[_ARG_2_].index = _ARG_2_
end
function b60.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function b60.GetCommandName(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Name
end
function b60.GetMotion(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName
end
function b60.GetMotion1(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName1
end
function b60.GetMotion2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName2
end
function b60.GetMotion3(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName3
end
function b60.GetMotion4(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName4
end
function b60.GetMotion5(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName5
end
function b60.GetMotion6(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName6
end
function b60.GetMotion7(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].MotionName7
end
function b60.GetHomingRate(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].HomingRate
end
function b60.GetHomingDist(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].HomingDist
end
function b60.GetHomingDiv(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].HomingDiv
end
function b60.GetTime(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Time
end
function b60.GetSpeed(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Speed
end
function b60.GetSpeed2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Speed2
end
function b60.AttackCommand(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_[_ARG_1_.charaID][_ARG_2_].Function(_ARG_1_)
end
function b60.GetCancelTime(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].CancelTime
end
function b60.GetDelayTime(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Delay
end
function b60.GetNextAttack(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].NextAttack
end
function b60.GetNextAttack2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].NextAttack2
end
function b60.GetUpDateTime(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].UpDateTime
end
function b60.GetRecoveryAmon(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].RecoveryAmon
end
function b60.GetRecoveryHPR(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].RecoveryHPR
end
function b60.GetRate(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Rate
end
function b60.GetGroupNum(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].GroupNum
end
function b60.GetScriptName(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].ScriptName
end
function b60.GetFepName(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].FepName
end
function b60.GetBulletEffect(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].BulletEffect
end
function b60.GetHitEffect(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].HitEffect
end
function b60.GetBgHitEffect(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].BgHitEffect
end
function b60.GetShootEffect(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].ShootEffect
end
function b60.GetAttackID(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].AttackID
end
function b60.GetAttackID2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].AttackID2
end
function b60.GetCallSize(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].CallSize
end
function b60.GetCallSize2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].CallSize2
end
function b60.GetBulletType(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].BulletType
end
function b60.GetWait(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Wait
end
function b60.GetWait2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].Wait2
end
function b60.GetEffect_1(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].BulletType
end
function b60.GetEffect_2(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].BulletType
end
function b60.GetEffect_3(_ARG_0_, _ARG_1_)
  return _UPVALUE0_[_ARG_0_.charaID][_ARG_1_].BulletType
end
function b60.AttackBeginState(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_[_ARG_1_.charaID][_ARG_2_].State.BeginState(_ARG_1_)
end
function b60.AttackEndState(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_[_ARG_1_.charaID][_ARG_2_].State.EndState(_ARG_1_)
end
function b60.AttackUpdate(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_[_ARG_1_.charaID][_ARG_2_].State.Update(_ARG_1_)
end
function b60.EvasionBeginState(_ARG_0_, _ARG_1_)
  _UPVALUE0_[_ARG_1_.charaID].EvasionCommand.BeginState(_ARG_1_)
end
function b60.EvasionEndState(_ARG_0_, _ARG_1_)
  _UPVALUE0_[_ARG_1_.charaID].EvasionCommand.EndState(_ARG_1_)
end
function b60.EvasionUpdate(_ARG_0_, _ARG_1_)
  _UPVALUE0_[_ARG_1_.charaID].EvasionCommand.Update(_ARG_1_)
end
function b60.GetName(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Name
end
function b60.GetWalkSpeed(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].WalkSpeed
end
function b60.GetRunSpeed(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].RunSpeed
end
function b60.GetComboMax(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].ComboMax
end
function b60.GetAction1(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Action1_Dist
end
function b60.GetAction2(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Action2_Dist
end
function b60.GetDistAttack1(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Rate_DistAttack1
end
function b60.GetWalkOrRun(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].WalkOrRun_Dist
end
function b60.GetDeckcommand(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Rate_Deckcommand
end
function b60.GetAirEvasionRate(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Rate_AirEvasion
end
function b60.GetGrandEvasionRate(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Rate_GrandEvasion
end
function b60.GetRate_GuradRate(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Rate_GuradRate
end
function b60.GetChangeModeHPRate0(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].ChangeModeHPRate0
end
function b60.GetChangeModeHPRate1(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].ChangeModeHPRate1
end
function b60.GetBulletNum(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].BulletNum
end
function b60.GetJampPow(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].JampPow
end
function b60.GetGravitiy(_ARG_0_)
  return _UPVALUE0_[_ARG_0_.charaID].Gravitiy
end
function b60.GetAttackRate1(_ARG_0_)
  if Script.Random() < _UPVALUE0_[_ARG_0_.charaID].Rate_Combo then
    return 1
  elseif Script.Random() < _UPVALUE0_[_ARG_0_.charaID].Rate_Combo + _UPVALUE0_[_ARG_0_.charaID].Rate_DeckCombo then
    return 2
  else
    return 3
  end
end
function b60.GetAttackRate2(_ARG_0_)
  if Script.Random() < _UPVALUE0_[_ARG_0_.charaID].Rate_DistAttack1 then
    return 1
  else
    return 0
  end
end
function b60.GetAerialComboRate(_ARG_0_)
  if Script.Random() < _UPVALUE0_[_ARG_0_.charaID].Rate_AerialCombo then
    return 1
  else
    return 0
  end
end
function b60.GetShotDistCommandAttack(_ARG_0_)
  if Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_ATTACKCOM1) then
    return 1
  elseif Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_ATTACKCOM1) + _ARG_0_:GetRate(PLBBASE_COMMAND_SPECIAL0) then
    return 2
  else
    return 3
  end
end
function b60.SetMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion(_ARG_1_))
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion(_ARG_1_))
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotion_1(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion1(_ARG_1_))
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion1(_ARG_1_))
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotion_2(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion2(_ARG_1_))
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion2(_ARG_1_))
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotion_3(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion3(_ARG_1_))
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion3(_ARG_1_))
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotion_4(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion4(_ARG_1_))
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion4(_ARG_1_))
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotion_5(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion5(_ARG_1_))
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion5(_ARG_1_))
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_1(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion1(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion1(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_2(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion2(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion2(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_3(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion3(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion3(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_4(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion4(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion4(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_5(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion5(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion5(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_6(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion6(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion6(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.SetMotionEx_7(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_0_:GetMotion7(_ARG_1_), _ARG_2_, _ARG_3_)
  Entity.SetMotionWithSameCheck(_ARG_0_.keyHandle, _ARG_0_:GetMotion7(_ARG_1_), _ARG_2_, _ARG_3_)
  _ARG_0_.GuardFlag = 0
end
function b60.InitKeyBraid(_ARG_0_)
  EntityManager:GetEntity(_ARG_0_.keyHandle).HitAttackFlag = 0
end
function b60.SetingGuard(_ARG_0_)
  Entity.EnableGuard(_ARG_0_.myHandle, 1)
  Entity.EnableGuardPhysical(_ARG_0_.myHandle, 1)
  Entity.EnableGuardZero(_ARG_0_.myHandle, 1)
  Entity.EnableGuardFire(_ARG_0_.myHandle, 1)
  Entity.EnableGuardIce(_ARG_0_.myHandle, 1)
  Entity.EnableGuardThunder(_ARG_0_.myHandle, 1)
  Entity.SetGuardDir(_ARG_0_.myHandle, 180)
  Entity.EnableGuardSpecial(_ARG_0_.myHandle, 1)
end
function b60.EndGuard(_ARG_0_)
  Entity.EnableGuard(_ARG_0_.myHandle, 0)
  Entity.EnableGuardPhysical(_ARG_0_.myHandle, 0)
  Entity.EnableGuardZero(_ARG_0_.myHandle, 0)
  Entity.EnableGuardFire(_ARG_0_.myHandle, 0)
  Entity.EnableGuardIce(_ARG_0_.myHandle, 0)
  Entity.EnableGuardThunder(_ARG_0_.myHandle, 0)
  Entity.SetGuardDir(_ARG_0_.myHandle, 0)
  Entity.EnableGuardSpecial(_ARG_0_.myHandle, 0)
end
function b60.reSetRootMoveScale(_ARG_0_)
  Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
end
function b60.AuraControler(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if Effect.IsAlive(_ARG_0_.AuraEffectHandle) then
    if _ARG_1_ == 0 then
      Effect.LoopEnd(_ARG_0_.AuraEffectHandle)
      _ARG_0_.AuraEffectHandle = NULL_HANDLE
    end
  elseif _ARG_1_ == 1 then
    _ARG_0_.AuraEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, _ARG_2_, _ARG_3_, _ARG_4_)
    Effect.SetAttachReverseTrs(_ARG_0_.AuraEffectHandle, true)
  end
end
function b60.EnableActionSelect(_ARG_0_)
  if _ARG_0_.charaID == PLBBASE_CHARACTER_ID_VENT then
    if Entity.GetName(_ARG_0_.myHandle) == "b60ex00" then
      ActionSelect.b60ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b62ex00" then
      ActionSelect.b62ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b68ex00" or Entity.GetName(_ARG_0_.myHandle) == "b69ex00" then
      ActionSelect.b68ex00(_ARG_0_)
    end
  elseif _ARG_0_.charaID == PLBBASE_CHARACTER_ID_TERR then
    if Entity.GetName(_ARG_0_.myHandle) == "b70ex00" then
      ActionSelect.b70ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b72ex00" then
      ActionSelect.b72ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b73ex00" then
      ActionSelect.b73ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b78ex00" or Entity.GetName(_ARG_0_.myHandle) == "b79ex00" then
      ActionSelect.b78ex00(_ARG_0_)
    end
  elseif _ARG_0_.charaID == PLBBASE_CHARACTER_ID_TERR_XEHANORT1 then
    if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" then
      ActionSelect.b50ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      ActionSelect.b50ex00(_ARG_0_)
    end
  elseif _ARG_0_.charaID == PLBBASE_CHARACTER_ID_AQUA then
    if Entity.GetName(_ARG_0_.myHandle) == "b80ex00" then
      ActionSelect.b80ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b82ex00" then
      ActionSelect.b82ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b83ex00" then
      ActionSelect.b83ex00(_ARG_0_)
    elseif Entity.GetName(_ARG_0_.myHandle) == "b88ex00" or Entity.GetName(_ARG_0_.myHandle) == "b89ex00" then
      ActionSelect.b88ex00(_ARG_0_)
    end
  end
end
function b60.SetEnemyParam(_ARG_0_, _ARG_1_)
  _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_BATTLEIDLING].Time = Enemy.GetExtraParam(_ARG_1_, "IdlingTime") * 60
  print("Time = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_BATTLEIDLING].Time .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Action1_Dist = Enemy.GetExtraParam(_ARG_1_, "Action1Dist") * Enemy.GetExtraParam(_ARG_1_, "Action1Dist")
  print("Action1_Dist = " .. _UPVALUE0_[_ARG_0_.charaID].Action1_Dist .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Action2_Dist = Enemy.GetExtraParam(_ARG_1_, "Action2Dist") * Enemy.GetExtraParam(_ARG_1_, "Action2Dist")
  print("Action2_Dist = " .. _UPVALUE0_[_ARG_0_.charaID].Action2_Dist .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_Combo = Enemy.GetExtraParam(_ARG_1_, "ConboRate") / 100
  print("Rate_Combo = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_Combo .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_DeckCombo = Enemy.GetExtraParam(_ARG_1_, "DeckConboR") / 100
  print("Rate_DeckCombo = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_DeckCombo .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_AerialCombo = Enemy.GetExtraParam(_ARG_1_, "AirAttackR") / 100
  print("Rate_AerialCombo = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_AerialCombo .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_GrandEvasion = Enemy.GetExtraParam(_ARG_1_, "GrandEvRate") / 100
  print("Rate_GrandEvasion = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_GrandEvasion .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_AirEvasion = Enemy.GetExtraParam(_ARG_1_, "AirEvRate") / 100
  print("Rate_AirEvasion = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_AirEvasion .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_Deckcommand = Enemy.GetExtraParam(_ARG_1_, "DistDeckAR") / 100
  print("Rate_Deckcommand = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_Deckcommand .. "\n")
  _UPVALUE0_[_ARG_0_.charaID].Rate_DistAttack1 = Enemy.GetExtraParam(_ARG_1_, "DistDeckCR") / 100
  print("Rate_DistAttack1 = " .. _UPVALUE0_[_ARG_0_.charaID].Rate_DistAttack1 .. "\n")
  _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM1].Rate = Enemy.GetExtraParam(_ARG_1_, "AttComRate") / 100
  print("AttackComRate = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM1].Rate .. "\n")
  _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL0].Rate = Enemy.GetExtraParam(_ARG_1_, "SpeComRate") / 100
  print("SpecialComRate = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL0].Rate .. "\n")
end
function b60.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  print(Entity.GetName(_ARG_0_.myHandle) .. ":: OnInit\n")
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.keyHandle = NULL_HANDLE
  _ARG_0_.workHandle = NULL_HANDLE
  _ARG_0_.oldState = 0
  _ARG_0_.windVoiceFlag = 0
  _ARG_0_.Speed = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.HomingFlag = 0
  _ARG_0_.Mode = 0
  _ARG_0_.ComboCnt = 0
  _ARG_0_.ComboStep = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.GuardFlag = 0
  _ARG_0_.NoEvasionframe = 0
  _ARG_0_.DamageCnt = 0
  _ARG_0_.SubTime = 0
  _ARG_0_.GoseAppFlag = 0
  _ARG_0_.friendFlag = 0
  _ARG_0_.DeadFlag = 0
  _ARG_0_.AuraEffectHandle = NULL_HANDLE
  _ARG_0_.KealCnt = 0
  _ARG_0_.FinishFlag = 1
  _ARG_0_.noReactionFlag = 0
  _ARG_0_.BulletStep = 0
  _ARG_0_.BulletTime = 0
  _ARG_0_.RockStormCount = 3
  _ARG_0_.RockStormStartNum = 0
  _ARG_0_.keyModelOffFlag = 0
  _ARG_0_.oldShootLockNum = 0
  _ARG_0_.VolleyCnt = 0
  _ARG_0_.VolleyFrame = 0
  _ARG_0_.UltimaFlag = 0
  _ARG_0_.TossDamageCnt = 0
  _ARG_0_.stack = Stack:Create()
  _ARG_0_.gaugeId = -1
  _ARG_0_.reflectCount = 0
  _ARG_0_.evadeTimer = 0
  _ARG_0_.evadeFlag = false
  _ARG_0_.saveDamage = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkNum = 0
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.attackDelay = 0
  _ARG_0_.guardDelay = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.JumpTime = 0
  _ARG_0_.HitAttackFlag = 0
  _ARG_0_.OldState = "BattleIdling"
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if PLBBASE_INIT_PARAM == false then
    PLBBASE_INIT_PARAM = true
  end
  if Entity.GetName(_ARG_1_) == "b60ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b61ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.DeadFlag = 3
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_VENT
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM1].State = Aero_Command
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM2].State = Rush_Command
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM3].State = StrikeReid
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT].EvasionCommand = Dodgerool
    _ARG_0_:SetEnemyParam(_ARG_1_)
  elseif Entity.GetName(_ARG_1_) == "b62ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b61ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_VENT
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM1].State = Aero_Command
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM2].State = Rush_Command
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM3].State = StrikeReid
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT].EvasionCommand = Dodgerool
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_SPECIAL0].State = Blackout_Command
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _ARG_0_.DeadFlag = 1
  elseif Entity.GetName(_ARG_1_) == "b68ex00" or Entity.GetName(_ARG_1_) == "b69ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b61ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_VENT
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM1].State = Aero_Command
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM2].State = Rush_Command
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT][PLBBASE_COMMAND_ATTACKCOM3].State = StrikeReid
    _UPVALUE0_[PLBBASE_CHARACTER_ID_VENT].EvasionCommand = Dodgerool
    _ARG_0_:SetEnemyParam(_ARG_1_)
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Entity.EnableLockon(_ARG_1_, 0)
    Entity.EnableShooton(_ARG_1_, 0)
    Entity.SetAttackCollKindForBodyColl(_ARG_1_, COLL_KIND_PLAYER)
    Entity.SetDamageCollKindForBodyColl(_ARG_1_, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_1_, 1)
    _ARG_0_.friendFlag = 1
    EntityManager:GetEntity(_ARG_0_.keyHandle).friendFlag = 1
    _ARG_0_.FinishFlag = 0
    _ARG_0_.DeadFlag = 2
    _ARG_0_.gaugeId = Enemy.SetupGauge(_ARG_0_.myHandle, FRIEND_VE)
    _UPVALUE0_[_ARG_0_.charaID].RetrunTime = Enemy.GetExtraParam(_ARG_1_, "RetTime") * 60
  elseif Entity.GetName(_ARG_1_) == "b70ex00" or Entity.GetName(_ARG_1_) == "b73ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b71ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.DeadFlag = 3
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_TERR
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM1].State = Brutus_force
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM2].State = Sonicimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM3].State = Sonicimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR].EvasionCommand = Guardimpact
    _ARG_0_:SetEnemyParam(_ARG_1_)
  elseif Entity.GetName(_ARG_1_) == "b72ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b71ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_TERR
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM1].State = Brutus_force
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM2].State = Sonicimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM3].State = Sonicimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR].EvasionCommand = Guardimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_SPECIAL0].State = Blackout_Command
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _ARG_0_.DeadFlag = 1
  elseif Entity.GetName(_ARG_1_) == "b50ex00" or Entity.GetName(_ARG_1_) == "b51ex00" or Entity.GetName(_ARG_1_) == "b52ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b53ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_TERR_XEHANORT1
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM1].State = Brutus_force
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM2].State = SonicimpactEx
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM3].State = Quake
    _UPVALUE0_[_ARG_0_.charaID].EvasionCommand = Guardimpact
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].State = Keal
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL0].State = Meteor
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL1].State = Midareuti
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL2].State = DarkImpulse
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL3].State = DarkVolley
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL4].State = UltimaCannon
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL5].State = Rockstorm
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL6].State = DarkVolleyLvMax
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL7].State = DashVolley
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL8].State = DashVolley2
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_SPECIAL9].State = Sonicimpact2
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].Rate = Enemy.GetExtraParam(_ARG_1_, "KealRate") / 100
    print("KealRate = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].Rate .. "\n")
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].RecoveryHPR = Enemy.GetExtraParam(_ARG_1_, "RecoHPR") / 100
    print("RecoHPR = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].RecoveryHPR .. "\n")
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].RecoveryAmon = Enemy.GetExtraParam(_ARG_1_, "RecoAmon")
    print("RecoAmon = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_KEAL].RecoveryAmon .. "\n")
    _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM3].Rate = Enemy.GetExtraParam(_ARG_1_, "QuakeRate") / 100
    print("QuakeRate = " .. _UPVALUE0_[_ARG_0_.charaID][PLBBASE_COMMAND_ATTACKCOM3].Rate .. "\n")
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "QuakeRa25") / 100
    print("QuakeRa25 = " .. _UPVALUE1_ .. "\n")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "MetoRa25") / 100
    print("MetoRa25 = " .. _UPVALUE2_ .. "\n")
    _UPVALUE0_[_ARG_0_.charaID].ChangeModeHPRate0 = Enemy.GetExtraParam(_ARG_1_, "FlowTypeB") / 100
    print("FlowTypeB = " .. _UPVALUE0_[_ARG_0_.charaID].ChangeModeHPRate0 .. "\n")
    _UPVALUE0_[_ARG_0_.charaID].ChangeModeHPRate1 = Enemy.GetExtraParam(_ARG_1_, "FlowTypeC") / 100
    print("FlowTypeC = " .. _UPVALUE0_[_ARG_0_.charaID].ChangeModeHPRate1 .. "\n")
    _ARG_0_.RockStormStartNum = Enemy.GetExtraParam(_ARG_1_, "RockAttNum")
    print("RockAttNum = " .. _ARG_0_.RockStormStartNum .. "\n")
    _UPVALUE0_[_ARG_0_.charaID].BulletNum = Enemy.GetExtraParam(_ARG_1_, "RockNum")
    print("RockNum = " .. _UPVALUE0_[_ARG_0_.charaID].BulletNum .. "\n")
    _ARG_0_.RockstormIndex = 0
    _ARG_0_.RockstormBullet = {}
    for _FORV_6_ = 0, 8 do
      _ARG_0_.RockstormBullet[_FORV_6_] = {handle = NULL_HANDLE, index = 0}
    end
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR_XEHANORT1].RockSpeed1 = Enemy.GetExtraParam(_ARG_0_.keyHandle, "RokSpeed1")
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR_XEHANORT1].RockSpeed2 = Enemy.GetExtraParam(_ARG_0_.keyHandle, "RokSpeed2")
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR_XEHANORT1].RockY = Enemy.GetExtraParam(_ARG_0_.keyHandle, "RockUpY")
  elseif Entity.GetName(_ARG_1_) == "b78ex00" or Entity.GetName(_ARG_1_) == "b79ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b71ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_TERR
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM1].State = Brutus_force
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM2].State = Sonicimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR][PLBBASE_COMMAND_ATTACKCOM3].State = Sonicimpact
    _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR].EvasionCommand = Guardimpact
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _ARG_0_.DeadFlag = 2
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Entity.EnableLockon(_ARG_1_, 0)
    Entity.EnableShooton(_ARG_1_, 0)
    Entity.SetAttackCollKindForBodyColl(_ARG_1_, COLL_KIND_PLAYER)
    Entity.SetDamageCollKindForBodyColl(_ARG_1_, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_1_, 1)
    _ARG_0_.friendFlag = 1
    EntityManager:GetEntity(_ARG_0_.keyHandle).friendFlag = 1
    _ARG_0_.FinishFlag = 0
    _ARG_0_.gaugeId = Enemy.SetupGauge(_ARG_0_.myHandle, FRIEND_TE)
    _UPVALUE0_[_ARG_0_.charaID].RetrunTime = Enemy.GetExtraParam(_ARG_1_, "RetTime") * 60
  elseif Entity.GetName(_ARG_1_) == "b80ex00" or Entity.GetName(_ARG_1_) == "b83ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b81ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_AQUA
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM1].State = Rifrectobritts
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM2].State = Faira
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM3].State = Brizara
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].State = Keal
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA].EvasionCommand = Cartwheel
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _ARG_0_.DeadFlag = 3
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].Rate = Enemy.GetExtraParam(_ARG_1_, "KealRate") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].RecoveryHPR = Enemy.GetExtraParam(_ARG_1_, "RecoHPR") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].RecoveryAmon = Enemy.GetExtraParam(_ARG_1_, "RecoAmon") / 100
  elseif Entity.GetName(_ARG_1_) == "b82ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b81ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.DeadFlag = 1
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_AQUA
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM1].State = Rifrectobritts
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM2].State = Faira
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM3].State = Brizara
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].State = Keal
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA].EvasionCommand = Cartwheel
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].Rate = Enemy.GetExtraParam(_ARG_1_, "KealRate") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].RecoveryHPR = Enemy.GetExtraParam(_ARG_1_, "RecoHPR") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].RecoveryAmon = Enemy.GetExtraParam(_ARG_1_, "RecoAmon") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_SPECIAL0].State = Blackout_Command
  elseif Entity.GetName(_ARG_1_) == "b88ex00" or Entity.GetName(_ARG_1_) == "b89ex00" then
    _ARG_0_.keyHandle = Entity.CreateEntity("b81ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
    Entity.AttachCoord(_ARG_1_, "R_buki", _ARG_0_.keyHandle, "Root")
    Entity.EnableLockonAndShooton(_ARG_0_.keyHandle, 0)
    EntityManager:GetEntity(_ARG_0_.keyHandle).Master = _ARG_1_
    Entity.SetAttacker(_ARG_0_.keyHandle, _ARG_1_)
    _ARG_0_.charaID = PLBBASE_CHARACTER_ID_AQUA
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM1].State = Rifrectobritts
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM2].State = Faira
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_ATTACKCOM3].State = Brizara
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].State = Keal
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA].EvasionCommand = Cartwheel
    _ARG_0_:SetEnemyParam(_ARG_1_)
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].Rate = Enemy.GetExtraParam(_ARG_1_, "KealRate") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].RecoveryHPR = Enemy.GetExtraParam(_ARG_1_, "RecoHPR") / 100
    _UPVALUE0_[PLBBASE_CHARACTER_ID_AQUA][PLBBASE_COMMAND_KEAL].RecoveryAmon = Enemy.GetExtraParam(_ARG_1_, "RecoAmon") / 100
    _ARG_0_.DeadFlag = 2
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Entity.EnableLockon(_ARG_1_, 0)
    Entity.EnableShooton(_ARG_1_, 0)
    Entity.SetAttackCollKindForBodyColl(_ARG_1_, COLL_KIND_PLAYER)
    Entity.SetDamageCollKindForBodyColl(_ARG_1_, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_1_, 1)
    _ARG_0_.friendFlag = 1
    EntityManager:GetEntity(_ARG_0_.keyHandle).friendFlag = 1
    _ARG_0_.FinishFlag = 0
    _ARG_0_.gaugeId = Enemy.SetupGauge(_ARG_0_.myHandle, FRIEND_AQ)
    _UPVALUE0_[_ARG_0_.charaID].RetrunTime = Enemy.GetExtraParam(_ARG_1_, "RetTime") * 60
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.5)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.8)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  if _ARG_0_.friendFlag == 1 then
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Entity.EnableLockon(_ARG_1_, 0)
    Entity.EnableShooton(_ARG_1_, 0)
    _ARG_0_:GotoState("Standby")
  else
    Entity.EnableLockonAndShooton(_ARG_1_, 1)
    Entity.EnableLockon(_ARG_1_, 1)
    Entity.EnableShooton(_ARG_1_, 1)
    if Enemy.IsAllEnemyWaiting() == true then
      _ARG_0_:GotoState("Standby")
    else
      if Entity.GetName(_ARG_1_) == "b62ex00" or Entity.GetName(_ARG_1_) == "b72ex00" or Entity.GetName(_ARG_1_) == "b82ex00" then
        _ARG_0_:GotoState("Standby")
      else
        _ARG_0_:GotoState("Appear")
      end
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end
  end
end
function b60.OnDamageBefore(_ARG_0_, _ARG_1_)
  if _ARG_0_.friendFlag == 1 and _ARG_1_ == ATK_KIND_RECOVER then
    if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_FriendEsuna then
      return 1
    else
      print("\137\241\149\156\130\181\130\220\130\183.\n")
      _ARG_0_.KealCnt = 1
      Enemy.AddHp(_ARG_0_.myHandle, Entity.GetDamagePoint(_ARG_0_.myHandle))
      Enemy.NotifyHp(_ARG_0_.myHandle, _ARG_0_.gaugeId)
    end
  end
  if _ARG_0_.NoEvasionframe <= 0 or _ARG_0_.DamageCnt > 6 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      if Script.Random() < _ARG_0_:GetGrandEvasionRate() then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("BattleIdling")
        _ARG_0_.stack:push("EvasionAction")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _ARG_0_.DamageCnt = 0
        return 1
      else
      end
    elseif Script.Random() < _ARG_0_:GetAirEvasionRate() then
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("BattleIdling")
      _ARG_0_.stack:push("EvasionAction")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      _ARG_0_.DamageCnt = 0
      return 1
    end
  else
  end
  return 0
end
function b60.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_.friendFlag == 1 then
    Enemy.NotifyHp(_ARG_0_.myHandle, _ARG_0_.gaugeId)
    if 1 >= Enemy.GetHp(_ARG_0_.myHandle) then
      _ARG_0_:GotoState("Dead_Friend")
      return 1
    end
  end
  if _ARG_0_.noReactionFlag == 0 then
    if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
      if Entity.GetName(Entity.GetAttackOwnerHandle(_ARG_0_.myHandle)) ~= nil then
        print("saveDamage = " .. _ARG_0_.saveDamage .. "\n")
        if Script.Random() < _ARG_0_.saveDamage and _ARG_0_.DamageCnt > _UPVALUE0_ then
          _ARG_0_.StateParam = _ARG_0_.DamageWarpParam
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("BattleIdling")
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("SpecialCommandAttack6")
            _ARG_0_.stack:push("SpecialCommandAttack7")
          else
            _ARG_0_.stack:push("DistanceAttackCommand2")
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          _ARG_0_.saveDamage = 0
          _ARG_0_.DamageCnt = 0
          return 1
        end
      else
        _ARG_0_.stack:push("BattleIdling")
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("SpecialCommandAttack8")
        else
          _ARG_0_.stack:push("DistanceAttackCommand2")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _ARG_0_.saveDamage = 0
        _ARG_0_.DamageCnt = 0
        return 1
      end
    end
    _ARG_0_.saveDamage = _ARG_0_.saveDamage + _UPVALUE1_
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    if _ARG_0_:GetState() == "StateReflect" or _ARG_0_:GetState() == "EvasionAction" then
    else
      _ARG_0_.OldState = _ARG_0_:GetState()
    end
    if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" or Entity.GetName(_ARG_0_.myHandle) == "b52ex00" then
      Entity.LoopEndEffectAttach(_ARG_0_.myHandle)
      Entity.LoopEndEffectAttach(_ARG_0_.keyHandle)
    end
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
    _ARG_0_:EndGuard()
    _ARG_0_.DamageCnt = _ARG_0_.DamageCnt + 1
    Entity.SetMotion(_ARG_0_.keyHandle, 0)
  end
  if 0 >= _ARG_0_.DamageCnt then
    _ARG_0_.NoEvasionframe = 210
  end
end
function b60.OnReturnDamage(_ARG_0_)
  print("b60 : OnReturnDamage\n")
  if (Entity.GetName(_ARG_0_.myHandle) == "b80ex00" or Entity.GetName(_ARG_0_.myHandle) == "b82ex00" or Entity.GetName(_ARG_0_.myHandle) == "b83ex00") and Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _ARG_0_:GetRecoveryHPR(PLBBASE_COMMAND_KEAL) and Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_KEAL) then
    _ARG_0_:GotoState("KealCommand")
  end
  if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
    _ARG_0_.SubTime = _ARG_0_.SubTime + _ARG_0_.DamageCnt * 60
    if _ARG_0_:RestHpRate() > _ARG_0_:GetChangeModeHPRate1() then
      _ARG_0_.SubTime = _ARG_0_.SubTime + Script.Random() * 100
    else
      _ARG_0_.SubTime = _ARG_0_.SubTime + Script.Random() * 300
    end
    DeleteModel(_ARG_0_.myHandle)
    if _ARG_0_:GetState() ~= "SpecialCommandAttack7" and _ARG_0_:GetState() ~= "DistanceAttackCommand2" and _ARG_0_:GetState() ~= "WarpMove" and _ARG_0_:GetState() ~= "WarpMoveIn" and _ARG_0_:GetState() ~= "WarpMoveOut" then
      _ARG_0_:GotoState("BattleIdling")
    end
    return
  end
  _ARG_0_:GotoState(_ARG_0_.OldState)
end
function b60.OnGuard(_ARG_0_)
  _ARG_0_.GuardFlag = 1
  Entity.GetDamageCrossPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.guardDelay = 5
  if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
    Entity.AttachEffect(_ARG_0_.myHandle, "b50_10", "P_GU_GUA_GUA0_0", "Root")
  else
    Entity.AttachEffect(_ARG_0_.myHandle, "p_gu_gua_00", "P_GU_GUA_GUA0_0", "Root")
  end
end
function b60.OnReflect(_ARG_0_)
  if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
    if _ARG_0_.noReactionFlag == 1 then
    else
      _ARG_0_:GotoState("StateReflect")
    end
  else
    _ARG_0_:GotoState("StateReflect")
  end
  return 1
end
function b60.Defense(_ARG_0_)
  if _ARG_0_.evadeTimer > 0 then
    return
  end
  if _ARG_0_.evadeFlag == false then
    if Entity.IsAttacking(_ARG_0_.targetHandle) then
      _ARG_0_.evadeFlag = true
      _ARG_0_.evadeTimer = -1
    end
  else
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 12.25 then
      _ARG_0_.stack:push("EvasionAction")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    else
    end
    _ARG_0_.evadeTimer = 60 * (5 + Script.Random() * 2)
    _ARG_0_.evadeFlag = false
    return true
  end
  return false
end
function b60.IsPlShootShot(_ARG_0_)
  Entity.GetLocalPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.plShootBulletHandle = Player.GetNearBullet(_ARG_0_.targetHandle, _ARG_0_.WorkVec)
  return true
end
function b60.OnUpdateDamageReaction(_ARG_0_, _ARG_1_)
  if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00" then
    if _ARG_1_ == REACTION_KIND_BLOW_DAMAGE or _ARG_1_ == REACTION_KIND_TOSS_DAMAGE or _ARG_1_ == REACTION_KIND_FLICK_DAMAGE then
      if _ARG_0_.TossDamageCnt > 2 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 8 then
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("BattleIdling")
        if _ARG_0_:RestHpRate() < _ARG_0_:GetChangeModeHPRate1() then
          _ARG_0_.stack:push("SpecialCommandAttack1")
        elseif Script.Random() < 0.5 then
          _ARG_0_.stack:push("SpecialCommandAttack1")
        else
          _ARG_0_.stack:push("SpecialCommandAttack2")
        end
        _ARG_0_.stack:push("WarpMoveIn")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _ARG_0_.saveDamage = 0
        _ARG_0_.DamageCnt = 0
        _ARG_0_.TossDamageCnt = _ARG_0_.TossDamageCnt + 1
        if _ARG_0_.TossDamageCnt > 1 then
          _ARG_0_.TossDamageCnt = 1
        end
        return 1
      end
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 17 then
        _ARG_0_.TossDamageCnt = _ARG_0_.TossDamageCnt + 1
        _ARG_0_.StateParam = _ARG_0_.DamageWarpParam
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("BattleIdling")
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("SpecialCommandAttack7")
        else
          _ARG_0_.stack:push("DistanceAttackCommand2")
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        _ARG_0_.saveDamage = 0
        _ARG_0_.DamageCnt = 0
        return 1
      end
    elseif _ARG_1_ == REACTION_KIND_SMALL_DAMAGE then
    end
  else
  end
  return 0
end
function b60.OnHitAttack(_ARG_0_)
  _ARG_0_.HitAttackFlag = 1
  if "SpecialCommandAttack2" == _ARG_0_:GetState() then
  end
end
function b60.PlayVoice(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Sound.PlayVoice(108, _ARG_1_, 1, _ARG_0_.workVec, SE_OPT_ALWAYS)
end
function b60.OnDead(_ARG_0_)
  if _ARG_0_.DeadFlag == 0 then
    _ARG_0_:GotoState("Dead")
    SetupBossDead(_ARG_0_.myHandle)
    return 1
  elseif _ARG_0_.DeadFlag == 1 then
    if Entity.GetName(_ARG_0_.myHandle) == "b62ex00" or Entity.GetName(_ARG_0_.myHandle) == "b72ex00" or Entity.GetName(_ARG_0_.myHandle) == "b82ex00" then
      Entity.GetWorldPos(workVec, _ARG_0_.myHandle)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      Enemy.SetReaction(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
      Entity.SetEffect(_ARG_0_.myHandle, "b01vs00", "B022_IMI_SMK1_0", workVec, workVec1)
      _ARG_0_:GotoStateSub("Dead2")
      print("\142\128\150S\130\181\130\220\130\183.\n")
    end
  elseif _ARG_0_.DeadFlag == 2 then
    print("\139C\144\226\130\181\130\220\130\183.\n")
    _ARG_0_:GotoState("Dead_Friend")
    return 1
  elseif _ARG_0_.DeadFlag == 3 then
    Enemy.SetReaction(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
    print("\144\129\130\193\148\242\130\209\130\220\130\183.\n")
    _ARG_0_:GotoState("Dead2")
    SetupBossDead(_ARG_0_.myHandle)
    return 1
  end
end
function b60.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("BattleIdling")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function b60.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  if _ARG_0_.NoEvasionframe <= 0 then
    _ARG_0_.NoEvasionframe = 0
  else
    _ARG_0_.NoEvasionframe = _ARG_0_.NoEvasionframe - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if 0 >= _ARG_0_.DamageCnt then
    _ARG_0_.DamageCnt = 0
  else
    _ARG_0_.DamageCnt = _ARG_0_.DamageCnt - 0.001 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if 0 >= _ARG_0_.evadeTimer then
    _ARG_0_.evadeTimer = 0
  else
    _ARG_0_.evadeTimer = _ARG_0_.evadeTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if 0 >= _ARG_0_.saveDamage then
    _ARG_0_.saveDamage = 0
  else
    _ARG_0_.saveDamage = _ARG_0_.saveDamage - 0.001 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if 0 >= _ARG_0_.VolleyFrame then
    _ARG_0_.VolleyFrame = 0
    _ARG_0_.VolleyCnt = 0
  else
    _ARG_0_.VolleyFrame = _ARG_0_.VolleyFrame - 0.001 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if Entity.GetName(_ARG_0_.myHandle) == "b69ex00" or Entity.GetName(_ARG_0_.myHandle) == "b79ex00" or Entity.GetName(_ARG_0_.myHandle) == "b89ex00" then
    if _ARG_0_:GetState() ~= "LimitCommando" and Player.IsNowEntryLimitCommand() == COMMAND_KIND_TrinityLimit then
      print("\131g\131\138\131j\131e\131B\131\138\131~\131b\131g\142\243\149t\n")
      _ARG_0_.stack:push("LimitCommando")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return
    end
  elseif (Entity.GetName(_ARG_0_.myHandle) == "b50ex00" or Entity.GetName(_ARG_0_.myHandle) == "b51ex00") and _ARG_0_.windVoiceFlag == 0 and Player.IsBattleFlagPlayerDead() == true and Sound.IsInvalidateSeCall() == 1 then
    if Script.Random() < 0.3 then
      _ARG_0_:PlayVoice(22)
    elseif Script.Random() < 0.66 then
      _ARG_0_:PlayVoice(23)
    else
      _ARG_0_:PlayVoice(26)
    end
    _ARG_0_.windVoiceFlag = 1
  end
  if _ARG_0_.friendFlag == 1 and _ARG_0_.KealCnt == 1 then
    Enemy.NotifyHp(_ARG_0_.myHandle, _ARG_0_.gaugeId)
    _ARG_0_.KealCnt = _ARG_0_.KealCnt + 1
    if _ARG_0_.KealCnt > 10 then
      _ARG_0_.KealCnt = 0
    end
  end
end
EntityFactory:Add("b60ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b62ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b68ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b69ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b80ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b82ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b83ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b88ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b89ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b70ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b72ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b73ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b78ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b79ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b50ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b51ex00", function(_ARG_0_)
  return (b60:new())
end)
EntityFactory:Add("b52ex00", function(_ARG_0_)
  return (b60:new())
end)
function collSE(_ARG_0_, _ARG_1_)
end
b61ex00 = {}
b61ex00_base_mt = {__index = __StateMachine}
setmetatable(b61ex00, b61ex00_base_mt)
b61ex00_mt = {__index = b61ex00}
function b61ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b61ex00_mt)
end
function b61ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Master = NULL_HANDLE
  _ARG_0_.HitAttackFlag = 0
  _ARG_0_.friendFlag = 0
  Enemy.SetNoNetwork(_ARG_1_, 1)
end
function b61ex00.OnHitAttack(_ARG_0_, _ARG_1_)
  _ARG_0_.HitAttackFlag = 1
end
function b61ex00.OnReflect(_ARG_0_)
  print("b61ex00 : OnReflect\n")
  EntityManager:GetEntity(_ARG_0_.Master):GotoState("StateReflect")
  return 1
end
function b61ex00.OnUpdate(_ARG_0_)
  Entity.SetAttacker(_ARG_0_.myHandle, _ARG_0_.Master)
  if _ARG_0_.friendFlag == 1 then
    Entity.SetCollKindForAAC(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_0_.myHandle, 1)
  end
  workVec:set(0, 0, 0)
  Entity.SetLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetOldLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(_ARG_0_.Master)))
end
EntityFactory:Add("b61ex00", function(_ARG_0_)
  return (b61ex00:new())
end)
b81ex00 = {}
b81ex00_base_mt = {__index = __StateMachine}
setmetatable(b81ex00, b81ex00_base_mt)
b81ex00_mt = {__index = b81ex00}
function b81ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b81ex00_mt)
end
function b81ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Master = NULL_HANDLE
  _ARG_0_.HitAttackFlag = 0
  _ARG_0_.friendFlag = 0
  Enemy.SetNoNetwork(_ARG_1_, 1)
end
function b81ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.HitAttackFlag = 1
end
function b81ex00.OnReflect(_ARG_0_)
  EntityManager:GetEntity(_ARG_0_.Master):GotoState("StateReflect")
  return 1
end
function b81ex00.OnUpdate(_ARG_0_)
  Entity.SetAttacker(_ARG_0_.myHandle, _ARG_0_.Master)
  if _ARG_0_.friendFlag == 1 then
    Entity.SetCollKindForAAC(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_0_.myHandle, 1)
  end
  workVec:set(0, 0, 0)
  Entity.SetLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetOldLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(_ARG_0_.Master)))
end
EntityFactory:Add("b81ex00", function(_ARG_0_)
  return (b81ex00:new())
end)
b71ex00 = {}
b71ex00_base_mt = {__index = __StateMachine}
setmetatable(b71ex00, b71ex00_base_mt)
b71ex00_mt = {__index = b71ex00}
function b71ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b71ex00_mt)
end
function b71ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Master = NULL_HANDLE
  _ARG_0_.HitAttackFlag = 0
  _ARG_0_.friendFlag = 0
  Enemy.SetNoNetwork(_ARG_1_, 1)
end
function b71ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.HitAttackFlag = 1
end
function b71ex00.OnReflect(_ARG_0_)
  EntityManager:GetEntity(_ARG_0_.Master):GotoState("StateReflect")
  return 1
end
function b71ex00.OnUpdate(_ARG_0_)
  Entity.SetAttacker(_ARG_0_.myHandle, _ARG_0_.Master)
  if _ARG_0_.friendFlag == 1 then
    Entity.SetCollKindForAAC(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_0_.myHandle, 1)
  end
  workVec:set(0, 0, 0)
  Entity.SetLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetOldLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(_ARG_0_.Master)))
end
EntityFactory:Add("b71ex00", function(_ARG_0_)
  return (b71ex00:new())
end)
b53ex00 = {}
b53ex00_base_mt = {__index = __StateMachine}
setmetatable(b53ex00, b53ex00_base_mt)
b53ex00_mt = {__index = b53ex00}
function b53ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b53ex00_mt)
end
function b53ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Master = NULL_HANDLE
  _ARG_0_.HitAttackFlag = 0
  _ARG_0_.friendFlag = 0
  Enemy.SetNoNetwork(_ARG_1_, 1)
end
function b53ex00.OnHitAttack(_ARG_0_)
  _ARG_0_.HitAttackFlag = 1
end
function b53ex00.OnReflect(_ARG_0_)
  EntityManager:GetEntity(_ARG_0_.Master):GotoState("StateReflect")
  return 1
end
function b53ex00.OnUpdate(_ARG_0_)
  Entity.SetAttacker(_ARG_0_.myHandle, _ARG_0_.Master)
  if _ARG_0_.friendFlag == 1 then
    Entity.SetCollKindForAAC(_ARG_0_.myHandle, COLL_KIND_PLAYER)
    Enemy.EnableTargetEnemy(_ARG_0_.myHandle, 1)
  end
  workVec:set(0, 0, 0)
  Entity.SetLocalPos(_ARG_0_.myHandle, workVec)
  Entity.SetOldLocalPos(_ARG_0_.myHandle, workVec)
  if EntityManager:GetEntity(_ARG_0_.Master).keyModelOffFlag == 1 then
    Entity.SetAlpha(_ARG_0_.myHandle, 0)
  else
    Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(_ARG_0_.Master)))
  end
end
EntityFactory:Add("b53ex00", function(_ARG_0_)
  return (b53ex00:new())
end)
EntityFactory:Add("b60_Bullet", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("buletal", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("meteorBGHit", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b60_DarkVoll", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b60_UltimaBomb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b60_Ultima", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("RockStrormB", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("RockSBomb", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
ActionSelect = {
  b60ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b62ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b68ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
    if _ARG_0_.targetPos:gety() > 6 then
      _ARG_0_.stack:push("EvasionTime")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("Combo")
        else
          _ARG_0_.stack:push("Combo")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("Combo")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Goes_away")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if _ARG_0_.GoseAppFlag == 1 then
        _ARG_0_.stack:push("Combo")
        _ARG_0_.stack:push("Approache")
      else
        _ARG_0_.stack:push("Combo")
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b70ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Goes_away")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Approache")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Approache")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b72ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b78ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
    if _ARG_0_.targetPos:gety() > 6 then
      _ARG_0_.stack:push("EvasionTime")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("Combo")
        else
          _ARG_0_.stack:push("Combo")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("Combo")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Goes_away")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if _ARG_0_.GoseAppFlag == 1 then
        _ARG_0_.stack:push("Combo")
        _ARG_0_.stack:push("Approache")
      else
        _ARG_0_.stack:push("Combo")
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b73ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b50ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if _ARG_0_:RestHpRate() > _ARG_0_:GetChangeModeHPRate0() then
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
        if _ARG_0_:GetAttackRate1() == 1 then
          _ARG_0_.stack:push("Combo")
        elseif _ARG_0_:GetAttackRate1() == 2 then
          if Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_ATTACKCOM3) then
            _ARG_0_.stack:push("DistanceAttackCommand3")
          else
            _ARG_0_.stack:push("SpecialCommandAttack1")
          end
        elseif _ARG_0_.GoseAppFlag == 1 then
          if Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_ATTACKCOM3) then
            _ARG_0_.stack:push("DistanceAttackCommand3")
          else
            _ARG_0_.stack:push("SpecialCommandAttack1")
          end
        else
          _ARG_0_.stack:push("Goes_away")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
        if Script.Random() < _ARG_0_:GetDeckcommand() then
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("DistanceAttackCommand2")
          elseif _ARG_0_.VolleyCnt < 3 then
            _ARG_0_.stack:push("SpecialCommandAttack3")
          else
            _ARG_0_.stack:push("DistanceAttackCommand2")
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
        elseif _ARG_0_.GoseAppFlag == 1 then
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("DistanceAttackCommand2")
          elseif _ARG_0_.VolleyCnt < 3 then
            _ARG_0_.stack:push("SpecialCommandAttack3")
          else
            _ARG_0_.stack:push("DistanceAttackCommand2")
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Approache")
        end
      else
        _ARG_0_.stack:push("Move")
      end
    elseif _ARG_0_:RestHpRate() > _ARG_0_:GetChangeModeHPRate1() then
      _UPVALUE0_[PLBBASE_CHARACTER_ID_TERR_XEHANORT1].WalkOrRun_Dist = 25
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
        if _ARG_0_:GetAttackRate1() == 1 then
          _ARG_0_.stack:push("SpecialCommandAttack2")
        elseif _ARG_0_:GetAttackRate1() == 2 then
          for _FORV_8_ = 0, Script.Random() * 3 do
            if Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_ATTACKCOM3) then
              _ARG_0_.stack:push("DistanceAttackCommand3")
            else
              _ARG_0_.stack:push("SpecialCommandAttack1")
            end
          end
        elseif _ARG_0_.GoseAppFlag == 1 then
        else
          _ARG_0_.stack:push("Goes_away")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
        if Script.Random() < _ARG_0_:GetDeckcommand() then
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("DistanceAttackCommand2")
          elseif _ARG_0_.VolleyCnt < 3 then
            _ARG_0_.stack:push("SpecialCommandAttack6")
          else
            _ARG_0_.stack:push("DistanceAttackCommand2")
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
        elseif _ARG_0_.GoseAppFlag == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Approache")
        end
      else
        _ARG_0_.stack:push("Move")
      end
    else
      if _ARG_0_:RestHpRate() < 0.25 and _ARG_0_.UltimaFlag == 0 then
        _ARG_0_.stack:push("SpecialCommandAttack2")
        _ARG_0_.stack:push("WarpMoveIn")
        for _FORV_7_ = 0, Script.Random() * 3 do
          _ARG_0_.stack:push("WarpMoveIn")
        end
        _FOR_:push("SpecialCommandAttack4")
        _ARG_0_.stack:push("WarpMoveOut")
        _ARG_0_.UltimaFlag = 1
      end
      if Script.Random() < 0.1 then
        _ARG_0_.UltimaFlag = 0
      end
      if Entity.GetName(_ARG_0_.myHandle) == "b50ex00" and _ARG_0_.RockStormCount >= _ARG_0_.RockStormStartNum then
        _ARG_0_.stack:push("SpecialCommandAttack5")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
        if _ARG_0_:GetAttackRate1() == 1 then
          _ARG_0_.stack:push("SpecialCommandAttack2")
        elseif _ARG_0_:GetAttackRate1() == 2 then
          for _FORV_9_ = 0, Script.Random() * 3 do
            if Script.Random() < _UPVALUE1_ then
              _ARG_0_.stack:push("DistanceAttackCommand3")
            elseif Script.Random() < _UPVALUE1_ + _UPVALUE2_ then
              _ARG_0_.stack:push("SpecialCommandAttack0")
            else
              _ARG_0_.stack:push("SpecialCommandAttack1")
            end
          end
        elseif _ARG_0_.GoseAppFlag == 1 then
        else
          _ARG_0_.stack:push("SpecialCommandAttack4")
          _ARG_0_.stack:push("WarpMove")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
        if Script.Random() < _ARG_0_:GetDeckcommand() then
          if Script.Random() < _UPVALUE3_ then
            _ARG_0_.stack:push("DistanceAttackCommand2")
          elseif _ARG_0_.VolleyCnt < 3 then
            _ARG_0_.stack:push("SpecialCommandAttack6")
          else
            _ARG_0_.stack:push("DistanceAttackCommand2")
          end
          Entity.ClearSpeed(_ARG_0_.myHandle)
        elseif _ARG_0_.GoseAppFlag == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        elseif Script.Random() < 0.4 then
          _ARG_0_.stack:push("SpecialCommandAttack1")
          _ARG_0_.stack:push("WarpMoveIn")
          _ARG_0_.stack:push("SpecialCommandAttack2")
          _ARG_0_.stack:push("WarpMoveIn")
          _ARG_0_.stack:push("SpecialCommandAttack6")
          _ARG_0_.stack:push("WarpMoveOut")
        elseif Script.Random() < 0.8 then
          _ARG_0_.stack:push("SpecialCommandAttack1")
          _ARG_0_.stack:push("WarpMoveIn")
          _ARG_0_.stack:push("SpecialCommandAttack2")
          _ARG_0_.stack:push("WarpMoveIn")
        else
          _ARG_0_.stack:push("SpecialCommandAttack2")
          _ARG_0_.stack:push("WarpMoveIn")
          for _FORV_8_ = 0, Script.Random() * 3 do
            _ARG_0_.stack:push("WarpMoveIn")
          end
          _FOR_:push("SpecialCommandAttack4")
          _ARG_0_.stack:push("WarpMoveOut")
        end
      else
        _ARG_0_.stack:push("Move")
      end
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b80ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b51ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("SpecialCommandAttack2")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        for _FORV_8_ = 0, Script.Random() * 3 do
          if Script.Random() < _ARG_0_:GetRate(PLBBASE_COMMAND_ATTACKCOM3) then
            _ARG_0_.stack:push("SpecialCommandAttack6")
          else
            _ARG_0_.stack:push("SpecialCommandAttack1")
          end
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
        else
          _ARG_0_.stack:push("SpecialCommandAttack3")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        _ARG_0_.stack:push("DistanceAttackCommand2")
        Entity.ClearSpeed(_ARG_0_.myHandle)
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b80ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b82ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b83ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("ShortDistAttackCommand")
        else
          _ARG_0_.stack:push("SpecialCommandAttack0")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if Script.Random() < _ARG_0_:GetDeckcommand() then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("DistanceAttackCommand2")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("DistanceAttackCommand3")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end,
  b88ex00 = function(_ARG_0_)
    _ARG_0_.stack:push("BattleIdling")
    Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
    if _ARG_0_.targetPos:gety() > 6 then
      _ARG_0_.stack:push("EvasionTime")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      return
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction1() then
      if _ARG_0_:GetAttackRate1() == 1 then
        _ARG_0_.stack:push("Combo")
      elseif _ARG_0_:GetAttackRate1() == 2 then
        if _ARG_0_:GetShotDistCommandAttack() == 1 then
          _ARG_0_.stack:push("Combo")
        else
          _ARG_0_.stack:push("Combo")
        end
        Entity.ClearSpeed(_ARG_0_.myHandle)
      elseif _ARG_0_.GoseAppFlag == 1 then
        if _ARG_0_:GetAttackRate2() == 1 then
          _ARG_0_.stack:push("Combo")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          _ARG_0_.stack:push("Goes_away")
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      else
        _ARG_0_.stack:push("Goes_away")
      end
    elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _ARG_0_:GetAction2() then
      if _ARG_0_.GoseAppFlag == 1 then
        _ARG_0_.stack:push("Combo")
        _ARG_0_.stack:push("Approache")
      else
        _ARG_0_.stack:push("Combo")
        _ARG_0_.stack:push("Approache")
      end
    else
      _ARG_0_.stack:push("Move")
    end
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end
}
