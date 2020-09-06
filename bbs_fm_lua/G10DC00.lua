workVec0 = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
G10DC_GEARONFLAG = 0
G10DC_PISTONFLAG = 0
g10dc00 = {}
g10dc00.__index = g10dc00
function g10dc00.new(_ARG_0_)
  return setmetatable({}, g10dc00)
end
function g10dc00.OnUpdate(_ARG_0_)
  if Player.IsBattleFlagPlayerDead() == true and _ARG_0_.camera ~= NULL_HANDLE then
    Script.OutTask(_ARG_0_.camera)
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.step = 4
    Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
    Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
    Script.EnablePauseChecker()
  end
  if _UPVALUE0_ == 0 then
    _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.powerAngle <= _ARG_0_.nowPower then
      _ARG_0_.powerAngle = _ARG_0_.nowPower
    else
      _ARG_0_.powerAngle = _ARG_0_.powerAngle - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
    if _ARG_0_.powerAngle < _ARG_0_.powerMaxAngle then
      _ARG_0_.powerAngle = _ARG_0_.powerMaxAngle
      Entity.AttachEffectInIndex(_ARG_0_.myHandle, "g_dc_010_00", "G_DC_010_DEN1_0", 0)
      print("g10dc\139N\147\174\129I\129I\129I\n")
      Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
      _UPVALUE0_ = 2
      Entity.SetTimer(_ARG_0_.myHandle, 30)
    end
    if _ARG_0_.nowPower < _ARG_0_.powerMaxAngle then
      _ARG_0_.nowPower = _ARG_0_.powerMaxAngle
    end
    if 0 > _ARG_0_.wait then
      _ARG_0_.powerAngle = _ARG_0_.powerAngle + _ARG_0_.subPower * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.powerAngle > _ARG_0_.initPower then
        _ARG_0_.powerAngle = _ARG_0_.initPower
      end
      _ARG_0_.nowPower = _ARG_0_.powerAngle
    end
  elseif _UPVALUE0_ == 2 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      _UPVALUE0_ = 1
      print("G10DC_ISMOVE On\n")
      _ARG_0_.cameraOnWait = 0
      _ARG_0_.camerastep = 1
      _ARG_0_.camera = Camera.CreateExusiaCamera("camera0")
      Camera.StartExusiaCamera(_ARG_0_.camera)
      Script.SetObjStop(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      Entity.GetWorldPos(workVec0, _UPVALUE1_, 1)
      Sound.PlaySe(59, 10, 1, workVec0)
      Script.DisablePauseChecker()
    end
  elseif _UPVALUE0_ == 1 then
    _ARG_0_.powerAngle = _ARG_0_.powerMaxAngle
    if _ARG_0_.camerastep == 0 then
      _ARG_0_.cameraOnWait = _ARG_0_.cameraOnWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 > _ARG_0_.cameraOnWait then
        _ARG_0_.camerastep = 1
        Entity.SetTimer(_ARG_0_.myHandle, 22)
      end
    elseif _ARG_0_.camerastep == 1 then
      _ARG_0_.camerastep = 2
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        G10DC_PISTONFLAG = 1
        _ARG_0_.camerastep = 2
      end
    elseif _ARG_0_.camerastep == 2 then
      if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
        Script.OutTask(_ARG_0_.camera)
        _ARG_0_.camera = NULL_HANDLE
        _ARG_0_.camera = Camera.CreateExusiaCamera("camera1")
        Camera.StartExusiaCamera(_ARG_0_.camera)
        _ARG_0_.camerastep = 3
      end
    elseif _ARG_0_.camerastep == 3 then
      if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
        Script.OutTask(_ARG_0_.camera)
        _ARG_0_.camera = NULL_HANDLE
        _ARG_0_.camerastep = 2
        Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
        Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
        Script.EnablePauseChecker()
        _ARG_0_.camerastep = 4
      end
    elseif _ARG_0_.camerastep == 4 then
    end
  end
end
function g10dc00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _UPVALUE0_ == 0 and _ARG_3_ == ATK_ATTR_THUNDER then
    Entity.AttachEffectInIndex(_ARG_0_.myHandle, "g_dc_010_00", "G_DC_010_DEN0_0", 0)
    _ARG_0_.nowPower = _ARG_0_.nowPower - _ARG_0_.addpower
    _ARG_0_.wait = _UPVALUE1_
  end
end
function g10dc00.OnUpdatePositionAfter(_ARG_0_)
  workVec0:set(0, 0, DegToRad(_ARG_0_.powerAngle))
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE0_, workVec0)
end
function g10dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
  _UPVALUE1_ = NULL_HANDLE
  _UPVALUE2_ = NULL_HANDLE
  _UPVALUE3_ = NULL_HANDLE
  _UPVALUE4_ = NULL_HANDLE
  _UPVALUE5_ = NULL_HANDLE
  _UPVALUE6_ = NULL_HANDLE
  _UPVALUE7_ = NULL_HANDLE
  _UPVALUE8_ = NULL_HANDLE
  _UPVALUE9_ = NULL_HANDLE
  _UPVALUE10_ = NULL_HANDLE
  _UPVALUE11_ = NULL_HANDLE
  _UPVALUE12_ = NULL_HANDLE
  _UPVALUE13_ = NULL_HANDLE
  _UPVALUE14_ = 0
  _UPVALUE15_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.camerastep = 0
  _ARG_0_.addpower, _ARG_0_.power = Entity.GetLayoutParam(_ARG_0_.myHandle, 2), 0
  _ARG_0_.initPower = 55
  _ARG_0_.powerAngle = 55
  _ARG_0_.nowPower = 55
  _ARG_0_.addmovepower = 1
  _ARG_0_.cameraOnWait = 0
  if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
    _UPVALUE14_ = 1
    _ARG_0_.camerastep = 99
    G10DC_GEARONFLAG = 1
    G10DC_PISTONFLAG = 1
    Entity.AttachEffectInIndex(_ARG_0_.myHandle, "g_dc_010_00", "G_DC_010_DEN1_0", 0)
  else
  end
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 7) == 0 then
  else
    _ARG_0_.addmovepower = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
  end
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 1) == 0 then
  else
    _ARG_0_.powerAngle, _ARG_0_.initPower = Entity.GetLayoutParam(_ARG_0_.myHandle, 1), Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  end
  _ARG_0_.subPower, _ARG_0_.powerMaxAngle = Entity.GetLayoutParam(_ARG_0_.myHandle, 5), _ARG_0_.powerAngle * -1
  _ARG_0_.wait = 0
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
end
g11dc00 = {}
g11dc00.__index = g11dc00
function g11dc00.new(_ARG_0_)
  return setmetatable({}, g11dc00)
end
function g11dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.stateWait < 0 then
      if _ARG_0_.startstep == 1 then
        _ARG_0_.step = _UPVALUE4_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      else
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      end
    end
    _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
function g11dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 5)
  Entity.AttachRideCollision(_ARG_1_, 1, 4)
  Entity.AttachRideCollision(_ARG_1_, 2, 3)
  Entity.AttachRideCollision(_ARG_1_, 3, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g12dc00 = {}
g12dc00.__index = g12dc00
function g12dc00.new(_ARG_0_)
  return setmetatable({}, g12dc00)
end
function g12dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.stateWait < 0 then
      if _ARG_0_.startstep == 1 then
        _ARG_0_.step = _UPVALUE4_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      else
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      end
    end
    _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
function g12dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 5)
  Entity.AttachRideCollision(_ARG_1_, 1, 4)
  Entity.AttachRideCollision(_ARG_1_, 2, 3)
  Entity.AttachRideCollision(_ARG_1_, 3, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g13dc00 = {}
g13dc00.__index = g13dc00
function g13dc00.new(_ARG_0_)
  return setmetatable({}, g13dc00)
end
function g13dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.stateWait < 0 then
      if _ARG_0_.startstep == 1 then
        _ARG_0_.step = _UPVALUE4_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      else
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      end
    end
    _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
function g13dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 3)
  Entity.AttachRideCollision(_ARG_1_, 1, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g14dc00 = {}
g14dc00.__index = g14dc00
function g14dc00.new(_ARG_0_)
  return setmetatable({}, g14dc00)
end
function g14dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.stateWait < 0 then
      if _ARG_0_.startstep == 1 then
        _ARG_0_.step = _UPVALUE4_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      else
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      end
    end
    _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
function g14dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 3)
  Entity.AttachRideCollision(_ARG_1_, 1, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g15dc00 = {}
g15dc00.__index = g15dc00
function g15dc00.new(_ARG_0_)
  return setmetatable({}, g15dc00)
end
function g15dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ then
    if _UPVALUE9_ == 1 or G10DC_PISTONFLAG == 1 then
      if _ARG_0_.stateWait < 0 then
        if _ARG_0_.startstep == 1 then
          _ARG_0_.step = _UPVALUE4_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
        else
          _ARG_0_.step = _UPVALUE0_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
        end
      end
      _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == _UPVALUE10_ and (_UPVALUE9_ == 1 or G10DC_PISTONFLAG == 1) then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
    _ARG_0_.step = _UPVALUE8_
  end
end
function g15dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.stateWait = 140
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
  _ARG_0_.startstep = 1
end
g16dc00 = {}
g16dc00.__index = g16dc00
function g16dc00.new(_ARG_0_)
  return setmetatable({}, g16dc00)
end
function g16dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.stateWait < 0 then
      if _ARG_0_.startstep == 1 then
        _ARG_0_.step = _UPVALUE4_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      else
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      end
    end
    _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
function g16dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g17dc00 = {}
g17dc00.__index = g17dc00
function g17dc00.new(_ARG_0_)
  return setmetatable({}, g17dc00)
end
function g17dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.startstep == 1 then
      _ARG_0_.step = _UPVALUE4_
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
    else
      _ARG_0_.step = _UPVALUE0_
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
    end
  end
end
function g17dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g18dc00 = {}
g18dc00.__index = g18dc00
function g18dc00.new(_ARG_0_)
  return setmetatable({}, g18dc00)
end
function g18dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == _UPVALUE0_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
    end
  elseif _ARG_0_.step == _UPVALUE2_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      _ARG_0_.step = _UPVALUE4_
    end
  elseif _ARG_0_.step == _UPVALUE4_ then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      _ARG_0_.step = _UPVALUE6_
    end
  elseif _ARG_0_.step == _UPVALUE6_ then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.time2)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      _ARG_0_.step = _UPVALUE0_
    end
  elseif _ARG_0_.step == _UPVALUE8_ and _UPVALUE9_ == 1 then
    if _ARG_0_.stateWait < 0 then
      if _ARG_0_.startstep == 1 then
        _ARG_0_.step = _UPVALUE4_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      else
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
      end
    end
    _ARG_0_.stateWait = _ARG_0_.stateWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
end
function g18dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = _UPVALUE0_
  _ARG_0_.time1 = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.time2 = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  _ARG_0_.startstep = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
  _ARG_0_.stateWait = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _ARG_0_.startstep == 1 then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
  end
end
g19dc00 = {}
g19dc00.__index = g19dc00
function g19dc00.new(_ARG_0_)
  return setmetatable({}, g19dc00)
end
function g19dc00.OnUpdatePositionAfter(_ARG_0_)
  if _UPVALUE0_ == 1 and G10DC_GEARONFLAG == 1 then
    workVec0:set(0, DegToRad(_ARG_0_.Angle), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, workVec0)
  end
end
function g19dc00.OnUpdate(_ARG_0_)
  if _ARG_0_.uniqueID == 50 and _UPVALUE0_ == 1 then
    if _ARG_0_.upFlag == 0 then
      Entity.GetWorldPos(workVec0, _ARG_0_.myHandle)
      workVec0:sety(workVec0:gety() + Gimmick.GetExtraParam(_ARG_0_.myHandle, "UpPow") * Entity.GetFrameRate(_ARG_0_.myHandle))
      if workVec0:gety() > 10 then
        workVec0:sety(10)
        _ARG_0_.upFlag = 1
        Entity.SetTimer(_ARG_0_.myHandle, 22)
      end
      Entity.SetLocalPos(_ARG_0_.myHandle, workVec0)
    elseif _ARG_0_.upFlag == 1 then
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        G10DC_GEARONFLAG = 1
        _ARG_0_.upFlag = 2
        Entity.GetWorldPos(workVec0, _UPVALUE1_, 1)
        Sound.PlaySe(59, 11, 1, workVec0)
        Entity.GetWorldPos(workVec0, _UPVALUE2_, 1)
        Sound.PlaySe(59, 11, 1, workVec0)
        Entity.GetWorldPos(workVec0, _UPVALUE3_, 1)
        Sound.PlaySe(59, 12, 1, workVec0)
        Entity.GetWorldPos(workVec0, _UPVALUE4_, 1)
        Sound.PlaySe(59, 13, 1, workVec0)
        Entity.GetWorldPos(workVec0, _UPVALUE5_, 1)
        Sound.PlaySe(59, 14, 1, workVec0)
      end
    elseif _ARG_0_.upFlag == 2 then
      Entity.GetWorldPos(workVec0, _ARG_0_.myHandle)
      workVec0:sety(10)
      Entity.SetLocalPos(_ARG_0_.myHandle, workVec0)
    end
  end
end
function g19dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.Angle = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.uniqueID = Entity.GetLayoutParam(_ARG_1_, 9)
  _ARG_0_.upFlag = 0
  if _ARG_0_.uniqueID == 50 then
    _ARG_0_.Angle = _ARG_0_.Angle * -1
    _UPVALUE0_ = _ARG_1_
  else
    _UPVALUE1_ = _ARG_1_
  end
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _UPVALUE2_ == 1 then
    Entity.GetWorldPos(workVec0, _ARG_0_.myHandle, 1)
    Sound.PlaySe(59, 11, 1, workVec0)
  end
end
g20dc00 = {}
g20dc00.__index = g20dc00
function g20dc00.new(_ARG_0_)
  return setmetatable({}, g20dc00)
end
function g20dc00.OnUpdate(_ARG_0_)
end
function g20dc00.OnUpdatePositionAfter(_ARG_0_)
  if _UPVALUE0_ == 1 then
    workVec0:set(0, DegToRad(_ARG_0_.Angle), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, workVec0)
  end
end
function g20dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
  _ARG_0_.Angle = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _UPVALUE1_ == 1 then
    Entity.GetWorldPos(workVec0, _ARG_0_.myHandle, 1)
    Sound.PlaySe(59, 12, 1, workVec0)
  end
end
g21dc00 = {}
g21dc00.__index = g21dc00
function g21dc00.new(_ARG_0_)
  return setmetatable({}, g21dc00)
end
function g21dc00.OnUpdate(_ARG_0_)
end
function g21dc00.OnUpdatePositionAfter(_ARG_0_)
  if _UPVALUE0_ == 1 then
    workVec0:set(0, 0, DegToRad(_ARG_0_.Angle))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, workVec0)
  end
end
function g21dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
  _ARG_0_.Angle = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _UPVALUE1_ == 1 then
    Entity.GetWorldPos(workVec0, _ARG_0_.myHandle, 1)
    Sound.PlaySe(59, 13, 1, workVec0)
  end
end
g22dc00 = {}
g22dc00.__index = g22dc00
function g22dc00.new(_ARG_0_)
  return setmetatable({}, g22dc00)
end
function g22dc00.OnUpdate(_ARG_0_)
end
function g22dc00.OnUpdatePositionAfter(_ARG_0_)
  if _UPVALUE0_ == 1 then
    workVec0:set(0, 0, DegToRad(_ARG_0_.Angle))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, workVec0)
  end
end
function g22dc00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
  _ARG_0_.Angle = Entity.GetLayoutParam(_ARG_0_.myHandle, 5)
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 2)
  if _UPVALUE1_ == 1 then
    Entity.GetWorldPos(workVec0, _ARG_0_.myHandle, 1)
    Sound.PlaySe(59, 14, 1, workVec0)
  end
end
EntityFactory:Add("g10dc00", function(_ARG_0_)
  return (g10dc00:new())
end)
EntityFactory:Add("g11dc00", function(_ARG_0_)
  return (g11dc00:new())
end)
EntityFactory:Add("g12dc00", function(_ARG_0_)
  return (g12dc00:new())
end)
EntityFactory:Add("g13dc00", function(_ARG_0_)
  return (g13dc00:new())
end)
EntityFactory:Add("g14dc00", function(_ARG_0_)
  return (g14dc00:new())
end)
EntityFactory:Add("g15dc00", function(_ARG_0_)
  return (g15dc00:new())
end)
EntityFactory:Add("g16dc00", function(_ARG_0_)
  return (g16dc00:new())
end)
EntityFactory:Add("g17dc00", function(_ARG_0_)
  return (g17dc00:new())
end)
EntityFactory:Add("g18dc00", function(_ARG_0_)
  return (g18dc00:new())
end)
EntityFactory:Add("g19dc00", function(_ARG_0_)
  return (g19dc00:new())
end)
EntityFactory:Add("g19dc00", function(_ARG_0_)
  return (g19dc00:new())
end)
EntityFactory:Add("g20dc00", function(_ARG_0_)
  return (g20dc00:new())
end)
EntityFactory:Add("g21dc00", function(_ARG_0_)
  return (g21dc00:new())
end)
EntityFactory:Add("g22dc00", function(_ARG_0_)
  return (g22dc00:new())
end)
function createEffect(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(workVec0, _ARG_0_)
  Entity.GetRot(workVec1, _ARG_0_)
  Entity.SetEffect(_ARG_0_, _ARG_2_, _ARG_3_, workVec0, workVec1)
end
function createCircleEffectEnd()
  if Effect.IsAlive(G23DC_CIRCLE_HANDLE) then
    Effect.LoopEnd(G23DC_CIRCLE_HANDLE)
  end
  if Effect.IsAlive(G23DC_CIRCLE_ATTACK_HANDLE) then
    Effect.LoopEnd(G23DC_CIRCLE_ATTACK_HANDLE)
  end
end
