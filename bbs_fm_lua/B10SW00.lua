b10sw00 = {}
b10sw00_base_mt = {__index = __StateMachine}
setmetatable(b10sw00, b10sw00_base_mt)
b10sw00_mt = {__index = b10sw00}
function b10sw00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b10sw00_mt)
end
b10sw00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * 1.5)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_:setFacialFlag(_UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_ + Script.Random() * 1.5)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      if Player.GetPlayerID(_ARG_0_.targetHandle) == PLAYER_ID_AQUA then
        _ARG_0_.stack:push("Rising_press")
      else
        _ARG_0_.stack:push("Ninja_attack")
      end
      _ARG_0_.FlowType = Script.RandomInteger(_UPVALUE2_)
      if _ARG_0_.FlowType == _UPVALUE3_ then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("Giganticcimpact")
        else
          _ARG_0_.stack:push("Facial_press")
        end
        _ARG_0_.stack:push("Infinit_Wall")
        _ARG_0_.stack:push("Giganticcimpact")
        _ARG_0_.stack:push("Facial_serge")
      elseif _ARG_0_.FlowType == _UPVALUE4_ then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("Giganticcimpact")
        else
          _ARG_0_.stack:push("Facial_press")
        end
        _ARG_0_.stack:push("Facial_serge")
        _ARG_0_.stack:push("Giganticcimpact")
        _ARG_0_.stack:push("Infinit_Wall")
      elseif _ARG_0_.FlowType == _UPVALUE5_ then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("Facial_serge")
        else
          _ARG_0_.stack:push("Infinit_Wall")
        end
        _ARG_0_.stack:push("Facial_press")
        _ARG_0_.stack:push("Facial_serge")
        _ARG_0_.stack:push("Giganticcimpact")
      elseif _ARG_0_.FlowType == _UPVALUE6_ then
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("Facial_serge")
        else
          _ARG_0_.stack:push("Infinit_Wall")
        end
        _ARG_0_.stack:push("Giganticcimpact")
        _ARG_0_.stack:push("Facial_serge")
        _ARG_0_.stack:push("Facial_press")
      end
      _ARG_0_:setFacialFlag()
      _ARG_0_:OnCheckCamera()
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:OffCheckCamera()
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:AuraControler(_UPVALUE0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
        return
      end
      if Script.IsDebugCheckAttack() then
        _ARG_0_:GotoState("Idling")
      else
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Facial_serge = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      _ARG_0_.MoveFlag = 0
      _ARG_0_.WorkTime = 20
      _ARG_0_.WorkTime2 = 0
      _ARG_0_.FacialID = 0
      _ARG_0_.MyFacialID = Script.RandomInteger(_UPVALUE1_ - 2)
      Entity.GetWorldPos(_ARG_0_.targetPos, Player.GetHandle())
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 360)
      Entity.GetRot(_ARG_0_.targetRot, _ARG_0_.myHandle)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      _ARG_0_:FaicelPushInit(0.1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_.MotCangeCnt = 0
      _ARG_0_:setFacialFlag(_UPVALUE3_)
      _ARG_0_:AuraControler(_UPVALUE4_)
      _ARG_0_.RotationSpeed = 0
      _ARG_0_.RotationFlag = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:setFacialFlag(_UPVALUE5_)
      _ARG_0_:OffCheckCamera()
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_:OffCheckCamera()
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 10)
      if _ARG_0_.step == _UPVALUE0_ then
        if _ARG_0_.MoveFlag == 0 then
          _ARG_0_:setFacialFlag(_UPVALUE1_)
          _ARG_0_:ResetFacial_X()
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.MoveFlag = 2
            _ARG_0_.step = _UPVALUE2_
            Entity.ClearSpeed(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.MoveFlag == 1 then
          _ARG_0_.MoveFlag = 2
        elseif _ARG_0_.MoveFlag == 2 then
          for _FORV_5_ = 0, _UPVALUE3_ - 1 do
            if _ARG_0_.MyFacialID == _FORV_5_ then
              _ARG_0_:SetCirclePosition(_ARG_0_.myHandle, 0)
              Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 20)
              if Entity.IsMotionEnd(_ARG_0_.myHandle) then
                Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_)
                _ARG_0_:setFacialFlag(_UPVALUE5_)
              end
            else
              _ARG_0_:SetCirclePosition(_ARG_0_.ProliferationHandle[_FORV_5_].handle, 0)
              Entity.TurnTargetYDegree(_ARG_0_.ProliferationHandle[_FORV_5_].handle, Player.GetHandle(), 20)
              if Entity.IsMotionEnd(_ARG_0_.ProliferationHandle[_FORV_5_].handle) and _ARG_0_.ProliferationHandle[_FORV_5_].MotRandFlag == 0 then
                Entity.SetMotion(_ARG_0_.ProliferationHandle[_FORV_5_].handle, _UPVALUE6_)
                Entity.SetAnimNowFrame(_ARG_0_.ProliferationHandle[_FORV_5_].handle, Script.Random() * Entity.GetMotionTotalFrame(_ARG_0_.ProliferationHandle[_FORV_5_].handle))
                _ARG_0_.ProliferationHandle[_FORV_5_].MotRandFlag = 1
                _ARG_0_.MotCangeCnt = _ARG_0_.MotCangeCnt + 1
              end
            end
            if _FORV_5_ > _UPVALUE3_ - 1 then
              break
            end
          end
          if _ARG_0_.MotCangeCnt >= _UPVALUE3_ - 1 then
            _ARG_0_.WorkTime = 60
            _ARG_0_.RotationTime = _UPVALUE7_
            _ARG_0_.MotCangeCnt = 0
            _ARG_0_.step = _UPVALUE8_
          end
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
        Entity.GetWorldPos(_ARG_0_.PlayerPos, Player.GetHandle())
        if 0 > _ARG_0_.WorkTime then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if _ARG_0_.FacialID >= _UPVALUE3_ then
            _ARG_0_.step = _UPVALUE0_
            _ARG_0_.MoveFlag = 1
            return
          end
          Entity.GetWorldPos(_ARG_0_.WorkVec, Player.GetHandle())
          _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + _UPVALUE9_ * Math.Cos(DegToRad(360 / _UPVALUE3_ * _ARG_0_.FacialID)))
          _ARG_0_.WorkVec:sety(0)
          _ARG_0_.WorkVec:setz(_ARG_0_.WorkVec:getz() + _UPVALUE9_ * Math.Sin(DegToRad(360 / _UPVALUE3_ * _ARG_0_.FacialID)))
          _ARG_0_.rot:set(0, 0, 0)
          FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.WorkVec)
          FVECTOR3.normalize(_ARG_0_.workVec)
          _ARG_0_.rot:sety((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz())))
          if _ARG_0_.MyFacialID == _ARG_0_.FacialID then
            Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.WorkVec)
            _ARG_0_.id = _ARG_0_.FacialID
            _ARG_0_.angle = _ARG_0_.FacialID
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE10_)
            _ARG_0_:ResetFacial()
          else
            _ARG_0_.ProliferationHandle[_ARG_0_.FacialID].handle = Entity.CreateEntity("b11sw00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
            _ARG_0_.ProliferationHandle[_ARG_0_.FacialID].AttackFlag = 0
            _ARG_0_.ProliferationHandle[_ARG_0_.FacialID].AttackDelay = Script.Random() * _UPVALUE11_
            EntityManager:GetEntity(_ARG_0_.ProliferationHandle[_ARG_0_.FacialID].handle).id = _ARG_0_.FacialID
            Entity.SetMotion(_ARG_0_.ProliferationHandle[_ARG_0_.FacialID].handle, _UPVALUE12_)
            EntityManager:GetEntity(_ARG_0_.ProliferationHandle[_ARG_0_.FacialID].handle):GotoState("Facial_serge_other_self")
            EntityManager:GetEntity(_ARG_0_.ProliferationHandle[_ARG_0_.FacialID].handle).step = 2
          end
          _ARG_0_.FacialID = _ARG_0_.FacialID + 1
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        if _ARG_0_.RotationFlag == 0 then
          if 0 > _ARG_0_.RotationTime then
            _ARG_0_.RotationSpeed = _ARG_0_.RotationSpeed - 0.03 * 0.04 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 > _ARG_0_.RotationSpeed then
              _ARG_0_.RotationSpeed = 0
              _ARG_0_.step = _UPVALUE13_
              _ARG_0_.RotationTime = _UPVALUE14_
              Entity.GetWorldPos(_ARG_0_.centerPos, Player.GetHandle(), 2)
            end
          end
          if 1 == 0 then
            _ARG_0_.RotationSpeed = _ARG_0_.RotationSpeed + _UPVALUE15_ * 0.15 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _UPVALUE15_ < _ARG_0_.RotationSpeed then
              _ARG_0_.RotationSpeed = _UPVALUE15_
            end
          end
          _ARG_0_.RotationTime = _ARG_0_.RotationTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.WorkTime then
            for _FORV_6_ = 0, _UPVALUE3_ do
              if _FORV_6_ > _UPVALUE3_ - 1 then
                break
              end
              if _ARG_0_.MyFacialID == _FORV_6_ then
                _ARG_0_:SetCirclePosition(_ARG_0_.myHandle, -0.05)
                Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 20)
                Entity.ClearSpeed(_ARG_0_.myHandle)
              else
                _ARG_0_:SetCirclePosition(_ARG_0_.ProliferationHandle[_FORV_6_].handle, -0.05)
                Entity.TurnTargetYDegree(_ARG_0_.ProliferationHandle[_FORV_6_].handle, Player.GetHandle(), 20)
                Entity.ClearSpeed(_ARG_0_.ProliferationHandle[_FORV_6_].handle)
              end
            end
          else
            for _FORV_6_ = 0, _UPVALUE3_ do
              if _FORV_6_ > _UPVALUE3_ - 1 then
                break
              end
              if _ARG_0_.MyFacialID == _FORV_6_ then
                _ARG_0_:SetCirclePosition(_ARG_0_.myHandle, 0)
              else
                _ARG_0_:SetCirclePosition(_ARG_0_.ProliferationHandle[_FORV_6_].handle, 0)
              end
            end
          end
        elseif _ARG_0_.RotationFlag == 1 then
          if 0 > _ARG_0_.RotationTime then
            _ARG_0_.RotationSpeed = _ARG_0_.RotationSpeed + 0.03 * 0.04 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 < _ARG_0_.RotationSpeed then
              _ARG_0_.RotationSpeed = 0
              _ARG_0_.step = _UPVALUE16_
              _ARG_0_.RotationTime = _UPVALUE17_
              Entity.EnableLockon(_ARG_0_.myHandle, 1)
              Entity.GetWorldPos(_ARG_0_.centerPos, Player.GetHandle(), 2)
            end
          end
          if 1 == 0 then
            _ARG_0_.RotationSpeed = _ARG_0_.RotationSpeed - _UPVALUE15_ * 0.15 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.RotationSpeed < -_UPVALUE15_ then
              _ARG_0_.RotationSpeed = -_UPVALUE15_
            end
          end
          _ARG_0_.RotationTime = _ARG_0_.RotationTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.WorkTime then
            for _FORV_7_ = 0, _UPVALUE3_ do
              if _FORV_7_ > _UPVALUE3_ - 1 then
                break
              end
              if _ARG_0_.MyFacialID == _FORV_7_ then
                _ARG_0_:SetCirclePosition(_ARG_0_.myHandle, 0.05)
              else
                _ARG_0_:SetCirclePosition(_ARG_0_.ProliferationHandle[_FORV_7_].handle, 0.05)
              end
            end
          end
        end
      else
        if _ARG_0_.step == _UPVALUE13_ then
          if 0 > _ARG_0_.RotationTime and _ARG_0_.ProliferationHandle[_UPVALUE3_ - 2].AttackFlag == 4 then
            _ARG_0_.step = _UPVALUE8_
            _ARG_0_.RotationTime = _UPVALUE7_
            _ARG_0_.RotationFlag = 1
            for _FORV_5_ = 0, _UPVALUE3_ do
              if _FORV_5_ > _UPVALUE3_ - 1 then
                break
              end
              if _ARG_0_.MyFacialID == _FORV_5_ then
                Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 20)
              else
                _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag = 0
                Entity.SetMotionWithSameCheck(_ARG_0_.ProliferationHandle[_FORV_5_].handle, _UPVALUE6_)
              end
            end
            return
          end
          _ARG_0_.RotationTime = _ARG_0_.RotationTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          for _FORV_5_ = 0, _UPVALUE3_ do
            if _FORV_5_ > _UPVALUE3_ - 1 then
              break
            end
            if _ARG_0_.MyFacialID == _FORV_5_ then
              _ARG_0_:SetCirclePosition(_ARG_0_.myHandle, 0)
            else
              _ARG_0_:SetCirclePosition(_ARG_0_.ProliferationHandle[_FORV_5_].handle, 0)
            end
          end
          for _FORV_6_ = 0, _UPVALUE3_ do
            if _FORV_6_ > _UPVALUE3_ - 1 then
              if 0 == 0 then
                do break end
                if _ARG_0_.MyFacialID == _FORV_6_ then
                  Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 20)
                else
                  Entity.GetVelocity(_ARG_0_.workVec, Player.GetHandle())
                  Entity.GetWorldPos(_ARG_0_.centerPos, Player.GetHandle())
                  _ARG_0_.workVec:scale(Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) / 2)
                  FVECTOR3.Add(_ARG_0_.centerPos, _ARG_0_.centerPos, _ARG_0_.workVec)
                  _ARG_0_.centerPos:sety(0.5)
                  Entity.TurnTargetYDegree(_ARG_0_.ProliferationHandle[_FORV_6_].handle, _ARG_0_.centerPos, 20)
                  if _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag == 0 then
                    if 0 == 0 then
                      _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag = 1
                      Entity.SetMotion(_ARG_0_.ProliferationHandle[_FORV_6_].handle, _UPVALUE18_, 0, 0)
                    end
                  elseif _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag == 1 then
                    if Entity.IsMotionEnd(_ARG_0_.ProliferationHandle[_FORV_6_].handle) then
                      _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag = 2
                      Entity.SetMotion(_ARG_0_.ProliferationHandle[_FORV_6_].handle, _UPVALUE19_, 0, 0)
                    end
                  elseif _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag == 2 then
                    if Entity.GetMotionNowFrame(_ARG_0_.ProliferationHandle[_FORV_6_].handle) >= 8 then
                      _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag = 3
                      _ARG_0_:CreateBullet_Lod(_ARG_0_.ProliferationHandle[_FORV_6_].handle)
                    end
                  elseif _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag == 3 and Entity.IsMotionEnd(_ARG_0_.ProliferationHandle[_FORV_6_].handle) then
                    _ARG_0_.ProliferationHandle[_FORV_6_].AttackFlag = 4
                    Entity.SetMotionWithSameCheck(_ARG_0_.ProliferationHandle[_FORV_6_].handle, _UPVALUE6_)
                  end
                end
                elseif _ARG_0_.step == _UPVALUE16_ then
                  if 0 > _ARG_0_.RotationTime then
                    _ARG_0_.step = _UPVALUE20_
                    _ARG_0_.RotationTime = _UPVALUE7_
                    _ARG_0_.RotationFlag = 0
                    _ARG_0_.MoveFlag = 0
                    for _FORV_5_ = 0, _UPVALUE3_ do
                      if _FORV_5_ > _UPVALUE3_ - 1 then
                        break
                      end
                      if _ARG_0_.MyFacialID == _FORV_5_ then
                        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE21_)
                        _ARG_0_:setFacialFlag(_UPVALUE1_)
                      else
                        Entity.SetMotion(_ARG_0_.ProliferationHandle[_FORV_5_].handle, _UPVALUE22_)
                      end
                    end
                    return
                  end
                  for _FORV_5_ = 0, _UPVALUE3_ do
                    if _FORV_5_ > _UPVALUE3_ - 1 then
                      break
                    end
                    if _ARG_0_.MyFacialID == _FORV_5_ then
                    else
                      if _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag == 0 then
                        if _ARG_0_.RotationTime > 4 and 0 > _ARG_0_.ProliferationHandle[_FORV_5_].AttackDelay and Script.Random() < 0.5 then
                          _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag = 1
                          Entity.SetMotion(_ARG_0_.ProliferationHandle[_FORV_5_].handle, _UPVALUE18_, 0, 0)
                        end
                      elseif _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag == 1 then
                        if Entity.IsMotionEnd(_ARG_0_.ProliferationHandle[_FORV_5_].handle) then
                          _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag = 2
                          Entity.SetMotion(_ARG_0_.ProliferationHandle[_FORV_5_].handle, _UPVALUE19_, 0, 0)
                        end
                      elseif _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag == 2 then
                        if Entity.GetMotionNowFrame(_ARG_0_.ProliferationHandle[_FORV_5_].handle) >= 8 then
                          _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag = 3
                          _ARG_0_:CreateBullet_Lod(_ARG_0_.ProliferationHandle[_FORV_5_].handle)
                        end
                      elseif _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag == 3 and Entity.IsMotionEnd(_ARG_0_.ProliferationHandle[_FORV_5_].handle) then
                        _ARG_0_.ProliferationHandle[_FORV_5_].AttackFlag = 0
                        Entity.SetMotionWithSameCheck(_ARG_0_.ProliferationHandle[_FORV_5_].handle, _UPVALUE6_)
                        _ARG_0_.ProliferationHandle[_FORV_5_].AttackDelay = _UPVALUE11_
                      end
                      _ARG_0_.ProliferationHandle[_FORV_5_].AttackDelay = _ARG_0_.ProliferationHandle[_FORV_5_].AttackDelay - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
                    end
                  end
                  _ARG_0_.RotationTime = _ARG_0_.RotationTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
                else
                  if _ARG_0_.step == _UPVALUE20_ then
                    if _ARG_0_.MoveFlag == 0 then
                      for _FORV_5_ = 0, _UPVALUE3_ do
                        if _FORV_5_ > _UPVALUE3_ - 1 then
                          if _ARG_0_.MyFacialID == _FORV_5_ then
                            if Entity.IsMotionEnd(_ARG_0_.myHandle) then
                              _ARG_0_.step = _UPVALUE23_
                              _ARG_0_.WorkTime = 60
                              _ARG_0_.RotationTime = _UPVALUE7_
                              do break end
                              if _ARG_0_.ProliferationHandle[_FORV_5_ - 1].MotRandFlag == 1 and Entity.IsMotionEnd(_ARG_0_.ProliferationHandle[_FORV_5_ - 1].handle) then
                                _ARG_0_.step = _UPVALUE23_
                                _ARG_0_.WorkTime = 60
                                _ARG_0_.RotationTime = _UPVALUE7_
                                do break end
                                elseif _ARG_0_.step == _UPVALUE23_ then
                                  for _FORV_5_ = 0, _UPVALUE3_ do
                                    if _FORV_5_ > _UPVALUE3_ - 1 then
                                      return
                                    end
                                    if _ARG_0_.MyFacialID == _FORV_5_ then
                                      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE10_)
                                      _ARG_0_.step = _UPVALUE24_
                                    else
                                      _ARG_0_.ProliferationHandle[_FORV_5_].handle = NULL_HANDLE
                                      _ARG_0_.ProliferationHandle[_FORV_5_].MotRandFlag = 0
                                    end
                                  end
                                elseif _ARG_0_.step == _UPVALUE24_ then
                                  if Entity.IsMotionEnd(_ARG_0_.myHandle) then
                                    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE25_)
                                    _ARG_0_.step = _UPVALUE26_
                                    _ARG_0_.WorkTime = _UPVALUE27_
                                    _ARG_0_:OnCheckCamera()
                                  end
                                elseif _ARG_0_.step == _UPVALUE26_ and 0 > _ARG_0_.WorkTime then
                                  _ARG_0_:OffCheckCamera()
                                  if Script.IsDebugCheckAttack() then
                                    _ARG_0_:GotoState("Idling")
                                  else
                                    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                end
              end
            end
          end
      end
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.WorkTime2 = _ARG_0_.WorkTime2 + 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
  },
  Facial_serge_other_self = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.angle = _ARG_0_.id
      _ARG_0_.step = 0
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 999
      _ARG_0_:setWallFlag(999)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Giganticcimpact = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.NowScale:set(0, 0, 0)
      Entity.GetScale(_ARG_0_.NowScale, _ARG_0_.myHandle)
      _ARG_0_.Speed = 0
      _ARG_0_.Speed2 = 0
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.step = _UPVALUE1_
      Entity.SetTimer(_ARG_0_.myHandle, 780)
      _ARG_0_.time = 0
      _ARG_0_.angle = 0
      _ARG_0_.work0 = 1.5 + Script.Random()
      _ARG_0_.WorkTime2 = _UPVALUE2_
      _ARG_0_.ScaleStep = 0
      _ARG_0_.AttackHitFlag = 0
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
      _ARG_0_:setFacialFlag(_UPVALUE3_)
      _ARG_0_:AuraControler(_UPVALUE4_)
      _ARG_0_:OffCheckCamera()
      _ARG_0_.zigzagStep = 0
      _ARG_0_.zigzagTime = _UPVALUE5_ / 2
      _ARG_0_.Speed = _UPVALUE6_ * 3
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_:setFacialFlag(_UPVALUE0_)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:setWallFlag(6)
      _ARG_0_:AuraControler(_UPVALUE1_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_:ResetFacial_X()
        if _ARG_0_.ScaleStep == _UPVALUE1_ then
          _ARG_0_.FalceRotZ = _ARG_0_.FalceRotZ * 1 + 1
          if _ARG_0_.scale > 0.2 then
            _ARG_0_.ScaleCount = _ARG_0_.ScaleCount - 0.1
            _ARG_0_.srcScale = _ARG_0_.scale
            _ARG_0_.dstScale = 1 + (_UPVALUE2_ - 1) / _UPVALUE2_ * _ARG_0_.ScaleCount
            _ARG_0_.scaleTimer = _UPVALUE3_
          else
            _ARG_0_.ScaleStep = _UPVALUE4_
            _ARG_0_.FalceRotZ = 0
            _ARG_0_:AuraControler(_UPVALUE5_)
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        elseif _ARG_0_.ScaleStep == _UPVALUE4_ then
          if _ARG_0_.ScaleCount < _UPVALUE2_ then
            _ARG_0_.ScaleCount = _ARG_0_.ScaleCount + 0.3
            _ARG_0_.srcScale = _ARG_0_.scale
            _ARG_0_.dstScale = 1 + (_UPVALUE2_ - 1) / _UPVALUE2_ * _ARG_0_.ScaleCount
            _ARG_0_.scaleTimer = _UPVALUE3_
          else
            _ARG_0_.c = 0.2
            _ARG_0_.theta = 0
            _ARG_0_.exec = true
            _ARG_0_.srcScale = _ARG_0_.scale
            _ARG_0_.dstScale = 1 + (_UPVALUE2_ - 1) / _UPVALUE2_ * _ARG_0_.ScaleCount
            _ARG_0_.scaleTimer = _UPVALUE3_
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE7_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_, 1, 1)
            _ARG_0_:AuraControler(_UPVALUE9_)
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
      elseif _ARG_0_.step == _UPVALUE7_ then
        _ARG_0_:ResetFacial_X()
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          Entity.EnableBgColl(_ARG_0_.myHandle, 1)
          Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
          if Entity.IsGround(_ARG_0_.myHandle) then
            Entity.EnableGravity(_ARG_0_.myHandle, 0)
            _ARG_0_.step = _UPVALUE10_
            Entity.ClearSpeed(_ARG_0_.myHandle)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE11_)
          end
        end
      elseif _ARG_0_.step == _UPVALUE10_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetTimer(_ARG_0_.myHandle, Math.Sqrt((Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle))) / (_UPVALUE12_ * Entity.GetFrameRate(_ARG_0_.myHandle)) + 70)
          _ARG_0_.step = _UPVALUE13_
          Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
          Sound.PlayVoice(139, 7, 1, _ARG_0_.workVec)
          _ARG_0_:setWallFlag(4)
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        if _ARG_0_.zigzagStep == 0 then
          _ARG_0_:homingPlayer(0.8)
          _ARG_0_:ZigzagMoveRight(_UPVALUE14_, 1, _UPVALUE15_)
          if 0 > _ARG_0_.zigzagTime then
            _ARG_0_.zigzagTime = _UPVALUE16_
            _ARG_0_.zigzagStep = 2
          end
        elseif _ARG_0_.zigzagStep == 1 then
          _ARG_0_:homingPlayer(0.5)
          _ARG_0_:ZigzagMoveLeft(_UPVALUE14_, 1, _UPVALUE15_)
          if 0 > _ARG_0_.zigzagTime then
            _ARG_0_.zigzagTime = _UPVALUE16_
            _ARG_0_.zigzagStep = 3
          end
        elseif _ARG_0_.zigzagStep == 2 then
          _ARG_0_:StopZigzagMove1(_UPVALUE14_, 0.05, _UPVALUE15_)
          if 0 > _ARG_0_.zigzagTime then
            _ARG_0_.zigzagTime = _UPVALUE17_
            _ARG_0_.zigzagStep = 1
            _ARG_0_.Speed = _UPVALUE14_ * 3
          end
        elseif _ARG_0_.zigzagStep == 3 then
          _ARG_0_:StopZigzagMove2(_UPVALUE14_, 0.05, _UPVALUE15_)
          if 0 > _ARG_0_.zigzagTime then
            _ARG_0_.zigzagTime = _UPVALUE17_
            _ARG_0_.zigzagStep = 0
            _ARG_0_.Speed = _UPVALUE14_ * 3
          end
        end
        if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false or 10 < _ARG_0_.AttackHitFlag then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE18_)
          _ARG_0_.step = _UPVALUE19_
          Entity.SetTimer(_ARG_0_.myHandle, 120)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          _ARG_0_.RotY = _ARG_0_.rot:gety()
        end
        _ARG_0_:setWallFlag(5)
        _ARG_0_.zigzagTime = _ARG_0_.zigzagTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      elseif _ARG_0_.step == _UPVALUE19_ then
        _ARG_0_.Speed = _ARG_0_.Speed - 0.0025 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.Speed then
          _ARG_0_.Speed = 0
          _ARG_0_:setWallFlag(6)
        elseif 0.1 > _ARG_0_.Speed then
          _ARG_0_:setWallFlag(6)
        end
        _ARG_0_.rot:set(0, _ARG_0_.RotY, 0)
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(_ARG_0_.Speed)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if _ARG_0_:isZeroSpeed() == 1 then
          _ARG_0_.step = _UPVALUE20_
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE18_)
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE18_)
          _ARG_0_.step = _UPVALUE20_
        end
      elseif _ARG_0_.step == _UPVALUE20_ then
        _ARG_0_:UpMoveY(0.3, 0.08)
        _ARG_0_.ScaleCount = 0
        _ARG_0_.srcScale = _ARG_0_.scale
        _ARG_0_.dstScale = 1 + (_UPVALUE2_ - 1) / _UPVALUE2_ * _ARG_0_.ScaleCount
        _ARG_0_.scaleTimer = _UPVALUE3_
        _ARG_0_.NowScale:set(1, 1, 1)
        Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.NowScale)
        _ARG_0_.step = _UPVALUE21_
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE22_)
        _ARG_0_:setFacialFlag(_UPVALUE23_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE18_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_:AuraControler(_UPVALUE24_)
        _ARG_0_:setWallFlag(6)
        _ARG_0_:OnCheckCamera()
      elseif _ARG_0_.step == _UPVALUE21_ then
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        _ARG_0_:setWallFlag(6)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE18_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:OffCheckCamera()
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if Script.IsDebugCheckAttack() then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      elseif _ARG_0_.step ~= _UPVALUE25_ or _ARG_0_:RandomMove() == 0 then
      elseif _ARG_0_:RandomMove() == 1 then
        _ARG_0_.Speed = 0
        _ARG_0_.step = _UPVALUE0_
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
        _ARG_0_:setFacialFlag(_UPVALUE26_)
      elseif _ARG_0_:RandomMove() == 2 then
        _ARG_0_.step = _UPVALUE0_
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 360)
        _ARG_0_:setFacialFlag(_UPVALUE26_)
        _ARG_0_.Speed = 0
      end
    end
  },
  Facial_press = {
    OnBeginState = function(_ARG_0_)
      print("b10sw00:Facial_press\n")
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      _ARG_0_:AuraControler(_UPVALUE0_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:OffCheckCamera()
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_, 8, 8)
      _ARG_0_.step = _UPVALUE2_
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_.JumpPow = 2
      _ARG_0_.Gravity = 0.01
      _ARG_0_.PopFlag = 0
      _ARG_0_.AddRotY = 25
      _ARG_0_:AuraControler(_UPVALUE3_)
      _ARG_0_.ScaleStep = _UPVALUE4_
      _ARG_0_.AttackCnt = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:OffCheckCamera()
      _ARG_0_:setWallFlag(6)
      _ARG_0_:AuraControler(_UPVALUE0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
      _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        if _ARG_0_.WorkVec1:gety() > _UPVALUE1_ + 1 then
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        if _ARG_0_.WorkVec1:gety() < _UPVALUE1_ then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = _UPVALUE3_
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_:setFacialFlag(_UPVALUE5_)
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE6_
          Entity.GetWorldPos(_ARG_0_.pressTargetPos, _ARG_0_.targetHandle)
          _ARG_0_.pressTargetPos:sety(0)
          Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
          Sound.PlayVoice(139, 6, 1, _ARG_0_.workVec)
          _ARG_0_:setFacialFlag(_UPVALUE5_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE7_)
          _ARG_0_:setWallFlag(4)
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(-_UPVALUE9_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 100 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE10_, 1, 2)
          _ARG_0_.step = _UPVALUE11_
          _ARG_0_.JumpPow = 0.8
          _ARG_0_.Gravity = 0.01
          _ARG_0_.PopFlag = 0
          _ARG_0_.AddRotY = 25
          Entity.SetTimer(_ARG_0_.myHandle, Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) / _UPVALUE12_)
          _ARG_0_:setFacialFlag(_UPVALUE5_)
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        _ARG_0_:setWallFlag(5)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.pressTargetPos, _ARG_0_.myPos)
        FVECTOR3.normalize(_ARG_0_.workVec)
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:setx(ROUND_PI(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()))
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(_UPVALUE12_)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        _ARG_0_:homingPlayer(0.6)
        Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
        if 4 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.pressTargetPos) or _ARG_0_.WorkVec1:gety() < 0.1 or Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) == false then
          _ARG_0_.step = _UPVALUE13_
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE14_)
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          _ARG_0_.Speed = _UPVALUE12_
          _ARG_0_.RotY = _ARG_0_.rot:gety()
          _ARG_0_:UpMoveY(0.3, 0.08)
          _ARG_0_.ScaleCount = 0
          _ARG_0_.srcScale = _ARG_0_.scale
          _ARG_0_.dstScale = 1 + (_UPVALUE15_ - 1) / _UPVALUE15_ * _ARG_0_.ScaleCount
          _ARG_0_.scaleTimer = _UPVALUE16_
          _ARG_0_.NowScale:set(1, 1, 1)
          Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.NowScale)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE17_)
          _ARG_0_:setFacialFlag(_UPVALUE18_)
          _ARG_0_:AuraControler(_UPVALUE19_)
          return
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        _ARG_0_:setWallFlag(5)
        _ARG_0_.Speed = _ARG_0_.Speed - _UPVALUE12_ * 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.Speed then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE20_)
          _ARG_0_.Speed = 0
          _ARG_0_:setWallFlag(6)
        elseif 0.1 > _ARG_0_.Speed then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE20_)
          _ARG_0_:setWallFlag(6)
        end
        _ARG_0_.rot:set(0, _ARG_0_.RotY, 0)
        _ARG_0_.velocity:set(0, 0, 1)
        Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
        _ARG_0_.velocity:scale(_ARG_0_.Speed)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE20_)
          _ARG_0_:setFacialFlag(_UPVALUE18_)
          _ARG_0_:OffCheckCamera()
          Entity.ClearSpeed(_ARG_0_.myHandle)
          if Script.IsDebugCheckAttack() then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      elseif _ARG_0_.step == _UPVALUE11_ then
        if _ARG_0_.ScaleStep == _UPVALUE21_ then
          _ARG_0_.FalceRotZ = _ARG_0_.FalceRotZ * 1 + 1
          if _ARG_0_.scale > 0.2 then
            _ARG_0_.ScaleCount = _ARG_0_.ScaleCount - 0.1
            _ARG_0_.srcScale = _ARG_0_.scale
            _ARG_0_.dstScale = 1 + (_UPVALUE15_ - 1) / _UPVALUE15_ * _ARG_0_.ScaleCount
            _ARG_0_.scaleTimer = _UPVALUE16_
          else
            _ARG_0_.ScaleStep = _UPVALUE22_
            _ARG_0_.FalceRotZ = 0
          end
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        elseif _ARG_0_.ScaleStep == _UPVALUE22_ then
          if _ARG_0_.ScaleCount < _UPVALUE15_ then
            _ARG_0_.ScaleCount = _ARG_0_.ScaleCount + 0.3
            _ARG_0_.srcScale = _ARG_0_.scale
            _ARG_0_.dstScale = 1 + (_UPVALUE15_ - 1) / _UPVALUE15_ * _ARG_0_.ScaleCount
            _ARG_0_.scaleTimer = _UPVALUE16_
          else
            _ARG_0_.c = 0.2
            _ARG_0_.theta = 0
            _ARG_0_.exec = true
            _ARG_0_.srcScale = _ARG_0_.scale
            _ARG_0_.dstScale = 1 + (_UPVALUE15_ - 1) / _UPVALUE15_ * _ARG_0_.ScaleCount
            _ARG_0_.scaleTimer = _UPVALUE16_
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE23_)
            Entity.ClearSpeed(_ARG_0_.myHandle)
            _ARG_0_.step = _UPVALUE0_
            Entity.SetTimer(_ARG_0_.myHandle, 400)
            _ARG_0_:AuraControler(_UPVALUE24_)
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
      elseif _ARG_0_.step == _UPVALUE25_ then
        _ARG_0_:UpMoveY(0.3, 0.08)
        _ARG_0_.ScaleCount = 0
        _ARG_0_.step = _UPVALUE13_
        _ARG_0_.srcScale = _ARG_0_.scale
        _ARG_0_.dstScale = 1 + (_UPVALUE15_ - 1) / _UPVALUE15_ * _ARG_0_.ScaleCount
        _ARG_0_.scaleTimer = _UPVALUE16_
        _ARG_0_.NowScale:set(1, 1, 1)
        Entity.SetScale(_ARG_0_.myHandle, _ARG_0_.NowScale)
        _ARG_0_.step = _UPVALUE26_
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE17_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        _ARG_0_:OnCheckCamera()
        _ARG_0_:AuraControler(_UPVALUE19_)
      end
      if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE2_ then
        if 0 > _ARG_0_.JumpPow then
          _ARG_0_:setFacialFlag(_UPVALUE18_)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 4)
        end
        _ARG_0_.AddRotY = _ARG_0_.AddRotY - 0.2 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.AddRotY then
          _ARG_0_.AddRotY = 0
        end
        _ARG_0_:TurnY(DegToRad(_ARG_0_.AddRotY))
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(0, 0, 0)
        _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
    end
  },
  Infinit_Wall = {
    OnBeginState = function(_ARG_0_)
      print("b10sw00:Infinit_Wall\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
      Entity.EnableShooton(_ARG_0_.myHandle, 0)
      _ARG_0_:FaicelPushInit(0.1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:AuraControler(_UPVALUE3_)
      _ARG_0_:setFacialFlag(_UPVALUE4_)
      _ARG_0_:OffCheckCamera()
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      _ARG_0_:setWallFlag(_UPVALUE1_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.EnableShooton(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      if _ARG_0_.GridHandle1 then
        Entity.Out(_ARG_0_.GridHandle1)
        _ARG_0_.GridHandle1 = NULL_HANDLE
      end
      if _ARG_0_.GridHandle2 then
        Entity.Out(_ARG_0_.GridHandle2)
        _ARG_0_.GridHandle2 = NULL_HANDLE
      end
      _ARG_0_:setWallFlag(_UPVALUE2_)
      _ARG_0_:OffCheckCamera()
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.GridHandle1 then
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.GridHandle1)
        Entity.GetWorldPos(_ARG_0_.PlayerPos, Player.GetHandle())
        _ARG_0_.WorkVec:setz(_ARG_0_.PlayerPos:getz())
        Entity.SetLocalPos(_ARG_0_.GridHandle1, _ARG_0_.WorkVec)
      end
      if _ARG_0_.GridHandle2 then
        Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.GridHandle2)
        Entity.GetWorldPos(_ARG_0_.PlayerPos, Player.GetHandle())
        _ARG_0_.WorkVec:setz(_ARG_0_.PlayerPos:getz())
        Entity.SetLocalPos(_ARG_0_.GridHandle2, _ARG_0_.WorkVec)
      end
      if _ARG_0_.step == _UPVALUE0_ then
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_:setWallFlag(_UPVALUE1_)
        Entity.GetWorldPos(_ARG_0_.PlayerPos, Player.GetHandle())
        _ARG_0_.WorkVec:set(_ARG_0_.PlayerPos:getx() + _UPVALUE2_, 1.0E-5, _ARG_0_.PlayerPos:getz())
        _ARG_0_.rot:set(0, 0, 0)
        _ARG_0_.GridHandle1 = Entity.CreateEntity("g21sw00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.rot:set(0, DegToRad(90), 0)
        _ARG_0_.InfEffectHndle1 = Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_INF_00_0", _ARG_0_.WorkVec, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.PlayerPos, Player.GetHandle())
        _ARG_0_.WorkVec:set(_ARG_0_.PlayerPos:getx() - _UPVALUE2_, 1.0E-5, _ARG_0_.PlayerPos:getz())
        _ARG_0_.rot:set(0, 0, DegToRad(180))
        _ARG_0_.GridHandle2 = Entity.CreateEntity("g21sw00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
      elseif _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_:OffCheckCamera()
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE3_
          _ARG_0_:setWallFlag(_UPVALUE3_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          print("B10SW_INFINIT_UPDATE\n")
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        _ARG_0_.rot:set(0, DegToRad(90), 0)
        if _ARG_0_.GridHandle1 then
          Entity.Out(_ARG_0_.GridHandle1)
          _ARG_0_.GridHandle1 = NULL_HANDLE
        end
        if _ARG_0_.GridHandle2 then
          Entity.Out(_ARG_0_.GridHandle2)
          _ARG_0_.GridHandle2 = NULL_HANDLE
        end
        _ARG_0_.step = _UPVALUE6_
        _ARG_0_:ResetFacial()
        _ARG_0_:setFacialFlag(_UPVALUE7_)
      elseif _ARG_0_.step == _UPVALUE6_ then
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE5_)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 10)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:OffCheckCamera()
          if Script.IsDebugCheckAttack() then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, Player.GetHandle(), 20)
      elseif _ARG_0_.step == _UPVALUE8_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:setFacialFlag(_UPVALUE9_)
        _ARG_0_:ResetFacial()
        _ARG_0_.step = _UPVALUE0_
        _ARG_0_:setWallFlag(_UPVALUE0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end
    end
  },
  Ninja_attack = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 4, 4)
      Entity.SetTimer(_ARG_0_.myHandle, 600)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_:setFacialFlag(_UPVALUE1_)
      _ARG_0_.step = _UPVALUE2_
      _ARG_0_.JumpPow = 0.5
      _ARG_0_.Gravity = 0.01
      _ARG_0_.PopFlag = 0
      _ARG_0_.AttackFlag = 0
      _ARG_0_.WorkTime = 0
      _ARG_0_:OffCheckCamera()
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_:OffCheckCamera()
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableGravity(_ARG_0_.myHandle, 1)
      _ARG_0_:setFacialFlag(_UPVALUE0_)
    end,
    OnUpdate = function(_ARG_0_)
      Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_:TurnY(DegToRad(20))
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(0, 0, 0)
        _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
      if _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_.step = _UPVALUE3_
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
      elseif _ARG_0_.step == _UPVALUE3_ then
        if _ARG_0_.oldAnglx >= DegToRad(90) then
          _ARG_0_.step = _UPVALUE4_
          _ARG_0_.WorkVec:set(0, 0, 0)
          _ARG_0_.rot:set(-_ARG_0_.oldAnglx, 0, 0)
          _ARG_0_.NinjaEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b10sw00", "B006_NIN_00_0", "FACE", _ARG_0_.WorkVec, _ARG_0_.rot)
          _ARG_0_.WorkTime = _UPVALUE5_ + Script.Random() * 2
          _ARG_0_:setFacialFlag(_UPVALUE6_)
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        _ARG_0_:UpMoveY(1, 0.1)
      elseif _ARG_0_.step == _UPVALUE4_ then
        _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.WorkTime then
        end
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 4 then
          _ARG_0_.WorkTime = _UPVALUE5_ + Script.Random() * 0.5
          _ARG_0_.step = _UPVALUE7_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_, 2, 2)
        end
        _ARG_0_:AddMove(0.3, 0.1)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE9_
          _ARG_0_:setFacialFlag(_UPVALUE10_)
          Effect.KillEffect(_ARG_0_.NinjaEffectHandle)
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
        end
      elseif _ARG_0_.step == _UPVALUE7_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 8 then
          _ARG_0_.step = _UPVALUE11_
          _ARG_0_:CreateBullet_Ninja(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == _UPVALUE11_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:setFacialFlag(_UPVALUE6_)
          _ARG_0_.step = _UPVALUE4_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE12_, 0, 4, 4)
          _ARG_0_:AllResetFacial()
        end
      elseif _ARG_0_.step == _UPVALUE9_ then
        _ARG_0_:StopMove(0.3, 0.01)
        if _ARG_0_:isZeroSpeed() == 1 and 0 >= _ARG_0_.oldAnglx then
          _ARG_0_.step = _UPVALUE13_
          _ARG_0_:OffCheckCamera()
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE14_)
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE15_)
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == _UPVALUE0_ then
        if _ARG_0_.WorkVec1:gety() > 3.5 then
          Entity.EnableBgColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        if _ARG_0_.WorkVec1:gety() < 2.5 then
          _ARG_0_:setFacialFlag(_UPVALUE16_)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE17_
        end
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 5)
      elseif _ARG_0_.step == _UPVALUE17_ then
        if Script.IsDebugCheckAttack() then
          _ARG_0_:GotoState("Idling")
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  Rising_press = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = _UPVALUE0_
      _ARG_0_.MoveFlag = 0
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Entity.EnableBgColl(_ARG_0_.myHandle, 0)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE1_, 8, 8)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
      _ARG_0_.Rising_Cnt = 0
      _ARG_0_:FaicelPushInit(_UPVALUE2_)
      _ARG_0_:OffCheckCamera()
      Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
      _ARG_0_.WorkVec:sety(0)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_LST_00_0", _ARG_0_.WorkVec, _ARG_0_.rot)
      _ARG_0_:AuraControler(_UPVALUE3_)
      _ARG_0_:setFacialFlag(_UPVALUE4_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_:FaicelPush(_UPVALUE1_, (Entity.GetFrameRate(_ARG_0_.myHandle))) == 1 then
          _ARG_0_.step = _UPVALUE2_
          Entity.EnableLockon(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        _ARG_0_:ResetFacial()
        _ARG_0_:FaicelPopInit(_UPVALUE3_)
        _ARG_0_:SetRishingOutPos()
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        _ARG_0_.step = _UPVALUE4_
      elseif _ARG_0_.step == _UPVALUE4_ then
        Entity.GetVelocity(_ARG_0_.workVec, _ARG_0_.targetHandle)
        Entity.GetWorldPos(_ARG_0_.centerPos, _ARG_0_.targetHandle)
        _ARG_0_.workVec:scale(Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 2)
        FVECTOR3.Add(_ARG_0_.centerPos, _ARG_0_.centerPos, _ARG_0_.workVec)
        _ARG_0_.centerPos:sety(0.5)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.centerPos, 20)
        if _ARG_0_:FaicelPop(_UPVALUE5_, (Entity.GetFrameRate(_ARG_0_.myHandle))) == 1 then
          _ARG_0_.step = _UPVALUE6_
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_, 1, 1)
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 8 then
          _ARG_0_.step = _UPVALUE8_
          _ARG_0_:CreateBreath(_ARG_0_.myHandle)
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE9_, 8, 8)
          _ARG_0_.step = _UPVALUE10_
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE11_)
          _ARG_0_:setFacialFlag(_UPVALUE12_)
        end
      elseif _ARG_0_.step == _UPVALUE10_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 20)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE13_
          Entity.EnableBgColl(_ARG_0_.myHandle, 0)
          _ARG_0_.Speed = 0
          _ARG_0_:FaicelPushInit(_UPVALUE14_)
          Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.myHandle)
          _ARG_0_.WorkVec:sety(0)
          Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
          Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_LST_00_0", _ARG_0_.WorkVec, _ARG_0_.rot)
          Entity.EnableLockon(_ARG_0_.myHandle, 0)
          _ARG_0_:setFacialFlag(_UPVALUE15_)
        end
      elseif _ARG_0_.step == _UPVALUE13_ then
        if _ARG_0_:FaicelPush(_UPVALUE1_, (Entity.GetFrameRate(_ARG_0_.myHandle))) == 1 then
          _ARG_0_.Rising_Cnt = _ARG_0_.Rising_Cnt + 1
          _ARG_0_.step = _UPVALUE2_
          _ARG_0_.MoveFlag = 0
          Entity.EnableLockon(_ARG_0_.myHandle, 0)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
        end
        if _ARG_0_.Rising_Cnt >= _UPVALUE16_ then
          _ARG_0_.step = _UPVALUE17_
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
          _ARG_0_:OnCheckCamera()
        end
      elseif _ARG_0_.step == _UPVALUE17_ then
        _ARG_0_:ResetFacial()
        _ARG_0_:FaicelPopInit(_UPVALUE3_)
        _ARG_0_:SetRishingOutPos()
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        _ARG_0_.step = _UPVALUE18_
      elseif _ARG_0_.step == _UPVALUE18_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if _ARG_0_:FaicelPop(_UPVALUE5_, (Entity.GetFrameRate(_ARG_0_.myHandle))) == 1 then
          _ARG_0_.step = _UPVALUE19_
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
        end
      elseif _ARG_0_.step == _UPVALUE19_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:OffCheckCamera()
          if Script.IsDebugCheckAttack() then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      end
      if _ARG_0_.WorkVec1:gety() < -99 then
        Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
        _ARG_0_.WorkVec1:sety(10)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.WorkVec1)
      end
    end
  },
  CameraOut = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, 40)
      if Script.Random() * 3 < 1 then
        _ARG_0_.CamRotFlag = 0
      elseif Script.Random() * 3 < 2 then
        _ARG_0_.CamRotFlag = 1
      else
        _ARG_0_.CamRotFlag = 2
      end
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      _ARG_0_.CamCheckFlag = 0
      _ARG_0_:OnCheckCamera()
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
        _ARG_0_:LeftMove(0.1, 0.6)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      else
      end
    end
  },
  ScaleTest = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.ScaleStep = _UPVALUE1_
      _ARG_0_.NowScale:set(0, 0, 0)
      Entity.GetScale(_ARG_0_.NowScale, _ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Entity.EnableBgColl(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.ScaleStep == _UPVALUE0_ then
        if _ARG_0_.scale > 0.5 then
          _ARG_0_.ScaleCount = _ARG_0_.ScaleCount - 0.6
          _ARG_0_.srcScale = _ARG_0_.scale
          _ARG_0_.dstScale = 1 + (_UPVALUE1_ - 1) / _UPVALUE1_ * _ARG_0_.ScaleCount
          _ARG_0_.scaleTimer = _UPVALUE2_
        else
          _ARG_0_.ScaleStep = _UPVALUE3_
        end
      elseif _ARG_0_.ScaleStep == _UPVALUE3_ then
        if _ARG_0_.ScaleCount < _UPVALUE1_ then
          _ARG_0_.ScaleCount = _ARG_0_.ScaleCount + 0.4
          _ARG_0_.srcScale = _ARG_0_.scale
          _ARG_0_.dstScale = 1 + (_UPVALUE1_ - 1) / _UPVALUE1_ * _ARG_0_.ScaleCount
          _ARG_0_.scaleTimer = _UPVALUE2_
        else
          _ARG_0_.c = 0.25
          _ARG_0_.theta = 0
          _ARG_0_.exec = true
          _ARG_0_.srcScale = _ARG_0_.scale
          _ARG_0_.dstScale = 1 + (_UPVALUE1_ - 1) / _UPVALUE1_ * _ARG_0_.ScaleCount
          _ARG_0_.scaleTimer = _UPVALUE2_
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
          _ARG_0_.ScaleStep = _UPVALUE5_
        end
      elseif _ARG_0_.ScaleStep == _UPVALUE5_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.ScaleStep = _UPVALUE6_
        end
      elseif _ARG_0_.ScaleStep == _UPVALUE6_ then
        _ARG_0_.ScaleCount = 0
        _ARG_0_.srcScale = _ARG_0_.scale
        _ARG_0_.dstScale = 1 + (_UPVALUE1_ - 1) / _UPVALUE1_ * _ARG_0_.ScaleCount
        _ARG_0_.scaleTimer = _UPVALUE2_
        _ARG_0_.ScaleStep = _UPVALUE7_
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE4_)
      elseif _ARG_0_.ScaleStep == _UPVALUE7_ and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_.ScaleStep = _UPVALUE0_
      end
    end
  },
  RotJumpTest = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 8, 8)
      _ARG_0_.step = _UPVALUE1_
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      _ARG_0_.JumpPow = 0.5
      _ARG_0_.Gravity = 0.01
      _ARG_0_.PopFlag = 0
      _ARG_0_:setFacialFlag(_UPVALUE2_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ or _ARG_0_.step == _UPVALUE1_ then
        _ARG_0_:TurnY(DegToRad(20))
        _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_0_.Gravity * Entity.GetFrameRate(_ARG_0_.myHandle)
        _ARG_0_.WorkVec:set(0, 0, 0)
        _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
      end
      Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
      if _ARG_0_.step == _UPVALUE0_ then
        if _ARG_0_.WorkVec1:gety() > 5.5 then
          Entity.EnableBgColl(_ARG_0_.myHandle, 1)
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        if _ARG_0_.WorkVec1:gety() < 4.5 then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
      end
      if _ARG_0_.WorkVec1:gety() < -99 then
        Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
        _ARG_0_.WorkVec1:sety(10)
        Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.WorkVec1)
      end
    end
  },
  BlowDamage = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
      _ARG_0_:OffCheckCamera()
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_:OffCheckCamera()
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.step = 1
      elseif _ARG_0_.step == 1 then
        Enemy.SetReaction(_ARG_0_.myHandle, ATK_KIND_DMG_BLOW)
        Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 1)
        _ARG_0_.step = 2
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
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function b10sw00.TurnY(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec:gety() + _ARG_1_)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.TurnXEx(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + _ARG_1_)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.TurnXExRight(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_:TurnY(DegToRad(_ARG_0_.AngY))
  _ARG_0_.AngY = _ARG_0_.AngY + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.AngY then
    _ARG_0_.AngY = _ARG_1_
  end
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + _ARG_1_)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.TurnX(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle)))
  if _ARG_0_.rot:getx() < DegToRad(-_ARG_3_) then
    _ARG_0_.rot:setx(DegToRad(-_ARG_3_))
  end
  if _ARG_0_.rot:getx() > DegToRad(_ARG_3_) then
    _ARG_0_.rot:setx(DegToRad(_ARG_3_))
  end
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return HomingDegree(_ARG_0_.rot:getx(), _ARG_1_, _ARG_2_, Entity.GetFrameRate(_ARG_0_.myHandle))
end
function b10sw00.ZigzagMoveRight(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ > _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  _ARG_0_.Speed2 = _ARG_0_.Speed2 + _ARG_3_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_3_ < _ARG_0_.Speed2 then
    _ARG_0_.Speed2 = _ARG_3_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.Speed2, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.ZigzagMoveLeft(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ > _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  _ARG_0_.Speed2 = _ARG_0_.Speed2 - _ARG_3_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed2 < -_ARG_3_ then
    _ARG_0_.Speed2 = -_ARG_3_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.Speed2, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.StopZigzagMove1(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  _ARG_0_.Speed2 = _ARG_0_.Speed2 - _ARG_3_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 > _ARG_0_.Speed2 then
    _ARG_0_.Speed2 = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.Speed2, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.StopZigzagMove2(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  _ARG_0_.Speed2 = _ARG_0_.Speed2 + _ARG_3_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 < _ARG_0_.Speed2 then
    _ARG_0_.Speed2 = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.Speed2, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.AddMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.LeftMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, _ARG_0_.Speed, 0, 0)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.BackMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ > _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.StopMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.StopYMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.Speed < 0 then
    _ARG_0_.Speed = 0
  end
  Entity.CalcVelocityY(_ARG_0_.myHandle, _ARG_0_.Speed)
end
function b10sw00.UpMove(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  Entity.CalcVelocityY(_ARG_0_.myHandle, _ARG_0_.Speed)
end
function b10sw00.UnMoveY(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
  if _ARG_2_ > _ARG_0_.WorkVec1:gety() then
    Entity.ClearSpeed(_ARG_0_.myHandle)
    return
  end
  Entity.CalcVelocityY(_ARG_0_.myHandle, _ARG_1_)
end
function b10sw00.UpMoveY(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
  if _ARG_2_ < _ARG_0_.WorkVec1:gety() then
    Entity.ClearSpeed(_ARG_0_.myHandle)
    return
  end
  FVECTOR3.set(_ARG_0_.WorkVec, 0, _ARG_1_, 0)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.isZeroSpeed(_ARG_0_)
  if _ARG_0_.Speed <= 0 then
    return 1
  end
  return 0
end
function ROUND_PI(_ARG_0_)
  if _ARG_0_ < -PI then
    return _ARG_0_ + PI * 2
  elseif _ARG_0_ > PI then
    return _ARG_0_ - PI * 2
  else
    return _ARG_0_
  end
end
function b10sw00.AllResetFacial(_ARG_0_)
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.NeckAngle:set(0, 0, 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
end
function b10sw00.ResetFacial(_ARG_0_)
  _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, 0, 2, (Entity.GetFrameRate(_ARG_0_.myHandle)))
end
function b10sw00.ResetFacial_X(_ARG_0_)
  _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, 0, 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
end
function b10sw00.Facial(_ARG_0_)
  if _ARG_0_.FacialFlag == _UPVALUE0_ then
    _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, 0, 2, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(_ARG_0_.oldAnglx, 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE1_ then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))), ROUND_PI((HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 5, (Entity.GetFrameRate(_ARG_0_.myHandle))))), ROUND_PI(_ARG_0_.FalceRotZ))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE2_ then
    _ARG_0_.oldAnglx = 0
    _ARG_0_.oldAngly = 0
  elseif _ARG_0_.FacialFlag == _UPVALUE3_ then
    _ARG_0_.NeckAngle:set(ROUND_PI(_ARG_0_.oldAnglx), 0, ROUND_PI(_ARG_0_.FalceRotZ))
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE4_ then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = _ARG_0_.rot:gety(), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 1, (Entity.GetFrameRate(_ARG_0_.myHandle))))), 0, ROUND_PI(_ARG_0_.FalceRotZ))
    if _ARG_0_.NeckAngle:getx() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.NeckAngle:getx() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE5_ then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()
    _ARG_0_.NeckAngle:set(ROUND_PI(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx()), ROUND_PI(Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()), ROUND_PI(_ARG_0_.FalceRotZ))
    if _ARG_0_.NeckAngle:getx() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.NeckAngle:getx() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE6_ then
    Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 5)
    Entity.GetWorldPos(_ARG_0_.NeckPos, _ARG_0_.myHandle, 2)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.NeckPos)
    FVECTOR3.normalize(_ARG_0_.workVec)
    _ARG_0_.oldAngly, _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 4, (Entity.GetFrameRate(_ARG_0_.myHandle))), HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 4, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, -Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())) - _ARG_0_.rot:getx(), 4, (Entity.GetFrameRate(_ARG_0_.myHandle))))), ROUND_PI((HomingDegree(_ARG_0_.oldAngly, Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety(), 4, (Entity.GetFrameRate(_ARG_0_.myHandle))))), ROUND_PI(_ARG_0_.FalceRotZ))
    if _ARG_0_.NeckAngle:getx() > _ARG_0_.LookMaxMin[1].Max then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Max)
    end
    if _ARG_0_.NeckAngle:getx() < _ARG_0_.LookMaxMin[1].Min then
      _ARG_0_.NeckAngle:setx(_ARG_0_.LookMaxMin[1].Min)
    end
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE7_ then
    _ARG_0_.oldAnglx = HomingDegree(_ARG_0_.oldAnglx, DegToRad(90), 3, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.NeckAngle:set(ROUND_PI((HomingDegree(_ARG_0_.oldAnglx, DegToRad(90), 3, (Entity.GetFrameRate(_ARG_0_.myHandle))))), 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  elseif _ARG_0_.FacialFlag == _UPVALUE8_ then
    _ARG_0_.oldAnglx = DegToRad(90)
    _ARG_0_.NeckAngle:set(ROUND_PI((DegToRad(90))), 0, 0)
    Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _ARG_0_.NeckAngle)
  end
end
function b10sw00.setFacialFlag(_ARG_0_, _ARG_1_)
  _ARG_0_.FacialFlag = _ARG_1_
end
function b10sw00.SetCirclePosition(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.WorkVec, Player.GetHandle())
  _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + _UPVALUE1_ * Math.Cos(DegToRad(EntityManager:GetEntity(_ARG_1_).angle * (360 / _UPVALUE0_))))
  _ARG_0_.WorkVec:sety(_ARG_0_.WorkVec1:gety())
  _ARG_0_.WorkVec:setz(_ARG_0_.WorkVec:getz() + _UPVALUE1_ * Math.Sin(DegToRad(EntityManager:GetEntity(_ARG_1_).angle * (360 / _UPVALUE0_))))
  Entity.SetLocalPos(_ARG_1_, _ARG_0_.WorkVec)
  EntityManager:GetEntity(_ARG_1_).angle = EntityManager:GetEntity(_ARG_1_).angle - _ARG_0_.RotationSpeed * Entity.GetFrameRate(_ARG_0_.myHandle)
  Entity.TurnTargetYDegree(_ARG_1_, Player.GetHandle(), 20)
end
function b10sw00.FacialScaleChange(_ARG_0_)
  if _ARG_0_.Scaleflag == 0 then
    _ARG_0_.NowScale:setx(_ARG_0_.NowScale:getx() - 0.05)
    _ARG_0_.NowScale:sety(_ARG_0_.NowScale:gety() - 0.05)
    _ARG_0_.NowScale:setz(_ARG_0_.NowScale:getz() - 0.05)
    if 0 > _ARG_0_.NowScale:getx() then
      _ARG_0_.NowScale:set(0, 0, 0)
      _ARG_0_.Scaleflag = 1
    end
  elseif _ARG_0_.Scaleflag == 1 then
    _ARG_0_.NowScale:setx(_ARG_0_.NowScale:getx() + (_ARG_0_.NowScale:getx() + 0.01) * 0.09)
    _ARG_0_.NowScale:sety(_ARG_0_.NowScale:gety() + (_ARG_0_.NowScale:gety() + 0.01) * 0.09)
    _ARG_0_.NowScale:setz(_ARG_0_.NowScale:getz() + (_ARG_0_.NowScale:getz() + 0.01) * 0.09)
    if _ARG_0_.NowScale:getx() > 0.5 then
      _ARG_0_.Scaleflag = 0
    end
  else
    _ARG_0_.NowScale:setx(_ARG_0_.NowScale:getx() - 0.05)
    _ARG_0_.NowScale:sety(_ARG_0_.NowScale:gety() - 0.05)
    _ARG_0_.NowScale:setz(_ARG_0_.NowScale:getz() - 0.05)
    if 0 > _ARG_0_.NowScale:getx() then
      _ARG_0_.NowScale:set(0, 0, 0)
      _ARG_0_.Scaleflag = 1
    end
  end
end
function b10sw00.PLSearchAirMove(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(WorkVec, _ARG_0_.targetHandle)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 225 then
  else
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 100 then
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.velocity:set(0, 0, 1)
      Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
      _ARG_0_.velocity:scale(-_UPVALUE0_)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
    else
    end
  end
end
function b10sw00.homingPlayer(_ARG_0_, _ARG_1_)
  Entity.GetVelocity(_ARG_0_.workVec, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.centerPos, _ARG_0_.targetHandle)
  _ARG_0_.workVec:scale(Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 2)
  FVECTOR3.Add(_ARG_0_.centerPos, _ARG_0_.centerPos, _ARG_0_.workVec)
  _ARG_0_.centerPos:sety(0.5)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.centerPos, _ARG_1_)
end
function b10sw00.FaicelPushInit(_ARG_0_, _ARG_1_)
  _ARG_0_.JumpPow = _ARG_1_
  _ARG_0_.Gravity = 0
  _ARG_0_.PushFlag = 0
end
function b10sw00.FaicelPush(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_1_ * _ARG_2_
  _ARG_0_.WorkVec:set(0, 0, 0)
  _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  if _ARG_0_.PushFlag == 0 then
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
    if _ARG_0_.WorkVec1:gety() < -6.8 then
      Entity.ClearSpeed(_ARG_0_.myHandle)
      return 1
    end
  elseif _ARG_0_.PushFlag == 1 then
  end
  if _ARG_0_.WorkVec1:gety() < -99 then
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
    _ARG_0_.WorkVec1:sety(10)
    Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.WorkVec1)
  end
  return 0
end
function b10sw00.FaicelPopInit(_ARG_0_, _ARG_1_)
  _ARG_0_.JumpPow = _ARG_1_
  _ARG_0_.Gravity = 0
end
function b10sw00.FaicelPop(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_0_.JumpPow = _ARG_0_.JumpPow - _ARG_1_ * _ARG_2_
  _ARG_0_.WorkVec:set(0, 0, 0)
  _ARG_0_.WorkVec:sety(_ARG_0_.JumpPow)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
  if _ARG_0_.PopFlag == 0 then
    if 0 < _ARG_0_.WorkVec1:gety() then
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      _ARG_0_.PopFlag = 1
    end
  elseif _ARG_0_.PopFlag == 1 and Entity.IsGround(_ARG_0_.myHandle) then
    Entity.ClearSpeed(_ARG_0_.myHandle)
    _ARG_0_.PopFlag = 0
    return 1
  end
  if _ARG_0_.WorkVec1:gety() < -99 then
    Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
    _ARG_0_.WorkVec1:sety(10)
    Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.WorkVec1)
  end
  return 0
end
function b10sw00.isFacialGroundUnder(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
  if _ARG_0_.WorkVec1:gety() < -0.38 then
    return 1
  end
  return 0
end
function b10sw00.setWallFlag(_ARG_0_, _ARG_1_)
  _ARG_0_.WallFlag = _ARG_1_
end
function b10sw00.AuraControler(_ARG_0_, _ARG_1_)
  if Effect.IsAlive(_ARG_0_.AuraEffectHandle) then
    if _ARG_1_ == _UPVALUE0_ then
      Effect.LoopEnd(_ARG_0_.AuraEffectHandle)
      _ARG_0_.AuraEffectHandle = NULL_HANDLE
    elseif _ARG_1_ == _UPVALUE1_ then
      Effect.LoopEnd(_ARG_0_.AuraEffectHandle)
      _ARG_0_.WorkVec:set(0, 0.25, 0)
      Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.AuraEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b10sw00", "B006_ORA_01_0", "FACE", _ARG_0_.WorkVec)
      Effect.SetAttachReverseTrs(_ARG_0_.AuraEffectHandle, true)
      Effect.SetAttachAlpha(_ARG_0_.AuraEffectHandle, true)
    elseif _ARG_1_ == _UPVALUE2_ then
      Effect.LoopEnd(_ARG_0_.AuraEffectHandle)
      _ARG_0_.WorkVec:set(0, 0.25, 0)
      Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
      Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
      _ARG_0_.AuraEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b10sw00", "B006_ORA_00_0", "FACE", _ARG_0_.WorkVec)
      Effect.SetAttachReverseTrs(_ARG_0_.AuraEffectHandle, true)
      Effect.SetAttachAlpha(_ARG_0_.AuraEffectHandle, true)
    end
  elseif _ARG_1_ == _UPVALUE3_ then
    _ARG_0_.WorkVec:set(0, 0.25, 0)
    Entity.GetWorldPos2(_ARG_0_.WorkVec1, _ARG_0_.myHandle, _ARG_0_.WorkVec)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    _ARG_0_.AuraEffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "b10sw00", "B006_ORA_00_0", "FACE", _ARG_0_.WorkVec)
    Effect.SetAttachReverseTrs(_ARG_0_.AuraEffectHandle, true)
    Effect.SetAttachAlpha(_ARG_0_.AuraEffectHandle, true)
  end
end
function b10sw00.CreateBullet(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 0)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_, 18)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.myPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _UPVALUE0_, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE0_, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 0)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_01_0")
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle)
  Entity.CalcVelocity(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), 0.25)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), 900)
  _ARG_0_.workVec:set(_UPVALUE1_, _UPVALUE1_, _UPVALUE1_)
  Effect.SetScale(Bullet.CreateEffectBullet(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_RIS_01_0"), _ARG_0_.workVec)
end
function b10sw00.CreateBullet_Lod(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_, 2)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.centerPos, _ARG_0_.myPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, _UPVALUE0_, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE0_, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 0)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_01_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_01_0")
  Entity.CalcVelocity(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), 0.25)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), 900)
  _ARG_0_.workVec:set(_UPVALUE1_, _UPVALUE1_, _UPVALUE1_)
  Effect.SetScale(Bullet.CreateEffectBullet(Bullet.CreateBullet("b10sw00f2", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_00_0"), _ARG_0_.workVec)
end
function b10sw00.CreateBreath(_ARG_0_, _ARG_1_)
  _ARG_0_.PlayerPos:set(0, 0.5, 0)
  Entity.GetWorldPos2(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, _ARG_0_.PlayerPos)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_, 18)
  Entity.GetRot(_ARG_0_.rot, _ARG_1_)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.PlayerPos, _ARG_0_.myPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  _ARG_0_.rot:setx(-Math.Atan2(_ARG_0_.workVec:gety(), Math.Sqrt(_ARG_0_.workVec:getz() * _ARG_0_.workVec:getz() + _ARG_0_.workVec:getx() * _ARG_0_.workVec:getx())))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_RIS_01_0")
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 5)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_RIS_02_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_RIS_03_0")
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle)
  Entity.CalcVelocity(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), 0.25)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b10sw00b", _ARG_0_.myPos, _ARG_0_.rot), 100)
end
function b10sw00.CreateBullet_Ninja(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_1_, 18)
  _ARG_0_.rot:set(DegToRad(90), 0, 0)
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.6, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.6, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), _ARG_0_.myHandle, 4)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_01_0")
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle)
  Entity.CalcVelocity(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), 0)
  Entity.EnableGravity(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), 1)
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), 900)
  _ARG_0_.workVec:set(_UPVALUE0_, _UPVALUE0_, _UPVALUE0_)
  Effect.SetScale(Bullet.CreateEffectBullet(Bullet.CreateBullet("b10sw00f", _ARG_0_.myPos, _ARG_0_.rot), "b10sw00", "B006_FIR_00_0"), _ARG_0_.workVec)
end
function b10sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.AuraEffectHandle = NULL_HANDLE
  _ARG_0_.GridHandle1 = NULL_HANDLE
  _ARG_0_.GridHandle2 = NULL_HANDLE
  _ARG_0_.InfEffectHndle1 = NULL_HANDLE
  _ARG_0_.InfEffectHndle2 = NULL_HANDLE
  _ARG_0_.BigEffectHandle = NULL_HANDLE
  _ARG_0_.NinjaEffectHandle = NULL_HANDLE
  _ARG_0_.OldState = 0
  _ARG_0_.angle = 2
  _ARG_0_.targetAngle = 0
  _ARG_0_.cont = 0
  _ARG_0_.ProliferationHandle = {}
  _ARG_0_.Speed = 0
  _ARG_0_.Speed2 = 0
  _ARG_0_.RotationSpeed = 0
  _ARG_0_.targetSpeed = 0
  _ARG_0_.PopFlag = 0
  _ARG_0_.PushFlag = 0
  _ARG_0_.RotY = 0
  _ARG_0_.AddRotY = 0
  _ARG_0_.AttackHitFlag = 0
  _ARG_0_.Scaleflag = 0
  _ARG_0_.FlowType = 0
  _ARG_0_.ScaleStep = 0
  _ARG_0_.id = 0
  for _FORV_5_ = 0, _UPVALUE0_ - 1 do
    _ARG_0_.ProliferationHandle[_FORV_5_] = {
      handle = NULL_HANDLE,
      AttackFlag = 0,
      AttackDelay = 0,
      MotRandFlag = 0
    }
  end
  _ARG_0_.CamCnt = 0
  _ARG_0_.MotCangeCnt = 0
  _ARG_0_.FlameRate = 0
  _ARG_0_.PlayerDist = 0
  _ARG_0_.AttackFlag = 0
  _ARG_0_.AttackCnt = 0
  _ARG_0_.theta = 0
  _ARG_0_.c = 0
  _ARG_0_.scale = 1
  _ARG_0_.scaleTimer = 0
  _ARG_0_.dstScale = 0
  _ARG_0_.srcScale = 0
  _ARG_0_.ScaleCount = 0
  _ARG_0_.exec = 0
  _ARG_0_.AngY = 0
  _ARG_0_.Gravity = 0
  _ARG_0_.JumpPow = 0
  _ARG_0_.FacialID = 0
  _ARG_0_.MyFacialID = 0
  _ARG_0_.damageCnt = 0
  _ARG_0_.FalceRotZ = 0
  _ARG_0_.FacialFlag = 0
  _ARG_0_.WallFlag = 0
  _ARG_0_.CamCheckFlag = 0
  _ARG_0_.OldState = 0
  _ARG_0_.RotationTime = 0
  _ARG_0_.RotationFlag = 0
  _ARG_0_.MoveFlag = 0
  _ARG_0_.flagafterimage = 0
  _ARG_0_.Rising_Cnt = 0
  _ARG_0_.zigzagStep = 0
  _ARG_0_.zigzagTime = 0
  _ARG_0_.Rising_ang_X = Script.Random() * 360 - 180
  _ARG_0_.Rising_ang_Y = Script.Random() * 100 - 50
  _ARG_0_.Rising_ang_Z = Script.Random() * 360 - 180
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkTime = 0
  _ARG_0_.WorkTime2 = 0
  _ARG_0_.work0 = 0
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NowScale = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.PlayerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.centerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.pressTargetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NeckPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.NeckAngle = FVECTOR3.new(0, 0, 0)
  _ARG_0_.oldAnglx = 0
  _ARG_0_.oldAngly = 0
  _ARG_0_.LookMaxMin = {}
  _ARG_0_.LookMaxMin[0] = {
    Max = DegToRad(90),
    Min = DegToRad(-90)
  }
  _ARG_0_.LookMaxMin[1] = {
    Max = DegToRad(90),
    Min = DegToRad(-90)
  }
  _ARG_0_.stack = Stack:Create()
  if _UPVALUE1_ == false then
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingBase") * 60
    _UPVALUE3_ = _UPVALUE2_
    _UPVALUE0_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacSerCnt")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacSerRad")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacSerSp")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacSerRT") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacSerRST") * 60
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacSerAT") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Giga_Scale")
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Giga_Dist1") * Enemy.GetExtraParam(_ARG_0_.myHandle, "Giga_Dist1")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Giga_Scale")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GigaBigLaT")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "InfinitTime") * 60
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "InfDelay") * 60
    _UPVALUE15_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "InfDelay")
    _UPVALUE16_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RisingDelay") * 60
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacialPleSp")
    _UPVALUE18_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "FacialPlePY")
    _UPVALUE19_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RisingLerp")
    _UPVALUE20_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "RisingRad")
    _UPVALUE21_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BulletScale")
    _UPVALUE22_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BCollSize")
    _UPVALUE23_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BlownCount")
    _UPVALUE24_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GigaUpFra")
    _UPVALUE25_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PressUpFra")
    _UPVALUE26_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ZigzagSpZ")
    _UPVALUE27_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ZigzagSpX")
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ZigzagTime")
    _UPVALUE29_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "ZigzagSTime")
    _UPVALUE1_ = true
  end
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 2)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 2.5)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableHeavy(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b10sw00.OnDamage(_ARG_0_, _ARG_1_)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 30)
  if _ARG_0_:GetState() == "Facial_serge" or _ARG_0_:GetState() == "Facial_serge_other_self" then
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _UPVALUE0_ and Entity.GetCurrentMotion(_ARG_0_.myHandle) ~= _UPVALUE1_ then
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      _ARG_0_:setFacialFlag(_UPVALUE2_)
      _ARG_0_:AllResetFacial()
      for _FORV_6_ = 0, _UPVALUE3_ do
        if _FORV_6_ > _UPVALUE3_ - 1 then
          break
        end
        if _ARG_0_.MyFacialID == _FORV_6_ then
          Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
          if _ARG_0_.step ~= _UPVALUE4_ then
            _ARG_0_.step = _UPVALUE4_
            _ARG_0_.WorkTime = _UPVALUE5_
            _ARG_0_:OnCheckCamera()
          end
        elseif _ARG_0_.ProliferationHandle[_FORV_6_].handle then
          Entity.SetMotionWithSameCheck(_ARG_0_.ProliferationHandle[_FORV_6_].handle, _UPVALUE6_)
          _ARG_0_.ProliferationHandle[_FORV_6_].handle = NULL_HANDLE
          _ARG_0_.ProliferationHandle[_FORV_6_].MotRandFlag = 0
        end
      end
    end
  elseif _ARG_0_:GetState() == "Giganticcimpact" then
  elseif _ARG_0_:GetState() == "Facial_press" then
  elseif _ARG_0_:GetState() == "Ninja_attack" then
    if _ARG_0_.step == _UPVALUE7_ then
      _ARG_0_:setFacialFlag(_UPVALUE2_)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE8_)
      Enemy.EnableNoDamageReaction(_ARG_0_.myHandle, 0)
      _ARG_0_:AllResetFacial()
      return 1
    end
  elseif _ARG_0_:GetState() == "Infinit_Wall" then
    _ARG_0_:ResetFacial()
    _ARG_0_:setFacialFlag(_UPVALUE9_)
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
    Player.OffAttackFlagAttackTarget()
    if _ARG_0_.step == _UPVALUE10_ then
      Entity.SetTimer(_ARG_0_.myHandle, 10)
    end
    print("|||||||||")
  elseif _ARG_0_:GetState() == "Rising_press" then
  elseif _ARG_0_:GetState() == "RotJumpTest" then
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    _ARG_0_:setFacialFlag(_UPVALUE2_)
  end
  _ARG_0_.damageCnt = _ARG_0_.damageCnt + 1
  print("Damage Cnt = " .. _ARG_0_.damageCnt .. "\n")
  if _ARG_0_.damageCnt > _UPVALUE11_ - 1 then
    if Enemy.IsNoDamageReaction(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoState("BlowDamage")
      _ARG_0_.damageCnt = 0
      return 1
    end
    _ARG_0_.damageCnt = 0
  end
end
function b10sw00.OnDamageBefore(_ARG_0_)
  print("nowMotion = " .. Entity.GetCurrentMotion(_ARG_0_.myHandle) .. "\n")
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  if _UPVALUE1_ == Entity.GetCurrentMotion(_ARG_0_.myHandle) or _UPVALUE2_ == Entity.GetCurrentMotion(_ARG_0_.myHandle) or _UPVALUE0_:gety() < 0 then
    return 1
  end
  return 0
end
function b10sw00.OnReturnDamage(_ARG_0_)
  _ARG_0_:ResetFacial()
  if _ARG_0_:GetState() == "Facial_serge" or _ARG_0_:GetState() == "Facial_serge_other_self" then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_:setFacialFlag(_UPVALUE1_)
  elseif _ARG_0_:GetState() == "Giganticcimpact" then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_:setFacialFlag(_UPVALUE1_)
  elseif _ARG_0_:GetState() == "Facial_press" then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_:setFacialFlag(_UPVALUE1_)
  elseif _ARG_0_:GetState() == "Infinit_Wall" then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_:setFacialFlag(_UPVALUE1_)
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  elseif _ARG_0_:GetState() == "Ninja_attack" then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_:setFacialFlag(_UPVALUE1_)
  elseif _ARG_0_:GetState() == "Rising_press" then
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    _ARG_0_:setFacialFlag(_UPVALUE1_)
  elseif _ARG_0_:GetState() == "Idling" then
    _ARG_0_:GotoState("Idling")
  else
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end
end
function b10sw00.OnHitAttack(_ARG_0_)
  _ARG_0_.AttackHitFlag = _ARG_0_.AttackHitFlag + 1
  if _ARG_0_:GetState() == "Giganticcimpact" then
    Camera.QuakeV(80, 0.32, 8)
    _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
    if 1 < _ARG_0_.AttackCnt then
      _ARG_0_.AttackCnt = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 5, 5)
    end
  elseif _ARG_0_:GetState() == "Facial_press" then
    Camera.QuakeV(80, 0.32, 8)
    _ARG_0_.AttackCnt = _ARG_0_.AttackCnt + 1
    if 1 < _ARG_0_.AttackCnt then
      _ARG_0_.AttackCnt = 0
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_, 5, 5)
    end
  end
end
function b10sw00.UpdateExpansion(_ARG_0_)
  if _ARG_0_.scaleTimer > 0 then
    _ARG_0_.scaleTimer = _ARG_0_.scaleTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.scaleTimer <= 0 then
      _ARG_0_.scaleTimer = 0
    end
    _ARG_0_.scale = _ARG_0_.srcScale + (1 - _ARG_0_.scaleTimer / _UPVALUE0_) * (_ARG_0_.dstScale - _ARG_0_.srcScale)
  end
  if _ARG_0_.exec then
    _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(60))
    _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.008
    if 0 >= _ARG_0_.c then
      _ARG_0_.c = 0
      _ARG_0_.exec = false
    end
  end
end
function b10sw00.OnCheckCamera(_ARG_0_)
  _ARG_0_.CamCheckFlag = 1
end
function b10sw00.OffCheckCamera(_ARG_0_)
  _ARG_0_.CamCheckFlag = 0
end
function b10sw00.CheckCameraIn(_ARG_0_)
  if _ARG_0_.CamCheckFlag == 0 then
  elseif _ARG_0_.CamCheckFlag == 1 then
    Camera.GetPlayerCameraPos(_ARG_0_.workVec)
    Camera.GetPlayerCameraDir(_ARG_0_.workVec1)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.workVec) < 9 then
      _ARG_0_.CamCheckFlag = 0
      _ARG_0_.OldState = _ARG_0_:GetState()
      _ARG_0_:GotoState("CameraOut")
      print("b10sw00 : \131J\131\129\131\137\130\170\148\205\136\205\147\224\130\201\147\252\130\193\130\196\130\162\130\220\130\183\129B\n")
    end
  end
end
function b10sw00.SetRishingOutPos(_ARG_0_)
  Camera.GetPlayerCameraPos(_ARG_0_.workVec)
  Camera.GetPlayerCameraDir(_ARG_0_.workVec1)
  Entity.GetWorldPos(_ARG_0_.WorkVec, _ARG_0_.targetHandle)
  Math.VectorLerp(_ARG_0_.myPos, _ARG_0_.workVec, _ARG_0_.WorkVec, _UPVALUE0_)
  _ARG_0_.WorkVec:set(0, 0, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
  _ARG_0_.myPos:setx(_ARG_0_.myPos:getx() + _UPVALUE1_ * Math.Cos(DegToRad(Script.Random() * 360)))
  _ARG_0_.myPos:sety(-6)
  _ARG_0_.myPos:setz(_ARG_0_.myPos:getz() + _UPVALUE1_ * Math.Sin(DegToRad(Script.Random() * 360)))
  Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.myPos)
  _ARG_0_.myPos:sety(0)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_LST_00_0", _ARG_0_.myPos, _ARG_0_.rot)
end
function b10sw00.RandomMove(_ARG_0_)
  _ARG_0_.WorkTime = _ARG_0_.WorkTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.WorkTime <= 0 then
    _ARG_0_.targetAngle = (Script.Random() - Script.Random()) * (5.5 * PI)
    _ARG_0_.WorkTime = 240
    _ARG_0_.WorkVec:set(Math.Cos((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 1 + _UPVALUE0_), 0, Math.Sin((RoundPI(DegToRad(Script.Random() * 360)))) * (Script.Random() * 1 + _UPVALUE0_))
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  end
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetWorldPos(_ARG_0_.PlayerPos, _ARG_0_.targetHandle, 2)
  if Entity.GetFloorDistance(_ARG_0_.myHandle) < 0.2 then
    _ARG_0_.targetAngle = -Script.Random() * (0.5 * PI)
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  elseif Entity.GetFloorDistance(_ARG_0_.myHandle) > 4 then
    _ARG_0_.targetAngle = Script.Random() * (0.5 * PI)
    _ARG_0_.targetSpeed = Script.Random() * 0.3 + 0.1
  end
  FVECTOR3.Add(_ARG_0_.PlayerPos, _ARG_0_.PlayerPos, _ARG_0_.WorkVec)
  Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.PlayerPos, -_ARG_0_.work0)
  _ARG_0_.angle = HomingDegree(_ARG_0_.angle, _ARG_0_.targetAngle, RoundPI(1.5), (Entity.GetFrameRate(_ARG_0_.myHandle)))
  _ARG_0_.Speed = HomingDegree(_ARG_0_.Speed, _ARG_0_.targetAngle, RoundPI(1.5), (Entity.GetFrameRate(_ARG_0_.myHandle)))
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:setx(_ARG_0_.angle)
  _ARG_0_.velocity:set(0, 0, 1)
  Math.RotateVectorXYZ(_ARG_0_.velocity, _ARG_0_.rot)
  _ARG_0_.velocity:scale(_UPVALUE1_)
  Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.velocity)
  _ARG_0_.WorkTime2 = _ARG_0_.WorkTime2 - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if 0 > _ARG_0_.WorkTime2 then
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 225 then
      return 1
    end
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      return 2
    end
  end
  return 0
end
function b10sw00.OnUpdatePositionAfter(_ARG_0_)
  _ARG_0_:Facial()
  _ARG_0_:UpdateExpansion()
  _ARG_0_.WorkVec:set(Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale, Math.Cos(_ARG_0_.theta) * _ARG_0_.c + _ARG_0_.scale)
  Entity.ScalingBone(_ARG_0_.myHandle, 2, _ARG_0_.WorkVec)
  Entity.GetScale(_ARG_0_.WorkVec1, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(0, (_ARG_0_.scale - 1) * 1.25 * _ARG_0_.WorkVec1:getx(), 0)
  Entity.SetDispOffset(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b10sw00.OnDead(_ARG_0_)
  _ARG_0_:GotoState("Dead")
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  SetupBossDead(_ARG_0_.myHandle)
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
  else
  end
  return 1
end
function b10sw00.GetNumber(_ARG_0_)
  return _ARG_0_.WallFlag
end
function b10sw00.Debug(_ARG_0_)
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
function b10sw00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  _ARG_0_:CheckCameraIn()
  _ARG_0_.damageCnt = _ARG_0_.damageCnt - 0.005 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.damageCnt < 0 then
    _ARG_0_.damageCnt = 0
  end
end
EntityFactory:Add("b10sw00", function(_ARG_0_)
  EntityManager:Add(b10sw00:new(), _ARG_0_)
  return (b10sw00:new())
end)
b10sw00b = {}
b10sw00b_mt = {__index = b10sw00b}
function b10sw00b.new(_ARG_0_)
  return setmetatable({}, b10sw00b_mt)
end
function b10sw00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.SetTimer(_ARG_0_.myHandle, 180)
end
function b10sw00b.OnHitAttack(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  return 1
end
function b10sw00b.OnHitBg(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
    _ARG_0_.step = 1
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_RIS_03_0", _UPVALUE0_, _UPVALUE1_)
    Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
    Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  end
end
function b10sw00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == 1 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    end
    Entity.ClearSpeed(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("b10sw00b", function(_ARG_0_)
  return (b10sw00b:new())
end)
b10sw00f = {}
b10sw00f_mt = {__index = b10sw00f}
function b10sw00f.new(_ARG_0_)
  return setmetatable({}, b10sw00f_mt)
end
function b10sw00f.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.SetTimer(_ARG_0_.myHandle, 180)
end
function b10sw00f.OnHitAttack(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  _ARG_0_.step = 1
  return 1
end
function b10sw00f.OnHitBg(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
    _ARG_0_.step = 1
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(0.009)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_FIR_04_0", _UPVALUE0_, _UPVALUE1_)
    Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
    Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  end
end
function b10sw00f.OnReflect(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  _ARG_0_.step = 1
  return 1
end
function b10sw00f.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == 1 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    end
    Entity.ClearSpeed(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("b10sw00f", function(_ARG_0_)
  return (b10sw00f:new())
end)
b10sw00f2 = {}
b10sw00f2_mt = {__index = b10sw00f2}
function b10sw00f2.new(_ARG_0_)
  return setmetatable({}, b10sw00f2_mt)
end
function b10sw00f2.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.SetTimer(_ARG_0_.myHandle, 180)
end
function b10sw00f2.OnHitAttack(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  _ARG_0_.step = 1
  return 1
end
function b10sw00f2.OnReflect(_ARG_0_)
  Entity.ClearSpeed(_ARG_0_.myHandle)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  _ARG_0_.step = 1
  return 1
end
function b10sw00f2.OnHitBg(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsGround(_ARG_0_.myHandle) then
      _ARG_0_.step = 1
    end
    _ARG_0_.step = 1
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(0.009)
    _UPVALUE1_:set(0, 0, 0)
    Entity.SetEffect(_ARG_0_.myHandle, "b10sw00", "B006_FIR_02_0", _UPVALUE0_, _UPVALUE1_)
    Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
    Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  end
end
function b10sw00f2.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == 1 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    end
    Entity.ClearSpeed(_ARG_0_.myHandle)
  end
end
EntityFactory:Add("b10sw00f2", function(_ARG_0_)
  return (b10sw00f2:new())
end)
