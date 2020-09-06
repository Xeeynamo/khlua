workVec0 = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
G28DC_MAKERON_FLAG = 0
G24DC_MAKERON_FLAG = 0
G56DC_MAKERON_FLAG = 0
G23CD_CAMERA_HANDLE = NULL_HANDLE
G23CD_PLAYER_HANDLE = NULL_HANDLE
G23CD_GUIDE_HANDLE = NULL_HANDLE
G23DC_2D_HANDLE = NULL_HANDLE
G23DC_2D_WAITTIME = 0
g23dc00 = {}
g23dc00.__index = g23dc00
function g23dc00.new(_ARG_0_)
  return setmetatable({}, g23dc00)
end
function g23dc00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsMotionEnd(_ARG_0_.myHandle) and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.ridePlayer = _ARG_1_
  else
  end
end
function g23dc00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.isRide = true
    _ARG_0_.riderHandle = _ARG_1_
    Entity.EnableRideColl(G23CD_GUIDE_HANDLE, 1, 0)
  end
end
function g23dc00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.isRide = false
    _ARG_0_.riderHandle = NULL_HANDLE
  end
end
function g23dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.isRide = false
  _ARG_0_.riderHandle = NULL_HANDLE
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.ridePlayer = NULL_HANDLE
  _ARG_0_.hitflag = 0
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  _ARG_0_.bumpertype = 0
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 4)
  Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_JUMP_STAND)
  Gimmick.SetJumpStand(_ARG_1_, 1)
  _UPVALUE0_ = NULL_HANDLE
  _UPVALUE1_ = NULL_HANDLE
  _UPVALUE2_ = NULL_HANDLE
  _UPVALUE3_ = NULL_HANDLE
  _UPVALUE4_ = NULL_HANDLE
  _UPVALUE5_ = NULL_HANDLE
  _UPVALUE6_ = NULL_HANDLE
  G23CD_CAMERA_HANDLE = NULL_HANDLE
end
function g23dc00.OnTrigger(_ARG_0_, _ARG_1_)
  if _ARG_0_.step == 0 then
    _ARG_0_.step = 1
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
  end
end
function g23dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    Entity.GetWorldPos(_ARG_0_.workVec0, Player.GetNearestPlayer())
    Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle, 4)
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Player.GetNearestPlayer()) < 6.25 and _ARG_0_.workVec0:gety() - _ARG_0_.workVec1:gety() < 2 and _ARG_0_.workVec0:gety() - _ARG_0_.workVec1:gety() > -2 then
      _ARG_0_.step = 1
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end
  elseif _ARG_0_.step == 1 then
    Entity.GetWorldPos(_ARG_0_.workVec0, Player.GetNearestPlayer())
    if Entity.IsMotionEnd(_ARG_0_.myHandle) or _ARG_0_.workVec0:gety() < -28.5 then
      _ARG_0_.step = 2
    end
    if Entity.IsPlayer(_ARG_0_.riderHandle) then
      Player.NotifyGimmickJump(_ARG_0_.riderHandle, _ARG_0_.myHandle, 1)
    end
  elseif _ARG_0_.step == 2 then
    if Entity.IsPlayer(_ARG_0_.riderHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, Player.GetNearestPlayer()) > 16 then
      Player.NotifyGimmickJump(_ARG_0_.riderHandle, _ARG_0_.myHandle, 1)
      _ARG_0_.step = 3
    end
  elseif _ARG_0_.step == 3 then
    Player.NotifyGimmickJump(_ARG_0_.riderHandle, _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
    Entity.GetWorldPos(_ARG_0_.workVec0, Player.GetNearestPlayer())
    Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle, 4)
    if _ARG_0_.isRide == false then
      _ARG_0_.step = 4
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
    end
  elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
  _ARG_0_.ridePlayer = NULL_HANDLE
end
g24dc00 = {}
g24dc00.__index = g24dc00
function g24dc00.new(_ARG_0_)
  return setmetatable({}, g24dc00)
end
function g24dc00.new(_ARG_0_)
  return setmetatable({}, g24dc00)
end
function g24dc00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID and G23DC_2D_WAITTIME < 0 then
    _ARG_0_.workVec0:set(0, 2, 1)
    Entity.GetWorldPos2(_ARG_0_.workVec0, _ARG_0_.myHandle, _ARG_0_.workVec0, 1)
    Sprite2D.SetCtrl3DPos(G23DC_2D_HANDLE, _ARG_0_.workVec0)
    if G24DC_MAKERON_FLAG == 0 then
      Sprite2D.SetLayCtrlIDX(G23DC_2D_HANDLE, 3, CTRL_IN_2D)
      G24DC_MAKERON_FLAG = 1
    end
  end
end
function g24dc00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID and G24DC_MAKERON_FLAG == 1 then
    Sprite2D.SetLayCtrlIDX(G23DC_2D_HANDLE, 3, CTRL_OUT_2D)
    G24DC_MAKERON_FLAG = 0
    G23DC_2D_WAITTIME = 30
  end
end
function g24dc00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Player.GetPlayerState(Player.GetHandle()) == 35 then
    return
  end
  if _ARG_0_.jumpFrag ~= 1 then
    return
  end
  if _ARG_0_.hitWait < 0 and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.hitWait = 30
    _ARG_0_.ridePlayer = Player.GetNearestPlayer()
    createEffect(_ARG_0_.ridePlayer, _ARG_0_.myHandle, "g_dc_pinb_0", "G_DC_PIN_SSH0_0")
    _ARG_0_.workVec1:set(0, 1, 0)
    FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.workVec1)
    _ARG_0_.workVec1:setx(_ARG_0_.workVec0:getx())
    FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
    FVECTOR3.normalize(_ARG_0_.workVec2)
    _ARG_0_.workVec2:scale(-Gimmick.GetJumpStandPower(_UPVALUE0_))
    _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
    _ARG_0_.workVec2:setz(_ARG_0_.workVec2:getz() + Pad.GetAnalogLX() * 0.0078125 * -1 * _ARG_0_.hitPowUpX)
    Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
  end
end
function g24dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.spr2DHandle = NULL_HANDLE
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.hitPowUpX = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  if _ARG_0_.hitPowUpX == 0 then
    _ARG_0_.hitPowUpX = 10
  end
  _ARG_0_.hitPowUpY = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  if _ARG_0_.hitPowUpY == 0 then
    _ARG_0_.hitPowUpY = 10
  end
  _UPVALUE0_ = _ARG_1_
  _ARG_0_.ridePlayer = 0
  _ARG_0_.hitflag = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.bumpertype = 0
  _ARG_0_.jumpFrag = 0
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  Entity.AttachRideCollision(_ARG_1_, 1, 2)
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_FLIPPER)
  Sprite2D.SetDispDefault(true)
  G23DC_2D_HANDLE = Sprite2D.CreateLay("bynlr_00", 1, CTRL_OUT_2D)
  Sprite2D.SetCtrlIDX(G23DC_2D_HANDLE, CTRL_OUT_2D)
  Sprite2D.EnableCtrl3DTo2D(G23DC_2D_HANDLE, 1)
  _ARG_0_.sp2DFlag = 0
  _ARG_0_.workVec0:set(0, 2, 1)
  Entity.GetWorldPos2(_ARG_0_.workVec0, _ARG_0_.myHandle, _ARG_0_.workVec0, 1)
  Sprite2D.SetCtrl3DPos(G23DC_2D_HANDLE, _ARG_0_.workVec0)
end
function g24dc00.OnUpdate(_ARG_0_)
  if Pad.IsButtonDown(PAD_R1) ~= 0 then
    if G23CD_CAMERA_HANDLE ~= NULL_HANDLE and _ARG_0_.jumpFrag == 0 then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.jumpFrag = 1
    end
  elseif _ARG_0_.jumpFrag == 2 then
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
    Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.jumpFrag = 0
  end
  if _UPVALUE0_ == Entity.GetCurrentMotion(_ARG_0_.myHandle) and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
    Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.jumpFrag = 2
  end
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  G23DC_2D_WAITTIME = G23DC_2D_WAITTIME - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
g56dc00 = {}
g56dc00.__index = g56dc00
function g56dc00.new(_ARG_0_)
  return setmetatable({}, g56dc00)
end
function g56dc00.new(_ARG_0_)
  return setmetatable({}, g56dc00)
end
function g56dc00.OnRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID and G23DC_2D_WAITTIME < 0 then
    _ARG_0_.workVec0:set(0, 2, -1)
    Entity.GetWorldPos2(_ARG_0_.workVec0, _ARG_0_.myHandle, _ARG_0_.workVec0, 1)
    Sprite2D.SetCtrl3DPos(G23DC_2D_HANDLE, _ARG_0_.workVec0)
    if G56DC_MAKERON_FLAG == 0 then
      Sprite2D.SetLayCtrlIDX(G23DC_2D_HANDLE, 2, CTRL_IN_2D)
      G56DC_MAKERON_FLAG = 1
    end
  end
end
function g56dc00.OnRiderLeave(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID and G56DC_MAKERON_FLAG == 1 then
    Sprite2D.SetLayCtrlIDX(G23DC_2D_HANDLE, 2, CTRL_OUT_2D)
    G56DC_MAKERON_FLAG = 0
    G23DC_2D_WAITTIME = 30
  end
end
function g56dc00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.jumpFrag ~= 1 then
    return
  end
  if _ARG_0_.hitWait < 0 and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.hitWait = 30
    _ARG_0_.ridePlayer = Player.GetNearestPlayer()
    createEffect(_ARG_0_.ridePlayer, _ARG_0_.myHandle, "g_dc_pinb_0", "G_DC_PIN_SSH0_0")
    _ARG_0_.workVec1:set(0, 1, 0)
    FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.workVec1)
    _ARG_0_.workVec1:setx(_ARG_0_.workVec0:getx())
    FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
    FVECTOR3.normalize(_ARG_0_.workVec2)
    _ARG_0_.workVec2:scale(-Gimmick.GetJumpStandPower(_UPVALUE0_))
    _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
    _ARG_0_.workVec2:setz(_ARG_0_.workVec2:getz() + Pad.GetAnalogLX() * 0.0078125 * -1 * _ARG_0_.hitPowUpX)
    Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
  end
end
function g56dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.hitPowUpX = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  if _ARG_0_.hitPowUpX == 0 then
    _ARG_0_.hitPowUpX = 10
  end
  _ARG_0_.hitPowUpY = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  if _ARG_0_.hitPowUpY == 0 then
    _ARG_0_.hitPowUpY = 10
  end
  _UPVALUE0_ = _ARG_1_
  _ARG_0_.ridePlayer = 0
  _ARG_0_.hitflag = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.bumpertype = 0
  _ARG_0_.jumpFrag = 0
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  Entity.AttachRideCollision(_ARG_1_, 1, 2)
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_FLIPPER)
  Sprite2D.SetCtrlPos(G23DC_2D_HANDLE, 0, 0)
  _ARG_0_.sp2DFlag = 0
end
function g56dc00.OnUpdate(_ARG_0_)
  if Pad.IsButtonDown(PAD_L1) ~= 0 then
    if G23CD_CAMERA_HANDLE ~= NULL_HANDLE and _ARG_0_.jumpFrag == 0 then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.jumpFrag = 1
    end
  elseif _ARG_0_.jumpFrag == 2 then
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
    Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.jumpFrag = 0
  end
  if _UPVALUE0_ == Entity.GetCurrentMotion(_ARG_0_.myHandle) and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
    Entity.SetMotionSpeed(_ARG_0_.myHandle, _UPVALUE1_)
    _ARG_0_.jumpFrag = 2
  end
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
end
g25dc00 = {}
g25dc00.__index = g25dc00
function g25dc00.new(_ARG_0_)
  return setmetatable({}, g25dc00)
end
function g25dc00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Player.GetPlayerState(Player.GetHandle()) == 35 then
    return
  end
  if _ARG_0_.hitWait < 0 and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.hitWait = 30
    _ARG_0_.blinkingFrame = 6
    changeModel(_ARG_0_, 1)
    _ARG_0_.ridePlayer = Player.GetNearestPlayer()
    createEffect(_ARG_0_.ridePlayer, _ARG_0_.myHandle, "g_dc_pinb_0", "G_DC_PIN_HIT0_0")
    Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.ridePlayer, 5)
    Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
    _ARG_0_.workVec1:setx(_ARG_0_.workVec0:getx())
    FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
    FVECTOR3.normalize(_ARG_0_.workVec2)
    _ARG_0_.workVec2:scale(Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
    _ARG_0_.workVec2:setx(0)
    _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
    _ARG_0_.workVec2:setz(_ARG_0_.workVec2:getz() + Pad.GetAnalogLX() * 0.0078125 * -1 * _ARG_0_.hitPowUpX)
    Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
    Entity.EnableRideColl(G23CD_GUIDE_HANDLE, 0, 0)
  end
end
function g25dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitPowUpX = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  if _ARG_0_.hitPowUpX == 0 then
    _ARG_0_.hitPowUpX = 10
  end
  _ARG_0_.hitPowUpY = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  if _ARG_0_.hitPowUpY == 0 then
    _ARG_0_.hitPowUpY = 10
  end
  _ARG_0_.step = 0
  _ARG_0_.blinkingFrame = 0
  _ARG_0_.ridePlayer = 0
  _ARG_0_.hitflag = 0
  changeModel(_ARG_0_, 0)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  _ARG_0_.bumpertype = 0
  _ARG_0_.hitWait = 0
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BUMPER_A)
end
function g25dc00.OnUpdate(_ARG_0_)
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.blinkingFrame = _ARG_0_.blinkingFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.blinkingFrame < 0 then
    changeModel(_ARG_0_, 0)
  end
end
g26dc00 = {}
g26dc00.__index = g26dc00
function g26dc00.new(_ARG_0_)
  return setmetatable({}, g26dc00)
end
function g26dc00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Player.GetPlayerState(Player.GetHandle()) == 35 then
    return
  end
  if _ARG_0_.hitWait < 0 and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.hitWait = 30
    _ARG_0_.blinkingFrame = 6
    changeModel(_ARG_0_, 1)
    _ARG_0_.ridePlayer = Player.GetNearestPlayer()
    createEffect(_ARG_0_.ridePlayer, _ARG_0_.myHandle, "g_dc_pinb_0", "G_DC_PIN_HIT0_0")
    Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.ridePlayer, 5)
    Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
    _ARG_0_.workVec1:setx(_ARG_0_.workVec0:getx())
    FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
    FVECTOR3.normalize(_ARG_0_.workVec2)
    _ARG_0_.workVec2:scale(Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
    _ARG_0_.workVec2:setx(0)
    _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
    _ARG_0_.workVec2:setz(_ARG_0_.workVec2:getz() + Pad.GetAnalogLX() * 0.0078125 * -1 * _ARG_0_.hitPowUpX)
    Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
    Entity.EnableRideColl(G23CD_GUIDE_HANDLE, 0, 0)
    if _ARG_0_.step == 0 then
      if _UPVALUE0_ == 0 then
        Entity.EnableModelDisp(_UPVALUE1_, 3, 0)
        Entity.EnableModelDisp(_UPVALUE1_, 7, 1)
        Entity.AttachEffectInIndex(_UPVALUE1_, "g_dc_pinb_0", "G_DC_PIN_LIG2_0", 3)
        Sound.PlaySe(59, 5)
      elseif _UPVALUE0_ == 1 then
        Entity.EnableModelDisp(_UPVALUE1_, 4, 0)
        Entity.EnableModelDisp(_UPVALUE1_, 8, 1)
        Entity.AttachEffectInIndex(_UPVALUE1_, "g_dc_pinb_0", "G_DC_PIN_LIG2_0", 4)
        Sound.PlaySe(59, 5)
      elseif _UPVALUE0_ == 2 then
        Entity.EnableModelDisp(_UPVALUE1_, 5, 0)
        Entity.EnableModelDisp(_UPVALUE1_, 9, 1)
        Entity.AttachEffectInIndex(_UPVALUE1_, "g_dc_pinb_0", "G_DC_PIN_LIG2_0", 5)
        Sound.PlaySe(59, 5)
      elseif _UPVALUE0_ == 3 then
        Entity.EnableModelDisp(_UPVALUE1_, 6, 0)
        Entity.EnableModelDisp(_UPVALUE1_, 10, 1)
        Entity.AttachEffectInIndex(_UPVALUE1_, "g_dc_pinb_0", "G_DC_PIN_LIG2_0", 6)
        Sound.PlaySe(59, 6)
      end
      _UPVALUE0_ = _UPVALUE0_ + 1
      if _UPVALUE0_ > 4 then
        _UPVALUE0_ = 4
      end
      _ARG_0_.step = 1
    end
  end
end
function g26dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.ridePlayer = 0
  _ARG_0_.hitflag = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.blinkingFrame = 0
  _ARG_0_.hitPowUpX = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  if _ARG_0_.hitPowUpX == 0 then
    _ARG_0_.hitPowUpX = 10
  end
  changeModel(_ARG_0_, 0)
  _ARG_0_.hitPowUpY = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  if _ARG_0_.hitPowUpY == 0 then
    _ARG_0_.hitPowUpY = 10
  end
  _ARG_0_.bumpertype = 0
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BUMPER_B)
end
function g26dc00.OnUpdate(_ARG_0_)
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  _ARG_0_.blinkingFrame = _ARG_0_.blinkingFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.blinkingFrame < 0 then
    changeModel(_ARG_0_, 0)
  end
end
g27dc00 = {}
g27dc00.__index = g27dc00
function g27dc00.new(_ARG_0_)
  return setmetatable({}, g27dc00)
end
function g27dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.angle = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraMoveNoPoint = {}
  _ARG_0_.cameraMoveNoPoint[0] = {y = 100, z = -5}
  _ARG_0_.cameraMoveNoPoint[1] = {y = 8, z = -5}
  _ARG_0_.cameraMoveNoPoint[2] = {y = 8, z = 25}
  _ARG_0_.BumperA_Handle1 = NULL_HANDLE
  _ARG_0_.BumperA_Handle2 = NULL_HANDLE
  _ARG_0_.BumperA_Handle3 = NULL_HANDLE
  _ARG_0_.BumperB_Handle1 = NULL_HANDLE
  _UPVALUE0_ = NULL_HANDLE
  _UPVALUE1_ = NULL_HANDLE
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_1_, "DropSpeed")
  Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE3_, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 3, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 6, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 7, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 8, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 9, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 10, 0)
  _UPVALUE4_ = _ARG_1_
end
function g27dc00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_.WorkVec:set(0, 0, DegToRad(_ARG_0_.angle))
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 7, _ARG_0_.WorkVec)
  _ARG_0_.angle = -2
end
function g27dc00.GateOpen(_ARG_0_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE0_, 0)
  Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
end
function g27dc00.BumperAttack(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.WorkVec:set(0, 0, -3.5)
  _ARG_0_.WorkVec:set(0, DegToRad(90), 0)
  Entity.SetRot(_ARG_1_, _ARG_0_.WorkVec)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, _ARG_2_)
  Entity.SetLocalPos(_ARG_1_, _ARG_0_.WorkVec)
end
function g27dc00.OnTrigger(_ARG_0_, _ARG_1_)
  if _ARG_1_ == _UPVALUE0_ then
    if G23CD_CAMERA_HANDLE == NULL_HANDLE then
      G23CD_PLAYER_HANDLE = Player.GetHandle()
      Entity.GetWorldPos(_ARG_0_.workVec0, Player.GetHandle())
      if _ARG_0_.workVec0:getz() < -5 then
        _ARG_0_.workVec0:setz(-5)
      elseif _ARG_0_.workVec0:getz() > 25 then
        _ARG_0_.workVec0:setz(25)
      end
      _UPVALUE1_:set(_ARG_0_.workVec0:getx() + 12, _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
      _UPVALUE2_:set(-10, _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
      G23CD_CAMERA_HANDLE = Camera.CameraCreate(_UPVALUE1_, _UPVALUE2_)
    end
    createCircleEffect(Player.GetHandle(), "g_dc_pinb_0", "G_DC_PIN_BAL0_0")
    createCircleAttackEffect(Player.GetHandle(), "g_dc_pinb_0", "G_DC_PIN_BAL1_0")
    Player.SetBattleFlagShootLockOff(1)
  elseif _ARG_1_ == _UPVALUE3_ then
    if G23CD_CAMERA_HANDLE ~= NULL_HANDLE then
      Camera.CameraGetCameraPos(_ARG_0_.workVec1, G23CD_CAMERA_HANDLE)
      Camera.CameraGetLookPos(_ARG_0_.workVec0, G23CD_CAMERA_HANDLE)
      Entity.GetWorldPos(_ARG_0_.workVec0, Player.GetHandle())
      _ARG_0_.workVec0:setx(_ARG_0_.workVec0:getx() - 10)
      Player.SetPCamEventTransfer(_ARG_0_.workVec1, _ARG_0_.workVec0)
      Camera.CameraDestroy(G23CD_CAMERA_HANDLE)
      G23CD_CAMERA_HANDLE = NULL_HANDLE
    end
    createCircleEffectEnd()
    Player.SetBattleFlagShootLockOff(0)
  elseif _ARG_1_ == _UPVALUE4_ then
    createCircleEffectEnd()
  elseif _ARG_1_ == _UPVALUE5_ then
    createCircleEffect(Player.GetHandle(), "g_dc_pinb_0", "G_DC_PIN_BAL0_0")
    createCircleAttackEffect(Player.GetHandle(), "g_dc_pinb_0", "G_DC_PIN_BAL1_0")
  elseif _ARG_1_ == _UPVALUE6_ and G23CD_CAMERA_HANDLE == NULL_HANDLE then
    G23CD_PLAYER_HANDLE = Player.GetHandle()
    Entity.GetWorldPos(_ARG_0_.workVec0, Player.GetHandle())
    if _ARG_0_.workVec0:getz() < -5 then
      _ARG_0_.workVec0:setz(-5)
    elseif _ARG_0_.workVec0:getz() > 25 then
      _ARG_0_.workVec0:setz(25)
    end
    _UPVALUE1_:set(_ARG_0_.workVec0:getx() + 12, _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
    _UPVALUE2_:set(-10, _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
    G23CD_CAMERA_HANDLE = Camera.CameraCreate(_UPVALUE1_, _UPVALUE2_)
    Player.SetBattleFlagShootLockOff(1)
  end
end
function g27dc00.OnUpdate(_ARG_0_)
  if Player.GetPlayerState(Player.GetHandle()) == 35 then
    createCircleEffectEnd()
  end
  if _ARG_0_.step == 0 then
    _ARG_0_.BumperA_Handle1 = Gimmick.SearchGimmick(21)
    _UPVALUE0_ = _ARG_0_.BumperA_Handle1
    _ARG_0_.BumperA_Handle2 = Gimmick.SearchGimmick(20)
    _UPVALUE1_ = _ARG_0_.BumperA_Handle2
    _UPVALUE2_ = _ARG_0_.BumperA_Handle3
    _ARG_0_.BumperB_Handle1 = Gimmick.SearchGimmick(4)
    _UPVALUE3_ = _ARG_0_.BumperB_Handle1
    _ARG_0_.step = 1
  end
  _ARG_0_:BumperAttack(_ARG_0_.BumperA_Handle1, 10)
  _ARG_0_:BumperAttack(_ARG_0_.BumperA_Handle2, 9)
  _ARG_0_:BumperAttack(_ARG_0_.BumperB_Handle1, 8)
  if _UPVALUE4_ >= 4 then
    _ARG_0_:GateOpen()
  end
  if G23CD_CAMERA_HANDLE ~= NULL_HANDLE then
    Entity.GetWorldPos(_ARG_0_.workVec0, G23CD_PLAYER_HANDLE)
    if _ARG_0_.cameraMoveNoPoint[2].z < _ARG_0_.workVec0:getz() then
      print("\131J\131\129\131\137\136\218\147\174\150\179\140\248\131|\131C\131\147\131g2\n")
    end
    Camera.CameraGetCameraPos(_UPVALUE5_, G23CD_CAMERA_HANDLE)
    _ARG_0_.WorkVec0:set(_ARG_0_.workVec0:getx() + 12, _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
    _ARG_0_.WorkVec1:set(_UPVALUE5_:getx(), _UPVALUE5_:gety(), _UPVALUE5_:getz())
    FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.WorkVec0, _ARG_0_.WorkVec1)
    _ARG_0_.workVec0:set(_ARG_0_.workVec0:getx() + 12, _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
    _UPVALUE6_:set(_ARG_0_.workVec0:getx() - 1, _ARG_0_.workVec0:gety() + (_UPVALUE5_:gety() - _ARG_0_.workVec0:gety()) * 0.02, _ARG_0_.workVec0:getz() + (_UPVALUE5_:getz() - _ARG_0_.workVec0:getz()) * 0.02)
    if 2 == 1 then
      _ARG_0_.workVec0:setz(_UPVALUE5_:getz())
      _UPVALUE6_:setz(_UPVALUE5_:getz())
    elseif 2 == 2 then
      _ARG_0_.workVec0:setz(_UPVALUE5_:getz())
      Entity.GetWorldPos(workVec0, G23CD_PLAYER_HANDLE)
      _UPVALUE6_:set(workVec0:getx(), _ARG_0_.workVec0:gety(), workVec0:getz())
    end
    Camera.CameraSetPos(G23CD_CAMERA_HANDLE, _ARG_0_.workVec0)
    _UPVALUE5_:set(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:gety(), _ARG_0_.workVec0:getz())
    Camera.CameraSetView(G23CD_CAMERA_HANDLE, _UPVALUE6_)
    Camera.SetCameraViewAngle(G23CD_CAMERA_HANDLE, DegToRad(60))
  end
end
g28dc00 = {}
g28dc00.__index = g28dc00
function g28dc00.new(_ARG_0_)
  return setmetatable({}, g28dc00)
end
function g28dc00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if Player.GetPlayerState(Player.GetHandle()) == 35 then
    return
  end
  if _ARG_0_.hitWait < 0 and Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID then
    _ARG_0_.hitWait = 30
    _ARG_0_.ridePlayer = Player.GetNearestPlayer()
    createEffect(_ARG_0_.ridePlayer, _ARG_0_.myHandle, "g_dc_pinb_0", "G_DC_PIN_HIT1_0")
    Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.ridePlayer)
    if _ARG_0_.workVec0:getz() < 15 and _ARG_0_.workVec0:getz() > 4 then
      _ARG_0_.workVec1:set(0, 1, 0)
    else
      Entity.GetRideWallNormal(_ARG_0_.workVec1, Player.GetHandle())
    end
    FVECTOR3.Add(_ARG_0_.workVec1, _ARG_0_.workVec0, _ARG_0_.workVec1)
    _ARG_0_.workVec1:setx(_ARG_0_.workVec0:getx())
    FVECTOR3.Sub(_ARG_0_.workVec2, _ARG_0_.workVec0, _ARG_0_.workVec1)
    FVECTOR3.normalize(_ARG_0_.workVec2)
    _ARG_0_.workVec2:scale(-Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
    _ARG_0_.workVec2:sety(_ARG_0_.workVec2:gety() + Pad.GetAnalogLY() * 0.0078125 * -1 * _ARG_0_.hitPowUpY)
    _ARG_0_.workVec2:setz(_ARG_0_.workVec2:getz() + Pad.GetAnalogLX() * 0.0078125 * -1 * _ARG_0_.hitPowUpX)
    Player.SetGimmicBlow(_ARG_0_.ridePlayer, _ARG_0_.workVec2)
  end
end
function g28dc00.OnUpdate(_ARG_0_)
  _ARG_0_.hitWait = _ARG_0_.hitWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if Player.IsNowInputOn(Player.GetHandle()) == 0 then
    if G28DC_MAKERON_FLAG == 1 then
      G24DC_MAKERON_FLAG = 0
      G56DC_MAKERON_FLAG = 0
      G28DC_MAKERON_FLAG = 0
    end
  elseif G28DC_MAKERON_FLAG == 0 then
    print("\131}\129[\131J\129[\131I\131t\129I\129I\129I")
    if G56DC_MAKERON_FLAG == 1 then
      Sprite2D.SetLayCtrlIDX(G23DC_2D_HANDLE, 2, CTRL_OUT_2D)
    end
    if G24DC_MAKERON_FLAG == 1 then
      Sprite2D.SetLayCtrlIDX(G23DC_2D_HANDLE, 3, CTRL_OUT_2D)
    end
    G28DC_MAKERON_FLAG = 1
  end
end
function g28dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.ridePlayer = 0
  _ARG_0_.hitflag = 0
  _ARG_0_.hitWait = 0
  _ARG_0_.bumpertype = 0
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  _ARG_0_.hitPowUpX = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
  if _ARG_0_.hitPowUpX == 0 then
    _ARG_0_.hitPowUpX = 10
  end
  _ARG_0_.hitPowUpY = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  if _ARG_0_.hitPowUpY == 0 then
    _ARG_0_.hitPowUpY = 10
  end
  print("g28dc00:OnInit\n")
  if Entity.GetName(_ARG_1_) == "g28dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_SLINGSHOT)
  elseif Entity.GetName(_ARG_1_) == "g24dc00" or Entity.GetName(_ARG_1_) == "g56dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_FLIPPER)
  elseif Entity.GetName(_ARG_1_) == "g25dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BUMPER_A)
  elseif Entity.GetName(_ARG_1_) == "g26dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BUMPER_B)
    if _UPVALUE0_ == 0 then
      _UPVALUE1_ = _ARG_1_
      _ARG_0_.bumpertype = _UPVALUE2_
      print("BumperB Handle::" .. _UPVALUE1_ .. "\n")
    elseif _UPVALUE0_ == 1 then
      _UPVALUE3_ = _ARG_1_
      _ARG_0_.bumpertype = _UPVALUE4_
      print("BumperB Handle::" .. _UPVALUE3_ .. "\n")
    elseif _UPVALUE0_ == 2 then
      _UPVALUE5_ = _ARG_1_
      _ARG_0_.bumpertype = _UPVALUE6_
      print("BumperB Handle::" .. _UPVALUE5_ .. "\n")
    elseif _UPVALUE0_ == 3 then
      _UPVALUE7_ = _ARG_1_
      _ARG_0_.bumpertype = _UPVALUE8_
      print("BumperB Handle::" .. _UPVALUE7_ .. "\n")
    end
    _UPVALUE0_ = _UPVALUE0_ + 1
  elseif Entity.GetName(_ARG_1_) == "g27dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_GATE)
  elseif Entity.GetName(_ARG_1_) == "g28dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BLOC_A)
  elseif Entity.GetName(_ARG_1_) == "g29dc00" then
    Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BLOC_B)
  end
end
g46dc00 = {}
g46dc00.__index = g46dc00
function g46dc00.new(_ARG_0_)
  return setmetatable({}, g46dc00)
end
function g46dc00.OnUpdate(_ARG_0_)
end
function g46dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  G23CD_GUIDE_HANDLE = _ARG_0_.myHandle
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
end
EntityFactory:Add("g23dc00", function(_ARG_0_)
  return (g23dc00:new())
end)
EntityFactory:Add("g24dc00", function(_ARG_0_)
  return (g24dc00:new())
end)
EntityFactory:Add("g56dc00", function(_ARG_0_)
  return (g56dc00:new())
end)
EntityFactory:Add("g25dc00", function(_ARG_0_)
  return (g25dc00:new())
end)
EntityFactory:Add("g26dc00", function(_ARG_0_)
  return (g26dc00:new())
end)
EntityFactory:Add("g27dc00", function(_ARG_0_)
  return (g27dc00:new())
end)
EntityFactory:Add("g28dc00", function(_ARG_0_)
  return (g28dc00:new())
end)
EntityFactory:Add("g29dc00", function(_ARG_0_)
  return (g28dc00:new())
end)
EntityFactory:Add("g46dc00", function(_ARG_0_)
  return (g46dc00:new())
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
  Entity.EnableModelDisp(_UPVALUE0_, 2, 0)
  Entity.EnableModelDisp(_UPVALUE0_, 5, 0)
  Entity.EnableModelDisp(_UPVALUE1_, 2, 0)
  Entity.EnableModelDisp(_UPVALUE1_, 5, 0)
  Entity.EnableModelDisp(_UPVALUE2_, 2, 0)
  Entity.EnableModelDisp(_UPVALUE2_, 5, 0)
end
function createEffect(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(workVec0, _ARG_0_)
  Entity.GetRot(workVec1, _ARG_0_)
  Entity.SetEffect(_ARG_0_, _ARG_2_, _ARG_3_, workVec0, workVec1)
  Entity.GetWorldPos(workVec0, _ARG_0_, 3)
  Gimmick.MakePraize(_ARG_1_, workVec0, 0.01, 0.2 * _UPVALUE0_)
end
function createCircleEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  if Effect.IsAlive(_UPVALUE0_) then
  else
    _UPVALUE0_ = Entity.AttachEffect(_ARG_0_, _ARG_1_, _ARG_2_, "center")
  end
end
function createCircleAttackEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  if Effect.IsAlive(_UPVALUE0_) then
  else
    _UPVALUE0_ = Entity.AttachEffect(_ARG_0_, _ARG_1_, _ARG_2_, "center")
  end
end
function createCircleEffectEnd()
  if Effect.IsAlive(_UPVALUE0_) then
    Effect.LoopEnd(_UPVALUE0_)
  end
  if Effect.IsAlive(_UPVALUE1_) then
    Effect.LoopEnd(_UPVALUE1_)
  end
end
