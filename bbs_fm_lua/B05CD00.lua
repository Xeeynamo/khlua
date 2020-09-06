b05cd00_mt = {
  __index = {
    new = function(_ARG_0_)
      return setmetatable({}, b05cd00_mt)
    end,
    OnInit = function(_ARG_0_, _ARG_1_)
      _ARG_0_.myHandle = _ARG_1_
      _ARG_0_.type = 0
      _ARG_0_.step = 0
      _ARG_0_.homing = false
      _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
      _ARG_0_.target = FVECTOR3.new(0, 0, 0)
      Entity.SetTimer(_ARG_1_, 300)
      Entity.SetMovementCollRadius(_ARG_1_, 0.25)
      Entity.SetLowerHalf(_ARG_1_, 0)
      Entity.EnableLockonAndShooton(_ARG_1_, 0)
      Entity.EnableCheckUnderFoot(_ARG_1_, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.type ~= 0 then
        if _ARG_0_.step == 0 then
          _ARG_0_:TargetHoming(_ARG_0_.target, SymphonyMaster.BIG_BATON_ATTACK_SPEED, SymphonyMaster.BIG_BATON_ATTACK_SPEED * 0.05, SymphonyMaster.BIG_BATON_ATTACK_SPEED * 0.05)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.target) <= 1 or Entity.IsWall(_ARG_0_.myHandle) or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, 300)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetWorldPos(_ARG_0_.target, _ARG_0_.parent, 58)
          _ARG_0_:TargetHoming(_ARG_0_.target, SymphonyMaster.BIG_BATON_ATTACK_SPEED, SymphonyMaster.BIG_BATON_ATTACK_SPEED * 0.1, SymphonyMaster.BIG_BATON_ATTACK_SPEED * 0.1)
          if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.target) <= 2.25 or Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.Out(_ARG_0_.myHandle)
          end
        end
      else
        _UPVALUE0_:set(0, 0, 1.5)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE1_)
        Entity.SetMovementOffset(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.IsWall(_ARG_0_.myHandle) or Entity.IsGround(_ARG_0_.myHandle) then
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, "b01cd00", "B001_HIT_04_0", _UPVALUE2_, _UPVALUE1_)
          Entity.Out(_ARG_0_.myHandle)
        end
      end
    end,
    OnHitAttack = function(_ARG_0_)
    end,
    Setup = function(_ARG_0_, _ARG_1_, _ARG_2_)
      _ARG_0_.parent = _ARG_1_
      _ARG_0_.type = _ARG_2_
      if EntityManager:GetEntity(_ARG_1_) ~= nil then
        _ARG_0_.targetHandle = EntityManager:GetEntity(_ARG_1_).targetHandle
        Entity.SetMotion(_ARG_0_.myHandle, 2)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_, 58)
        _ARG_0_.target:copy(EntityManager:GetEntity(_ARG_1_).playerPos)
        FVECTOR3.Sub(_ARG_0_.target, _ARG_0_.target, _ARG_0_.myPos)
        _ARG_0_.target:sety(0)
        if _ARG_0_.target:dot(_ARG_0_.target) < 56.25 then
          Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_)
          _ARG_0_.target:normalize()
          _ARG_0_.target:scale(10)
          FVECTOR3.Add(_ARG_0_.target, _ARG_0_.target, _ARG_0_.myPos)
        else
          _ARG_0_.target:copy(EntityManager:GetEntity(_ARG_1_).playerPos)
          _ARG_0_.target:sety(_ARG_0_.myPos:gety())
        end
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 3)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 0)
      end
    end,
    TargetHoming = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      FVECTOR3.Sub(_UPVALUE1_, _ARG_1_, _UPVALUE0_)
      _UPVALUE1_:sety(0)
      _UPVALUE1_:scale(_ARG_2_)
      Entity.GetVelocity(_UPVALUE2_, _ARG_0_.myHandle)
      FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE2_)
      _UPVALUE1_:scale(_ARG_4_)
      if _ARG_3_ <= _UPVALUE1_:length() then
        _UPVALUE1_:normalize()
        _UPVALUE1_:scale(_ARG_3_)
      end
      FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE1_)
      if _ARG_2_ < _UPVALUE2_:length() then
        _UPVALUE2_:normalize()
        _UPVALUE2_:scale(_ARG_2_)
      end
      Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE0_:sety(Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()))
      Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE2_)
    end
  }
}
EntityFactory:Add("b05cd00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
