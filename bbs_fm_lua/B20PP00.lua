setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
        _ARG_0_:EffectControler()
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("BattleStartState")
          Sound.PlayVoice(130, 0, 1, _ARG_0_.WorkVec)
        end
      end
    },
    BattleStartState = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 500)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 9 then
          _ARG_0_:GotoState("Attack3")
          return
        end
        Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        _ARG_0_:IdlingMove(_UPVALUE0_ / 2)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
          return
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.step == 99 then
          Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
        end
        Entity.SetTimer(_ARG_0_.myHandle, Entity.GetMotionTotalFrame(_ARG_0_.myHandle) + Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
        _ARG_0_.step = 0
        _ARG_0_.Wait = Entity.GetMotionTotalFrame(_ARG_0_.myHandle) / 3
        _ARG_0_.step = 0
        _ARG_0_.attackCnt = Script.Random() * _UPVALUE1_ + _UPVALUE2_
        _ARG_0_:EffectControler()
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.step == 0 then
          if _ARG_0_.Wait < 0 then
            _ARG_0_:GotoState("Move")
            return
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Move")
            return
          end
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = _UPVALUE0_
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetTimer(_ARG_0_.myHandle, Script.Random() * 360 + 360)
        _ARG_0_.MotionFlag = 0
        _ARG_0_.Speed = 0
        _ARG_0_.Height = Script.Random() * _UPVALUE2_ + (_UPVALUE2_ + _UPVALUE3_)
        _ARG_0_.NowHeight = _ARG_0_.Height
        _ARG_0_.workTime = _UPVALUE4_
        _ARG_0_.Angle = 0
        _ARG_0_.Wait = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.step == _UPVALUE0_ then
          _ARG_0_.step = _UPVALUE1_
        elseif _ARG_0_.step == _UPVALUE1_ then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE2_
            _ARG_0_.Angle = 1
            _ARG_0_:DashEffectControler(0)
            return
          end
          _ARG_0_.workTime = _ARG_0_.workTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.workTime then
            _ARG_0_.Height = Script.Random() * _UPVALUE3_ + (_UPVALUE3_ + _UPVALUE4_)
            _ARG_0_.workTime = _UPVALUE5_
            if Script.Random() < _UPVALUE6_ then
              _ARG_0_.step = _UPVALUE7_
              Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
              _ARG_0_:DashEffectControler(1)
              _ARG_0_.Angle = 0
              _ARG_0_.Wait = 300
              return
            end
            _ARG_0_.velocity:set(0, _ARG_0_.NowHeight, 0)
            _ARG_0_.targetPos:set(0, 0, 0)
            _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + Script.Random() * 12 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
            _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + Script.Random() * 12 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
          end
          _ARG_0_.NowHeight = HomingDegree(_ARG_0_.NowHeight, _ARG_0_.Height, 1, Entity.GetFrameRate(_ARG_0_.myHandle))
          _ARG_0_.targetPos:sety(_ARG_0_.NowHeight)
          _ARG_0_:TargetHomingMove(_UPVALUE8_, 1.5)
          if _ARG_0_.MotionFlag == 1 then
            if _ARG_0_:WhichRightandLeft() == 2 then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_)
            elseif _ARG_0_:WhichRightandLeft() == 1 then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE10_)
            else
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_)
            end
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.MotionFlag = 1
          end
        elseif _ARG_0_.step == _UPVALUE2_ then
          _ARG_0_.Angle = _ARG_0_.Angle + 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.Angle)
          _ARG_0_:Move(_UPVALUE8_)
          if _ARG_0_.MotionFlag == 1 then
            if _ARG_0_:WhichRightandLeft() == 2 then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_)
            elseif _ARG_0_:WhichRightandLeft() == 1 then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE10_)
            else
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_)
            end
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2.25 then
            _ARG_0_.step = _UPVALUE12_
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE13_)
            Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
            _ARG_0_:ReSetRot()
          end
        elseif _ARG_0_.step == _UPVALUE7_ then
          _ARG_0_.Angle = _ARG_0_.Angle + 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.Angle > 5 then
            _ARG_0_.Angle = 5
          end
          Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, _ARG_0_.Angle)
          _ARG_0_:MoveEx(_UPVALUE14_, 0.01)
          if _ARG_0_.MotionFlag == 1 then
            if _ARG_0_:WhichRightandLeft() == 2 then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_)
            elseif _ARG_0_:WhichRightandLeft() == 1 then
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE10_)
            else
              Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_)
            end
          end
          if Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE15_, 1, 1)
            _ARG_0_.step = _UPVALUE16_
            _ARG_0_:DashEffectControler(0)
            Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
          end
          if _ARG_0_.Wait < 0 then
            _ARG_0_.step = _UPVALUE16_
            _ARG_0_:DashEffectControler(0)
            Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
          end
        elseif _ARG_0_.step == _UPVALUE16_ then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE17_
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE18_)
          end
        elseif _ARG_0_.step == _UPVALUE17_ then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = _UPVALUE1_
          end
        elseif _ARG_0_.step == _UPVALUE12_ then
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("BeforeAttackIdling")
          end
        end
      end
    },
    BeforeAttackIdling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        if _ARG_0_.step == 99 then
          Entity.SetAnimNowFrame(_ARG_0_.myHandle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
        end
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_ + Script.Random() * _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.NowHeight = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 180)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 2.25 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
        else
          Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 0)
          Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle, 0)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
          _ARG_0_.NowHeight = HomingDegree(_ARG_0_.NowHeight, _ARG_0_.workVec:length(), 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
          _ARG_0_.rot:setx(_ARG_0_.NowHeight / 10)
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
          FVECTOR3.normalize(_ARG_0_.workVec)
          _ARG_0_.rot:setx((_ARG_0_.workVec:length()))
          _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
          _ARG_0_.WorkVec:set(0, 0, 1)
          Math.RotateVectorXYZ(_ARG_0_.WorkVec, _ARG_0_.rot)
          _ARG_0_.WorkVec:scale(_UPVALUE0_ / 5)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
        end
        if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:ReSetRot()
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE1_ then
            if Script.Random() < _UPVALUE2_ then
              _ARG_0_:GotoState("Attack1")
            elseif Script.Random() < _UPVALUE2_ + _UPVALUE3_ then
              _ARG_0_:GotoState("Attack2")
            else
              _ARG_0_:GotoState("Attack3")
            end
          else
            _ARG_0_:GotoState("Idling")
          end
          return
        end
      end
    },
    Attack1 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.attackCnt = _ARG_0_.attackCnt - 1
          if 0 > _ARG_0_.attackCnt then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState("BeforeAttackIdling")
          end
        end
      end
    },
    Attack2 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.attackCnt = _ARG_0_.attackCnt - 1
          if 0 > _ARG_0_.attackCnt then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState("BeforeAttackIdling")
          end
        end
      end
    },
    Attack3 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.attackLoopCnt = 0
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:IdlingMove(_UPVALUE0_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
            if _ARG_0_.attackLoopCnt > _UPVALUE1_ then
              _ARG_0_.step = 2
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            end
            _ARG_0_.attackLoopCnt = _ARG_0_.attackLoopCnt + 1
          end
          _ARG_0_.Wait = _ARG_0_.Wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.Wait then
            _ARG_0_.Wait = 30
            Entity.AACUpdateAttackID(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.attackCnt = _ARG_0_.attackCnt - 1
          if 0 > _ARG_0_.attackCnt then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState("BeforeAttackIdling")
          end
        end
      end
    },
    Attack4 = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10) == false then
          _ARG_0_.step = 1
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.attackCnt = _ARG_0_.attackCnt - 1
          if 0 > _ARG_0_.attackCnt then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState("BeforeAttackIdling")
          end
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  IdlingMove = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle, 0)
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle, 0)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec, _ARG_0_.WorkVec1)
    _ARG_0_.NowHeight = HomingDegree(_ARG_0_.NowHeight, _ARG_0_.workVec:length(), 0.1, Entity.GetFrameRate(_ARG_0_.myHandle))
    _ARG_0_.rot:setx(_ARG_0_.NowHeight / 10)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.rot:setx((_ARG_0_.workVec:length()))
    _ARG_0_.rot:sety(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle))
    _ARG_0_.WorkVec:set(0, 0, 1)
    Math.RotateVectorXYZ(_ARG_0_.WorkVec, _ARG_0_.rot)
    _ARG_0_.WorkVec:scale(_ARG_1_)
    Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  end,
  Move = function(_ARG_0_, _ARG_1_)
    _ARG_0_.Speed = _ARG_0_.Speed + 0.02 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
  end,
  MoveEx = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed + _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
  end,
  TargetHomingMove = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_.Speed = _ARG_0_.Speed + 0.02 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_1_ < _ARG_0_.Speed then
      _ARG_0_.Speed = _ARG_1_
    end
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, _ARG_2_)
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.Speed)
  end,
  ReSetRot = function(_ARG_0_)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.rot:setx(0)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  end,
  CheckHP = function(_ARG_0_)
    if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _UPVALUE0_ then
      return 1
    end
    return 0
  end,
  WhichRightandLeft = function(_ARG_0_)
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.targetHandle)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.WorkVec1, _ARG_0_.WorkVec)
    FVECTOR3.normalize(_ARG_0_.workVec)
    if RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < DegToRad(10) and RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) > DegToRad(-10) then
      return 2
    elseif RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
      return 1
    else
      return 0
    end
  end,
  EffectControler = function(_ARG_0_, _ARG_1_)
    if Effect.IsAlive(_ARG_0_.EffectHandle) then
    else
      _ARG_0_.EffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b20pp00", "B014_KIR_00_0", "center")
    end
  end,
  DashEffectControler = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 0 then
      Effect.LoopEnd(_ARG_0_.DashEffectHandleR)
      Effect.LoopEnd(_ARG_0_.DashEffectHandleL)
    elseif Effect.IsAlive(_ARG_0_.DashEffectHandleR) then
    else
      _ARG_0_.WorkVec:set(0, 0, 0)
      _ARG_0_.rot:set(DegToRad(90), 0, 0)
      _ARG_0_.DashEffectHandleR = Entity.AttachEffect(_ARG_0_.myHandle, "b20pp00", "B014_KAZ_00_0", "R_te", _ARG_0_.WorkVec, _ARG_0_.rot)
      _ARG_0_.DashEffectHandleL = Entity.AttachEffect(_ARG_0_.myHandle, "b20pp00", "B014_KAZ_00_0", "L_te", _ARG_0_.WorkVec, _ARG_0_.rot)
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.EffectHandle = NULL_HANDLE
    _ARG_0_.DashEffectHandleR = NULL_HANDLE
    _ARG_0_.DashEffectHandleL = NULL_HANDLE
    _ARG_0_.oldState = 0
    _ARG_0_.Speed = 0
    _ARG_0_.MotionFlag = 0
    _ARG_0_.workTime = 0
    _ARG_0_.Height = Script.Random() * _UPVALUE0_ + (_UPVALUE0_ + _UPVALUE1_)
    _ARG_0_.NowHeight = _ARG_0_.Height
    _ARG_0_.attackLoopCnt = 0
    _ARG_0_.attackCnt = 0
    _ARG_0_.Wait = 0
    _ARG_0_.away = 0
    _ARG_0_.Angle = 0
    _ARG_0_.deadFlag = 0
    _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
    _ARG_0_.step = 0
    _ARG_0_.stack = Stack:Create()
    _ARG_0_.playerNowHp = Player.GetPlayerHP()
    _ARG_0_.playerNowHp = _ARG_0_.playerNowHp * 0.5
    if _UPVALUE2_ == false then
      _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingT") * 60
      _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ActionDis1")
      _UPVALUE4_ = _UPVALUE4_ * _UPVALUE4_
      _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ActionDis2")
      _UPVALUE5_ = _UPVALUE5_ * _UPVALUE5_
      _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate1") * 0.01
      _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate2") * 0.01
      _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "AtkRate4") * 0.01
      _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Atk4Wait")
      _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MettaSpeed")
      _UPVALUE2_ = true
    end
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 0)
    Player.SetBossCamera("b20pp")
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 2)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 2.5)
    _ARG_0_:GotoState("Appear")
  end,
  OnReturnDamage = function(_ARG_0_)
    print("RetrunDamag\n")
    _ARG_0_:GotoState("Idling")
  end,
  OnReflect = function(_ARG_0_)
    Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
    Sound.PlayVoice(130, 14, 1, _ARG_0_.WorkVec)
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == ATK_KIND_STOP or _ARG_1_ == ATK_KIND_SLEEP or _ARG_1_ == ATK_KIND_FAINT or _ARG_1_ == ATK_KIND_DETONE or _ARG_1_ == ATK_KIND_BIND then
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      _ARG_0_:DashEffectControler(0)
    else
    end
    Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
    _ARG_0_:DashEffectControler(0)
    _ARG_0_.oldState = _ARG_0_:GetState()
    _ARG_0_:ReSetRot()
  end,
  OnDead = function(_ARG_0_)
    _ARG_0_:GotoState("Dead")
    SetupBossDead(_ARG_0_.myHandle)
    return 1
  end,
  OnUpdate = function(_ARG_0_)
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
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b20pp00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
