G10KG_LEADER_HANDLE = 0
G10KG_CHASER_HANDLE = 0
G10KG_NEAR_DIST = 100000000
G10KG_HIT_DIST = 9
G10KG_MODEL_OUT_DIST = 160000
G10KG_BLIZZARD_EFFHANDLE = NULL_HANDLE
G10KG_SEARCH_DIST = 1600
G10KG_MAX_SPEED = 0.05
G10KG_ADD_SPEED = 0.01
G10KG_HOMING_MAX_SPEED = 0.05
G10KG_SPEEDUP_MODE = 0
G10KG_SPEEDDOWN_MODE = 1
G10KG_CHANGE_TIME = 0
G10KG_MODE_IDLING = 0
G10KG_MODE_MOVE = 1
G10KG_MODE_RETRUN = 2
CAMERAFIXFLAG = 0
G10KG_STARTCAMERAY = 6
G10KG_ANCHOR_START_PL_POSY = 13
G10KG_CAMEAMOVE_SPEED = 0.1
g10kg00 = {}
g10kg00_mt = {__index = g10kg00}
function g10kg00.new(_ARG_0_)
  return setmetatable({}, g10kg00_mt)
end
function g10kg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.Time = 300
  _ARG_0_.CameraFixTime = 0
  _ARG_0_.CameraFixflag = 0
  _ARG_0_.CameraHandle = NULL_HANDLE
  _ARG_0_.Mode = 0
  _ARG_0_.Speed = 0
  _ARG_0_.SpeedFlag = 0
  _ARG_0_.MaxSpeed = 0
  _ARG_0_.QuakeWait = 0
  if Script.Random() < 0.5 then
    _ARG_0_.SpeedFlag = 0
  else
    _ARG_0_.SpeedFlag = 1
  end
  _ARG_0_.SpeedTime = Script.Random() * 180 + 60
  _ARG_0_.pos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.aim = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.uniqueID = Entity.GetLayoutParam(_ARG_0_.myHandle, 9)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 5)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  if G10KG_LEADER_HANDLE == 0 then
    G10KG_HIT_DIST = Gimmick.GetExtraParam(_ARG_0_.myHandle, "UsefRang") * Gimmick.GetExtraParam(_ARG_0_.myHandle, "UsefRang")
    G10KG_SEARCH_DIST = Gimmick.GetExtraParam(_ARG_0_.myHandle, "SearchDist") * Gimmick.GetExtraParam(_ARG_0_.myHandle, "SearchDist")
    G10KG_HOMING_MAX_SPEED = Gimmick.GetExtraParam(_ARG_0_.myHandle, "MaxSpeed")
    G10KG_MAX_SPEED = Gimmick.GetExtraParam(_ARG_0_.myHandle, "IMaxSpeed")
    G10KG_ADD_SPEED = Gimmick.GetExtraParam(_ARG_0_.myHandle, "AddSpeed")
    G10KG_CHANGE_TIME = Gimmick.GetExtraParam(_ARG_0_.myHandle, "ChangeT")
    G10KG_STARTCAMERAY = Gimmick.GetExtraParam(_ARG_0_.myHandle, "StartCY")
    G10KG_ANCHOR_START_PL_POSY = Gimmick.GetExtraParam(_ARG_0_.myHandle, "StartPY")
    G10KG_CAMEAMOVE_SPEED = Gimmick.GetExtraParam(_ARG_0_.myHandle, "CamSpeed")
    G10KG_MODEL_OUT_DIST = Gimmick.GetExtraParam(_ARG_0_.myHandle, "OutDist")
    _UPVALUE0_[0].time = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakeTim1")
    _UPVALUE0_[0].power = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakePow1")
    _UPVALUE0_[1].time = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakeTim2")
    _UPVALUE0_[1].power = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakePow2")
    _UPVALUE0_[2].time = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakeTim3")
    _UPVALUE0_[2].power = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakePow3")
    _UPVALUE1_[0].Dist = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakeDist1")
    _UPVALUE1_[0].Dist = _UPVALUE1_[0].Dist * _UPVALUE1_[0].Dist
    _UPVALUE1_[1].Dist = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakeDist2")
    _UPVALUE1_[1].Dist = _UPVALUE1_[1].Dist * _UPVALUE1_[1].Dist
    _UPVALUE1_[2].Dist = Gimmick.GetExtraParam(_ARG_0_.myHandle, "QuakeDist3")
    _UPVALUE1_[2].Dist = _UPVALUE1_[2].Dist * _UPVALUE1_[2].Dist
    G10KG_LEADER_HANDLE = _ARG_1_
    G10KG_CHASER_HANDLE = _ARG_0_.myHandle
    print("\131\138\129[\131_\129[\130\201\130\183\130\233.")
  end
  if G10KG_LEADER_HANDLE == _ARG_1_ then
  else
  end
  if Gimmick.IsStartedFromAnchorPoint() then
    print("UniqueID = " .. _ARG_0_.uniqueID .. "\n")
    if Gimmick.GetAnchorPointID() == _ARG_0_.uniqueID then
      print("\142c\159\230\148\173\144\182\n")
      Entity.GetWorldPos(_UPVALUE2_, Player.GetHandle())
      print("x = " .. _UPVALUE2_:getx() .. "\n")
      print("y = " .. _UPVALUE2_:gety() .. "\n")
      print("z = " .. _UPVALUE2_:getz() .. "\n")
      _UPVALUE2_:sety(_UPVALUE2_:gety() - 3)
      _UPVALUE3_:set(0, 0, 0)
      Entity.CreateEntity("g11kg00", _UPVALUE2_, _UPVALUE3_)
    end
    if G10KG_LEADER_HANDLE == _ARG_1_ then
      _ARG_0_.CameraFixTime = 90
    end
    if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 1
      if G10KG_CHASER_HANDLE == _ARG_1_ then
        G10KG_CHASER_HANDLE = NULL_HANDLE
      end
    end
    Gimmick.GetAncharPos(_UPVALUE2_, _ARG_0_.myHandle, _ARG_0_.uniqueID)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
  else
    if G10KG_LEADER_HANDLE == _ARG_1_ then
    end
    if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 1
      if G10KG_CHASER_HANDLE == _ARG_1_ then
        G10KG_CHASER_HANDLE = NULL_HANDLE
      end
    end
    _ARG_0_.CameraFixflag = 2
    CAMERAFIXFLAG = 2
  end
  Entity.GetRot(_UPVALUE2_, _ARG_0_.myHandle)
  _UPVALUE2_:set(0, Script.Random() * DegToRad(360), 0)
  Entity.SetRot(_ARG_0_.myHandle, _UPVALUE2_)
  Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, G10KG_MODEL_OUT_DIST)
end
function g10kg00.OnUpdate(_ARG_0_)
end
function g10kg00.CanMainSkip(_ARG_0_)
  if G10KG_LEADER_HANDLE == _ARG_0_.myHandle then
    if _ARG_0_.CameraFixflag == 0 then
      _UPVALUE0_:set(0, 0, -0.001)
      Entity.GetWorldPos2(_ARG_0_.pos, Player.GetHandle(), _UPVALUE0_)
      Entity.GetWorldPos(_ARG_0_.aim, (Player.GetHandle()))
      _ARG_0_.pos:sety(_ARG_0_.pos:gety() + G10KG_STARTCAMERAY)
      _ARG_0_.pos:setz(_ARG_0_.pos:getz())
      _ARG_0_.pos:setx(_ARG_0_.pos:getx())
      _ARG_0_.CameraHandle = Camera.CameraCreate(_ARG_0_.pos, _ARG_0_.aim)
      _ARG_0_.CameraFixflag = 1
      CAMERAFIXFLAG = 1
    else
      if _ARG_0_.CameraFixflag == 1 then
        Entity.GetWorldPos(_ARG_0_.aim, (Player.GetHandle()))
        _UPVALUE0_:set(0, 0, -0.001)
        Entity.GetWorldPos2(_ARG_0_.pos, Player.GetHandle(), _UPVALUE0_)
        _ARG_0_.pos:sety(_ARG_0_.pos:gety() + G10KG_STARTCAMERAY)
        _ARG_0_.pos:setz(_ARG_0_.pos:getz())
        _ARG_0_.pos:setx(_ARG_0_.pos:getx())
        Camera.CameraMovePos(_ARG_0_.CameraHandle, _ARG_0_.pos, G10KG_CAMEAMOVE_SPEED)
        Camera.CameraSetView(_ARG_0_.CameraHandle, _ARG_0_.aim)
        _ARG_0_.CameraFixTime = _ARG_0_.CameraFixTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.CameraFixTime or Entity.IsGround((Player.GetHandle())) then
          _ARG_0_.CameraFixflag = 2
          CAMERAFIXFLAG = 2
          Camera.GetWorldPos(_ARG_0_.pos, _ARG_0_.CameraHandle)
          Player.SetPCamEventTransfer(_ARG_0_.pos, _ARG_0_.aim)
          Camera.CameraDestroy(_ARG_0_.CameraHandle)
        end
      else
      end
    end
    if Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) ~= 0 and 0 > _ARG_0_.QuakeWait then
      if Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) < _UPVALUE1_[0].Dist and Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) > _UPVALUE1_[1].Dist then
        _ARG_0_:CameraQuake(0)
      elseif Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) < _UPVALUE1_[1].Dist and Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) > _UPVALUE1_[2].Dist then
        _ARG_0_:CameraQuake(1)
      elseif Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) < _UPVALUE1_[2].Dist then
        _ARG_0_:CameraQuake(2)
      end
      _ARG_0_.QuakeWait = _UPVALUE2_[2].time
    end
    _ARG_0_.QuakeWait = _ARG_0_.QuakeWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if _ARG_0_.step == 1 or CAMERAFIXFLAG ~= 2 or Player.IsPlayerFlagEventOn((Player.GetHandle())) == 1 then
    return true
  end
  if _ARG_0_.step == 0 then
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, (Player.GetHandle())) <= Entity.CalcDistanceXZSq(G10KG_CHASER_HANDLE, (Player.GetHandle())) then
      G10KG_NEAR_DIST = Entity.CalcDistanceXZSq(_ARG_0_.myHandle, (Player.GetHandle()))
      G10KG_CHASER_HANDLE = _ARG_0_.myHandle
    end
    if G10KG_CHASER_HANDLE == NULL_HANDLE then
      G10KG_NEAR_DIST = Entity.CalcDistanceXZSq(_ARG_0_.myHandle, (Player.GetHandle()))
      G10KG_CHASER_HANDLE = _ARG_0_.myHandle
    end
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, (Player.GetHandle())) < G10KG_HIT_DIST then
      _ARG_0_.Time = _ARG_0_.Time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    else
      _ARG_0_.Time = 0
    end
    if 0 > _ARG_0_.Time then
      Entity.GetWorldPos(_UPVALUE0_, (Player.GetHandle()))
      _UPVALUE0_:sety(G10KG_ANCHOR_START_PL_POSY)
      Entity.GetWorldPos(_UPVALUE3_, (Player.GetHandle()))
      _UPVALUE3_:sety(_UPVALUE0_:gety() + 8)
      Entity.GetRot(_UPVALUE4_, (Player.GetHandle()))
      Gimmick.SetAnchorPoint(_UPVALUE0_, _UPVALUE3_, _UPVALUE4_:gety())
      Gimmick.SetAnchorPointID(Entity.GetLayoutParam(_ARG_0_.myHandle, 9))
      Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
      if Script.Random() < 0.3333 then
        print("GAMETRG_GIMMICK_1\n")
        Gimmick.TriggerFire(_ARG_0_.myHandle, GAMETRG_GIMMICK_1)
      elseif Script.Random() < 0.633 then
        print("GAMETRG_GIMMICK_2\n")
        Gimmick.TriggerFire(_ARG_0_.myHandle, GAMETRG_GIMMICK_2)
      else
        print("GAMETRG_GIMMICK_3\n")
        Gimmick.TriggerFire(_ARG_0_.myHandle, GAMETRG_GIMMICK_3)
      end
    end
  end
  if G10KG_CHASER_HANDLE == _ARG_0_.myHandle then
    if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, (Player.GetHandle())) < G10KG_SEARCH_DIST then
      if _ARG_0_.Speed > G10KG_HOMING_MAX_SPEED then
        _ARG_0_.Speed = G10KG_HOMING_MAX_SPEED
      end
      _ARG_0_.Speed = _ARG_0_.Speed + G10KG_ADD_SPEED
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, (Player.GetHandle())))
      _ARG_0_.velocity:set(0, 0, 1)
      Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
      _ARG_0_.velocity:scale(_ARG_0_.Speed)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 1)
    else
      _ARG_0_.Mode = G10KG_MODE_RETRUN
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 0)
    end
  else
    if _ARG_0_.SpeedFlag == G10KG_SPEEDUP_MODE then
      if _ARG_0_.Speed > _ARG_0_.MaxSpeed then
        _ARG_0_.Speed = _ARG_0_.MaxSpeed
      end
      _ARG_0_.Speed = _ARG_0_.Speed + 0.001
    elseif _ARG_0_.SpeedFlag == G10KG_SPEEDDOWN_MODE then
      if _ARG_0_.Speed < -_ARG_0_.MaxSpeed then
        _ARG_0_.Speed = -_ARG_0_.MaxSpeed
      end
      _ARG_0_.Speed = _ARG_0_.Speed - 0.001
    end
    if 0 > _ARG_0_.SpeedTime then
      _ARG_0_.SpeedTime = Script.Random() * 180 + G10KG_CHANGE_TIME
      if Script.Random() < 0.5 then
        _ARG_0_.SpeedFlag = 0
      else
        _ARG_0_.SpeedFlag = 1
      end
      _ARG_0_.MaxSpeed = Script.Random() * (G10KG_MAX_SPEED - 0.004) + 0.004
    end
    if _ARG_0_.Mode == G10KG_MODE_IDLING then
      Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE0_))
      _ARG_0_.velocity:set(1, 0, 0)
      Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
      _ARG_0_.velocity:scale(_ARG_0_.Speed)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 0)
    elseif _ARG_0_.Mode == G10KG_MODE_MOVE then
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 1)
    elseif _ARG_0_.Mode == G10KG_MODE_RETRUN then
      Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
      if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _UPVALUE0_) < 1 then
        _ARG_0_.Mode = G10KG_MODE_IDLING
      else
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE0_))
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(0.05)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      end
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 1)
    end
  end
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Gimmick.SetAnchorPos(_ARG_0_.myHandle, _UPVALUE0_, _ARG_0_.uniqueID)
  return false
end
function g10kg00.OnDestroy(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Gimmick.SetAnchorPos(_ARG_0_.myHandle, _UPVALUE0_, _ARG_0_.uniqueID)
  Gimmick.SetAnchorPos(_ARG_0_.myHandle, _UPVALUE0_, _ARG_0_.uniqueID)
end
function g10kg00.CameraQuake(_ARG_0_, _ARG_1_)
  if Script.Random() < 0.5 then
    Camera.QuakeV(_UPVALUE0_[_ARG_1_].time, _UPVALUE0_[_ARG_1_].power, 1)
  else
    Camera.QuakeV(_UPVALUE0_[_ARG_1_].time, _UPVALUE0_[_ARG_1_].power, 1)
  end
  if Script.Random() < 0.5 then
    Camera.QuakeH(_UPVALUE0_[_ARG_1_].time, _UPVALUE0_[_ARG_1_].power, 1)
  else
  end
end
EntityFactory:Add("g10kg00", function(_ARG_0_)
  return (g10kg00:new())
end)
g11kg00 = {}
g11kg00_mt = {__index = g11kg00}
function g11kg00.new(_ARG_0_)
  return setmetatable({}, g11kg00_mt)
end
function g11kg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.scale = 1
  Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 200)
end
function g11kg00.OnUpdate(_ARG_0_)
  _ARG_0_.scale = _ARG_0_.scale + 0.005 * _ARG_0_.scale * Entity.GetFrameRate(_ARG_0_.myHandle)
  _UPVALUE0_:set(_ARG_0_.scale, 1, _ARG_0_.scale)
  Entity.SetScale(_ARG_0_.myHandle, _UPVALUE0_)
  if _ARG_0_.step == 0 then
    _ARG_0_.step = 1
  elseif _ARG_0_.step == 1 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
    Entity.Out(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("g11kg00", function(_ARG_0_)
  return (g11kg00:new())
end)
