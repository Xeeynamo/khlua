setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        SetupAppearEnd(_ARG_0_.myHandle)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsModelFade(_ARG_0_.myHandle) == false then
          Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
          Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:ChangeMoveState()
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("BulletFire2")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Script.Random() < _UPVALUE0_ then
            _ARG_0_:GotoState("BulletFire1")
          else
            _ARG_0_:GotoState("BulletFire2")
          end
        end
      end
    },
    MoveTargetBack = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ - _ARG_0_.decMoveTime)
        if Script.Random() < 0.5 then
          _ARG_0_.rotSpeed = 1
        else
          _ARG_0_.rotSpeed = -1
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:CalcRotMoveVelocity(_ARG_0_.rotSpeed, _UPVALUE0_)
        if _ARG_0_:IsPlayerBack() or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    MoveFar = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ - _ARG_0_.decMoveTime)
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
        _UPVALUE2_:sety(_UPVALUE3_:gety())
        for _FORV_6_ = 0, 360, 30 do
          _UPVALUE3_:copy(_UPVALUE2_)
          _UPVALUE3_:setx(_UPVALUE3_:getx() + Script.RandomInRange(10, 25) * Math.Cos((RoundPI(DegToRad(_FORV_6_)))))
          _UPVALUE3_:setz(_UPVALUE3_:getz() + Script.RandomInRange(10, 25) * Math.Sin((RoundPI(DegToRad(_FORV_6_)))))
          Collision.IntersectRayBg(_UPVALUE3_, COLL_KIND_ENEMY, _UPVALUE2_, _UPVALUE3_)
          FVECTOR3.Sub(_UPVALUE4_, _UPVALUE2_, _UPVALUE3_)
          if 0 < _UPVALUE4_:dot(_UPVALUE4_) then
            _ARG_0_.targetPos:copy(_UPVALUE3_)
          end
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Wander = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 1)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ - _ARG_0_.decMoveTime)
        _ARG_0_.timer = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.EnableAvoidPlayer(_ARG_0_.myHandle, 0)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.timer <= 0 then
          Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
          _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + Script.RandomInRange(4, 10) * Math.Cos((Script.RandomInRange(-PI, PI))))
          _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + Script.RandomInRange(4, 10) * Math.Sin((Script.RandomInRange(-PI, PI))))
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
          Collision.IntersectRayBg(_ARG_0_.targetPos, COLL_KIND_ENEMY, _UPVALUE0_, _ARG_0_.targetPos)
          _ARG_0_.timer = 30
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) <= 1 then
          _ARG_0_.timer = 0
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE1_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    BulletFire1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
            Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
            print("\146e\130\204\144\1481 " .. _UPVALUE1_(_ARG_0_.fireBall_1_MinNum, _ARG_0_.fireBall_1_MaxNum) .. "\n")
            for _FORV_7_ = 1, _UPVALUE1_(_ARG_0_.fireBall_1_MinNum, _ARG_0_.fireBall_1_MaxNum) do
              _UPVALUE2_:set(-(1.5 * (_UPVALUE1_(_ARG_0_.fireBall_1_MinNum, _ARG_0_.fireBall_1_MaxNum) / 2)) + Script.RandomInRange(-0.5, 0.5), Script.RandomInRange(-0.5, 0.5), Script.RandomInRange(-0.5, 0.5))
              _ARG_0_:CreateFireBall(_UPVALUE0_:gety(), 0.25, 5, _ARG_0_.fireBallGravity, _UPVALUE2_)
            end
            _ARG_0_.step = 1
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:ChangeMoveState()
        end
      end
    },
    BulletFire2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.count = _UPVALUE1_(_ARG_0_.fireBall_2_MinNum, _ARG_0_.fireBall_2_MaxNum)
        print("\146e\130\204\144\1482 " .. _ARG_0_.count .. "\n")
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.GetStartPos(_UPVALUE0_, _ARG_0_.myHandle)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 18 then
            Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
            _ARG_0_:CreateFireBall(_UPVALUE0_:gety(), 0.25, 5, _ARG_0_.fireBallGravity)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.count = _ARG_0_.count - 1
            if 0 < _ARG_0_.count then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
              Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.myHandle)
              _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + Script.RandomInRange(5, 10) * Math.Cos((Script.RandomInRange(-PI, PI))))
              _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + Script.RandomInRange(5, 10) * Math.Sin((Script.RandomInRange(-PI, PI))))
              _ARG_0_.timer = 30
              _ARG_0_.step = 2
            else
              _ARG_0_:ChangeMoveState()
            end
          end
        else
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 10)
          Entity.CalcVelocityXZ(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.timer = _ARG_0_.timer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.timer or 1 >= Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetPos) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = 0
          end
        end
      end
    }
  },
  ChangeMoveState = function(_ARG_0_)
    if Script.Random() < _UPVALUE0_ then
      _ARG_0_:GotoState("MoveTargetBack")
    elseif Script.Random() >= _UPVALUE0_ and Script.Random() < _UPVALUE0_ + _UPVALUE1_ then
      _ARG_0_:GotoState("MoveFar")
    elseif Script.Random() >= _UPVALUE0_ + _UPVALUE1_ and Script.Random() < _UPVALUE0_ + _UPVALUE1_ + _UPVALUE2_ then
      _ARG_0_:GotoState("Wander")
    else
      _ARG_0_:GotoState("Idling2")
    end
  end,
  CreateFireBall = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
    _UPVALUE0_:set(0, 1.06, 0.47)
    _UPVALUE1_:set(DegToRad(-40), 0, 0)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE1_)
    Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "koshi", _UPVALUE0_)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
    if _ARG_5_ ~= nil then
      Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "Root", _ARG_5_)
      FVECTOR3.Add(_UPVALUE0_, _UPVALUE0_, _ARG_5_)
    end
    _UPVALUE1_:set(0, _ARG_1_, 0)
    SetBulletAttackParam(Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, 4)
    Entity.CalcOrbitVelocityFromSpeedY(Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_), _ARG_2_, _ARG_3_)
    Bullet.EnableDamageCollision(Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_), 1)
    if EntityManager:GetEntity((Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_))) ~= nil then
      EntityManager:GetEntity((Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_))).dist = _ARG_3_ * 0.5
      EntityManager:GetEntity((Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_))).gravity = _ARG_4_
    end
    return (Bullet.CreateBullet("FireBall", _UPVALUE0_, _UPVALUE1_))
  end,
  CalcRotMoveVelocity = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _UPVALUE0_:set(Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Sin((Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle))), 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Cos((Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle))))
    _UPVALUE1_:set(Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Sin((RoundPI(DegToRad(_ARG_1_) + Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle)))), 0, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) * Math.Cos((RoundPI(DegToRad(_ARG_1_) + Entity.CalcDirection(_ARG_0_.targetHandle, _ARG_0_.myHandle)))))
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE1_, _UPVALUE0_)
    _UPVALUE0_:normalize()
    _UPVALUE0_:scale(_ARG_2_)
    Entity.GetVelocity(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:setx(_UPVALUE0_:getx())
    _UPVALUE1_:setz(_UPVALUE0_:getz())
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
    Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE1_:sety((Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz())))
    Entity.SetRot(_ARG_0_.myHandle, _UPVALUE1_)
  end,
  IsPlayerBack = function(_ARG_0_)
    Entity.GetDir(_UPVALUE0_, _ARG_0_.targetHandle)
    _UPVALUE0_:scale(-1)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE2_)
    _UPVALUE3_:normalize()
    if _UPVALUE0_:dot(_UPVALUE3_) >= Math.Cos(DegToRad(30)) then
      return true
    end
    return false
  end,
  UpdateBalance = function(_ARG_0_)
    if Enemy.IsAllEnemyWaiting() then
      return
    end
    if Mission.SendMissonMessage(MES_MISSION_GET_SCORE) >= _ARG_0_.paramChangeCount then
      _ARG_0_.paramChangeCount = _ARG_0_.paramChangeCount + _UPVALUE0_
      print("\131p\131\137\131\129\129[\131^\149\207\137\187 " .. _ARG_0_.paramChangeCount .. "\n")
      _ARG_0_.fireBall_1_MinNum = _ARG_0_.fireBall_1_MinNum + _UPVALUE1_
      if _ARG_0_.fireBall_1_MinNum >= _UPVALUE2_ then
        _ARG_0_.fireBall_1_MinNum = _UPVALUE2_
      end
      _ARG_0_.fireBall_1_MaxNum = _ARG_0_.fireBall_1_MaxNum + _UPVALUE1_
      if _ARG_0_.fireBall_1_MaxNum >= _UPVALUE3_ then
        _ARG_0_.fireBall_1_MaxNum = _UPVALUE3_
      end
      _ARG_0_.fireBall_2_MinNum = _ARG_0_.fireBall_2_MinNum + _UPVALUE1_
      if _ARG_0_.fireBall_2_MinNum >= _UPVALUE4_ then
        _ARG_0_.fireBall_2_MinNum = _UPVALUE4_
      end
      _ARG_0_.fireBall_2_MaxNum = _ARG_0_.fireBall_2_MaxNum + _UPVALUE1_
      if _ARG_0_.fireBall_2_MaxNum >= _UPVALUE5_ then
        _ARG_0_.fireBall_2_MaxNum = _UPVALUE5_
      end
      _ARG_0_.fireBallGravity = _ARG_0_.fireBallGravity + _UPVALUE6_
      _ARG_0_.decMoveTime = _ARG_0_.decMoveTime + _UPVALUE7_
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_1_, "Count")
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_1_, "IncBullet")
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_1_, "IncGravity")
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_1_, "DecMoveTime")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_1_, "Min1")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_1_, "Max1")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "Min2")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "Max2")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.count = 0
    _ARG_0_.rotSpeed = 1
    _ARG_0_.timer = 0
    _ARG_0_.decMoveTime = 0
    _ARG_0_.paramChangeCount = _UPVALUE0_
    _ARG_0_.fireBallGravity = _UPVALUE8_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.fireBall_1_MaxNum = 1
    _ARG_0_.fireBall_1_MinNum = 3
    _ARG_0_.fireBall_2_MaxNum = 1
    _ARG_0_.fireBall_2_MinNum = 3
    Enemy.EnableInvincible(_ARG_1_, 1)
    Entity.SetMovementCollRadius(_ARG_1_, 1)
    Entity.SetLowerHalf(_ARG_1_, 1.5)
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Player.SetBattleFlagTargetHpOff(1)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnUpdate = function(_ARG_0_)
    if Entity.IsAlive(_ARG_0_.targetHandle) == false then
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end
    _ARG_0_:UpdateBalance()
    _ARG_0_:Update()
    _ARG_0_:Debug()
  end,
  Debug = function(_ARG_0_)
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
}, {__index = __StateMachine})
EntityFactory:Add("m51ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("FireBall", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
