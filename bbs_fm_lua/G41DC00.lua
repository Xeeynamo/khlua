WorkVec = FVECTOR3.new(0, 0, 0)
WorkVec1 = FVECTOR3.new(0, 0, 0)
g41dc00 = {}
g41dc00_mt = {__index = g41dc00}
function g41dc00.new(_ARG_0_)
  return setmetatable({}, g41dc00_mt)
end
function g41dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetMotion(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
  _UPVALUE0_ = Gimmick.GetExtraParam(_ARG_1_, "BoxDropRate") * 0.01
  WorkVec:set(22.82411, 1.0E-4, 0)
  Entity.SetEffect(_ARG_1_, "g_dc_manho0", "G_DC_MANHOLE0_0", WorkVec, WorkVec1)
end
function g41dc00.CanMainSkip(_ARG_0_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Player.GetHandle())) < _UPVALUE0_ or _ARG_0_.step == 1 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end
    return false
  end
  return true
end
function g41dc00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if Entity.GetName(_ARG_0_.myHandle) == "g41dc00" then
    if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
      if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
      else
        _ARG_0_.step = 0
      end
    else
      if _ARG_0_.step == 0 then
        Entity.SetMotion(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 1
      end
      return
    end
  end
  if _ARG_0_.step == 0 then
    if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
    else
      Entity.GetDamageCrossPos(WorkVec, _ARG_0_.myHandle)
      print("\142\134\144\129\144\225\130\204\131R\131}\131\147\131h\144\148" .. Player.CountCommand(COMMAND_KIND_Confetti) .. "\n")
      if Player.CountCommand(COMMAND_KIND_Confetti) == 0 then
        Entity.CreatePrizeBox(_ARG_0_.myHandle, WorkVec, PRIZE_KIND_PrizeBoxAS, COMMAND_KIND_Confetti)
      elseif Script.Random() < _UPVALUE0_ then
        Entity.CreatePrizeBox(_ARG_0_.myHandle, WorkVec, PRIZE_KIND_PrizeBoxAS, COMMAND_KIND_Confetti)
      else
        Gimmick.MakeDropPrize(_ARG_0_.myHandle, WorkVec)
      end
      Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
    end
    Entity.SetMotion(_ARG_0_.myHandle, 1)
    _ARG_0_.step = 1
  end
end
g42dc00 = {}
g42dc00_mt = {__index = g42dc00}
function g42dc00.new(_ARG_0_)
  return setmetatable({}, g42dc00_mt)
end
function g42dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetMotion(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
end
function g42dc00.CanMainSkip(_ARG_0_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Player.GetHandle())) < _UPVALUE0_ or _ARG_0_.step == 1 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end
    return false
  end
  return true
end
function g42dc00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_.step == 0 then
    if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
    else
      Entity.GetDamageCrossPos(WorkVec, _ARG_0_.myHandle)
      Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
      Gimmick.MakeDropPrize(_ARG_0_.myHandle, WorkVec)
    end
    Entity.SetMotion(_ARG_0_.myHandle, 1)
    _ARG_0_.step = 1
  end
end
EntityFactory:Add("g41dc00", function(_ARG_0_)
  return (g41dc00:new())
end)
EntityFactory:Add("g42dc00", function(_ARG_0_)
  return (g42dc00:new())
end)
EntityFactory:Add("g43dc00", function(_ARG_0_)
  return (g42dc00:new())
end)
EntityFactory:Add("g44dc00", function(_ARG_0_)
  return (g42dc00:new())
end)
EntityFactory:Add("g47dc00", function(_ARG_0_)
  return (g42dc00:new())
end)
EntityFactory:Add("g48dc00", function(_ARG_0_)
  return (g42dc00:new())
end)
