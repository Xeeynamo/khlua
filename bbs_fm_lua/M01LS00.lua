WorkVec = FVECTOR3.new(0, 0, 0)
WorkVec1 = FVECTOR3.new(0, 0, 0)
workVec = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
workVec2 = FVECTOR3.new(0, 0, 0)
TagetPos = FVECTOR3.new(0, 0, 0)
Neck1Vec = FVECTOR3.new(0, 0, 0)
Neck2Vec = FVECTOR3.new(0, 0, 0)
Neck3Vec = FVECTOR3.new(0, 0, 0)
Neck4Vec = FVECTOR3.new(0, 0, 0)
m01ls00 = {}
m01ls00_base_mt = {__index = __StateMachine}
setmetatable(m01ls00, m01ls00_base_mt)
m01ls00_mt = {__index = m01ls00}
function m01ls00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), m01ls00_mt)
end
m01ls00.states = {
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("Idling\n")
      _ARG_0_.IsAttack = 0
      _ARG_0_.startWait = 60
      _ARG_0_.startWait = 30
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if Entity.IsPlayer(_ARG_0_.targetHandle) then
        _ARG_0_.startWait = _ARG_0_.startWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      else
        return
      end
      if _ARG_0_.startWait < 0 and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_:GotoState("Start")
      end
    end
  },
  Start = {
    OnBeginState = function(_ARG_0_)
      print("Start\n")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Search")
      end
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      print("Search\n")
      _ARG_0_.IsAttack = 1
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsPlayer(_ARG_0_.targetHandle) then
      else
        _ARG_0_:GotoState("Stop")
        return
      end
      if _ARG_0_.targetHandle == NULL_HANDLE then
        _ARG_0_:GotoState("Stop")
      end
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        if _ARG_0_.wait < 0 and Player.GetPlayerID(_ARG_0_.targetHandle) ~= PLAYER_ID_AQUA then
          if Script.Random() < _UPVALUE1_ then
            _ARG_0_:GotoState("Shoot")
          else
            _ARG_0_:GotoState("Shoot3")
          end
        end
      else
        _ARG_0_:GotoState("Stop")
      end
      _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Shoot = {
    OnBeginState = function(_ARG_0_)
      print("Shoot\n")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.wait < 0 then
        _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE0_, 0)
        _ARG_0_.wait = _UPVALUE1_
      end
      _ARG_0_:GotoState("Search")
    end
  },
  Shoot3 = {
    OnBeginState = function(_ARG_0_)
      print("Shoot3\n")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.step = 1
        _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE0_, DegToRad(-_UPVALUE1_))
        _ARG_0_.shootWait = _UPVALUE2_
      elseif _ARG_0_.step == 1 then
        if 0 > _ARG_0_.shootWait then
          _ARG_0_.shootWait = _UPVALUE2_
          _ARG_0_.step = 2
          _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE0_, 0)
        end
      elseif _ARG_0_.step == 2 then
        if 0 > _ARG_0_.shootWait then
          _ARG_0_.shootWait = _UPVALUE2_
          _ARG_0_.step = 3
          _ARG_0_:CreateShot(_ARG_0_.myHandle, _UPVALUE0_, DegToRad(_UPVALUE1_))
        end
      elseif _ARG_0_.step == 3 then
        _ARG_0_:GotoState("Search")
        _ARG_0_.wait = 60
      end
      _ARG_0_.shootWait = _ARG_0_.shootWait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Stop = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.IsAttack = 0
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
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Search")
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.IsAttack = 0
      _ARG_0_:NeckDispOff()
      Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
      Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle, 6)
      Entity.GetRot(workVec1, _ARG_0_.myHandle)
      Entity.SetEffect(_ARG_0_.myHandle, "g_ls_blast0", "G_LS_BLS_CRS0_0", WorkVec1, workVec1)
      WorkVec1:set(0, 0, 0)
      Entity.AttachEffect(_ARG_0_.myHandle, "g_ls_blast0", "G_LS_BLS_KEM0_0", "bone_05", WorkVec1, WorkVec1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
function m01ls00.NeckDispOff(_ARG_0_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 0)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 8, 0)
end
function m01ls00.OnDamage(_ARG_0_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 then
    return 0
  end
  _ARG_0_:GotoState("Damage")
  return 1
end
function m01ls00.Neck(_ARG_0_)
  Entity.GetWorldPos(WorkVec, _ARG_0_.targetHandle, 0)
  Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle, _UPVALUE0_)
  Entity.GetRot(workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
  FVECTOR3.normalize(workVec)
  Neck1Vec:set(0, 0, RoundPI((HomingDegree(_ARG_0_.oldAngly, Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle))))))
  _ARG_0_.oldAngly = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  if Neck1Vec:getz() > _ARG_0_.LookMaxMin[0].Max then
    Neck1Vec:setz(_ARG_0_.LookMaxMin[0].Max)
  end
  if Neck1Vec:getz() < _ARG_0_.LookMaxMin[0].Min then
    Neck1Vec:setz(_ARG_0_.LookMaxMin[0].Min)
  end
  Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle, _UPVALUE1_)
  Entity.GetRot(workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
  FVECTOR3.normalize(workVec)
  Neck2Vec:set(RoundPI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())), 1, (Entity.GetFrameRate(_ARG_0_.myHandle))))), 0, 0)
  _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())), 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  if Neck2Vec:getx() > _ARG_0_.LookMaxMin[1].Max then
    Neck2Vec:setx(_ARG_0_.LookMaxMin[1].Max)
  end
  if Neck2Vec:getx() < _ARG_0_.LookMaxMin[1].Min then
    Neck2Vec:setx(_ARG_0_.LookMaxMin[1].Min)
  end
  Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle, _UPVALUE2_)
  Entity.GetRot(workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
  FVECTOR3.normalize(workVec)
  Neck3Vec:set(RoundPI((HomingDegree(_ARG_0_.oldAnglx2, -Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())) - Neck2Vec:getx(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle))))), RoundPI((HomingDegree(_ARG_0_.oldAngly2, Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety() - Neck1Vec:getz(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle))))), 0)
  _ARG_0_.oldAngly2, _ARG_0_.oldAnglx2 = HomingDegree(_ARG_0_.oldAngly2, Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety() - Neck1Vec:getz(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx2, -Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())) - Neck2Vec:getx(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.GetWorldPos(WorkVec1, _ARG_0_.myHandle, _UPVALUE2_)
  Entity.GetRot(workVec1, _ARG_0_.myHandle)
  FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
  FVECTOR3.normalize(workVec)
  Neck4Vec:set(RoundPI(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())) - HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())), 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))), RoundPI(Math.Atan2(workVec:getx(), workVec:getz()) - HomingDegree(_ARG_0_.oldAngly, Math.Atan2(workVec:getx(), workVec:getz()) - workVec1:gety(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))), 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE0_, Neck1Vec)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE1_, Neck2Vec)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, _UPVALUE3_, Neck3Vec)
end
function m01ls00.CreateShot(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetWorldPos(WorkVec, _ARG_0_.targetHandle, 2)
  print([[

x = ]] .. WorkVec:getx() .. "\n")
  print([[

y = ]] .. WorkVec:gety() .. "\n")
  print([[

z = ]] .. WorkVec:getz() .. "\n")
  Entity.GetWorldPos(WorkVec1, _ARG_1_, _ARG_2_)
  FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
  FVECTOR3.normalize(workVec)
  WorkVec:set(0, 0, 1)
  Entity.GetWorldPos2(WorkVec, _ARG_1_, WorkVec, _ARG_2_)
  WorkVec1:set(0, 0, 0.3)
  Entity.GetWorldPos2(WorkVec1, _ARG_1_, WorkVec1, _ARG_2_)
  FVECTOR3.Sub(workVec, WorkVec, WorkVec1)
  FVECTOR3.normalize(workVec)
  workVec1:set(-Math.Atan2(workVec:gety(), Math.Sqrt(workVec:getz() * workVec:getz() + workVec:getx() * workVec:getx())), Math.Atan2(workVec:getx(), workVec:getz()), 0)
  workVec1:sety(workVec1:gety() + _ARG_3_)
  Entity.SetEffect(_ARG_1_, "g_ls_blast0", "G_LS_BLS_FIR0_0", WorkVec1, workVec1)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("", WorkVec1, workVec1), "g_ls_blast0", "G_LS_BLS_TAM0_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("", WorkVec1, workVec1), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("", WorkVec1, workVec1), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("", WorkVec1, workVec1), _ARG_0_.myHandle, 0)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("", WorkVec1, workVec1), "g_ls_blast0", "G_LS_BLS_HIT0_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("", WorkVec1, workVec1), "g_ls_blast0", "G_LS_BLS_HIT1_0")
  Bullet.EnableReflect(Bullet.CreateBullet("", WorkVec1, workVec1), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("", WorkVec1, workVec1), 0.25)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("", WorkVec1, workVec1), 225)
end
function m01ls00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.IsAttack = 0
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.oldAnglx2 = 0
  _ARG_0_.oldAngly2 = 0
  _ARG_0_.wait = 0
  _ARG_0_.shootWait = 0
  _ARG_0_.LookMaxMin = {}
  _ARG_0_.LookMaxMin[0] = {
    Max = DegToRad(40),
    Min = DegToRad(-40)
  }
  _ARG_0_.LookMaxMin[1] = {
    Max = DegToRad(30),
    Min = DegToRad(-10)
  }
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 7)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "SearDis")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "RateShot")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "ShotWait")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "3ShotWait")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "ShotAng")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
  end
  _ARG_0_:GotoState("Idling")
  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
end
function m01ls00.OnDead(_ARG_0_)
  _ARG_0_:GotoState("Dead")
  return 1
end
function m01ls00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function m01ls00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.IsAttack == 1 then
    _ARG_0_:Neck()
  else
    _ARG_0_.oldAnglx = 0
    _ARG_0_.oldAngly = 0
  end
end
function m01ls00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
end
EntityFactory:Add("m01ls00", function(_ARG_0_)
  return (m01ls00:new())
end)
