g17vs00 = {}
g17vs00_mt = {__index = g17vs00}
function g17vs00.new(_ARG_0_)
  print("g17vs00 new \n")
  return setmetatable({}, g17vs00_mt)
end
function g17vs00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  print("OnRide \n")
  if Player.GetHandleForNet() == _ARG_1_ and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.isRide = true
    _ARG_0_.riderHandle = _ARG_1_
  end
end
function g17vs00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Player.GetHandleForNet() == _ARG_1_ and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.isRide = false
    _ARG_0_.riderHandle = 0
    if 0 > _ARG_0_.hitWait2 then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.hitWait2 = Entity.GetMotionTotalFrame(_ARG_0_.myHandle)
      _ARG_0_.step = 1
    end
  end
end
function g17vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.hitWait2 = 0
  _ARG_0_.riderHandle = NULL_HANDLE
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_0_.myHandle, 9)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 4)
end
function g17vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.riderHandle)
  _UPVALUE1_:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.riderHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g17vs00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 17 * Entity.GetFrameRate(_ARG_0_.myHandle) and _ARG_0_.isRide == true then
      Player.NotifyGimmickJump(_ARG_0_.riderHandle, _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      Player.SetTrgFlagGeyser(_ARG_0_.riderHandle, 1)
      _ARG_0_.hitWait = _ARG_0_.hitWait2
    end
  elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_.step = 0
  end
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.hitWait2 = _ARG_0_.hitWait2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
EntityFactory:Add("g17vs00", function(_ARG_0_)
  EntityManager:Add(g17vs00:new(), _ARG_0_)
  return (g17vs00:new())
end)
g22vs00 = {}
g22vs00_mt = {__index = g22vs00}
function g22vs00.new(_ARG_0_)
  return setmetatable({}, g22vs00_mt)
end
function g22vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
end
function g22vs00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g22vs00", function(_ARG_0_)
  EntityManager:Add(g22vs00:new(), _ARG_0_)
  return (g22vs00:new())
end)
g23vs00 = {}
g23vs00_mt = {__index = g23vs00}
function g23vs00.new(_ARG_0_)
  return setmetatable({}, g23vs00_mt)
end
function g23vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.jumpflag = 0
  _ARG_0_.riderHandle = NULL_HANDLE
  _ARG_0_.ridePlayer = NULL_HANDLE
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitPowUpX = 10
  _ARG_0_.hitPowUpY = 10
end
function g23vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.riderHandle)
  _UPVALUE1_:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.riderHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g23vs00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.hitWait < 0 then
    _ARG_0_.hitWait = 30
    if Player.GetHandleForNet() == _ARG_1_ then
      _ARG_0_.ridePlayer = _ARG_1_
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.ridePlayer)
      _ARG_0_.workVec1:set(0, 0, 0)
      if _ARG_0_.workVec0:getx() < 6 and _ARG_0_.workVec0:getx() > -6 then
        _ARG_0_.workVec1:set(0, 1, 0)
        _ARG_0_.jumpflag = 1
        Entity.SetMotion(_UPVALUE0_, _UPVALUE1_)
        Entity.SetMotionSpeed(_UPVALUE0_, 1.5)
        print("jumppower = " .. Gimmick.GetJumpStandPower(_UPVALUE0_) .. "\n")
      elseif _ARG_0_.workVec0:getx() > 6 then
        _ARG_0_.workVec1:setx(-0.7071689)
        _ARG_0_.workVec1:sety(0.7071689)
        _ARG_0_.workVec1:setz(5.7783027)
        print("jumppower = " .. Gimmick.GetJumpStandPower(_ARG_0_.myHandle) .. "\n")
      elseif _ARG_0_.workVec0:getx() < -6 then
        _ARG_0_.workVec1:setx(0.7071689)
        _ARG_0_.workVec1:sety(0.7071689)
        _ARG_0_.workVec1:setz(5.7783027)
        print("jumppower = " .. Gimmick.GetJumpStandPower(_ARG_0_.myHandle) .. "\n")
      end
      FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.workVec1)
      _ARG_0_.workVec1:setz(_ARG_0_.workVec0:getz())
      FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
      FVECTOR3.normalize(_ARG_0_.workVec2)
      _ARG_0_.workVec2:scale(-Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
      _ARG_0_.workVec2:setx(_ARG_0_.workVec2:getx() + Pad.GetAnalogLX() * 0.0078125 * _ARG_0_.hitPowUpX)
      Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
    end
  end
end
function g23vs00.OnUpdate(_ARG_0_)
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.jumpflag == 1 and Entity.IsMotionEnd(_UPVALUE0_) then
    Entity.SetMotion(_UPVALUE0_, _UPVALUE1_)
    Entity.SetMotionSpeed(_UPVALUE0_, 2)
    _ARG_0_.jumpflag = 0
  end
end
EntityFactory:Add("g23vs00", function(_ARG_0_)
  EntityManager:Add(g23vs00:new(), _ARG_0_)
  return (g23vs00:new())
end)
g26vs00 = {}
g26vs00_mt = {__index = g26vs00}
function g26vs00.new(_ARG_0_)
  return setmetatable({}, g26vs00_mt)
end
function g26vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.riderHandle = NULL_HANDLE
  _ARG_0_.blinkingFrame = 0
  _ARG_0_.ridePlayer = NULL_HANDLE
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitPowUpX = 10
  _ARG_0_.hitPowUpY = 10
  changeModel(_ARG_0_, 0)
end
function g26vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.riderHandle)
  _UPVALUE1_:set(0, 0, 0)
  Entity.SetEffect(_ARG_0_.riderHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g26vs00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.hitWait < 0 then
    _ARG_0_.hitWait = 30
    _ARG_0_.blinkingFrame = 6
    if Player.GetHandleForNet() == _ARG_1_ then
      changeModel(_ARG_0_, 1)
      _ARG_0_.ridePlayer = _ARG_1_
      Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.ridePlayer)
      _ARG_0_.workVec1:set(0, 0, 0)
      Entity.GetRideWallNormal(_ARG_0_.workVec1, _ARG_0_.ridePlayer)
      FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.workVec1)
      _ARG_0_.workVec1:setz(_ARG_0_.workVec0:getz())
      FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
      FVECTOR3.normalize(_ARG_0_.workVec2)
      _ARG_0_.workVec2:scale(-Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
      _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
      _ARG_0_.workVec2:setx(_ARG_0_.workVec2:getx() + Pad.GetAnalogLX() * 0.0078125 * _ARG_0_.hitPowUpX)
      Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
    end
  end
end
function g26vs00.OnUpdate(_ARG_0_)
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.blinkingFrame = _ARG_0_.blinkingFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.blinkingFrame < 0 then
    changeModel(_ARG_0_, 0)
  end
end
EntityFactory:Add("g26vs00", function(_ARG_0_)
  EntityManager:Add(g26vs00:new(), _ARG_0_)
  return (g26vs00:new())
end)
function changeModel(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 0 then
    Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 3, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 1)
  elseif _ARG_1_ == 1 then
    Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 3, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 1)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 1)
  end
end
