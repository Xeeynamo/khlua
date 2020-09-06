g16sw00 = {}
g16sw00.__index = g16sw00
function g16sw00.new(_ARG_0_)
  return setmetatable({}, g16sw00)
end
function g16sw00.IsOnRide(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 3)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
  _ARG_0_.workVec2:sety(0)
  if _ARG_0_.workVec2:dot(_ARG_0_.workVec2) <= Gimmick.GetExtraParam(_ARG_0_.myHandle, "JumpDist") * Gimmick.GetExtraParam(_ARG_0_.myHandle, "JumpDist") and _ARG_0_.workVec1:gety() - _ARG_0_.workVec0:gety() <= 1 then
    return true
  end
  return false
end
function g16sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.ridePlayer = NULL_HANDLE
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  _ARG_0_:createEffect2("g_sw_souti0", "G_SW_SOU_JMN0_0")
end
function g16sw00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if _ARG_0_:IsOnRide((Player.GetNearestPlayer())) then
      Player.NotifyGimmickJump(Player.GetNearestPlayer(), _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      Player.SetTrgFlagGeyser(Player.GetNearestPlayer(), 1)
      _ARG_0_.ridePlayer = Player.GetNearestPlayer()
      _ARG_0_:createEffect("g_sw_awa_00", "G_SW_0XX_AWA0_0")
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 and _ARG_0_:IsOnRide(_ARG_0_.ridePlayer) == false then
    _ARG_0_.step = 0
  end
end
function g16sw00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.ridePlayer)
  _ARG_0_.workVec1:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_0_.workVec0, _ARG_0_.workVec1)
end
function g16sw00.createEffect2(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 4)
  _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() - 0.3)
  _ARG_0_.workVec1:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_0_.workVec0, _ARG_0_.workVec1)
end
function g16sw00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  return 1
end
EntityFactory:Add("g16sw00", function(_ARG_0_)
  return (g16sw00:new())
end)
