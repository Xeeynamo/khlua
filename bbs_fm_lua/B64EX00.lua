setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Judge = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:ActJudg() == _UPVALUE0_ then
          _ARG_0_:GotoState("Attack1")
        elseif _ARG_0_:ActJudg() == _UPVALUE1_ then
          _ARG_0_:GotoState("MoveRun")
        elseif _ARG_0_:ActJudg() == _UPVALUE2_ then
          _ARG_0_:GotoState("JumpFall")
        elseif _ARG_0_:ActJudg() == _UPVALUE3_ then
          _ARG_0_:GotoState("JumpUp")
        elseif _ARG_0_:ActJudg() == _UPVALUE4_ then
          _ARG_0_:GotoState("Escape")
        else
          _ARG_0_:GotoState("MoveWalk")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInteger(60) + 30)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR, SEARCH_OPTION_NO_CHECK_NPC)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Judge")
          return
        end
        if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, _ARG_0_.targetHandle, 90) == false then
          _ARG_0_:GotoState("Judge")
        end
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
          Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        end
        _ARG_0_.waitmode = 1
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.waitmode = 0
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    MoveRun = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInteger(120) + 120)
        _ARG_0_.Param0 = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Judge")
          return
        end
        if _ARG_0_:ActJudgJumpMov() == true then
          _ARG_0_:GotoState("JumpUp")
          return
        elseif _ARG_0_:ActJudgJumpMov() == 2 then
          _ARG_0_.Param0 = 30
        end
        if _ARG_0_:ActJudg() == _UPVALUE0_ then
          _ARG_0_:GotoState("Attack1")
          return
        elseif _ARG_0_:ActJudg() == _UPVALUE1_ then
          _ARG_0_:GotoState("JumpUp")
          return
        end
        _ARG_0_.Param0 = _ARG_0_.Param0 - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.Param0 < 0 then
          _ARG_0_.Param0 = 0
        end
        if _ARG_0_.Param0 == 0 then
          _ARG_0_:HomingPlayerMove(_UPVALUE2_)
        else
          _ARG_0_:HomingMoveHome(_UPVALUE2_)
        end
      end
    },
    MoveWalk = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInteger(120) + 60)
        _ARG_0_.Param0 = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Judge")
          return
        end
        if _ARG_0_:ActJudgJumpMov() == true then
          _ARG_0_:GotoState("JumpUp")
          return
        elseif _ARG_0_:ActJudgJumpMov() == 2 then
          _ARG_0_.Param0 = 30
        end
        if _ARG_0_:ActJudg() == _UPVALUE0_ then
          _ARG_0_:GotoState("Attack1")
          return
        elseif _ARG_0_:ActJudg() == _UPVALUE1_ then
          _ARG_0_:GotoState("JumpUp")
          return
        end
        _ARG_0_.Param0 = _ARG_0_.Param0 - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.Param0 < 0 then
          _ARG_0_.Param0 = 0
        end
        if _ARG_0_.Param0 == 0 then
          _ARG_0_:HomingPlayerMove(_UPVALUE2_)
        else
          _ARG_0_:HomingMoveHome(_UPVALUE2_)
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Judge")
      end
    },
    JumpUp = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        Entity.GetLocalPos(_ARG_0_.JumpStartPos, _ARG_0_.myHandle)
        _ARG_0_.JumpSpeedY = 0.0049 * _UPVALUE1_
        _ARG_0_.JumpSpdY = _ARG_0_.JumpSpeedY
        _ARG_0_.JumpGravity = -0.0049
        _ARG_0_.JumpHeight = 0
        _ARG_0_.JumpHeightMax = 1.75
        _ARG_0_.Param0 = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetLocalPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.JumpHeight = _ARG_0_.WorkVec:gety() - _ARG_0_.JumpStartPos:gety()
        if _ARG_0_.JumpHeight >= _ARG_0_.JumpHeightMax and _ARG_0_.JumpSpeedY > 0 then
          m_fJumpSpeedY = m_fJumpSpeedY * 0.5
        end
        _ARG_0_.JumpSpeedY = _ARG_0_.JumpSpeedY + _ARG_0_.JumpGravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.JumpSpdY = _ARG_0_.JumpSpeedY
        if _ARG_0_.JumpSpeedY <= 0 then
          _ARG_0_:GotoState("Judge")
        end
        _ARG_0_:HomingPlayerMove(0.05)
        Entity.GetVelocity(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_.WorkVec:sety(_ARG_0_.JumpSpdY)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
    },
    JumpFall = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        _ARG_0_.Param0 = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsGround(_ARG_0_.myHandle) == true and _ARG_0_.Param0 == 0 then
          _ARG_0_.Param0 = 1
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE1_)
          Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
          Entity.ClearSpeed(_ARG_0_.myHandle)
        end
        if _ARG_0_.Param0 == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) == true then
          _ARG_0_:GotoState("Judge")
        end
      end
    },
    Escape = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, Script.RandomInteger(30) + 60)
        Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_ARG_0_.WorkVec2, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.WorkVec1, _ARG_0_.WorkVec1, _ARG_0_.WorkVec2)
        FVECTOR3.normalize(_ARG_0_.WorkVec1)
        FVECTOR3.set(_ARG_0_.WorkVec3, 0, DegToRad(Script.RandomInteger(180)), 0)
        _ARG_0_.WorkVec1 = Math.RotateVectorXYZ(_ARG_0_.WorkVec1, _ARG_0_.WorkVec3)
        FVECTOR3.Scale(_ARG_0_.WorkVec1, _ARG_0_.WorkVec1, Script.Random() * 4 + 2)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.WorkVec1) < 2 then
          _ARG_0_:GotoState("Judge")
          return
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVec1, _UPVALUE0_)
        FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _UPVALUE1_)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
    },
    Attack1 = {
      OnBeginState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
        Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:ActJudg() == _UPVALUE0_ then
            _ARG_0_:GotoState("MoveWalk")
            return
          elseif _ARG_0_:ActJudg() == _UPVALUE1_ then
            _ARG_0_:GotoState("MoveWalk")
            return
          end
          if _ARG_0_.step == 0 then
            if Script.Random() < 0.3 then
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
              Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE2_)
              Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
              Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
              _ARG_0_.step = 10
            else
              _ARG_0_:GotoState("Idling")
              return
            end
          elseif _ARG_0_.step == 10 then
            if Script.Random() < 0.05 then
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
              Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE3_)
              Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
              Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
              _ARG_0_.step = 20
            else
              _ARG_0_:GotoState("Idling")
              return
            end
          else
            _ARG_0_:GotoState("Idling")
            return
          end
        end
      end
    },
    Attack2 = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Attack3 = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  RestHpRate = function(_ARG_0_)
    return Enemy.GetHp(_ARG_0_.myHandle) / Enemy.GetHpMax(_ARG_0_.myHandle)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = 0
    _ARG_0_.keyBladeHandle = 0
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.waitmode = 0
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec2 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec3 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVecClush0 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVecClush1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.Param0 = 0
    _ARG_0_.Param1 = 0
    _ARG_0_.Param2 = 0
    _ARG_0_.Param3 = 0
    _ARG_0_.JumpStartPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.JumpPow = 0
    _ARG_0_.JumpGravity = 0
    _ARG_0_.JumpSpeedY = 0
    _ARG_0_.JumpSpdY = 0
    _ARG_0_.JumpHeight = 0
    _ARG_0_.JumpHeightMax = 0
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    _ARG_0_.keyBladeHandle = Entity.CreateEntity("b61ex00", _ARG_0_.WorkVec, _ARG_0_.WorkVec1, _ARG_0_.myHandle)
    Entity.AttachCoord(_ARG_0_.myHandle, "R_buki", _ARG_0_.keyBladeHandle, "Root")
    Entity.EnableLockon(_ARG_0_.keyBladeHandle, 0)
    Entity.EnableShooton(_ARG_0_.keyBladeHandle, 0)
    if Enemy.IsAllEnemyWaiting() == true then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.keyBladeHandle, _UPVALUE0_)
      Entity.EnableAACReflect(_ARG_0_.keyBladeHandle, 0)
      _ARG_0_:GotoState("Standby")
    else
      _ARG_0_:GotoState("Idling")
    end
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_:ActJudg() == _UPVALUE0_ and Script.Random() < 0.1 then
      _ARG_0_:GotoState("Attack1")
      return
    end
    _ARG_0_:GotoState("Idling")
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    Enemy.SetHP(_ARG_0_.myHandle, Enemy.GetHpMax(_ARG_0_.myHandle))
    if COMMAND_CATEGORY_FINISH == _ARG_2_ then
      Mission.SendMissonMessage(MES_TUTORIAL_USE_FINISH_CMMAND)
    end
    if COMMAND_CATEGORY_SHOOTLOCK == _ARG_2_ then
      Mission.SendMissonMessage(MES_TUTORIAL_USE_SHOOTLOCK)
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    Enemy.SetHP(_ARG_0_.myHandle, Enemy.GetHpMax(_ARG_0_.myHandle))
    return 0
  end,
  OnDead = function(_ARG_0_)
    SetupBossDead(_ARG_0_.myHandle)
    _ARG_0_:GotoState("Dead")
    return 1
  end,
  OnUpdate = function(_ARG_0_)
    Enemy.SetHP(_ARG_0_.myHandle, Enemy.GetHpMax(_ARG_0_.myHandle))
    if Enemy.IsAllEnemyWaiting() == true and _ARG_0_.waitmode ~= 1 then
      _ARG_0_:GotoState("Standby")
    end
    _ARG_0_:Update()
    _ARG_0_:Debug()
  end,
  ActJudg = function(_ARG_0_)
    if _ARG_0_:ActJudgAttack() == _UPVALUE0_ then
      if _ARG_0_:ActJudgJumpAtk() == true then
        return _UPVALUE1_
      else
        return _UPVALUE0_
      end
    end
    if Entity.IsGround(_ARG_0_.myHandle) == false then
      return _UPVALUE2_
    end
    if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 12 then
      return _UPVALUE3_
    end
    if Script.RandomInteger(2) == 1 then
      return _UPVALUE3_
    elseif Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) > Script.RandomInteger(6) + 4 then
      return _UPVALUE3_
    end
    return _UPVALUE4_
  end,
  ActJudgAttack = function(_ARG_0_)
    if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 2 then
      return _UPVALUE0_
    elseif Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 2.5 and _ARG_0_:ActJudgJumpAtk() then
      return _UPVALUE0_
    end
  end,
  ActJudgJumpAtk = function(_ARG_0_)
    if Entity.IsGround(_ARG_0_.myHandle) == false then
      return false
    end
    Entity.GetLocalPos(_ARG_0_.WorkVecClush0, _ARG_0_.myHandle)
    Entity.GetLocalPos(_ARG_0_.WorkVecClush1, _ARG_0_.targetHandle)
    if _ARG_0_.WorkVecClush1:gety() - _ARG_0_.WorkVecClush0:gety() > 1 then
      return true
    end
    return false
  end,
  ActJudgJumpMov = function(_ARG_0_)
    if Entity.IsGround(_ARG_0_.myHandle) == false then
      return false
    end
    if Entity.IsFrontWall(_ARG_0_.myHandle, 1, 0.2) == true then
      if Entity.IsFrontWall(_ARG_0_.myHandle, 1, 1.5) == false then
        return true
      else
        return 2
      end
    end
    return false
  end,
  HomingPlayerMove = function(_ARG_0_, _ARG_1_)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _UPVALUE0_)
    FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_1_)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  end,
  HomingMoveHome = function(_ARG_0_, _ARG_1_)
    Entity.GetLocalPos(_ARG_0_.WorkVecClush0, _ARG_0_.myHandle)
    if _ARG_0_.WorkVecClush0:getx() > -20 then
    else
    end
    _ARG_0_.WorkVecClush0:setx(_ARG_0_.WorkVecClush0:getx() - 5 + 5)
    if _ARG_0_.WorkVecClush0:getz() > 0 then
    else
    end
    _ARG_0_.WorkVecClush0:setz(_ARG_0_.WorkVecClush0:getz() - 5 + 5)
    Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.WorkVecClush0, _UPVALUE0_)
    FVECTOR3.set(_ARG_0_.WorkVecClush1, 0, 0, _ARG_1_)
    Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVecClush1)
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
EntityFactory:Add("b61ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b64ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
