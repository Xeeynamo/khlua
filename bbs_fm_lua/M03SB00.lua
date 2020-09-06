setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), m03sb00_mt)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.MasterHandle = NULL_HANDLE
    _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkTime = 0
    _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
    _ARG_0_.WorkRot = FVECTOR3.new(0, 0, 0)
    _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.OldmyPos = FVECTOR3.new(0, 0, 0)
    Entity.EnableBgColl(_ARG_1_, 0)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.6)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 0.6)
    _ARG_0_.LoopEffect = NULL_HANDLE
  end,
  OnUpdate = function(_ARG_0_)
    Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    if _ARG_0_.step == 0 then
    elseif _ARG_0_.step == 1 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.Out(_ARG_0_.myHandle)
      return
    end
  end,
  OnDestroy = function(_ARG_0_)
    Effect.DetachCoord(_ARG_0_.LoopEffect)
    Effect.LoopEnd(_ARG_0_.LoopEffect)
  end
}, {__index = __StateMachine})
m03sb00_mt = {
  __index = {
    new = function(_ARG_0_)
      return setmetatable(__StateMachine:new(), m03sb00_mt)
    end,
    OnInit = function(_ARG_0_, _ARG_1_)
      _ARG_0_.myHandle = _ARG_1_
      _ARG_0_.step = 0
      _ARG_0_.MasterHandle = NULL_HANDLE
      _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
      _ARG_0_.WorkTime = 0
      _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
      _ARG_0_.WorkRot = FVECTOR3.new(0, 0, 0)
      _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
      _ARG_0_.OldmyPos = FVECTOR3.new(0, 0, 0)
      Entity.EnableBgColl(_ARG_1_, 0)
      Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.6)
      Entity.SetLowerHalf(_ARG_0_.myHandle, 0.6)
      _ARG_0_.LoopEffect = NULL_HANDLE
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle, 2)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      if _ARG_0_.step == 0 then
      elseif _ARG_0_.step == 1 then
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Entity.Out(_ARG_0_.myHandle)
        return
      end
    end,
    OnDestroy = function(_ARG_0_)
      Effect.DetachCoord(_ARG_0_.LoopEffect)
      Effect.LoopEnd(_ARG_0_.LoopEffect)
    end
  }
}
EntityFactory:Add("m03sb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
