b03cd00 = {}
b03cd00_base_mt = {__index = __StateMachine}
setmetatable(b03cd00, b03cd00_base_mt)
b03cd00_mt = {__index = b03cd00}
function b03cd00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b03cd00_mt)
end
b03cd00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      if _ARG_0_.play then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      end
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.parentHandle)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.rot:sety((_ARG_0_.rot:gety()))
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
      Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle, 0)
      _ARG_0_.parentPos:sety(_ARG_0_.parentPos:gety() + _ARG_0_.height)
      Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
    end
  },
  Attack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_.step = 0
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, _ARG_0_.myHandle)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.SendMessage(0, _ARG_0_.myHandle, _ARG_0_.parentHandle, SymphonyMaster.MSG_ATTACK_END)
      Entity.SetAttackerHandle(_ARG_0_.targetHandle, NULL_HANDLE)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.velocity:set(0, -0.2, 0)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_.velocity:set(0, 0, SymphonyMaster.VIOLIN_SPEED)
        Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) <= 4 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 2
        end
      else
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Return")
        end
      end
    end
  },
  OrchestraHitIdling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle)
        Entity.GetRotateAxis(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
        _ARG_0_.velocity:normalize()
        _ARG_0_.velocity:scale(0.2)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 10)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.playerPos) <= 1 then
          _ARG_0_.step = 1
        end
      else
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety((RoundPI(_ARG_0_.rot:gety() + DegToRad(5) * Entity.GetFrameRate(_ARG_0_.myHandle))))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle, 0)
        _ARG_0_.workVec0:copy(_ARG_0_.parentPos)
        _ARG_0_.workVec1:copy(_ARG_0_.parentPos)
        _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 0.5)
        _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 10)
        Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
        _ARG_0_.parentPos:sety(_ARG_0_.workVec1:gety())
        Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
      end
    end
  },
  OrchestraHit = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, SymphonyMaster.ORCHESTRA_HIT_WAIT)
      _ARG_0_.step = 0
      _ARG_0_.count = SymphonyMaster.ORCHESTRA_HIT_COUNT
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.parentHandle = _ARG_0_.ownerHandle
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle, 0)
        _ARG_0_.workVec0:copy(_ARG_0_.parentPos)
        _ARG_0_.workVec1:copy(_ARG_0_.parentPos)
        _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 0.5)
        _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 10)
        Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
        _ARG_0_.parentPos:sety(_ARG_0_.workVec1:gety())
        Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 2, 1)
          Entity.GetWorldPos(_ARG_0_.playerPos, _ARG_0_.parentHandle)
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
          FVECTOR3.Sub(_ARG_0_.workVec0, _ARG_0_.playerPos, _ARG_0_.myPos)
          Entity.SetTimer(_ARG_0_.myHandle, (_ARG_0_.workVec0:length() - 0.5) / SymphonyMaster.ORCHESTRA_HIT_SPEED)
          _ARG_0_.workVec0:sety(0)
          _ARG_0_.workVec0:normalize()
          _ARG_0_.workVec0:scale(SymphonyMaster.ORCHESTRA_HIT_SPEED)
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.count = _ARG_0_.count - 1
          if 0 >= _ARG_0_.count then
            _ARG_0_.parentHandle = _ARG_0_.ownerHandle
            _ARG_0_:GotoState("Return")
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 0, -2)
            Entity.SetTimer(_ARG_0_.myHandle, SymphonyMaster.ORCHESTRA_HIT_NEXT_WAIT)
            _ARG_0_.step = 2
          end
        end
      elseif _ARG_0_.step == 2 then
        Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle)
        Entity.GetRotateAxis(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
        _ARG_0_.velocity:normalize()
        _ARG_0_.velocity:scale(0.2)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.SetTimer(_ARG_0_.myHandle, SymphonyMaster.ORCHESTRA_HIT_WAIT)
          _ARG_0_.step = 0
        elseif 1 >= Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.playerPos) then
          _ARG_0_.step = 3
        end
      else
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:sety((RoundPI(_ARG_0_.rot:gety() + DegToRad(5) * Entity.GetFrameRate(_ARG_0_.myHandle))))
        Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle, 0)
        _ARG_0_.workVec0:copy(_ARG_0_.parentPos)
        _ARG_0_.workVec1:copy(_ARG_0_.parentPos)
        _ARG_0_.workVec0:sety(_ARG_0_.workVec0:gety() + 0.5)
        _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety() - 10)
        Collision.IntersectRayBg(_ARG_0_.workVec1, COLL_KIND_ENEMY, _ARG_0_.workVec0, _ARG_0_.workVec1)
        _ARG_0_.parentPos:sety(_ARG_0_.workVec1:gety())
        Entity.RotateAxis(_ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          Entity.SetTimer(_ARG_0_.myHandle, SymphonyMaster.ORCHESTRA_HIT_WAIT)
          _ARG_0_.step = 0
        end
      end
    end
  },
  Return = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetWorldPos(_ARG_0_.parentPos, _ARG_0_.parentHandle)
      _ARG_0_.parentPos:sety(_ARG_0_.parentPos:gety() + _ARG_0_.height)
      Entity.GetRotateAxis(_ARG_0_.playerPos, _ARG_0_.myHandle, _ARG_0_.axis, _ARG_0_.angle, SymphonyMaster.MUSICALINSTRUMENT_RADIUS, _ARG_0_.parentPos)
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 0)
      FVECTOR3.Sub(_ARG_0_.velocity, _ARG_0_.playerPos, _ARG_0_.myPos)
      _ARG_0_.velocity:normalize()
      _ARG_0_.velocity:scale(0.2)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.playerPos, 10)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.playerPos) <= 1 then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Return")
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
function b03cd00.TurnX(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
end
function b03cd00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.axis = FVECTOR3.new(0, 1, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.playerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.parentPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.angle = RoundPI(DegToRad(180))
  _ARG_0_.rotSpeed = SymphonyMaster.NORMAL_ROT_SPEED
  _ARG_0_.parentHandle = NULL_HANDLE
  _ARG_0_.ownerHandle = NULL_HANDLE
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.height = SymphonyMaster.NORMAL_HEIGHT
  _ARG_0_.play = false
  _ARG_0_.count = 0
  _ARG_0_:GotoState("Idling")
end
function b03cd00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  return 0
end
function b03cd00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Return")
end
function b03cd00.OnMessage(_ARG_0_, _ARG_1_)
  if _ARG_1_ == SymphonyMaster.MSG_ATTACK then
    _ARG_0_:GotoState("Attack")
  elseif _ARG_1_ == SymphonyMaster.MSG_PLAY then
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 0, -2)
    end
    _ARG_0_.play = true
  elseif _ARG_1_ == SymphonyMaster.MSG_STOP then
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end
    _ARG_0_.play = false
  elseif _ARG_1_ == SymphonyMaster.MSG_ORCHESTRA_HIT_IDLING then
    _ARG_0_:GotoState("OrchestraHitIdling")
  elseif _ARG_1_ == SymphonyMaster.MSG_ORCHESTRA_HIT then
    _ARG_0_:GotoState("OrchestraHit")
  end
end
function b03cd00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
EntityFactory:Add("b03cd00", function(_ARG_0_)
  return (b03cd00:new())
end)
