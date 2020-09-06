g15pp00 = {}
g15pp00_mt = {__index = g15pp00}
function g15pp00.new(_ARG_0_)
  return setmetatable({}, g15pp00_mt)
end
function g15pp00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    print("state = " .. Player.GetPlayerState(_ARG_1_) .. "\n")
    if Player.GetPlayerState(_ARG_1_) == 5 or Player.GetPlayerState(_ARG_1_) == 10 or Player.GetPlayerState(_ARG_1_) == 4 or Player.IsMuteki(_ARG_1_) then
    else
      Player.NotifyGimmickJump(_ARG_1_, _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      Player.SetTrgFlagGeyser(_ARG_1_, 1)
      Entity.SetMotion(_ARG_0_.myHandle, 1)
    end
  end
end
function g15pp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.isRide = false
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 25)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_JUMP_STAND)
  Gimmick.SetJumpStand(_ARG_1_, 1)
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.EnableLockon(_ARG_1_, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
end
function g15pp00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g15pp00", function(_ARG_0_)
  return (g15pp00:new())
end)
