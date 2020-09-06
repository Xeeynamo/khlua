G13LS_CAMERA_FLAG = 0
G13LS_HANDLE_1 = 0
G13LS_HANDLE_2 = 0
G13LS_PARAM_FLAG = 0
g13ls00 = {}
g13ls00_mt = {__index = g13ls00}
function g13ls00.new(_ARG_0_)
  return setmetatable({}, g13ls00_mt)
end
function g13ls00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g13ls00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, _UPVALUE0_, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g13ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = _ARG_1_
    Gimmick.SetGimmickKind(_ARG_1_, GIMMICK_KIND_JUMP_STAND)
    Gimmick.SetJumpStand(_ARG_1_, 1)
  end
  _ARG_0_.step = 0
  _ARG_0_.GravityFlag = 0
  _ARG_0_.changeFrame = 0
  _ARG_0_.colorFlag = 0
  _ARG_0_.AlertCnt = 0
  _ARG_0_.cameraFlag = 0
  _ARG_0_.cameraStep = 0
  _ARG_0_.camera = NULL_HANDLE
  _ARG_0_.markonOnWait = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.color = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldcolor = FVECTOR3.new(0, 0, 0)
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  _ARG_0_.UniqueID = Entity.GetLayoutParam(_ARG_1_, 9)
  if G13LS_PARAM_FLAG == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "AlertCnt")
    _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_1_, "StartFrame")
    _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_1_, "EndFrame")
    _UPVALUE4_ = Gimmick.GetExtraParam(_ARG_1_, "On_In_R")
    _UPVALUE5_ = Gimmick.GetExtraParam(_ARG_1_, "On_In_G")
    _UPVALUE6_ = Gimmick.GetExtraParam(_ARG_1_, "On_In_B")
    _UPVALUE7_ = Gimmick.GetExtraParam(_ARG_1_, "Off_In_R")
    _UPVALUE8_ = Gimmick.GetExtraParam(_ARG_1_, "Off_In_G")
    _UPVALUE9_ = Gimmick.GetExtraParam(_ARG_1_, "Off_In_B")
    G13LS_PARAM_FLAG = 1
    G13LS_HANDLE_1 = _ARG_0_.myHandle
    G13LS_HANDLE_2 = NULL_HANDLE
  end
  if G13LS_HANDLE_1 == _ARG_0_.myHandle then
  else
    G13LS_HANDLE_2 = _ARG_0_.myHandle
  end
  if Entity.GetName(_ARG_0_.myHandle) == "g13ls00" then
    Entity.LinkTxa(_ARG_1_, "g13ls00.pmo")
  else
    Entity.LinkTxa(_ARG_1_, "g26ls00.pmo")
  end
  Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE10_)
  Entity.SetMapTexAnim("arrow", "down")
  Entity.SetMapTexAnim("lt01b", "down")
  _ARG_0_.colorFlag = 99
end
function g13ls00.OnDestroy(_ARG_0_)
  Entity.SetGravityCoefficient(_ARG_0_.myHandle, 1)
  Script.SetShadowMapCameraDistance(-1)
end
function g13ls00.OnUpdate(_ARG_0_)
  Script.SetShadowMapCameraDistance(200)
  if Player.IsBattleFlagPlayerDead() == true and _ARG_0_.camera ~= NULL_HANDLE then
    Script.OutTask(_ARG_0_.camera)
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraStep = 0
    _ARG_0_.cameraStep = 1
    _ARG_0_.cameraFlag = 0
    Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
    Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
    Script.EnablePauseChecker()
  end
  if _ARG_0_.cameraFlag == 1 then
    if _ARG_0_.cameraStep == 0 then
      if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
        Script.OutTask(_ARG_0_.camera)
        _ARG_0_.camera = NULL_HANDLE
        _ARG_0_.cameraStep = 0
        _ARG_0_.cameraStep = 1
        _ARG_0_.cameraFlag = 0
        Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
        Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
        Script.EnablePauseChecker()
      end
    elseif _ARG_0_.cameraStep == 1 then
    end
  end
  _ARG_0_.changeFrame = _ARG_0_.changeFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if Entity.GetGravityCoefficient(_ARG_0_.myHandle) ~= 1 and _UPVALUE0_ == _ARG_0_.myHandle and Entity.IsGround(Player.GetHandle()) then
    Player.NotifyGimmickJump(Player.GetHandle(), _ARG_0_.myHandle, Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
  end
  if 0 > _ARG_0_.changeFrame then
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
    if _UPVALUE1_ == 1 then
      Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE2_)
    else
      Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE3_)
    end
  else
    Entity.EnableMarkon(_ARG_0_.myHandle, 0)
  end
  if _ARG_0_.UniqueID == 70 then
    return
  end
  if _UPVALUE1_ == 0 then
    if Gimmick.IsColorEnd() == true then
      if _ARG_0_.colorFlag == 0 then
        _ARG_0_.AlertCnt = _ARG_0_.AlertCnt + 1
        _ARG_0_.colorFlag = 1
        _ARG_0_.color:set(_UPVALUE4_, _UPVALUE5_, _UPVALUE6_)
        if _ARG_0_.cameraFlag == 0 then
          Gimmick.SetSceneColoer(_ARG_0_.color, _UPVALUE7_)
        else
          Script.SetSceneColorOff(_UPVALUE7_, _UPVALUE4_, _UPVALUE5_, _UPVALUE6_, 1, CH_EVENT, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
        end
      elseif _ARG_0_.colorFlag == 1 then
        _ARG_0_.colorFlag = 0
        if _ARG_0_.AlertCnt >= _UPVALUE8_ then
          _ARG_0_.colorFlag = 99
        end
        _ARG_0_.color:set(_UPVALUE9_, _UPVALUE10_, _UPVALUE11_)
        if _ARG_0_.cameraFlag == 0 then
          Gimmick.SetSceneColoer(_ARG_0_.color, _UPVALUE12_)
        else
          Script.SetSceneColorOff(_UPVALUE12_, _UPVALUE9_, _UPVALUE10_, _UPVALUE11_, 1, CH_EVENT, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
        end
      end
    end
  elseif Gimmick.IsColorEnd() == true then
    if _ARG_0_.colorFlag == 0 then
      _ARG_0_.colorFlag = 1
      _ARG_0_.AlertCnt = _ARG_0_.AlertCnt + 1
      _ARG_0_.color:set(_UPVALUE13_, _UPVALUE14_, _UPVALUE15_)
      if _ARG_0_.cameraFlag == 0 then
        Gimmick.SetSceneColoer(_ARG_0_.color, _UPVALUE7_)
      else
        Script.SetSceneColorOff(_UPVALUE7_, _UPVALUE13_, _UPVALUE14_, _UPVALUE15_, 1, CH_EVENT, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      end
    elseif _ARG_0_.colorFlag == 1 then
      _ARG_0_.colorFlag = 0
      if _ARG_0_.AlertCnt >= _UPVALUE8_ then
        _ARG_0_.colorFlag = 2
      end
      _ARG_0_.color:set(_UPVALUE16_, _UPVALUE17_, _UPVALUE18_)
      if _ARG_0_.cameraFlag == 0 then
        Gimmick.SetSceneColoer(_ARG_0_.color, _UPVALUE12_)
      else
        Script.SetSceneColorOff(_UPVALUE12_, _UPVALUE16_, _UPVALUE17_, _UPVALUE18_, 1, CH_EVENT, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      end
    end
  end
end
function g13ls00.OnCommand(_ARG_0_, _ARG_1_)
  if _ARG_0_.UniqueID == 70 then
    if _UPVALUE0_ == 1 then
      _UPVALUE0_ = 0
      Entity.SetGravityCoefficient(Player.GetHandle(), 1)
      _ARG_0_.changeFrame = _UPVALUE1_
      Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE2_)
      Entity.SetMapTexAnim("arrow", "down")
      Sound.PlaySe(56, 6)
    else
      _ARG_0_.changeFrame = _UPVALUE3_
      _UPVALUE0_ = 1
      Entity.SetGravityCoefficient(Player.GetHandle(), Entity.GetLayoutParam(_ARG_0_.myHandle, 6))
      Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE4_)
      Entity.SetMapTexAnim("arrow", "up")
      Sound.PlaySe(56, 7)
    end
  else
    if Gimmick.GetBitFlag(_ARG_0_.myHandle) then
    else
      if _ARG_0_.UniqueID == 22 then
        _ARG_0_.camera = Camera.CreateExusiaCamera("camera1")
      else
        _ARG_0_.camera = Camera.CreateExusiaCamera("camera0")
      end
      Camera.StartExusiaCamera(_ARG_0_.camera)
      Script.SetObjStop(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      _ARG_0_.cameraFlag = 1
      Gimmick.SetGimmckBitFlag(G13LS_HANDLE_2, true)
      Gimmick.SetGimmckBitFlag(G13LS_HANDLE_1, true)
      Script.DisablePauseChecker()
    end
    if _UPVALUE0_ == 1 then
      _UPVALUE0_ = 0
      Entity.SetGravityCoefficient(Player.GetHandle(), 1)
      _ARG_0_.changeFrame = _UPVALUE1_
      Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE2_)
      _ARG_0_.colorFlag = 0
      Entity.SetMapTexAnim("arrow", "down")
      Sound.PlaySe(56, 6)
    else
      _ARG_0_.changeFrame = _UPVALUE3_
      _UPVALUE0_ = 1
      _ARG_0_.colorFlag = 0
      Entity.SetGravityCoefficient(Player.GetHandle(), Entity.GetLayoutParam(_ARG_0_.myHandle, 6))
      Entity.SetTexAnim(_ARG_0_.myHandle, "console", _UPVALUE4_)
      Entity.SetMapTexAnim("arrow", "up")
      Sound.PlaySe(56, 7)
    end
    _ARG_0_.AlertCnt = 0
  end
  Entity.OnCommandCheck(_ARG_0_.myHandle)
end
EntityFactory:Add("g13ls00", function(_ARG_0_)
  return (g13ls00:new())
end)
EntityFactory:Add("g26ls00", function(_ARG_0_)
  return (g13ls00:new())
end)
EntityFactory:Add("g34ls00", function(_ARG_0_)
  return (g13ls00:new())
end)
