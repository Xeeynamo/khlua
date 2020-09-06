g16vs00 = {}
g16vs00_mt = {__index = g16vs00}
function g16vs00.new(_ARG_0_)
  return setmetatable({}, g16vs00_mt)
end
function g16vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.jumpdist = Entity.GetLayoutParam(_ARG_1_, 6)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.plPos = FVECTOR3.new(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  _ARG_0_.soundhandle = Sound.PlaySe(281, 1, 1, _ARG_0_.myPos)
end
function g16vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.riderHandle)
  _UPVALUE1_:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.riderHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g16vs00.OnUpdate(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.plPos, (Player.GetHandleForNet()))
  _ARG_0_.myPos:sety(_ARG_0_.plPos:gety())
  Sound.SetPosition(_ARG_0_.soundhandle, _ARG_0_.myPos)
  if Player.IsBattleFlagArenaBattlePlay() == 1 and Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Player.GetHandleForNet()) < _ARG_0_.jumpdist * _ARG_0_.jumpdist then
    Player.NotifyGimmickJump(Player.GetHandleForNet(), _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
    Player.SetTrgFlagGeyser(Player.GetHandleForNet(), 1)
  end
end
function g16vs00.CanMainSkip(_ARG_0_)
  if Player.IsBattleFlagArenaBattlePlay() == 1 then
    return false
  else
    return true
  end
end
EntityFactory:Add("g16vs00", function(_ARG_0_)
  EntityManager:Add(g16vs00:new(), _ARG_0_)
  return (g16vs00:new())
end)
