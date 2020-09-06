g33vs00 = {}
g33vs00_base_mt = {__index = __StateMachine}
setmetatable(g33vs00, g33vs00_base_mt)
g33vs00_mt = {__index = g33vs00}
function g33vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g33vs00_mt)
end
function g33vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.effectHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.blinkingFrame = 0
  _ARG_0_.ridePlayer = 0
  _ARG_0_.hitflag = 0
  _ARG_0_.jumpPow = Gimmick.GetJumpStandPower(_ARG_0_.myHandle)
  _ARG_0_.jumpPow2 = Entity.GetLayoutParam(_ARG_1_, 6)
  _ARG_0_.HitColType = Entity.GetLayoutParam(_ARG_1_, 1)
  if _ARG_0_.HitColType == 1 then
    _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, _ARG_0_.HitColType, 0)
    Entity.EnableRideColl(_ARG_1_, 0, 0)
  else
    _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 1, 0)
    Entity.EnableRideColl(_ARG_1_, 0, 0)
  end
  _ARG_0_.bumpertype = 0
  _ARG_0_.hitWait = 0
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_JUMP_STAND)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 20.25)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 1)
end
function g33vs00.setJump(_ARG_0_, _ARG_1_)
  _ARG_0_.hitWait = 30
  _ARG_0_.blinkingFrame = 6
  _ARG_0_.ridePlayer = _ARG_1_
  createEffect(_ARG_0_.ridePlayer, _ARG_0_.myHandle, "g_dc_pinb_0", "G_DC_PIN_HIT0_0")
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.ridePlayer, 5)
  Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
  _UPVALUE1_:setx(_UPVALUE0_:getx())
  FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE1_)
  FVECTOR3.normalize(_UPVALUE2_)
  _UPVALUE2_:scale(Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
  Player.SetGimmicBlow(_ARG_0_.ridePlayer, _UPVALUE2_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "002")
end
function g33vs00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Player.GetPlayerState(_ARG_1_) == 5 or Player.GetPlayerState(_ARG_1_) == 10 or Player.GetPlayerState(_ARG_1_) == 17 or Player.GetPlayerState(_ARG_1_) == 16 or Player.GetPlayerState(_ARG_1_) == 4 or Player.IsMuteki(_ARG_1_) then
    return
  end
  if _ARG_0_.hitWait < 0 and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    Entity.GetWorldPos(_UPVALUE0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    if _UPVALUE0_:gety() > _UPVALUE1_:gety() + 0.5 then
      Player.NotifyGimmickJump(_ARG_1_, _ARG_0_.myHandle, _ARG_0_.jumpPow2)
      Player.SetTrgFlagGeyser(_ARG_1_, 1)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "002")
    else
      _ARG_0_:setJump(_ARG_1_)
    end
  else
  end
end
function g33vs00.OnDamage(_ARG_0_, _ARG_1_)
  if Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle))) ~= nil then
  end
  print("name = " .. Entity.GetName(Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle)))) .. "\n")
  if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle)))) < 9 then
    if Player.IsMuteki((Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle))))) then
      return 1
    end
    if 0 > _ARG_0_.hitWait and Entity.IsPlayer((Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle))))) then
      _ARG_0_:setJump((Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle)))))
    end
  end
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "002")
  return 1
end
function g33vs00.OnUpdate(_ARG_0_)
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.hitWait < 0 then
    Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle())
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    if _UPVALUE0_:gety() < _UPVALUE1_:gety() + 0.5 and Entity.CalcDistance(_ARG_0_.myHandle, Player.GetHandle()) < 2 then
      _ARG_0_:setJump(Player.GetHandle())
    end
  end
  if Entity.GetCurrentMotion(_ARG_0_.myHandle) == Entity.GetMotionIndex(_ARG_0_.myHandle, "002") and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    print("\131\130\129[\131V\131\135\131\147\130\240\131A\131C\131h\131\138\131\147\131O\130\214\n")
    Player.NotifyGimmickJump(Player.GetHandle(), NULL_HANDLE, -1)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 0)
  end
end
function g33vs00.OnDead(_ARG_0_)
  print("\142\128\150S.")
  return 1
end
EntityFactory:Add("g33vs00", function(_ARG_0_)
  return (g33vs00:new())
end)
function createEffect(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_)
  Entity.GetRot(_UPVALUE1_, _ARG_0_)
  Entity.SetEffect(_ARG_0_, _ARG_2_, _ARG_3_, _UPVALUE0_, _UPVALUE1_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_, 3)
end
