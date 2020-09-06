G01VS_HANDLE = 0
g19vs00 = {}
g19vs00_base_mt = {__index = __StateMachine}
setmetatable(g19vs00, g19vs00_base_mt)
g19vs00_mt = {__index = g19vs00}
function g19vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g19vs00_mt)
end
function g19vs00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_8_, _FORV_9_ in pairs(EntityManager.entities) do
    if (Entity.GetName(_FORV_8_) == "m91ex00" or Entity.GetName(_FORV_8_) == "m92ex00" or Entity.GetName(_FORV_8_) == "m93ex00" or Entity.GetName(_FORV_8_) == "m94ex00" or Entity.GetName(_FORV_8_) == "m95ex00") and Player.GetNetworkID(Entity.GetParent(_FORV_8_)) == 0 and _ARG_1_ == _FORV_8_ then
      break
    end
  end
  if Entity.GetParent(_FORV_8_) == NULL_HANDLE then
  else
    _ARG_1_ = Entity.GetParent(_FORV_8_)
  end
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID and Player.GetHandleForNet() == _ARG_1_ then
    _UPVALUE0_ = true
    _UPVALUE1_ = _ARG_1_
  end
end
function g19vs00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  for _FORV_8_, _FORV_9_ in pairs(EntityManager.entities) do
    if (Entity.GetName(_FORV_8_) == "m91ex00" or Entity.GetName(_FORV_8_) == "m92ex00" or Entity.GetName(_FORV_8_) == "m93ex00" or Entity.GetName(_FORV_8_) == "m94ex00" or Entity.GetName(_FORV_8_) == "m95ex00") and Player.GetNetworkID(Entity.GetParent(_FORV_8_)) == 0 then
      break
    end
  end
  if Entity.GetParent(_FORV_8_) == NULL_HANDLE then
  else
    _ARG_1_ = Entity.GetParent(_FORV_8_)
  end
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _UPVALUE0_ = false
    _UPVALUE1_ = NULL_HANDLE
  end
end
function g19vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.effectHandle = NULL_HANDLE
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
end
function g19vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  _UPVALUE1_:set(0, 0, 0)
  _ARG_0_.effectHandle = Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g19vs00.OnUpdate(_ARG_0_)
  if _UPVALUE0_ == 1 then
    if Effect.IsAlive(_ARG_0_.effectHandle) then
    else
      _ARG_0_:createEffect("g_vs_019_00", "G_VS_SLT_DOM0_0")
    end
  elseif Effect.IsAlive(_ARG_0_.effectHandle) then
    Effect.LoopEnd(_ARG_0_.effectHandle)
  end
end
EntityFactory:Add("g19vs00", function(_ARG_0_)
  return (g19vs00:new())
end)
g20vs00 = {}
g20vs00_base_mt = {__index = __StateMachine}
setmetatable(g20vs00, g20vs00_base_mt)
g20vs00_mt = {__index = g20vs00}
function g20vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g20vs00_mt)
end
function g20vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.effectHandle = NULL_HANDLE
  _ARG_0_.alertHandle = NULL_HANDLE
  _ARG_0_.color = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldcolor = FVECTOR3.new(0, 0, 0)
  _ARG_0_.nextWait = Gimmick.GetExtraParam(_ARG_0_.myHandle, "nextWait") * 60
  _ARG_0_.startWait = Gimmick.GetExtraParam(_ARG_0_.myHandle, "startWait") * 60
  _UPVALUE0_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "alertCnt")
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_JUMP_STAND)
  Gimmick.SetJumpStand(_ARG_1_, 1)
  Gimmick.EnableNetwork(_ARG_1_, 1)
  _ARG_0_.alertFlag = 0
  _ARG_0_.colorFlag = 0
  _ARG_0_.AlertCnt = 0
  _ARG_0_:GotoState("Start")
  Entity.SetGravityCoefficient(_ARG_0_.myHandle, 0.5)
end
function g20vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(0, 0, 0)
  _UPVALUE1_:set(0, 0, 0)
  _ARG_0_.alertHandle = Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE1_, _UPVALUE0_)
end
function g20vs00.OnDestroy(_ARG_0_)
  Entity.SetGravityCoefficient(_ARG_0_.myHandle, 1)
end
g20vs00.states = {
  Start = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : Start\n")
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.startWait)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Alert")
      end
    end
  },
  Waiting = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : Waiting\n")
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.nextWait)
      _UPVALUE0_ = 0
      _ARG_0_.alertFlag = 0
      _ARG_0_.colorFlag = 0
      _ARG_0_.AlertCnt = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _UPVALUE0_ = 0
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true then
        if Player.IsBattleFlagArenaBattlePlay() == 0 then
          _ARG_0_:GotoState("Waiting")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Alert")
        end
      end
    end
  },
  Alert = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : Alert\n")
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true then
      end
      _ARG_0_.alertFlag = 1
      _ARG_0_.colorFlag = 0
      _ARG_0_.AlertCnt = 0
      Sound.PlaySe(283, 1)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.alertFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and _ARG_0_.alertFlag == 99 then
        _ARG_0_:GotoState("Damage")
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : Damage\n")
      if Player.IsBattleFlagArenaBattlePlay() == 0 then
        _ARG_0_:GotoState("Waiting")
        return
      end
      if _UPVALUE0_ == Player.GetHandleForNet() then
        print("\142\169\146[\150\150PC\130\205\150\179\142\150!!\n")
      else
        print("\142\169\146[\150\150PC\130\205\143\243\145\212\136\217\143\237\131_\131\129\129[\131W!!\n")
        if Script.Random() < 0.2 then
          Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_BLIND)
        elseif Script.Random() < 0.4 then
          Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_CONFUSE)
        elseif Script.Random() < 0.6 then
          Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_SLOW)
        elseif Script.Random() < 0.8 then
          Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_FAINT)
        elseif Script.Random() < 1 then
          Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_MINIMUM)
        end
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  },
  BlindDamage = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : BlindDamage\n")
      if _UPVALUE0_ == Player.GetHandleForNet() then
        print("\142\169\146[\150\150PC\130\205\150\179\142\150!!\n")
      else
        print("\142\169\146[\150\150PC\130\205\143\243\145\212\136\217\143\237\131_\131\129\129[\131W!!\n")
        Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_BLIND)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  },
  ConfuseDamage = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : ConfuseDamage\n")
      if _UPVALUE0_ == Player.GetHandleForNet() then
        print("\142\169\146[\150\150PC\130\205\150\179\142\150!!\n")
      else
        print("\142\169\146[\150\150PC\130\205\143\243\145\212\136\217\143\237\131_\131\129\129[\131W!!\n")
        Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_CONFUSE)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  },
  SlowDamage = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : SlowDamage\n")
      if _UPVALUE0_ == Player.GetHandleForNet() then
        print("\142\169\146[\150\150PC\130\205\150\179\142\150!!\n")
      else
        print("\142\169\146[\150\150PC\130\205\143\243\145\212\136\217\143\237\131_\131\129\129[\131W!!\n")
        Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_SLOW)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  },
  FaintDamage = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : FaintDamage\n")
      if _UPVALUE0_ == Player.GetHandleForNet() then
        print("\142\169\146[\150\150PC\130\205\150\179\142\150!!\n")
      else
        print("\142\169\146[\150\150PC\130\205\143\243\145\212\136\217\143\237\131_\131\129\129[\131W!!\n")
        Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_FAINT)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  },
  MinimumDamage = {
    OnBeginState = function(_ARG_0_)
      print("g20vs00 : MinimumDamage\n")
      if _UPVALUE0_ == Player.GetHandleForNet() then
        print("\142\169\146[\150\150PC\130\205\150\179\142\150!!\n")
      else
        print("\142\169\146[\150\150PC\130\205\143\243\145\212\136\217\143\237\131_\131\129\129[\131W!!\n")
        Player.SetDamage(Player.GetHandleForNet(), 0, ATK_KIND_MINIMUM)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  }
}
function g20vs00.OnUpdate(_ARG_0_)
  if Entity.GetGravityCoefficient(_ARG_0_.myHandle) ~= 1 and Entity.IsGround(Player.GetHandleForNet()) then
    Player.NotifyGimmickJump(Player.GetHandleForNet(), _ARG_0_.myHandle, 60)
  end
  if _ARG_0_.alertFlag == 1 then
    if Effect.IsAlive(_ARG_0_.alertHandle) == true and _ARG_0_.colorFlag == 6 and Effect.GetNowFrame(_ARG_0_.alertHandle) > 120 then
      _ARG_0_.alertFlag = 99
      _UPVALUE0_ = 0
    end
    if Effect.IsAlive(_ARG_0_.alertHandle) == false then
      if _ARG_0_.colorFlag == 0 then
        _ARG_0_.colorFlag = 1
        _ARG_0_.AlertCnt = _ARG_0_.AlertCnt + 1
        _ARG_0_:createEffect("g_vs_019_00", "G_VS_SLT_TEN0_0")
      elseif _ARG_0_.colorFlag == 1 then
        _ARG_0_.colorFlag = 0
        if _ARG_0_.AlertCnt >= 3 then
          _UPVALUE0_ = 1
        end
        if _ARG_0_.AlertCnt >= _UPVALUE1_ then
          _ARG_0_.colorFlag = 2
        end
      elseif _ARG_0_.colorFlag == 2 then
        _ARG_0_.colorFlag = 6
        _ARG_0_:createEffect("g_vs_019_00", "G_VS_SLT_FLS0_0")
      elseif _ARG_0_.colorFlag == 3 then
        _ARG_0_.colorFlag = 4
      elseif _ARG_0_.colorFlag == 4 then
        _ARG_0_.colorFlag = 5
      elseif _ARG_0_.colorFlag == 5 then
        _ARG_0_.colorFlag = 6
      elseif _ARG_0_.colorFlag == 6 then
        _ARG_0_.alertFlag = 99
        _UPVALUE0_ = 0
      end
    end
  end
  _ARG_0_:Update()
  Gimmick.EnableNetwork(_ARG_0_.myHandle, 1)
end
EntityFactory:Add("g20vs00", function(_ARG_0_)
  return (g20vs00:new())
end)
