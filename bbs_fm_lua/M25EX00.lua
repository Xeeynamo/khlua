M25_FAST_MOB = 0
m25ex00 = {}
m25ex00_base_mt = {__index = __StateMachine}
setmetatable(m25ex00, m25ex00_base_mt)
m25ex00_mt = {__index = m25ex00}
function m25ex00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m25ex00_mt)
end
m25ex00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin(_ARG_0_.myHandle, 1, _UPVALUE0_, 1)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:Idling\n")
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Script.Random() < _UPVALUE0_ then
        _ARG_0_:GotoState("AhedMove")
      else
        _ARG_0_:GotoState("InIdling")
      end
    end
  },
  InIdling = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:InIdling\n")
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_:GotoState("InIdlingEnd")
    end
  },
  InIdlingEnd = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:InIdlingEnd\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if Script.Random() < _UPVALUE0_ then
          _ARG_0_:GotoState("NeedleSpin")
        else
          _ARG_0_:GotoState("Idling")
        end
      end
    end
  },
  InIdlingNeedle = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:InIdlingNeedle\n")
      Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * _UPVALUE0_ + Script.Random() * _UPVALUE0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      _ARG_0_:GotoState("NeedleSpin")
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:AhedMove\n")
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  AhedMove = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:AhedMove\n")
      Entity.SetTimer(_ARG_0_.myHandle, 200)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.away = 5
      _ARG_0_.WorkVec:set(0, 0, 0)
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
      _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Cos((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getx()))
      _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + ((_ARG_0_.away * Script.Random() + _ARG_0_.away) * Math.Sin((RoundPI(Script.Random() * 5 * PI))) + _ARG_0_.WorkVec:getz()))
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1)
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, _UPVALUE0_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChngeState()
      end
    end
  },
  BackMove = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:BackMove\n")
      Entity.SetTimer(_ARG_0_.myHandle, 200)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, -_UPVALUE0_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChngeState()
      end
    end
  },
  RightMove = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:RightMove\n")
      Entity.SetTimer(_ARG_0_.myHandle, 200)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, -_UPVALUE0_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChngeState()
      end
    end
  },
  LeftMove = {
    OnBeginState = function(_ARG_0_)
      print("m25ex00:LeftMove\n")
      Entity.SetTimer(_ARG_0_.myHandle, 200)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.RLSpeed = HomingDegree(_ARG_0_.RLSpeed, _UPVALUE0_, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      _ARG_0_.ABSpeed = HomingDegree(_ARG_0_.ABSpeed, 0, 0.05, Entity.GetFrameRate(_ARG_0_.myHandle))
      FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.RLSpeed, 0, _ARG_0_.ABSpeed)
      Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:ChngeState()
      end
    end
  },
  CounterNeedle = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.damageNum = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Tentaclebeam = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 33 then
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 14)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 16)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 18)
        _ARG_0_:CreateShot(_ARG_0_.myHandle, 20)
        _ARG_0_.step = 1
      else
      end
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  TentacleRotation = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  NeedleSpin = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, 120)
      _ARG_0_.ABSpeed = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
      if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 40 then
        _ARG_0_:AheadMove(0.15, 0.1)
      end
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("NeedleSpinEnd")
      end
    end
  },
  NeedleSpinEnd = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:StopMove(0.15, 0.01)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Division = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 41 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          Entity.GetScale(_ARG_0_.NowScale, _ARG_0_.myHandle)
          _ARG_0_.NowScale:set(_ARG_0_.NowScale:getx() * 0.8, _ARG_0_.NowScale:gety() * 0.8, _ARG_0_.NowScale:getz() * 0.8)
          Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.NowScale)
          EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))):GotoState("NewJerry")
          EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))).NowScale:set(_ARG_0_.NowScale:getx() * 0.8, _ARG_0_.NowScale:gety() * 0.8, _ARG_0_.NowScale:getz() * 0.8)
          Entity.SetScale(Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.NowScale)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  NewJerry = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_:SetMotion(_UPVALUE0_)
      Entity.SetAnimNowFrame(_ARG_0_.myHandle, 41)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
      print("m25ex Dead\129I\129I\129I\n")
      _ARG_0_:SetMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 41 then
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        Entity.GetScale(_ARG_0_.NowScale, _ARG_0_.myHandle)
        if Entity.GetName(_ARG_0_.myHandle) == "m25vs00" then
        else
        end
        if Entity.IsAlive((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))) == false or Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot) == NULL_HANDLE then
          print("m25ex \130\177\130\234\136\200\143\227\149\170\151\244\130\197\130\171\130\200\130\162\130\230\130\193\129I\129I\129I\n")
          Enemy.Dead(_ARG_0_.myHandle)
          return
        end
        _ARG_0_.NowScale:set(_ARG_0_.NowScale:getx() * 0.8, _ARG_0_.NowScale:gety() * 0.8, _ARG_0_.NowScale:getz() * 0.8)
        Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.NowScale)
        EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))):GotoState("NewJerry")
        EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))).NowScale:set(_ARG_0_.NowScale:getx() * 0.8, _ARG_0_.NowScale:gety() * 0.8, _ARG_0_.NowScale:getz() * 0.8)
        Entity.SetScale(Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot), EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))).NowScale)
        if Entity.GetName(_ARG_0_.myHandle) == "m25vs00" then
        else
        end
        if Entity.IsAlive((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))) == false or Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot) == NULL_HANDLE then
          print("m25ex \130\177\130\234\136\200\143\227\149\170\151\244\130\197\130\171\130\200\130\162\130\230\130\193\129I\129I\129I\n")
          Enemy.Dead(_ARG_0_.myHandle)
          return
        end
        Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.NowScale)
        EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))):GotoState("NewJerry")
        EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))).NowScale:set(_ARG_0_.NowScale:getx() * 0.8, _ARG_0_.NowScale:gety() * 0.8, _ARG_0_.NowScale:getz() * 0.8)
        Entity.SetScale(Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot), EntityManager:GetEntity((Entity.CreateEntity("m25ex00", _ARG_0_.myPos, _ARG_0_.rot))).NowScale)
        Enemy.Dead(_ARG_0_.myHandle)
      end
    end
  },
  DeadEnd = {
    OnBeginState = function(_ARG_0_)
      Entity.SetAlpha(_ARG_0_.myHandle, 0)
      Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.myHandle == M25_FAST_MOB and Enemy.SearchEnemy(_ARG_0_.myHandle, "m25vs00", SEARCH_TYPE_NEAR) == NULL_HANDLE then
        Enemy.Dead(_ARG_0_.myHandle)
      else
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
function m25ex00.SetMotionWithSameCheck(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
end
function m25ex00.SetMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
end
function m25ex00.ChngeState(_ARG_0_)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
    if Script.Random() < _UPVALUE1_ then
      _ARG_0_:ContinuanceMove()
    elseif Script.Random() < _UPVALUE2_ then
      _ARG_0_:GotoState("TentacleRotation")
    else
      _ARG_0_:GotoState("Tentaclebeam")
    end
  elseif Script.Random() < _UPVALUE1_ then
    _ARG_0_:ContinuanceMove()
  else
    _ARG_0_:GotoState("InIdlingNeedle")
  end
end
function m25ex00.ContinuanceMove(_ARG_0_)
  if Script.Random() < 0.25 then
    _ARG_0_:GotoState("AhedMove")
  elseif Script.Random() < 0.5 then
    _ARG_0_:GotoState("RightMove")
  elseif Script.Random() < 0.75 then
    _ARG_0_:GotoState("RightMove")
  else
    _ARG_0_:GotoState("LeftMove")
  end
end
function m25ex00.CreateShot(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 2)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.WorkVec:set(0.2, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec, _ARG_1_, _ARG_0_.WorkVec, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
  _ARG_0_.WorkVec:set(1, 0, 0)
  Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_1_, _ARG_0_.WorkVec, _ARG_2_)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex250", "E025_BEM_00_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.2, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.2, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), _ARG_0_.myHandle, 0)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex250", "E025_HIT_00_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), "e_ex250", "E025_HIT_00_0")
  Bullet.EnableReflect(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("b25ex00b", _ARG_0_.WorkVec1, _ARG_0_.rot), 0.25)
end
function m25ex00.AheadMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m25ex00.StopMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function m25ex00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.DivFlag75 = 0
  _ARG_0_.DivFlag50 = 0
  _ARG_0_.DivFlag25 = 0
  _ARG_0_.ABSpeed = 0
  _ARG_0_.RLSpeed = 0
  _ARG_0_.Speed = 0
  _ARG_0_.damageNum = 0
  _ARG_0_.counterNum = 0
  _ARG_0_.exec = 0
  _ARG_0_.c = 0
  _ARG_0_.theta = 0
  _ARG_0_.exec2 = 0
  _ARG_0_.c2 = 0
  _ARG_0_.theta2 = 0
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.NowScale = FVECTOR3.new(1, 1, 1)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    M25_FAST_MOB = _ARG_1_
    _UPVALUE0_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function m25ex00.RestHpRate(_ARG_0_)
  return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
end
function m25ex00.OnDamage(_ARG_0_, _ARG_1_)
  print("OnDamage\n")
  _ARG_0_.exec = true
  _ARG_0_.c = 0.12
  _ARG_0_.theta = 0
  _ARG_0_.exec2 = true
  _ARG_0_.c2 = 0.1
  _ARG_0_.theta2 = 0
end
function m25ex00.OnDead(_ARG_0_)
  Entity.GetScale(_ARG_0_.NowScale, _ARG_0_.myHandle)
  if _ARG_0_.NowScale:getx() < 0.3 then
  elseif Enemy.IsSpecialDamage(_ARG_0_.myHandle) then
  else
    _ARG_0_:GotoState("Dead")
    return 2
  end
end
function m25ex00.OnNoReaction(_ARG_0_, _ARG_1_)
  if Enemy.IsStop(_ARG_0_.myHandle) then
    return
  end
  print("OnNoReaction\n")
  _ARG_0_.exec = true
  _ARG_0_.c = 0.15
  _ARG_0_.theta = 0
  _ARG_0_.exec2 = true
  _ARG_0_.c2 = 0.15
  _ARG_0_.theta2 = 0
end
function m25ex00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function m25ex00.OnHitAttack(_ARG_0_)
end
function m25ex00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.exec then
    _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0025
    if _ARG_0_.c < 0 then
      _ARG_0_.exec = false
    end
    Entity.GetLocalBoneTrans(_ARG_0_.workVec, _ARG_0_.myHandle, 3)
    _ARG_0_.workVec:set(_ARG_0_.workVec:getx() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:gety() + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, _ARG_0_.workVec:getz() + Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _ARG_0_.workVec, 3)
    Entity.GetScale(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:set(1 + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, 1 + Math.Cos(_ARG_0_.theta) * _ARG_0_.c, 1 + Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.ScalingBone(_ARG_0_.myHandle, 3, _ARG_0_.workVec)
  end
  if _ARG_0_.exec2 then
    _ARG_0_.theta2 = RoundPI(_ARG_0_.theta2 + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c2 = _ARG_0_.c2 - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.0015
    if 0 > _ARG_0_.c2 then
      _ARG_0_.exec2 = false
    end
    Entity.GetLocalBoneTrans(_ARG_0_.workVec, _ARG_0_.myHandle, 2)
    _ARG_0_.workVec:set(_ARG_0_.workVec:getx() + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, _ARG_0_.workVec:gety() + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, _ARG_0_.workVec:getz() + Math.Sin(_ARG_0_.theta2) * _ARG_0_.c2)
    Entity.SetLocalBoneTrans(_ARG_0_.myHandle, _ARG_0_.workVec, 2)
    Entity.GetScale(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:set(1 + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, 1 + Math.Cos(_ARG_0_.theta2) * _ARG_0_.c2, 1 + Math.Sin(_ARG_0_.theta2) * _ARG_0_.c2)
    Entity.ScalingBone(_ARG_0_.myHandle, 2, _ARG_0_.workVec)
  end
end
function m25ex00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function m25ex00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m25ex00", function(_ARG_0_)
  return (m25ex00:new())
end)
EntityFactory:Add("m25vs00", function(_ARG_0_)
  return (m25ex00:new())
end)
b25ex00b = {}
b25ex00b_mt = {__index = b25ex00b}
function b25ex00b.new(_ARG_0_)
  return setmetatable({}, b25ex00b_mt)
end
function b25ex00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.SetTimer(_ARG_0_.myHandle, 180)
end
function b25ex00b.OnHitAttack(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  return 1
end
function b25ex00b.OnHitBg(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
    _ARG_0_.step = 1
  end
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
end
function b25ex00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
    end
  elseif _ARG_0_.step == 1 then
  end
end
EntityFactory:Add("b25ex00b", function(_ARG_0_)
  return (b25ex00b:new())
end)
