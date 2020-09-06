g15rg00 = {}
g15rg00_mt = {__index = g15rg00}
function g15rg00.new(_ARG_0_)
  return setmetatable({}, g15rg00_mt)
end
function g15rg00.GetLockOnPos(_ARG_0_)
  _UPVALUE0_:set(0, _ARG_0_.lockoffsety, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _UPVALUE0_)
  return _UPVALUE0_
end
function g15rg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.jumpY = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  print("self.jumpY = " .. _ARG_0_.jumpY .. "\n")
  _ARG_0_.dist_jump = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  _ARG_0_.dist_jump = _ARG_0_.dist_jump * _ARG_0_.dist_jump
  print("self.dist_jump = " .. _ARG_0_.dist_jump .. "\n")
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_0_.myHandle, 9)
  _ARG_0_.lockoffsety = Gimmick.GetExtraParam(_ARG_0_.myHandle, "LockY")
  Entity.SetNoSetHitEffect(_ARG_0_.myHandle, 1)
end
function g15rg00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, Player.GetNearestPlayer())
  _UPVALUE1_:set(0, 0, 0)
  Entity.SetEffect(Player.GetNearestPlayer(), _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g15rg00.OnUpdate(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, Player.GetNearestPlayer())
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Player.GetNearestPlayer()) < _ARG_0_.dist_jump and _UPVALUE0_:gety() - _UPVALUE1_:gety() < _ARG_0_.jumpY then
      Entity.SetTimer(_ARG_0_.myHandle, 60)
      Player.NotifyGimmickJump(Player.GetNearestPlayer(), _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      Player.SetTrgFlagGeyser(Player.GetNearestPlayer(), 1)
      _ARG_0_:createEffect("g_rg_funsui", "G_RG_FUN_SIB0_0")
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
end
function g15rg00.OnDamage(_ARG_0_)
  Entity.GetDamageCrossPos(_UPVALUE0_, _ARG_0_.myHandle)
  _UPVALUE1_:set(0, 0, 0)
  _UPVALUE0_:set(0.5, 0.5, 0.5)
  Effect.GetScale(_UPVALUE0_, (Entity.SetEffect(_ARG_0_.myHandle, "g_rg_funsui", "G_RG_FUN_SIB0_0", _UPVALUE0_, _UPVALUE1_)))
  return 1
end
EntityFactory:Add("g15rg00", function(_ARG_0_)
  EntityManager:Add(g15rg00:new(), _ARG_0_)
  return (g15rg00:new())
end)
