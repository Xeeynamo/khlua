g32vs00 = {}
g32vs00_base_mt = {__index = __StateMachine}
setmetatable(g32vs00, g32vs00_base_mt)
g32vs00_mt = {__index = g32vs00}
function g32vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g32vs00_mt)
end
g32vs00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
    end
  },
  Waiting = {
    OnBeginState = function(_ARG_0_)
      print("Waiting\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("Idling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Attack")
      end
    end
  },
  NoAttackIdling = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Attack = {
    OnBeginState = function(_ARG_0_)
      print("AttackIdling\n")
      if Script.Random() < 0.5 then
        _ARG_0_.balletType = 0
      else
        _ARG_0_.balletType = 1
      end
      _ARG_0_:setAttackMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 80 then
          if _ARG_0_.balletType == 0 then
          else
            _ARG_0_:CreateShoot(_ARG_0_.myHandle, 45)
            _ARG_0_:CreateShoot(_ARG_0_.myHandle, 135)
            _ARG_0_:CreateShoot(_ARG_0_.myHandle, 225)
            _ARG_0_:CreateShoot(_ARG_0_.myHandle, 315)
          end
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 110 then
          if _ARG_0_.balletType == 0 then
            _ARG_0_:createEffect("g_vs_032_00", "G32VS_HIT_11_0")
          else
            _ARG_0_:createEffect("g_vs_032_00", "G32VS_HIT_12_0")
          end
          _ARG_0_.step = 2
          _ARG_0_.damageFloorTimer = Gimmick.GetExtraParam(_UPVALUE0_, "DamageT") * 60
        end
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  }
}
function g32vs00.setMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
end
function g32vs00.setAttackMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_, _ARG_0_.balletType, _ARG_0_.balletType)
end
function g32vs00.OnTouchRide(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.damageFloorTimer <= 0 then
    return
  end
  if _ARG_0_.balletType == 1 then
    return
  end
  _ARG_0_.damageWait = _ARG_0_.damageWait - Entity.GetFrameRate(_ARG_0_.myHandle)
  if Entity.IsPlayer(_ARG_1_) and _ARG_2_ == _ARG_0_.rideID and 0 > _ARG_0_.damageWait then
    _ARG_0_.damageWait = Gimmick.GetExtraParam(_UPVALUE0_, "DamageW")
    Player.SetDamage(_ARG_1_, (Player.CalcDamagePoint(_ARG_1_, Gimmick.GetAttackPoint(_UPVALUE0_, 0), (Gimmick.GetAttackPowerCorrection(_UPVALUE0_, 0)))))
  end
end
function g32vs00.OnInit(_ARG_0_, _ARG_1_)
  G30VS_MOTION_IDLING = Entity.GetMotionIndex(_ARG_1_, "001")
  _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "002")
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.effectHandle = NULL_HANDLE
  _ARG_0_.damageFloorTimer = 0
  _ARG_0_.damageWait = 30
  _ARG_0_.rideID = Entity.AttachRideCollision(_ARG_1_, 0, 0)
  _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "IdlingT") * 60
  _ARG_0_.typeid = Entity.GetLayoutParam(_ARG_1_, 1)
  _ARG_0_.balletType = 0
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  Gimmick.EnableNetwork(_ARG_1_, 1)
  if _ARG_0_.typeid == 1 then
    _ARG_0_:GotoState("NoAttackIdling")
  else
    _ARG_0_:GotoState("Waiting")
  end
end
function g32vs00.CreateShoot(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(0, 2, 0)
  Entity.GetWorldPos2(_UPVALUE0_, _ARG_1_, _UPVALUE0_, 5)
  Entity.GetRot(_UPVALUE1_, _ARG_1_)
  Bullet.SetCollision(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  Bullet.SetAttackParam(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), Gimmick.GetAttackKind(_ARG_0_.myHandle, 0), Gimmick.GetAttackAttr(_ARG_0_.myHandle, 0), Gimmick.GetAttackPoint(_ARG_0_.myHandle, 0), Gimmick.GetAttackPowerCorrection(_ARG_0_.myHandle, 0), 0, Enemy.GetDifficultyCorrection())
  Bullet.SetAttacker(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle)
  Bullet.SetCollKind(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), "g_vs_032_00", "G32VS_HIT_10_0")
  _UPVALUE0_:set(0, 3, 1)
  _UPVALUE1_:set(0, DegToRad(_ARG_2_), 0)
  Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE1_)
  _UPVALUE0_:normalize()
  _UPVALUE0_:scale(0.23)
  Entity.CalcVelocity(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), _UPVALUE0_)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), 14400)
  EntityManager:GetEntity((Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
  Bullet.EnableNoCheckHitBg(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), 1)
  Entity.EnableBgColl(Bullet.CreateBullet("bubble", _UPVALUE0_, _UPVALUE1_), 0)
end
function g32vs00.OnDestroy(_ARG_0_)
  Effect.LoopEnd(_ARG_0_.effectHandle)
end
function g32vs00.loopEndEffect(_ARG_0_)
  if _ARG_0_.effectHandle ~= NULL_HANDLE then
    Effect.LoopEnd(_ARG_0_.effectHandle)
    _ARG_0_.effectHandle = NULL_HANDLE
  end
end
function g32vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.effectHandle == NULL_HANDLE then
    _UPVALUE0_:set(0, 0, 0)
    _UPVALUE1_:set(0, 0, 0)
    _ARG_0_.effectHandle = Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
  end
end
function g32vs00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_.damageFloorTimer = _ARG_0_.damageFloorTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.damageFloorTimer < 0 then
    _ARG_0_.damageFloorTimer = 0
    _ARG_0_:loopEndEffect()
  elseif _ARG_0_.balletType == 1 then
    _UPVALUE0_:set(-5, 0, -13)
    _UPVALUE1_:set(-14.5, 0.5, 6.5)
    _UPVALUE2_:set(5, 0, 15)
    _UPVALUE3_:set(17, 0, -13)
    if Entity.IsPlayer((Player.GetHandle())) and (Entity.CalcDistanceSq(Player.GetHandle(), _UPVALUE0_) < _UPVALUE4_ or Entity.CalcDistanceSq(Player.GetHandle(), _UPVALUE1_) < _UPVALUE4_ or Entity.CalcDistanceSq(Player.GetHandle(), _UPVALUE2_) < _UPVALUE4_ or Entity.CalcDistanceSq(Player.GetHandle(), _UPVALUE3_) < _UPVALUE4_) then
      _ARG_0_.damageWait = _ARG_0_.damageWait - Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 > _ARG_0_.damageWait then
        _ARG_0_.damageWait = Gimmick.GetExtraParam(_UPVALUE5_, "DamageW")
        Player.SetDamage(Player.GetHandle(), (Player.CalcDamagePoint(Player.GetHandle(), Gimmick.GetAttackPoint(_UPVALUE5_, 0), (Gimmick.GetAttackPowerCorrection(_UPVALUE5_, 0)))))
      end
    end
  end
end
EntityFactory:Add("g32vs00", function(_ARG_0_)
  return (g32vs00:new())
end)
EntityFactory:Add("bubble", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g34vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g35vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
