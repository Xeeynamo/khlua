g14pp00 = {}
g14pp00_mt = {__index = g14pp00}
function g14pp00.new(_ARG_0_)
  return setmetatable({}, g14pp00_mt)
end
function g14pp00.GetLockOnPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, _ARG_0_.lockbone, _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g14pp00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, _ARG_0_.lockbone, _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g14pp00.HitAreaChack(_ARG_0_, _ARG_1_)
  if _ARG_0_.damageCnt > 2 then
    if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
      _ARG_0_.hitPow4 = 100
      if Gimmick.IsNoClearFlag(_ARG_0_.myHandle) == true then
        if Gimmick.IsDestroy(_ARG_0_.myHandle) ~= false or Gimmick.GetBitFlag(_ARG_0_.myHandle) then
        else
          Entity.GetWorldPos(_ARG_0_.prized, _ARG_0_.myHandle, _UPVALUE0_)
          Gimmick.MakePraize(_ARG_0_.myHandle, _ARG_0_.prized)
        end
      else
        Gimmick.WriteNoClearFlag(_ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.prized, _ARG_0_.myHandle, _UPVALUE0_)
        Entity.CreatePrizeBox(_ARG_0_.myHandle, _ARG_0_.prized, PRIZE_KIND_PrizeBoxAS, COMMAND_KIND_Thundaga)
      end
    end
    return 4
  elseif _ARG_0_.workVec:gety() >= _UPVALUE1_[0].y1 and _ARG_0_.workVec:gety() <= _UPVALUE1_[0].y2 then
    if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
      _ARG_0_.hitPow1 = 100
    end
    return 1
  elseif _ARG_0_.workVec:gety() >= _UPVALUE1_[1].y1 and _ARG_0_.workVec:gety() <= _UPVALUE1_[1].y2 then
    if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
      _ARG_0_.hitPow2 = 100
      _ARG_0_.damageCnt = _ARG_0_.damageCnt + 1
    end
    return 2
  else
    if _ARG_0_.workVec:gety() >= _UPVALUE1_[2].y1 and _ARG_0_.workVec:gety() <= _UPVALUE1_[2].y2 then
      if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
        _ARG_0_.hitPow3 = 100
        _ARG_0_.damageCnt = _ARG_0_.damageCnt + 1
      end
      return 3
    else
    end
  end
  return 0
end
function g14pp00.OnDamage(_ARG_0_, _ARG_1_)
  Entity.GetDamageCrossPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  _ARG_0_:HitAreaChack(_ARG_1_)
end
function g14pp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.prized = FVECTOR3.new(0, 0, 0)
  _ARG_0_.lockbone = "bone_04"
  _ARG_0_.hitPow1 = 0
  _ARG_0_.hitPow2 = 0
  _ARG_0_.hitPow3 = 0
  _ARG_0_.hitPow4 = 0
  _ARG_0_.damageCnt = 1
  _ARG_0_.lockFlag1 = 0
  _ARG_0_.lockFlag2 = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  Entity.SetReplyDistSq(_ARG_1_, 25)
  Entity.EnableLockon(_ARG_1_, 1)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
end
function g14pp00.OnUpdate(_ARG_0_)
  _ARG_0_.hitPow1 = HomingDegree(_ARG_0_.hitPow1, 0, 0.5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.workVec:set(0, _ARG_0_.hitPow1, 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE0_, _ARG_0_.workVec)
  _ARG_0_.hitPow2 = HomingDegree(_ARG_0_.hitPow2, 0, 0.5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.workVec:set(0, _ARG_0_.hitPow2, 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE1_, _ARG_0_.workVec)
  _ARG_0_.hitPow3 = HomingDegree(_ARG_0_.hitPow3, 0, 0.5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.workVec:set(0, _ARG_0_.hitPow3, 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE2_, _ARG_0_.workVec)
  _ARG_0_.hitPow4 = HomingDegree(_ARG_0_.hitPow4, 0, 0.5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.workVec:set(0, _ARG_0_.hitPow4, 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE3_, _ARG_0_.workVec)
  Entity.GetWorldPos(_ARG_0_.workVec, Player.GetNearestPlayer(), 2)
  if _ARG_0_.workVec:gety() <= _UPVALUE4_[1].y1 - 3 then
    _ARG_0_.lockbone = "bone_04"
    _ARG_0_.damageCnt = 1
    if _ARG_0_.lockFlag1 == 0 then
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_.lockFlag1 = 1
      _ARG_0_.lockFlag2 = 0
    elseif _ARG_0_.lockFlag1 == 1 then
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_.lockFlag1 = 2
      _ARG_0_.lockFlag2 = 0
    end
  else
    if _ARG_0_.lockFlag2 == 0 then
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_.lockFlag2 = 1
      _ARG_0_.lockFlag1 = 0
    elseif _ARG_0_.lockFlag2 == 1 then
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_.lockFlag1 = 2
      _ARG_0_.lockFlag1 = 0
    end
    if _ARG_0_.damageCnt == 0 then
      _ARG_0_.lockbone = "bone_04"
    elseif _ARG_0_.damageCnt == 1 then
      _ARG_0_.lockbone = "bone_03"
    elseif _ARG_0_.damageCnt == 2 then
      _ARG_0_.lockbone = "bone_05"
    elseif _ARG_0_.damageCnt == 3 then
      _ARG_0_.lockbone = "bone_02"
    end
  end
end
EntityFactory:Add("g14pp00", function(_ARG_0_)
  return (g14pp00:new())
end)
