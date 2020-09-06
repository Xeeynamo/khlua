b10ls00 = {}
b10ls00_base_mt = {__index = __StateMachine}
setmetatable(b10ls00, b10ls00_base_mt)
b10ls00_mt = {__index = b10ls00}
function b10ls00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b10ls00_mt)
end
b10ls00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Move")
        _ARG_0_.targetHandle = Player.GetHandle()
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("b10ls00:Idling\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + -(Script.Random() * _UPVALUE1_))
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_.targetHandle = Player.GetHandle()
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        if Script.Random() < _UPVALUE1_ then
          _ARG_0_:GotoState("Cuttingdown")
        elseif Script.Random() < _UPVALUE1_ + _UPVALUE2_ then
          _ARG_0_.away = _UPVALUE3_
          _ARG_0_:GotoState("Goes_away")
        else
          _ARG_0_:GotoState("Tackle")
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE4_ then
        if Script.Random() < _UPVALUE5_ then
          _ARG_0_:GotoState("BlasterShot")
        else
          _ARG_0_:GotoState("RandomBlaster")
        end
      else
        _ARG_0_:GotoState("Move")
      end
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("b10ls00:Move\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.step = _UPVALUE5_
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.step = _UPVALUE5_
        end
      elseif _ARG_0_.step == _UPVALUE5_ then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  Goes_away = {
    OnBeginState = function(_ARG_0_)
      print("b10ls00:Goes_away\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.step = 0
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      _ARG_0_.WorkVec:set(_UPVALUE2_.x, _UPVALUE2_.y, _UPVALUE2_.z)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.WorkVec) < 49 then
        _ARG_0_.WorkVec:set(0, 0, 0)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getx()))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 2 * PI))) + _ARG_0_.WorkVec:getz()))
      else
        _ARG_0_.targetPos:set(_UPVALUE2_.x, _UPVALUE2_.y, _UPVALUE2_.z)
      end
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 3)
        _ARG_0_.WorkVec:set(0, 0, _UPVALUE3_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 1 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.step = _UPVALUE5_
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == _UPVALUE5_ then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 3)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  Cuttingdown = {
    OnBeginState = function(_ARG_0_)
      print("b10ls00:Cuttingdown\n")
      _ARG_0_.step = 0
      _ARG_0_.ShotCnt = 0
      if _ARG_0_:WhichRightandLeft() == 0 then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  BlasterShot = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.targetHandle = Player.GetHandle()
      _ARG_0_.step = 0
      _ARG_0_.ShotCnt = 0
      _ARG_0_.shotFlag = 0
      print("b10ls00:BlasterShot\n")
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.BodyFlag = _UPVALUE0_
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
          _ARG_0_.BodyFlag = _UPVALUE1_
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
          _ARG_0_.shotFlag = 0
          _ARG_0_.ShotCnt = _ARG_0_.ShotCnt + 1
          _ARG_0_.BodyFlag = _UPVALUE1_
          if _ARG_0_.ShotCnt > _UPVALUE2_ then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.BodyFlag = _UPVALUE4_
            _ARG_0_.step = 2
          end
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 4 then
        end
        if 1 < Entity.GetMotionNowFrame(_ARG_0_.myHandle) and _ARG_0_.shotFlag == 0 then
          _ARG_0_.shotFlag = 1
          _ARG_0_:CreateShot(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_.away = _UPVALUE5_
        _ARG_0_:GotoState("Goes_away")
      end
    end
  },
  RandomBlaster = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.targetHandle = Player.GetHandle()
      _ARG_0_.step = 0
      _ARG_0_.ShotCnt = 0
      _ARG_0_.nextShotFrame = 6
      print("b10ls00:RandomBlaster\n")
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 54 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 164 then
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.rot:sety(_ARG_0_.rot:gety() + DegToRad(360 / (220 / Entity.GetFrameRate(_ARG_0_.myHandle))))
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 46 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 164 then
          if 0 > _ARG_0_.nextShotFrame then
            _ARG_0_:CreateblastShot(_ARG_0_.myHandle)
            _ARG_0_.nextShotFrame = 6
          end
          _ARG_0_.nextShotFrame = _ARG_0_.nextShotFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Tackle")
        end
      elseif _ARG_0_.step == 1 then
      end
    end
  },
  Tackle = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      print("b10ls00:Tackle\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  Struggle = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.TosFlag = 0
      print("b10ls00:Struggle\n")
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
          Mission.SendMissonMessage(MES_BTL_SHAKEN_OFF)
          _ARG_0_.WorkVec:set(0, 0, 6)
          Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
          Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle, 1)
          _ARG_0_.targetPos:set(0, 0, 0)
          if Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _ARG_0_.WorkVec, _ARG_0_.WorkVec1) == true then
            print("\130\170\130\215\130\193\130\219\130\162\n")
            _ARG_0_.TosFlag = 1
          end
        end
      elseif _ARG_0_.step == 1 then
        if _ARG_0_.TosFlag == 1 then
          _ARG_0_.WorkVec:set(_UPVALUE1_.x, _UPVALUE1_.y, _UPVALUE1_.z)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec, 10)
        end
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 73 then
          Mission.SendMissonMessage(MES_BTL_THROW_STITCH)
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 1
      end
      _ARG_0_.SavingsDamage = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          if _ARG_0_.step == 0 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          end
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      print("Dead\n")
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Sound.IsInvalidateSeCall() == 1 then
        _ARG_0_:PlayVoice(19)
        print("\141\196\144\182\n")
        _ARG_0_.step = 1
      end
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function b10ls00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if ROUND_PI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b10ls00.CreateShot(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, 15)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.WorkVec:set(-1, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, 15)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, 15)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "n01ls00", "N420_BLT_01_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), _ARG_0_.myHandle, 1)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "n01ls00", "N420_HIT_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "n01ls00", "N420_HIT_01_0")
  Bullet.EnableReflect(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.25)
end
function b10ls00.CreateblastShot(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, 15)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.WorkVec:set(-1, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, 15)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, 15)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "n01ls00", "N420_BLT_01_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), _ARG_0_.myHandle, 2)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "n01ls00", "N420_HIT_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), "n01ls00", "N420_HIT_01_0")
  Bullet.EnableReflect(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.25)
end
function b10ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.ShotCnt = 0
  _ARG_0_.shotFlag = 0
  _ARG_0_.nextShotFrame = 0
  _ARG_0_.TosFlag = 0
  _ARG_0_.oldAnglx = 0
  _ARG_0_.BodyFlag = 0
  _ARG_0_.away = _UPVALUE0_
  _ARG_0_.SavingsDamage = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.LookMaxMin = {}
  _ARG_0_.LookMaxMin[0] = {
    Max = DegToRad(90),
    Min = DegToRad(-90)
  }
  _ARG_0_.LookMaxMin[1] = {
    Max = DegToRad(30),
    Min = DegToRad(0)
  }
  if _UPVALUE1_ == false then
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingTime") * 60
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTime") * 60
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "StrTime") * 60
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Dis")
    _UPVALUE5_ = _UPVALUE5_ * _UPVALUE5_
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action2Dis")
    _UPVALUE6_ = _UPVALUE6_ * _UPVALUE6_
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ConDamage")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RecDamage")
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BlastNum")
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Action1Rat") * 0.01
    print("B10LS_RATE_BUTTING = " .. _UPVALUE10_ .. "\n")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "TopartMove") * 0.01
    print("B10LS_RATE_GOES_AWAY = " .. _UPVALUE11_ .. "\n")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BShotRate") * 0.01
    print("B10LS_RATE_BLASTER = " .. _UPVALUE12_ .. "\n")
    _UPVALUE1_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 4)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 4.1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Player.SetBossCamera("b10ls")
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b10ls00.OnHitStitchBall(_ARG_0_, _ARG_1_)
  _ARG_0_:GotoState("Struggle")
  print("Call OnHitStichBall")
end
function b10ls00.OnDamage(_ARG_0_, _ARG_1_)
  if _ARG_1_ == ATK_KIND_BURN or _ARG_1_ == ATK_KIND_FAINT or _ARG_1_ == ATK_KIND_POISON or _ARG_1_ == ATK_KIND_SLEEP or _ARG_1_ == ATK_KIND_BIND then
  elseif Enemy.IsSpecialDamage(_ARG_0_.myHandle) then
  else
    if _ARG_0_:GetState() == "Struggle" then
      return 1
    end
    print("Damage = " .. Entity.GetDamagePoint(_ARG_0_.myHandle) .. [[

Now Damage = ]] .. _ARG_0_.SavingsDamage .. "\n")
    _ARG_0_.SavingsDamage = _ARG_0_.SavingsDamage + Entity.GetDamagePoint(_ARG_0_.myHandle)
    if _ARG_0_.SavingsDamage < _UPVALUE0_ then
      return 1
    end
    _ARG_0_:GotoState("Damage")
    return 1
  end
end
function b10ls00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function b10ls00.OnHitAttack(_ARG_0_)
end
function b10ls00.BodyAngle(_ARG_0_)
  if _ARG_0_.BodyFlag == _UPVALUE0_ then
  elseif _ARG_0_.BodyFlag == _UPVALUE1_ then
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle, 7)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.targetPos, _ARG_0_.WorkVec1)
    FVECTOR3.normalize(_ARG_0_.workVec)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 25 then
    end
    _ARG_0_.oldAnglx = DegToRad(20)
    _ARG_0_.WorkVec:set(0, 0, ROUND_PI((DegToRad(20))))
    if _ARG_0_.WorkVec:getz() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.WorkVec:setz(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.WorkVec:getz() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.WorkVec:setz(_ARG_0_.LookMaxMin[1].Min)
    end
    print("z = " .. RadToDeg(_ARG_0_.WorkVec:getz()) .. "\n")
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
    _ARG_0_.BodyFlag = _UPVALUE2_
  elseif _ARG_0_.BodyFlag == _UPVALUE2_ then
    _ARG_0_.WorkVec:set(0, 0, ROUND_PI(_ARG_0_.oldAnglx))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
  end
end
function b10ls00.PlayVoice(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Sound.PlayVoice(141, _ARG_1_, 1, _ARG_0_.workVec, SE_OPT_ALWAYS)
end
function b10ls00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:BodyAngle()
end
function b10ls00.OnDead(_ARG_0_)
  print("\142\128\150S.")
  SetupBossDead(_ARG_0_.myHandle)
  _ARG_0_:GotoState("Dead")
  return 1
end
function b10ls00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.targetHandle = Player.GetHandle()
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function b10ls00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("b10ls00", function(_ARG_0_)
  return (b10ls00:new())
end)
