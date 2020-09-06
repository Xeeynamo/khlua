g12dp = {}
g12dp_mt = {__index = g12dp}
function g12dp.new(_ARG_0_)
  return setmetatable({}, g12dp_mt)
end
function g12dp.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitPow1 = 0
  _ARG_0_.nowRot = 0
  _ARG_0_.ringRot = 0
  _ARG_0_.addringRot = 0
  _ARG_0_.maxRingRot = 0
  _ARG_0_.MaxPow = 0
  _ARG_0_.timer = 0
  _ARG_0_.rotFlag = 0
  _ARG_0_.lingHandle = {}
  print("" .. Entity.GetLayoutParam(_ARG_1_, 9) .. "\n")
  _UPVALUE0_ = Gimmick.GetExtraParam(_ARG_1_, "Turnfor")
  _ARG_0_.lingHandle[0] = Entity.CreateEntity("g14dp00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.AttachCoord(_ARG_1_, "bone_02", _ARG_0_.lingHandle[0], "Root")
  EntityManager:GetEntity(_ARG_0_.lingHandle[0]).rotposnum = 3
  _ARG_0_.lingHandle[1] = Entity.CreateEntity("g14dp00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.AttachCoord(_ARG_1_, "bone_03", _ARG_0_.lingHandle[1], "Root")
  EntityManager:GetEntity(_ARG_0_.lingHandle[1]).rotposnum = 2
  _ARG_0_.lingHandle[2] = Entity.CreateEntity("g14dp00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.AttachCoord(_ARG_1_, "bone_04", _ARG_0_.lingHandle[2], "Root")
  EntityManager:GetEntity(_ARG_0_.lingHandle[2]).rotposnum = 1
  _ARG_0_.lingHandle[3] = Entity.CreateEntity("g14dp00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.AttachCoord(_ARG_1_, "bone_05", _ARG_0_.lingHandle[3], "Root")
  EntityManager:GetEntity(_ARG_0_.lingHandle[3]).rotposnum = 0
end
function g12dp.OnUpdate(_ARG_0_)
  if _UPVALUE0_ == 1 then
    _ARG_0_.timer = _ARG_0_.timer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
  if _ARG_0_.rotFlag == _UPVALUE1_ then
  elseif _ARG_0_.rotFlag == _UPVALUE2_ then
  elseif _ARG_0_.rotFlag == _UPVALUE3_ then
  elseif _ARG_0_.rotFlag == _UPVALUE4_ then
    _ARG_0_.hitPow1 = _ARG_0_.hitPow1 - 0.05
    if _ARG_0_.hitPow1 < 0 then
      _ARG_0_.hitPow1 = 0
    end
  elseif _ARG_0_.rotFlag == _UPVALUE5_ then
    _ARG_0_.hitPow1 = _ARG_0_.hitPow1 - 0.05
    if _ARG_0_.hitPow1 < 0 then
      _ARG_0_.hitPow1 = 0
    end
  end
end
function g12dp.NotifyStopRotation(_ARG_0_)
  _ARG_0_.timer = 30
  _UPVALUE0_ = 1
  _UPVALUE1_ = 1
end
function g12dp.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.rotFlag == _UPVALUE0_ then
  elseif _ARG_0_.rotFlag == _UPVALUE1_ or _ARG_0_.rotFlag == _UPVALUE2_ then
    _ARG_0_.WorkVec:set(0, DegToRad(-_ARG_0_.hitPow1), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
  elseif _ARG_0_.rotFlag == _UPVALUE3_ or _ARG_0_.rotFlag == _UPVALUE4_ then
    _ARG_0_.WorkVec:set(0, DegToRad(_ARG_0_.hitPow1), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
  end
  _ARG_0_.WorkVec:set(0, 0, 1)
  Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.WorkVec)
  _ARG_0_.nowRot = Math.Atan2(_ARG_0_.WorkVec:getx(), _ARG_0_.WorkVec:getz())
  if _ARG_0_.rotFlag == _UPVALUE1_ or _ARG_0_.rotFlag == _UPVALUE3_ then
    _ARG_0_.WorkVec:set(0, 0, DegToRad(_ARG_0_.ringRot))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 3, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(DegToRad(_ARG_0_.ringRot), 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 4, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(0, 0, DegToRad(-_ARG_0_.ringRot))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 5, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(DegToRad(-_ARG_0_.ringRot), 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 6, _ARG_0_.WorkVec)
  elseif _ARG_0_.rotFlag == _UPVALUE2_ or _ARG_0_.rotFlag == _UPVALUE4_ then
    _ARG_0_.WorkVec:set(0, 0, DegToRad(-_ARG_0_.ringRot))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 3, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(DegToRad(-_ARG_0_.ringRot), 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 4, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(0, 0, DegToRad(_ARG_0_.ringRot))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 5, _ARG_0_.WorkVec)
    _ARG_0_.WorkVec:set(DegToRad(_ARG_0_.ringRot), 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 6, _ARG_0_.WorkVec)
  end
  if _ARG_0_.rotFlag == _UPVALUE0_ then
  elseif _ARG_0_.rotFlag == _UPVALUE1_ or _ARG_0_.rotFlag == _UPVALUE3_ then
    _ARG_0_.ringRot = _UPVALUE5_ - _UPVALUE5_ / _UPVALUE6_ * _ARG_0_.addringRot
    _ARG_0_.addringRot = _ARG_0_.addringRot + 1.5
    if _ARG_0_.addringRot >= _UPVALUE6_ then
      _ARG_0_.addringRot = _UPVALUE6_
    else
      _ARG_0_.maxRingRot = _ARG_0_.maxRingRot + _ARG_0_.ringRot
    end
  elseif _ARG_0_.rotFlag == _UPVALUE2_ or _ARG_0_.rotFlag == _UPVALUE4_ then
    _ARG_0_.ringRot = _UPVALUE5_ - _UPVALUE5_ / _UPVALUE6_ * _ARG_0_.addringRot
    _ARG_0_.addringRot = _ARG_0_.addringRot + 1.5
    if _ARG_0_.addringRot >= _UPVALUE6_ then
      _ARG_0_.addringRot = _UPVALUE6_
      if _UPVALUE7_ == 1 then
        _UPVALUE7_ = 0
      end
    end
  end
  if _ARG_0_.rotFlag == _UPVALUE1_ then
    if 0 >= _ARG_0_.timer then
      _ARG_0_.rotFlag = _UPVALUE2_
      _ARG_0_.addringRot = 0
    end
  elseif _ARG_0_.rotFlag == _UPVALUE3_ and 0 >= _ARG_0_.timer then
    _ARG_0_.rotFlag = _UPVALUE4_
    _ARG_0_.addringRot = 0
  end
end
EntityFactory:Add("g12dp00", function(_ARG_0_)
  return (g12dp:new())
end)
g14dp00 = {}
g14dp00_mt = {__index = g14dp00}
function g14dp00.new(_ARG_0_)
  return setmetatable({}, g14dp00_mt)
end
function g14dp00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g14dp00.OnDamage(_ARG_0_, _ARG_1_)
  Entity.GetDamageCrossPos(_ARG_0_.hitpos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.workvec1, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.workvec, _ARG_0_.hitpos, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec)
  _ARG_0_.workvec:set(0, RoundPI(Math.Atan2(_ARG_0_.workvec:getx(), _ARG_0_.workvec:getz()) - EntityManager:GetEntity(_ARG_0_.parenthandle).nowRot), 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workvec)
  print("GetDamageCommandKind!! :: " .. Entity.GetDamageCommandKind(_ARG_0_.myHandle) .. "\n")
  if _UPVALUE0_ == 0 then
    if 1 == Entity.GetDamageCommandKind(_ARG_0_.myHandle) or 61 == Entity.GetDamageCommandKind(_ARG_0_.myHandle) then
      if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW then
        Entity.GetWorldPos(_ARG_0_.prized, _ARG_0_.myHandle, 1)
        if Entity.CanUserTarget(_ARG_0_.myHandle) then
          _ARG_0_.prized:set(0, 0, 0)
          Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.prized)
          Gimmick.MakePraize(_ARG_0_.myHandle, _ARG_0_.prized)
        end
        if _ARG_0_:WhichRightandLeft() == 0 then
          EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = _UPVALUE1_
          EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = _UPVALUE2_
          EntityManager:GetEntity(_ARG_0_.parenthandle).addringRot = 0
        else
          EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = _UPVALUE3_
          EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = _UPVALUE1_
          EntityManager:GetEntity(_ARG_0_.parenthandle).addringRot = 0
        end
        EntityManager:GetEntity(_ARG_0_.parenthandle).timer = 200
        _UPVALUE0_ = 1
        if _UPVALUE4_ == 0 then
          _UPVALUE4_ = 1
          Entity.CreatePrizeNoTimeLost(_ARG_0_.myHandle, 0, true, "X_marker")
        end
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
      end
    else
      EntityManager:GetEntity(_ARG_0_.parenthandle).timer = 200
      if _UPVALUE7_ == 0 then
        if _UPVALUE8_ == 0 then
          _UPVALUE0_ = 1
        elseif Mission.IsMissionNow() == true then
          _UPVALUE0_ = 2
        else
          _UPVALUE0_ = 1
        end
      else
        _UPVALUE0_ = 1
      end
      if Entity.IsUserPermissionLockOn(_ARG_0_.myHandle) then
        Mission.SendMissonMessage(MES_TUTORIAL_ATK_DECK_COMMAND_TO_RING)
      end
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
      if _ARG_0_:WhichRightandLeft() == 0 then
        EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = _UPVALUE1_
        EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = _UPVALUE2_
        EntityManager:GetEntity(_ARG_0_.parenthandle).addringRot = 0
      else
        EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = _UPVALUE3_
        EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = _UPVALUE1_
        EntityManager:GetEntity(_ARG_0_.parenthandle).addringRot = 0
      end
    end
  else
  end
end
function g14dp00.WhichRightandLeft(_ARG_0_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.parenthandle)
  Entity.GetWorldPos(_ARG_0_.workvec, _ARG_0_.parenthandle)
  Entity.GetWorldPos(_ARG_0_.workvec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workvec, _ARG_0_.workvec, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec)
  Entity.GetWorldPos(_ARG_0_.workvec, Player.GetHandle())
  Entity.GetWorldPos(_ARG_0_.workvec1, Entity.GetParent(_ARG_0_.myHandle))
  FVECTOR3.Sub(_ARG_0_.workvec0, _ARG_0_.workvec, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec0)
  if 0 > RoundPI(Math.Atan2(_ARG_0_.workvec0:getx(), _ARG_0_.workvec0:getz()) * -1 - Math.Atan2(_ARG_0_.workvec:getx(), _ARG_0_.workvec:getz()) * -1) then
    return 1
  else
    return 0
  end
end
function g14dp00.SetShakRot(_ARG_0_)
end
function g14dp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.step = 0
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.parenthandle = Entity.GetParent(_ARG_1_)
  _ARG_0_.hitPow1 = 0
  _ARG_0_.lockOnflag = 0
  _ARG_0_.rotflag = 0
  _ARG_0_.hitAng = 0
  _ARG_0_.nowshakepow = 0
  _ARG_0_.rotposnum = 0
  _ARG_0_.ShakeRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.BoneRot1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.BoneRot2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.BoneRot3 = FVECTOR3.new(0, 0, 0)
  Entity.SetReplyDistSq(_ARG_1_, 400)
  Entity.SetLockLimitSq(_ARG_1_, 400)
  _ARG_0_.prized = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitpos = FVECTOR3.new(0, 0, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
end
function g14dp00.OnUpdate(_ARG_0_)
  if _ARG_0_.lockOnflag == 0 then
    if 0 < Player.IsPadFlagLockOn() then
      if Player.IsNowTarget(Player.GetHandle()) == _ARG_0_.myHandle then
        _ARG_0_.lockOnflag = 1
        Entity.SetTimer(_ARG_0_.myHandle, 180)
      end
    else
      _ARG_0_.lockOnflag = 0
    end
  elseif _ARG_0_.lockOnflag == 1 then
    if 0 < Player.IsPadFlagLockOn() then
      if Player.IsNowTarget(Player.GetHandle()) == _ARG_0_.myHandle and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.lockOnflag = 2
        Mission.SendMissonMessage(MES_TUTORIAL_LOCK_ON_RING)
      end
    else
      _ARG_0_.lockOnflag = 99
    end
  elseif _ARG_0_.lockOnflag == 2 then
  elseif Player.IsPadFlagLockOn() == 0 then
    _ARG_0_.lockOnflag = 0
  end
  if _ARG_0_.step == 0 then
  elseif (_ARG_0_.step == 1 or _ARG_0_.step == 2) and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
  end
end
EntityFactory:Add("g14dp00", function(_ARG_0_)
  return (g14dp00:new())
end)
g11dp = {}
g11dp_mt = {__index = g11dp}
function g11dp.new(_ARG_0_)
  return setmetatable({}, g11dp_mt)
end
function g11dp.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitPow1 = 0
  _ARG_0_.rotFlag = 99
  _ARG_0_.nowRot = 0
  _ARG_0_.lingHandle = Entity.CreateEntity("g13dp00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.AttachCoord(_ARG_1_, "bone_01", _ARG_0_.lingHandle, "Root")
end
function g11dp.OnUpdate(_ARG_0_)
end
function g11dp.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.rotFlag == 0 then
    _ARG_0_.WorkVec:set(0, DegToRad(-_ARG_0_.hitPow1), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
  elseif _ARG_0_.rotFlag == 1 then
    _ARG_0_.WorkVec:set(0, DegToRad(_ARG_0_.hitPow1), 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
  end
  _ARG_0_.hitPow1 = _ARG_0_.hitPow1 - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 > _ARG_0_.hitPow1 then
    _ARG_0_.hitPow1 = 0
  end
  _ARG_0_.WorkVec:set(0, 0, 1)
  Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.WorkVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.WorkVec)
  _ARG_0_.nowRot = Math.Atan2(_ARG_0_.WorkVec:getx(), _ARG_0_.WorkVec:getz())
end
EntityFactory:Add("g11dp00", function(_ARG_0_)
  return (g11dp:new())
end)
g13dp00 = {}
g13dp00_mt = {__index = g13dp00}
function g13dp00.new(_ARG_0_)
  return setmetatable({}, g13dp00_mt)
end
function g13dp00.OnDamage(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.hitpos, Entity.GetAttacker(_ARG_0_.myHandle))
  _ARG_0_.step = 1
  Entity.GetDamageCrossPos(_ARG_0_.hitpos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.workvec1, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.workvec, _ARG_0_.hitpos, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec)
  _ARG_0_.workvec:set(0, RoundPI(Math.Atan2(_ARG_0_.workvec:getx(), _ARG_0_.workvec:getz()) - EntityManager:GetEntity(_ARG_0_.parenthandle).nowRot), 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workvec)
  if 1 == Entity.GetDamageCommandKind(_ARG_0_.myHandle) then
    if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      if _UPVALUE1_ == 0 then
        _UPVALUE1_ = 1
        Gimmick.MakePraize(_ARG_0_.myHandle, _ARG_0_.hitpos)
      end
      if Mission.IsMissionNow() == true then
        Mission.SendMissonMessage(MES_TUTORIAL_ATK_FINISH_TO_RING)
      end
      if _ARG_0_:WhichRightandLeft() == 0 then
        if 0 >= _ARG_0_.hitCnt then
          _ARG_0_.hitCnt = _ARG_0_.hitCnt + 1
          EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = 5
          EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = 0
        end
      elseif 0 <= _ARG_0_.hitCnt then
        _ARG_0_.hitCnt = _ARG_0_.hitCnt - 1
        EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = 5
        EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = 1
      end
    else
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
    end
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    if _UPVALUE1_ == 0 then
      _UPVALUE1_ = 1
      Gimmick.MakePraize(_ARG_0_.myHandle, _ARG_0_.hitpos)
    end
    if Mission.IsMissionNow() == true then
      Mission.SendMissonMessage(MES_TUTORIAL_ATK_FINISH_TO_RING)
    end
    if _ARG_0_:WhichRightandLeft() == 0 then
      if 0 >= _ARG_0_.hitCnt then
        _ARG_0_.hitCnt = _ARG_0_.hitCnt + 1
        EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = 5
        EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = 0
      end
    elseif 0 <= _ARG_0_.hitCnt then
      _ARG_0_.hitCnt = _ARG_0_.hitCnt - 1
      EntityManager:GetEntity(_ARG_0_.parenthandle).hitPow1 = 5
      EntityManager:GetEntity(_ARG_0_.parenthandle).rotFlag = 1
    end
  end
end
function g13dp00.WhichRightandLeft(_ARG_0_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.parenthandle)
  Entity.GetWorldPos(_ARG_0_.workvec, _ARG_0_.parenthandle, 2)
  Entity.GetWorldPos(_ARG_0_.workvec1, _ARG_0_.myHandle, 1)
  FVECTOR3.Sub(_ARG_0_.workvec, _ARG_0_.workvec, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec)
  Entity.GetWorldPos(_ARG_0_.workvec, Player.GetHandle())
  Entity.GetWorldPos(_ARG_0_.workvec1, Entity.GetParent(_ARG_0_.myHandle), 1)
  FVECTOR3.Sub(_ARG_0_.workvec0, _ARG_0_.workvec, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec0)
  if 0 > RoundPI(Math.Atan2(_ARG_0_.workvec0:getx(), _ARG_0_.workvec0:getz()) * -1 - Math.Atan2(_ARG_0_.workvec:getx(), _ARG_0_.workvec:getz()) * -1) then
    return 1
  else
    return 0
  end
end
function g13dp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.hitCnt = 0
  _ARG_0_.parenthandle = Entity.GetParent(_ARG_1_)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  _ARG_0_.prized = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitpos = FVECTOR3.new(0, 0, 0)
  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
end
function g13dp00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
end
EntityFactory:Add("g13dp00", function(_ARG_0_)
  return (g13dp00:new())
end)
