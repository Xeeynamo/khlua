setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:GetTargetBite() ~= NULL_HANDLE then
          _ARG_0_.targetHandle = _ARG_0_:GetTargetBite()
          _ARG_0_:GotoState("Bite")
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE1_:set(0, 0, 0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 2.5)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Swim")
        end
      end
    },
    Swim = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:GetTargetBite() ~= NULL_HANDLE then
          _ARG_0_.targetHandle = _ARG_0_:GetTargetBite()
          _ARG_0_:GotoState("Bite")
          return
        end
        _ARG_0_.theta = RoundPI(_ARG_0_.theta + DegToRad(_UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE2_:set(Math.Cos(_ARG_0_.theta) * _UPVALUE3_, _UPVALUE1_:gety(), Math.Sin(_ARG_0_.theta) * _UPVALUE3_)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
        FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Bite = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.myPos:set(0, 0, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, -2)
          Entity.SetTimer(_ARG_0_.myHandle, 30)
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() - _UPVALUE1_ * Entity.GetFrameRate(_ARG_0_.myHandle))
          Entity.SetDispOffset(_ARG_0_.myHandle, _ARG_0_.myPos)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _UPVALUE2_:set(0, 0, 0)
            Entity.SetDispOffset(_ARG_0_.myHandle, _UPVALUE2_)
            if Entity.IsPlayer(_ARG_0_.targetHandle) then
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_)
              _ARG_0_.step = 2
            else
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsSwim(_ARG_0_.targetHandle) == false then
            if _ARG_0_:GetTargetBite() ~= NULL_HANDLE then
              _ARG_0_.targetHandle = _ARG_0_:GetTargetBite()
              _ARG_0_.step = 3
            else
              _ARG_0_:GotoState("Return2")
            end
          else
            if _ARG_0_:GetTargetBite() ~= NULL_HANDLE then
              _ARG_0_.targetHandle = _ARG_0_:GetTargetBite()
              if Entity.IsPlayer(_ARG_0_.targetHandle) == false then
                Entity.SetTimer(_ARG_0_.myHandle, 0)
              end
            end
            if Entity.IsTimeOver(_ARG_0_.myHandle) then
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 3 then
          _UPVALUE2_:set(0, 0, 0)
          if Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE2_) >= 100 and Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE2_) <= 400 and Entity.IsSwim(_ARG_0_.targetHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
            Entity.GetLocalPos(_UPVALUE2_, _ARG_0_.targetHandle)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            _UPVALUE5_:set(0, 0, 0)
            if Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE2_) < 225 then
              FVECTOR3.Sub(_UPVALUE5_, _UPVALUE2_, _UPVALUE5_)
            else
              FVECTOR3.Sub(_UPVALUE5_, _UPVALUE5_, _UPVALUE2_)
            end
            Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE5_:getx(), _UPVALUE5_:getz()), 0)
            _UPVALUE5_:normalize()
            FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE5_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 4
          else
            _ARG_0_:GotoState("Return2")
          end
        elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:GetTargetBite() ~= NULL_HANDLE then
            _ARG_0_.targetHandle = _ARG_0_:GetTargetBite()
            _ARG_0_.step = 1
            Entity.SetTimer(_ARG_0_.myHandle, 30)
            Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
            _ARG_0_.myPos:set(0, 0, 0)
          else
            _ARG_0_:GotoState("Return1")
          end
        end
      end
    },
    Return1 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, 30)
        Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 30)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Return2")
        end
      end
    },
    Return2 = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE2_:set(Math.Cos(_ARG_0_.theta) * _UPVALUE3_, _UPVALUE1_:gety(), Math.Sin(_ARG_0_.theta) * _UPVALUE3_)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE2_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 30)
        Entity.SetTimer(_ARG_0_.myHandle, 30)
        _ARG_0_.myPos:set(0, 0, 0)
      end,
      OnEndState = function(_ARG_0_)
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetDispOffset(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.myPos:sety(_ARG_0_.myPos:gety() + _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle))
        Entity.SetDispOffset(_ARG_0_.myHandle, _ARG_0_.myPos)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Swim")
        end
      end
    }
  },
  GetTargetBite = function(_ARG_0_)
    if Entity.IsSwim((Enemy.SearchEnemy(_ARG_0_.myHandle, "b01pp00", SEARCH_TYPE_NEAR))) then
      return (Enemy.SearchEnemy(_ARG_0_.myHandle, "b01pp00", SEARCH_TYPE_NEAR))
    end
    if Entity.IsSwim((Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))) then
      _UPVALUE0_:set(0, 0, 0)
      if Entity.CalcDistanceXZSq(Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR), _UPVALUE0_) >= 100 and Entity.CalcDistanceXZSq(Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR), _UPVALUE0_) <= 400 then
        return (Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR))
      end
    end
    return NULL_HANDLE
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "012")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE5_, _ARG_1_)
    _ARG_0_.theta = Math.Atan2(_UPVALUE5_:getx(), _UPVALUE5_:getz())
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Entity.EnableLockonAndShooton(_ARG_1_, 0)
    Entity.SetMovementCollRadius(_ARG_1_, 1.25)
    Entity.SetLowerHalf(_ARG_1_, 1.75)
    _ARG_0_:GotoState("Swim")
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("b02pp00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
