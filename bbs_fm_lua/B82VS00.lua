{
  ["Speed"] = 0.21,
  ["CollSize"] = 0.4,
  ["SpeedUpRate"] = 1.8,
  [0] = {}
}[0][0] = {}
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:setMotion(_UPVALUE0_)
        _UPVALUE1_:set(0, 0, -4.5)
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.ShieldHandle = NULL_HANDLE
        _ARG_0_.ShieldHandle = Entity.CreateEntity("b84vs00", _UPVALUE1_, _UPVALUE2_)
        _UPVALUE1_:set(0, _UPVALUE3_, -5)
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.barrierEffect = _ARG_0_:createEffect("b82vs00", "b082_ash_bar1_0")
        _ARG_0_.GridHandle1 = NULL_HANDLE
        _UPVALUE1_:set(0, 0, -4)
        _UPVALUE2_:set(0, DegToRad(90), 0)
        _ARG_0_.GridHandle1 = Entity.CreateEntity("g21sw00", _UPVALUE1_, _UPVALUE2_, _ARG_0_.myHandle)
        _ARG_0_.GridHandle2 = NULL_HANDLE
        _UPVALUE1_:set(0, -1, -4.41177)
        _UPVALUE2_:set(0, 0, 0)
        _ARG_0_.GridHandle2 = Entity.CreateEntity("g60vs00", _UPVALUE1_, _UPVALUE2_, _ARG_0_.myHandle)
        Entity.SetTimer(_ARG_0_.myHandle, 20)
      end,
      OnEndState = function(_ARG_0_)
        _UPVALUE0_:set(0.5, 0, 0)
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.mainEffect = _ARG_0_:createAttachEffect(_ARG_0_.ShieldHandle, "b82vs00", "B082_ASH_ORA0_0", "shield")
        Effect.SetAttachNoScale(_ARG_0_.mainEffect, false)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Idling\n")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_:SetingState()
        _ARG_0_.noInvitationTime = _ARG_0_.noInvitationTime - 1
        _ARG_0_.time = _UPVALUE1_ + Script.Random() * _UPVALUE1_
        _UPVALUE2_ = "Idling"
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.time <= 0 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    },
    DarkBolley = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":DarkBolley\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.step = 0
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle, 2)
        _UPVALUE1_:setx(_UPVALUE1_:getx())
        _UPVALUE1_:sety(_UPVALUE1_:gety() + 0.7)
        _UPVALUE1_:setz(_UPVALUE1_:getz() + 2)
        _UPVALUE2_:set(_UPVALUE1_:getx(), _UPVALUE1_:gety(), _UPVALUE1_:getz())
        _UPVALUE3_ = "DarkBolley"
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 40 and _ARG_0_.time <= 0 then
          _ARG_0_:CreateShoot(_ARG_0_.myHandle)
          _ARG_0_.time = 5
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    BalazsType1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType1\n")
        _UPVALUE0_ = "BalazsType1"
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep2 = 0
        _ARG_0_.balazsStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            _ARG_0_:setMotion(_UPVALUE0_)
            _UPVALUE1_:set(0, _UPVALUE2_, 1.8)
            _UPVALUE3_:set(7.5, 2, _UPVALUE4_)
            _UPVALUE5_:set(0, DegToRad(21), 0)
            _ARG_0_.balazsStep = 0
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            if _ARG_0_.balazsStep == 0 then
              for _FORV_7_ = 0, 6 do
                _UPVALUE3_:set(_UPVALUE3_:getx(), _UPVALUE2_, _UPVALUE4_ - _UPVALUE1_:getz())
                _UPVALUE5_:set(0, _UPVALUE5_:gety(), 0)
                _UPVALUE5_:set(0, 0, Script.Random() * PI)
                _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, 0, 0)
                _UPVALUE3_:setx(_UPVALUE3_:getx() - 2.5)
                if _FORV_7_ <= 2 then
                  _UPVALUE1_:setz(_UPVALUE1_:getz() - 0.6)
                else
                  _UPVALUE1_:setz(_UPVALUE1_:getz() + 0.6)
                end
                _UPVALUE5_:sety(_UPVALUE5_:gety() - DegToRad(7))
              end
              _FOR_:set(0, 0, 1.8)
              _UPVALUE3_:set(6.25, 2, -10)
              _UPVALUE5_:set(0, DegToRad(21), 0)
              _ARG_0_.balazsStep = 1
              _ARG_0_.time = 30
            else
              for _FORV_7_ = 0, 5 do
                _UPVALUE3_:set(_UPVALUE3_:getx(), _UPVALUE2_, _UPVALUE4_ - _UPVALUE1_:getz())
                _UPVALUE5_:set(0, 0, Script.Random() * PI)
                _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, 0, 0)
                _UPVALUE3_:setx(_UPVALUE3_:getx() - 2.5)
                if _FORV_7_ < 2 then
                  _UPVALUE1_:setz(_UPVALUE1_:getz() - 0.6)
                elseif _FORV_7_ < 3 then
                else
                  _UPVALUE1_:setz(_UPVALUE1_:getz() + 0.6)
                end
              end
              _FOR_:set(0, 0, 1.8)
              _UPVALUE3_:set(7.5, 2, -10)
              _UPVALUE5_:set(0, DegToRad(21), 0)
              _ARG_0_.balazsStep = 0
              _ARG_0_.time = 180
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    BalazsType2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType2\n")
        _UPVALUE0_ = "BalazsType2"
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep2 = 0
        _ARG_0_.balazsStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_:setMotion(_UPVALUE0_)
            if Script.Random() < 0.5 then
              _UPVALUE1_:set(2.5, _UPVALUE2_, 1.8)
              _UPVALUE3_:set(7.5, 2, _UPVALUE4_)
              _UPVALUE5_:set(0, DegToRad(21), 0)
              _ARG_0_.balazsStep = 0
              print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType2 self.balazsStep = 0\n")
            else
              _UPVALUE1_:set(2.5, _UPVALUE2_, 1.8)
              _UPVALUE3_:set(-7.5 + _UPVALUE1_:getx() / 2, 2, _UPVALUE4_)
              _UPVALUE5_:set(0, DegToRad(21), 0)
              print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType2 self.balazsStep = 1\n")
              _ARG_0_.balazsStep = 1
            end
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            if _ARG_0_.balazsStep == 0 then
              _UPVALUE3_:set(_UPVALUE3_:getx(), _UPVALUE2_, _UPVALUE4_)
              _UPVALUE5_:set(0, _UPVALUE5_:gety(), 0)
              _UPVALUE5_:set(0, 0, Script.Random() * PI)
              _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE6_, 1)
              _UPVALUE3_:setx(_UPVALUE3_:getx() - _UPVALUE1_:getx())
              if _UPVALUE3_:getx() < -7.5 then
                _ARG_0_.balazsStep = 1
                _UPVALUE3_:set(-7.5 + _UPVALUE1_:getx() / 2, 2, -10)
                _UPVALUE1_:set(2.5, _UPVALUE2_, 1.8)
                _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
              end
              _ARG_0_.time = 5
            else
              _UPVALUE3_:set(_UPVALUE3_:getx(), _UPVALUE2_, _UPVALUE4_)
              _UPVALUE5_:set(0, _UPVALUE5_:gety(), 0)
              _UPVALUE5_:set(0, 0, Script.Random() * PI)
              _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE6_, 1)
              _UPVALUE3_:setx(_UPVALUE3_:getx() + _UPVALUE1_:getx())
              if 7.5 < _UPVALUE3_:getx() then
                _UPVALUE3_:set(7.5 - _UPVALUE1_:getx(), 2, -10)
                _UPVALUE1_:set(2.5, _UPVALUE2_, 1.8)
                _ARG_0_.balazsStep = 0
                _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
              end
              _ARG_0_.time = 5
            end
            if 2 < _ARG_0_.balazsStep2 then
              _ARG_0_.balazsStep2 = 0
              _ARG_0_.time = 240
              _ARG_0_.step = 3
            end
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    BalazsType3 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType3\n")
        _UPVALUE0_ = "BalazsType3"
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep2 = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 1
            _ARG_0_.balazsStep = 0
            _UPVALUE1_:set(0, 0, 0)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 2
            _ARG_0_.keyNumber = 0
            _ARG_0_.rnd = Script.Random() * 5 + 2
            _ARG_0_.rndx = Script.Random() * _UPVALUE2_ - _UPVALUE2_ / 2
            _ARG_0_.rndy = Script.Random() * _UPVALUE3_ + _UPVALUE4_
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _UPVALUE5_:set(_ARG_0_.rndx + (Script.Random() * 3 - 0.5), _ARG_0_.rndy + (Script.Random() * 3 - 0.5), _UPVALUE6_ + (Script.Random() * 2 - 1))
            _ARG_0_:SetKeyRotPlayerHoming()
            _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE7_, 2)
            if _ARG_0_.keyNumber > _ARG_0_.rnd then
              _ARG_0_.step = 3
            end
            _ARG_0_.keyNumber = _ARG_0_.keyNumber + 1
            _ARG_0_.time = 1
          end
        elseif _ARG_0_.step == 3 then
          if 2 < _ARG_0_.balazsStep2 then
            _ARG_0_.balazsStep2 = 0
            _ARG_0_.time = 60
            _ARG_0_.step = 4
          else
            _ARG_0_.time = 10
            _ARG_0_.step = 5
          end
          _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
        elseif _ARG_0_.step == 4 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _ARG_0_:GotoState("Idling")
          end
        elseif _ARG_0_.step == 5 then
          _ARG_0_.step = 2
          _ARG_0_.keyNumber = 0
          _ARG_0_.rnd = Script.Random() * 5 + 2
          _ARG_0_.rndx = Script.Random() * _UPVALUE2_ - _UPVALUE2_ / 2
          _ARG_0_.rndy = Script.Random() * _UPVALUE3_ + _UPVALUE4_
        end
      end
    },
    BalazsType4 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType4\n")
        _UPVALUE0_ = "BalazsType4"
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep2 = 0
        _ARG_0_.balazsStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 1
            _ARG_0_.balazsStep = 0
            _UPVALUE1_:set(0, 0, 0)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _UPVALUE4_:set(Script.Random() * _UPVALUE2_ - _UPVALUE2_ / 2 + (Script.Random() * 1 - 0.5), _UPVALUE3_ + Script.Random() * 1, _UPVALUE5_ + (Script.Random() * 2 - 1))
            _UPVALUE1_:set(0, 0, 0)
            _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE6_, 3)
            _ARG_0_.time = 2
            if 20 < _ARG_0_.balazsStep2 then
              _ARG_0_.balazsStep2 = 0
              _ARG_0_.time = 240
              _ARG_0_.step = 3
            end
            _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    BalazsType5 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":BalazsType5\n")
        _UPVALUE0_ = "BalazsType5"
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.balazsStep2 = 0
        _ARG_0_.balazsStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setMotion(_UPVALUE0_)
            _ARG_0_.step = 1
            _ARG_0_.balazsStep = 0
            _UPVALUE1_:set(0, 0, 0)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 20 then
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.time = _ARG_0_.time - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            _UPVALUE5_:set(Script.Random() * _UPVALUE2_ - _UPVALUE2_ / 2 + (Script.Random() * 1 - 0.5), Script.Random() * _UPVALUE3_ + _UPVALUE4_ + Script.Random() * 1, _UPVALUE6_ + (Script.Random() * 2 - 1))
            _ARG_0_:CreateKeyBalazs(_ARG_0_.myHandle, _UPVALUE7_, 4)
            _ARG_0_.time = 2
            if 20 < _ARG_0_.balazsStep2 then
              _ARG_0_.balazsStep2 = 0
              _ARG_0_.time = 240
              _ARG_0_.step = 3
            end
            _ARG_0_.balazsStep2 = _ARG_0_.balazsStep2 + 1
          end
        elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Invitation = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Invitation\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.noInvitationTime = 3
        _ARG_0_.step = 0
        _ARG_0_:createInvitationEffect(0)
        _UPVALUE2_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _UPVALUE3_ = "Invitation"
        _ARG_0_:createInviEffect()
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EffectLoopEnd(_ARG_0_.invitationEffect)
        _ARG_0_.invitationEffect = NULL_HANDLE
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviOnEffect)
        _ARG_0_.InviOnEffect = NULL_HANDLE
        _UPVALUE0_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _ARG_0_.invitaHandle = _ARG_0_.targetHandle
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
            if _ARG_0_.InviOnEffect == NULL_HANDLE then
              _UPVALUE1_:set(_UPVALUE2_[0].x, _UPVALUE2_[0].y, _UPVALUE2_[0].z)
              _UPVALUE3_:set(0, 0, 0)
              _ARG_0_.InviOnEffect = _ARG_0_:createEffect("b82vs00", "B082_SIN_KAI1_0")
            end
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE1_:set(_UPVALUE2_[0].x, _UPVALUE2_[0].y, _UPVALUE2_[0].z)
          if 1 > Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE1_) then
            if Player.GetPlayerState(_ARG_0_.targetHandle) == PLAYER_STATE_ILLUSION then
              Player.SetDamage(_ARG_0_.targetHandle, 0)
            end
            if Player.IsMuteki(_ARG_0_.targetHandle) == false then
              _ARG_0_:GotoState("Restraint")
            end
            return
          else
            _ARG_0_:playerPulls(_ARG_0_.targetHandle, 0)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.step == 0 then
            _ARG_0_:setMotion(_UPVALUE4_)
            _ARG_0_.step = 1
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Invitation1 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Invitation1\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.noInvitationTime = 3
        _ARG_0_.step = 0
        _UPVALUE2_:set(_UPVALUE3_[1].x, _UPVALUE3_[1].y, _UPVALUE3_[1].z)
        _UPVALUE4_:set(0, 0, 0)
        _ARG_0_.invitationEffect = _ARG_0_:createEffect("b82vs00", "b082_sin_kai0_0")
        _UPVALUE5_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _UPVALUE6_ = "Invitation"
        _ARG_0_:createInviEffect()
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EffectLoopEnd(_ARG_0_.invitationEffect)
        _ARG_0_.invitationEffect = NULL_HANDLE
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviOnEffect)
        _ARG_0_.InviOnEffect = NULL_HANDLE
        _UPVALUE0_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _ARG_0_.invitaHandle = _ARG_0_.targetHandle
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
            if _ARG_0_.InviOnEffect == NULL_HANDLE then
              _UPVALUE1_:set(_UPVALUE2_[1].x, _UPVALUE2_[1].y, _UPVALUE2_[1].z)
              _UPVALUE3_:set(0, 0, 0)
              _ARG_0_.InviOnEffect = _ARG_0_:createEffect("b82vs00", "B082_SIN_KAI1_0")
            end
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE1_:set(_UPVALUE2_[1].x, _UPVALUE2_[1].y, _UPVALUE2_[1].z)
          if 1 > Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE1_) then
            if Player.GetPlayerState(_ARG_0_.targetHandle) == PLAYER_STATE_ILLUSION then
              Player.SetDamage(_ARG_0_.targetHandle, 0)
            end
            if Player.IsMuteki(_ARG_0_.targetHandle) == false then
              _ARG_0_:GotoState("Restraint")
            end
            return
          else
            _ARG_0_:playerPulls(_ARG_0_.targetHandle, 0)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.step == 0 then
            _ARG_0_:setMotion(_UPVALUE4_)
            _ARG_0_.step = 1
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Invitation2 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Invitation2\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, 180)
        _ARG_0_.noInvitationTime = 3
        _ARG_0_.step = 0
        _UPVALUE1_:set(_UPVALUE2_[2].x, _UPVALUE2_[2].y, _UPVALUE2_[2].z)
        _UPVALUE3_:set(0, 0, 0)
        _ARG_0_.invitationEffect = _ARG_0_:createEffect("b82vs00", "b082_sin_kai0_0")
        _UPVALUE4_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _UPVALUE5_ = "Invitation"
        _ARG_0_:createInviEffect()
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EffectLoopEnd(_ARG_0_.invitationEffect)
        _ARG_0_.invitationEffect = NULL_HANDLE
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviOnEffect)
        _ARG_0_.InviOnEffect = NULL_HANDLE
        _UPVALUE0_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _ARG_0_.invitaHandle = _ARG_0_.targetHandle
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
            if _ARG_0_.InviOnEffect == NULL_HANDLE then
              _UPVALUE1_:set(_UPVALUE2_[2].x, _UPVALUE2_[2].y, _UPVALUE2_[2].z)
              _UPVALUE3_:set(0, 0, 0)
              _ARG_0_.InviOnEffect = _ARG_0_:createEffect("b82vs00", "B082_SIN_KAI1_0")
            end
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE1_:set(_UPVALUE2_[2].x, _UPVALUE2_[2].y, _UPVALUE2_[2].z)
          if 1 > Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE1_) then
            if Player.GetPlayerState(_ARG_0_.targetHandle) == PLAYER_STATE_ILLUSION then
              Player.SetDamage(_ARG_0_.targetHandle, 0)
            end
            if Player.IsMuteki(_ARG_0_.targetHandle) == false then
              _ARG_0_:GotoState("Restraint")
            end
            return
          else
            _ARG_0_:playerPulls(_ARG_0_.targetHandle, 0)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.step == 0 then
            _ARG_0_:setMotion(_UPVALUE4_)
            _ARG_0_.step = 1
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Invitation3 = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Invitation3\n")
        _ARG_0_:setMotion(_UPVALUE0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.SetTimer(_ARG_0_.myHandle, 180)
        _ARG_0_.noInvitationTime = 3
        _ARG_0_.step = 0
        _UPVALUE1_:set(_UPVALUE2_[3].x, _UPVALUE2_[3].y, _UPVALUE2_[3].z)
        _UPVALUE3_:set(0, 0, 0)
        _ARG_0_.invitationEffect = _ARG_0_:createEffect("b82vs00", "b082_sin_kai0_0")
        _UPVALUE4_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _UPVALUE5_ = "Invitation"
        _ARG_0_:createInviEffect()
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EffectLoopEnd(_ARG_0_.invitationEffect)
        _ARG_0_.invitationEffect = NULL_HANDLE
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviOnEffect)
        _ARG_0_.InviOnEffect = NULL_HANDLE
        _UPVALUE0_ = Entity.GetHp(_ARG_0_.ShieldHandle)
        _ARG_0_.invitaHandle = _ARG_0_.targetHandle
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetCurrentMotion(_ARG_0_.targetHandle) == Entity.GetMotionIndex(_ARG_0_.targetHandle, "801") then
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
            if _ARG_0_.InviOnEffect == NULL_HANDLE then
              _UPVALUE1_:set(_UPVALUE2_[3].x, _UPVALUE2_[3].y, _UPVALUE2_[3].z)
              _UPVALUE3_:set(0, 0, 0)
              _ARG_0_.InviOnEffect = _ARG_0_:createEffect("b82vs00", "B082_SIN_KAI1_0")
            end
          end
        elseif _ARG_0_.step == 1 then
          _UPVALUE1_:set(_UPVALUE2_[3].x, _UPVALUE2_[3].y, _UPVALUE2_[3].z)
          if 1 > Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE1_) then
            if Player.GetPlayerState(_ARG_0_.targetHandle) == PLAYER_STATE_ILLUSION then
              Player.SetDamage(_ARG_0_.targetHandle, 0)
            end
            if Player.IsMuteki(_ARG_0_.targetHandle) == false then
              _ARG_0_:GotoState("Restraint")
            end
            return
          else
            _ARG_0_:playerPulls(_ARG_0_.targetHandle, 0)
          end
          if Entity.IsMotionEnd(_ARG_0_.myHandle) and _ARG_0_.step == 0 then
            _ARG_0_:setMotion(_UPVALUE4_)
            _ARG_0_.step = 1
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Restraint = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Restraint\n")
        _UPVALUE0_:set(0, 0, 0)
        _ARG_0_.step = 0
        Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.targetHandle, 2)
        _ARG_0_:createEffect("b82vs00", "b082_com_wrp0_0")
        Entity.SetTimer(_ARG_0_.myHandle, 15)
        Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_DMG_SMALL)
      end,
      OnEndState = function(_ARG_0_)
        Player.SetDamage(_ARG_0_.targetHandle, 0, ATK_KIND_CAPTURE)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 3, -4)
        Entity.SetLocalPos(_ARG_0_.targetHandle, _UPVALUE1_)
        _UPVALUE1_:set(0, 0, 0)
        Entity.SetRot(_ARG_0_.targetHandle, _UPVALUE1_)
        _ARG_0_:setMotion(_UPVALUE2_)
        _UPVALUE1_:set(0, 4, -4)
        _UPVALUE3_:set(0, 0, 0)
        _ARG_0_:createEffect("b82vs00", "b082_com_wrp1_0")
        _ARG_0_.InveFlag = 1
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Waiting\n")
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        if Mission.IsFlagFinalRound() == 1 then
          _ARG_0_.step = 0
        else
          SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE0_, 1)
          _ARG_0_.step = 1
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        _ARG_0_.MantleHandle = Enemy.GetEnemyHandle(71)
        Entity.SetAlpha(_ARG_0_.MantleHandle, 1)
        _ARG_0_.GridHandle1 = NULL_HANDLE
        _UPVALUE0_:set(0, 0, -4)
        _UPVALUE1_:set(0, DegToRad(90), 0)
        _ARG_0_.GridHandle1 = Entity.CreateEntity("g21sw00", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle)
        _ARG_0_.GridHandle2 = NULL_HANDLE
        _UPVALUE0_:set(0, -1, -4.41177)
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.GridHandle2 = Entity.CreateEntity("g60vs00", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE0_:set(0, 0, 0)
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.mainEffect = _ARG_0_:createAttachEffect(_ARG_0_.ShieldHandle, "b82vs00", "B082_ASH_ORA0_0", "Root")
        Entity.EnableLockonAndShooton(Enemy.GetEnemyHandle(72), 0)
        Entity.SetAlpha(Enemy.GetEnemyHandle(72), 0)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.Out((Enemy.GetEnemyHandle(72)))
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.ShieldHandle = Enemy.GetEnemyHandle(73)
        _ARG_0_.MantleHandle = Enemy.GetEnemyHandle(71)
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetOldLocalPos(_ARG_0_.MantleHandle, _UPVALUE0_)
        Entity.SetLocalPos(_ARG_0_.MantleHandle, _UPVALUE0_)
        Entity.SetRot(_ARG_0_.MantleHandle, _UPVALUE0_)
        Entity.AttachCoord(_ARG_0_.myHandle, "mune", _ARG_0_.MantleHandle, "Root")
        Entity.EnableLockonAndShooton(_ARG_0_.MantleHandle, 0)
        Entity.EnableLockonAndShooton(Enemy.GetEnemyHandle(72), 0)
        if _ARG_0_.step == 0 then
          if Exusia.IsExistenceSchedule() then
            print("Exusia.IsExistenceSchedule()\n")
            SetupAppearBegin(_ARG_0_.myHandle, -1, _UPVALUE1_, 1)
            _ARG_0_.step = 1
          end
        else
          if Enemy.IsAllEnemyWaiting() == false then
          end
          if Enemy.IsAllEnemyWaiting() == false then
            print("Enemy.IsAllEnemyWaiting() == false\n")
            _ARG_0_:GotoState("Idling")
          end
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Dead\n")
        _ARG_0_:EffectLoopEnd(_ARG_0_.barrierEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.invitationEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.beamEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.pcAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.shieldAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviEffectHandle)
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviOnEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.mainEffect)
        Entity.Out(_ARG_0_.GridHandle1)
        _ARG_0_.GridHandle1 = NULL_HANDLE
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  getRate_p1 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp1
  end,
  getRate_p2 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp2
  end,
  getRate_p3 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp3
  end,
  getRate_p4 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp4
  end,
  getRate_p5 = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_2_ == 0 then
    elseif _ARG_2_ == 1 then
    elseif _ARG_2_ == 1 then
    end
    return _UPVALUE0_[_ARG_1_].ppp5
  end,
  checkRate = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _UPVALUE0_[_ARG_1_].rateType == 2 then
    elseif _UPVALUE0_[_ARG_1_].rateType == 5 then
    end
    if _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) > Script.Random() then
      return 1
    elseif _ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_) > Script.Random() then
      return 2
    elseif _ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)) > Script.Random() then
      return 3
    elseif _ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_))) > Script.Random() then
      return 4
    elseif _ARG_0_:getRate_p5(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p4(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p3(_ARG_1_, _ARG_2_) + (_ARG_0_:getRate_p2(_ARG_1_, _ARG_2_) + _ARG_0_:getRate_p1(_ARG_1_, _ARG_2_)))) > Script.Random() then
      return 5
    end
  end,
  SetingState = function(_ARG_0_)
    _ARG_0_.stack:push("Idling")
    if Player.IsDamageFlagCapture(_ARG_0_.targetHandle) == true then
      if Script.Random() < _UPVALUE0_[2].p1 then
        _ARG_0_.stack:push("DarkBolley")
      elseif _ARG_0_:checkRate(3, 0) == 1 then
        _ARG_0_.stack:push("BalazsType1")
      elseif _ARG_0_:checkRate(3, 0) == 2 then
        _ARG_0_.stack:push("BalazsType2")
      elseif _ARG_0_:checkRate(3, 0) == 3 then
        _ARG_0_.stack:push("BalazsType3")
      elseif _ARG_0_:checkRate(3, 0) == 4 then
        _ARG_0_.stack:push("BalazsType4")
      elseif _ARG_0_:checkRate(3, 0) == 5 then
        _ARG_0_.stack:push("BalazsType5")
      end
    else
      if Script.Random() < _UPVALUE1_ then
        _ARG_0_.stack:push("DarkBolley")
        return
      end
      if Script.Random() < _UPVALUE0_[1].p1 then
        if _ARG_0_:checkRate(3, 0) == 1 then
          _ARG_0_.stack:push("BalazsType1")
        elseif _ARG_0_:checkRate(3, 0) == 2 then
          _ARG_0_.stack:push("BalazsType2")
        elseif _ARG_0_:checkRate(3, 0) == 3 then
          _ARG_0_.stack:push("BalazsType3")
        elseif _ARG_0_:checkRate(3, 0) == 4 then
          _ARG_0_.stack:push("BalazsType4")
        elseif _ARG_0_:checkRate(3, 0) == 5 then
          _ARG_0_.stack:push("BalazsType5")
        end
      elseif 0 > _ARG_0_.noInvitationTime then
        if Script.Random() < 0.25 then
          _ARG_0_.stack:push("Invitation")
        elseif Script.Random() < 0.5 then
          _ARG_0_.stack:push("Invitation1")
        elseif Script.Random() < 0.75 then
          _ARG_0_.stack:push("Invitation2")
        elseif Script.Random() < 1 then
          _ARG_0_.stack:push("Invitation3")
        end
      end
    end
  end,
  setMotion = function(_ARG_0_, _ARG_1_)
    Entity.SetMotion(_ARG_0_.myHandle, _ARG_1_)
    Entity.SetMotion(_ARG_0_.MantleHandle, _ARG_1_)
  end,
  playerPulls = function(_ARG_0_, _ARG_1_, _ARG_2_)
    _ARG_0_:InhaleForPlayer(_ARG_0_.targetHandle, 4, _ARG_2_, _UPVALUE0_, "F_book2")
  end,
  SetKeyRotPlayerHoming = function(_ARG_0_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
    _UPVALUE0_:setx(_UPVALUE0_:getx() + 2 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE0_:setz(_UPVALUE0_:getz() + 2 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE1_:set(0, 0, 0)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE3_)
    FVECTOR3.normalize(_UPVALUE2_)
    _UPVALUE1_:set(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getz() * _UPVALUE2_:getz() + _UPVALUE2_:getx() * _UPVALUE2_:getx())), Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
  end,
  CreateKeyBalazs = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    for _FORV_9_ = 0, 9 do
      if Script.Random() < _FORV_9_ / 10 then
        break
      end
    end
    _FOR_.SetEffect(_ARG_0_.myHandle, "b82vs00", "b082_kba_fir0_0", _UPVALUE0_, _UPVALUE1_)
    Bullet.CreateEffectBullet(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), "b82vs00", "b082_kba_loc0_0")
    Bullet.SetCollision(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE2_.CollSize, 0, _ARG_1_)
    Bullet.SetDamageCollision(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, _UPVALUE2_.CollSize + 0.1, 0)
    SetBulletAttackParam(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle, _ARG_3_)
    if Entity.GetCurrentMotion(Player.GetHandle()) == Entity.GetMotionIndex(Player.GetHandle(), "801") then
      Bullet.SetAttackParam(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), ATK_KIND_WITHOUT, Enemy.GetAttackAttr(_ARG_0_.myHandle, _ARG_3_), Enemy.GetAttackPoint(_ARG_0_.myHandle, _ARG_3_), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, _ARG_3_), 0, Enemy.GetDifficultyCorrection())
    end
    Entity.CalcVelocity(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), 0)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), 14400)
    Entity.SetRotateMode(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), 4)
    if Script.Random() < 0.333 then
      Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), "b82vs00", "b082_kba_hit0_0")
    elseif Script.Random() < 0.666 then
      Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), "b82vs00", "b082_kba_hit1_0")
    else
      Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), "b82vs00", "b082_kba_hit2_0")
    end
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), "b82vs00", "b082_kba_los0_0")
    _UPVALUE3_:set(Script.Random() * 0.5 + 1, Script.Random() * 0.5 + 1, Script.Random() * 0.5 + 1)
    Entity.SetScale(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), _UPVALUE3_)
    Entity.GetRot(_UPVALUE4_, (Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_)))
    _UPVALUE4_:setz(Script.Random() * PI)
    Entity.SetRot(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), _UPVALUE4_)
    EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_))).mode = _ARG_2_
    if _ARG_2_ == _UPVALUE5_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_))).Speed = _UPVALUE2_.Speed
    elseif _ARG_2_ == _UPVALUE6_ then
    elseif _ARG_2_ == _UPVALUE7_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_))).Speed = _UPVALUE2_.Speed + (Script.Random() * 0.1 - 0.05)
    elseif _ARG_2_ == _UPVALUE8_ then
      EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_))).Speed = _UPVALUE2_.Speed + (Script.Random() * 0.1 - 0.05)
    end
    EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
    EntityManager:GetEntity((Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_))).initDist = Entity.CalcDistanceXZ(Bullet.CreateBullet("Balazs" .. _FORV_9_ .. "0", _UPVALUE0_, _UPVALUE1_), _ARG_0_.targetHandle)
  end,
  CreateShoot = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
    Entity.GetRot(_UPVALUE1_, _ARG_1_)
    FVECTOR3.Sub(_UPVALUE2_, _UPVALUE0_, _UPVALUE3_)
    FVECTOR3.normalize(_UPVALUE2_)
    Entity.SetEffect(_ARG_0_.myHandle, "p_sl_dav_00", "P_SL_DAV_FIR0_0", _UPVALUE3_, _UPVALUE1_)
    _UPVALUE3_:setx(_UPVALUE3_:getx() + 2 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE3_:setz(_UPVALUE3_:getz() + 2 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    Bullet.CreateEffectBullet(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), "p_sl_dav_00", "P_SL_DAV_BLT0_0")
    Bullet.SetCollision(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
    SetBulletAttackParam(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), _ARG_0_.myHandle, 5)
    if Entity.GetCurrentMotion(Player.GetHandle()) == Entity.GetMotionIndex(Player.GetHandle(), "801") then
      Bullet.SetAttackParam(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), ATK_KIND_WITHOUT, Enemy.GetAttackAttr(_ARG_0_.myHandle, 5), Enemy.GetAttackPoint(_ARG_0_.myHandle, 5), Enemy.GetAttackPowerCorrection(_ARG_0_.myHandle, 5), 0, Enemy.GetDifficultyCorrection())
    end
    Bullet.SetHitAttackEffectName(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), "p_sl_dav_00", "P_SL_DAV_HIT0_0")
    Bullet.SetHitBgEffectName(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), "p_sl_dav_00", "P_SL_DAV_WAL0_0")
    Entity.CalcVelocity(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), 0.25)
    Bullet.SetMaxMoveDist(Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_), 14400)
    EntityManager:GetEntity((Bullet.CreateBullet("Volley", _UPVALUE3_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
  end,
  EffectLoopEnd = function(_ARG_0_, _ARG_1_)
    Effect.LoopEnd(_ARG_1_)
    return NULL_HANDLE
  end,
  createEffect = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
  end,
  createInvitationEffect = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(_UPVALUE1_[_ARG_1_].x, _UPVALUE1_[_ARG_1_].y, _UPVALUE1_[_ARG_1_].z)
    _UPVALUE2_:set(0, 0, 0)
    if _ARG_0_.invitationEffect == NULL_HANDLE then
      _ARG_0_.invitationEffect = _ARG_0_:createEffect("b82vs00", "b082_sin_kai0_0")
    end
  end,
  createAttachEffect = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    return Entity.AttachEffect(_ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _UPVALUE0_, _UPVALUE1_)
  end,
  createInviEffect = function(_ARG_0_)
    if _ARG_0_.InviEffectHandle == NULL_HANDLE then
      _UPVALUE0_:set(0.5, 0, 0)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.InviEffectHandle = _ARG_0_:createAttachEffect(_ARG_0_.ShieldHandle, "b82vs00", "B082_SRE_BEA2_0", "shield")
    end
  end,
  InhaleForPlayer = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, _ARG_5_)
    for _FORV_11_, _FORV_12_ in pairs(EntityManager.entities) do
      if (Entity.GetName(_FORV_11_) == "m91ex00" or Entity.GetName(_FORV_11_) == "m92ex00" or Entity.GetName(_FORV_11_) == "m93ex00" or Entity.GetName(_FORV_11_) == "m94ex00" or Entity.GetName(_FORV_11_) == "m95ex00") and Player.GetNetworkID(Entity.GetParent(_FORV_11_)) == 0 and Enemy.IsIllusionGroundIn(_FORV_11_) == false then
        break
      end
    end
    if _FORV_11_ == NULL_HANDLE then
      if Player.IsMuteki(_ARG_1_) then
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetForce(_ARG_1_, _UPVALUE0_)
        return false
      end
    else
      _ARG_1_ = _FORV_11_
    end
    _UPVALUE1_:set(_UPVALUE2_[_ARG_3_].x, _UPVALUE2_[_ARG_3_].y, _UPVALUE2_[_ARG_3_].z)
    Entity.GetWorldPos(_UPVALUE3_, _ARG_1_, 2)
    _UPVALUE1_:set(_UPVALUE2_[_ARG_3_].x, _UPVALUE2_[_ARG_3_].y, _UPVALUE2_[_ARG_3_].z)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE3_)
    _UPVALUE0_:sety(0)
    _UPVALUE0_:normalize()
    _UPVALUE0_:scale(Entity.GetFrameRate(_ARG_0_.myHandle) * _ARG_4_)
    Entity.SetForce(_ARG_1_, _UPVALUE0_)
    return false
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = "011"
    _UPVALUE1_ = "300"
    _UPVALUE2_ = "440"
    _UPVALUE3_ = "800"
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.barrierEffect = NULL_HANDLE
    _ARG_0_.invitationEffect = NULL_HANDLE
    _ARG_0_.beamEffect = NULL_HANDLE
    _ARG_0_.pcAttachEffect = NULL_HANDLE
    _ARG_0_.shieldAttachEffect = NULL_HANDLE
    _ARG_0_.mainEffect = NULL_HANDLE
    _ARG_0_.InviOnEffect = NULL_HANDLE
    _ARG_0_.InviEffectHandle = NULL_HANDLE
    _ARG_0_.inveTime = 0
    _ARG_0_.step = 0
    _ARG_0_.time = 0
    _ARG_0_.keyNumber = 0
    _ARG_0_.rnd = 0
    _ARG_0_.rndx = 0
    _ARG_0_.rndy = 0
    _ARG_0_.InveFlag = 0
    _ARG_0_.noInvitationTime = 0
    _ARG_0_.balazsStep = 0
    _ARG_0_.balazsStep2 = 0
    _ARG_0_.MantleHandle = NULL_HANDLE
    _ARG_0_.stack = Stack:Create()
    _UPVALUE4_:set(0, 0, -4.5)
    _UPVALUE5_:set(0, 0, 0)
    _ARG_0_.ShieldHandle = NULL_HANDLE
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.5)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 0.7)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    Player.SetBossCamera("b82vs00")
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Enemy.EnableNoVanish(_ARG_0_.myHandle, 1)
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_1_, "IdlingTime")
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_1_, "SIdlingTime")
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_1_, "DorkVRate") * 0.001
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_1_, "AttackW")
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_1_, "InviWait") * 60
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_1_, "InviTime") * 60
    _ARG_0_.GridHandle1 = NULL_HANDLE
    _UPVALUE4_:set(0, 0, -4.5)
    _UPVALUE5_:set(0, DegToRad(90), 0)
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
    end
  end,
  OnDestroy = function(_ARG_0_)
    _ARG_0_:EffectLoopEnd(_ARG_0_.barrierEffect)
    _ARG_0_:EffectLoopEnd(_ARG_0_.invitationEffect)
    _ARG_0_:EffectLoopEnd(_ARG_0_.beamEffect)
    _ARG_0_:EffectLoopEnd(_ARG_0_.pcAttachEffect)
    _ARG_0_:EffectLoopEnd(_ARG_0_.shieldAttachEffect)
    _ARG_0_:EffectLoopEnd(_ARG_0_.InviEffectHandle)
    _ARG_0_:EffectLoopEnd(_ARG_0_.InviOnEffect)
    _ARG_0_:EffectLoopEnd(_ARG_0_.mainEffect)
    Entity.Out(_ARG_0_.GridHandle1)
    _ARG_0_.GridHandle1 = NULL_HANDLE
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return 1
  end,
  OnDead = function(_ARG_0_)
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
    if _UPVALUE0_ == 1 and _ARG_0_:GetState() ~= "Dead" then
      _ARG_0_:GotoStateSub("Dead")
    end
    if _ARG_0_.InveFlag == 1 then
      _ARG_0_.InveFlag = 2
      _ARG_0_.inveTime = 120
    elseif _ARG_0_.InveFlag == 2 then
      if Entity.GetCurrentMotion(_ARG_0_.invitaHandle) == Entity.GetMotionIndex(_ARG_0_.invitaHandle, "801") then
        _ARG_0_.InveFlag = 3
        if _ARG_0_.beamEffect == NULL_HANDLE then
          _ARG_0_:EffectLoopEnd(_ARG_0_.mainEffect)
          _ARG_0_.mainEffect = NULL_HANDLE
          if _ARG_0_.pcAttachEffect == NULL_HANDLE then
            print("\131^\129[\131Q\131b\131g\130\201\131G\131t\131F\131N\131g\131A\131^\131b\131`\n")
            _UPVALUE1_:set(0, 0, 0)
            _UPVALUE2_:set(0, 0, 0)
            _ARG_0_.pcAttachEffect = _ARG_0_:createAttachEffect(_ARG_0_.invitaHandle, "b82vs00", "b082_sre_bea1_0", "center")
            Effect.SetAttachNoRot(_ARG_0_.pcAttachEffect, true)
          end
          if _ARG_0_.mainEffect == NULL_HANDLE then
            print("\150{\145\204\130\201\131A\131^\131b\131`\n")
            _UPVALUE1_:set(0, 0, 0)
            _UPVALUE2_:set(0, 0, 0)
            _ARG_0_.mainEffect = _ARG_0_:createAttachEffect(_ARG_0_.ShieldHandle, "b82vs00", "B082_ASH_ORA0_0", "Root")
            Effect.SetAttachNoRot(_ARG_0_.mainEffect, true)
          end
          print("\131r\129[\131\128\131Z\131b\131g\n")
          _UPVALUE1_:set(-0.5, 0, 0)
          _UPVALUE2_:set(0, 0, 0)
          _ARG_0_.beamEffect = _ARG_0_:createAttachEffect(_ARG_0_.ShieldHandle, "b82vs00", "b082_sre_bea0_0", "Root")
          Effect.SetAttachNoRot(_ARG_0_.beamEffect, true)
        end
      end
      if _ARG_0_.inveTime < 0 then
        Effect.DetachCoord(_ARG_0_.beamEffect)
        Effect.DetachCoord(_ARG_0_.pcAttachEffect)
        Effect.DetachCoord(_ARG_0_.shieldAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.beamEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.pcAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.shieldAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviEffectHandle)
        _ARG_0_.beamEffect = NULL_HANDLE
        _ARG_0_.pcAttachEffect = NULL_HANDLE
        _ARG_0_.shieldAttachEffect = NULL_HANDLE
        _ARG_0_.InviEffectHandle = NULL_HANDLE
        _ARG_0_.InveFlag = 0
      end
      _ARG_0_.inveTime = _ARG_0_.inveTime - 1
    elseif _ARG_0_.InveFlag == 3 then
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.invitaHandle, 2)
      Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.ShieldHandle)
      FVECTOR3.Sub(_UPVALUE3_, _UPVALUE1_, _UPVALUE3_)
      FVECTOR3.normalize(_UPVALUE3_)
      _UPVALUE1_:set(0, 0, 0)
      _UPVALUE2_:set(RoundPI(-Math.Atan2(_UPVALUE3_:gety(), Math.Sqrt(_UPVALUE3_:getz() * _UPVALUE3_:getz() + _UPVALUE3_:getx() * _UPVALUE3_:getx()))), RoundPI((Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()))), 0)
      Effect.UpdateCoord(_ARG_0_.beamEffect, _UPVALUE1_, _UPVALUE2_)
      _UPVALUE1_:set(1, 1, Entity.CalcDistance(_ARG_0_.ShieldHandle, _ARG_0_.invitaHandle) / 5)
      Effect.SetScale(_ARG_0_.beamEffect, _UPVALUE1_)
      if Entity.GetCurrentMotion(_ARG_0_.invitaHandle) ~= Entity.GetMotionIndex(_ARG_0_.invitaHandle, "801") or _UPVALUE4_ - Entity.GetHp(_ARG_0_.ShieldHandle) >= 50 then
        print("id = " .. Entity.GetCurrentMotion(_ARG_0_.invitaHandle) .. "\n")
        print("index = " .. Entity.GetMotionIndex(_ARG_0_.invitaHandle, "801") .. "\n")
        print("resethp = " .. _UPVALUE4_ - Entity.GetHp(_ARG_0_.ShieldHandle) .. "\n")
        print("B84VS_SHIELD_DAMAGE_COUNT = " .. _UPVALUE4_ .. "\n")
        print("\138J\149\250\130\183\130\233\130\230\130\193\129I\n")
        Effect.DetachCoord(_ARG_0_.beamEffect)
        Effect.DetachCoord(_ARG_0_.pcAttachEffect)
        Effect.DetachCoord(_ARG_0_.shieldAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.beamEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.pcAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.shieldAttachEffect)
        _ARG_0_:EffectLoopEnd(_ARG_0_.InviEffectHandle)
        _ARG_0_.beamEffect = NULL_HANDLE
        _ARG_0_.pcAttachEffect = NULL_HANDLE
        _ARG_0_.shieldAttachEffect = NULL_HANDLE
        _ARG_0_.InviEffectHandle = NULL_HANDLE
        _ARG_0_.InveFlag = 0
        _UPVALUE1_:set(0.5, 0, 0)
        _ARG_0_:createAttachEffect(_ARG_0_.ShieldHandle, "b82vs00", "B082_ASH_ORA1_0", "shield")
        print("\146e\130\175\131G\131t\131F\131N\131g\144\182\144\172\129I\129I\n")
        if _UPVALUE4_ - Entity.GetHp(_ARG_0_.ShieldHandle) >= 50 then
          Player.SetDamage(_ARG_0_.invitaHandle, 0, ATK_KIND_DMG_SMALL)
        end
      end
    end
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b82vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Appear\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState("Move")
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "470")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Exusia.IsExistenceSchedule() then
            Entity.SetAlpha(_ARG_0_.myHandle, 1)
            _ARG_0_.step = 1
          end
        elseif Enemy.IsAllEnemyWaiting() == false then
          print("Enemy.IsAllEnemyWaiting() == false\n")
          _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
          _ARG_0_:GotoState("StopState")
        end
      end
    },
    StopState = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":StopState\n")
        Entity.SetTimer(_ARG_0_.myHandle, 60 * (Script.Random() * 2) + _UPVALUE0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "470")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:MoveStop()
        if _ARG_0_:Defense() then
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if _UPVALUE0_ == "DarkBolley" then
          elseif _UPVALUE0_ == "BalazsType1" then
            _ARG_0_:GotoState("MovePlayerChack")
          elseif _UPVALUE0_ == "BalazsType2" then
            _ARG_0_:GotoState("MovePlayerChack")
          elseif _UPVALUE0_ == "BalazsType3" then
            _ARG_0_:GotoState("MovePlayerChack")
          elseif _UPVALUE0_ == "BalazsType4" then
            _ARG_0_:GotoState("Move")
          elseif _UPVALUE0_ == "BalazsType5" then
            _ARG_0_:GotoState("Move")
          elseif _UPVALUE0_ == "Invitation" then
            _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_FAR)
            _ARG_0_:GotoState("MovePlayerChack")
          elseif _UPVALUE0_ == "Idling" then
          end
          return
        end
      end
    },
    Move_LeftorRight = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Move_LeftorRight\n")
        _ARG_0_.step = 0
        Entity.SetTimer(_ARG_0_.myHandle, 30)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        if 0 > _UPVALUE0_:getx() then
          _ARG_0_.moveType = _UPVALUE1_
          _ARG_0_.SpeedX = 0.2
        else
          _ARG_0_.moveType = _UPVALUE2_
          _ARG_0_.SpeedX = -0.2
        end
        _ARG_0_.speedAdd = 2 + Script.Random() * 2
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "470")
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("StopState")
            return
          end
          if Entity.GetFloorDistance(_ARG_0_.myHandle) > 1.5 then
            _ARG_0_.SpeedY = _ARG_0_.SpeedY - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY < -_UPVALUE0_ then
              _ARG_0_.SpeedY = -_UPVALUE0_
            end
          else
            _ARG_0_.SpeedY = 0
          end
          _ARG_0_:MoveRight_Left2(_UPVALUE1_ * _ARG_0_.speedAdd, 0.09, _ARG_0_.moveType)
        elseif _ARG_0_.step == 1 then
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":Move\n")
        _ARG_0_.step = 0
        _ARG_0_.moveType = 0
        _ARG_0_.time = 0
        Entity.SetTimer(_ARG_0_.myHandle, 60 * (Script.Random() * 2 + 2))
        _ARG_0_.speedAdd = 2 + Script.Random() * 2
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:Defense() then
          return
        end
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "470")
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("StopState")
            return
          end
          if _ARG_0_.moveStep == 0 then
          elseif _ARG_0_.moveStep == 1 then
          elseif _ARG_0_.moveStep == 2 then
          end
          _ARG_0_.time = _ARG_0_.time - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 >= _ARG_0_.time then
            if Script.Random() < 0.5 then
              _ARG_0_.moveType = _UPVALUE0_
            else
              _ARG_0_.moveType = _UPVALUE1_
            end
            _ARG_0_.time = 60 * (Script.Random() * 1)
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16 then
              if Script.Random() < 0.5 then
                _ARG_0_.moveType = _UPVALUE0_
              else
                _ARG_0_.moveType = _UPVALUE1_
              end
              _ARG_0_.time = 60 * (Script.Random() * 1)
            end
            print("self.moveType = " .. _ARG_0_.moveType .. "\n")
          end
          Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
          if _UPVALUE2_:getx() > _UPVALUE3_ - 1 then
            _ARG_0_.moveType = _UPVALUE1_
          elseif _UPVALUE2_:getx() < -(_UPVALUE3_ - 1) then
            _ARG_0_.moveType = _UPVALUE0_
          end
          if 0 >= _ARG_0_.time2 or 1 > Entity.GetFloorDistance(_ARG_0_.myHandle) or Entity.GetFloorDistance(_ARG_0_.myHandle) > _UPVALUE4_ then
            if 1 > Entity.GetFloorDistance(_ARG_0_.myHandle) then
              _ARG_0_.HeightFlag = 0
            elseif Entity.GetFloorDistance(_ARG_0_.myHandle) > 3 then
              _ARG_0_.HeightFlag = 1
            else
              if Script.Random() < 0.5 then
                _ARG_0_.HeightFlag = 0
              else
                _ARG_0_.HeightFlag = 1
              end
              _ARG_0_.time2 = Script.Random() * 120 + 120
            end
          end
          if _ARG_0_.HeightFlag == 0 then
            _ARG_0_.SpeedY = _ARG_0_.SpeedY + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY > _UPVALUE5_ then
              _ARG_0_.SpeedY = _UPVALUE5_
            end
          else
            _ARG_0_.SpeedY = _ARG_0_.SpeedY - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY < -_UPVALUE5_ then
              _ARG_0_.SpeedY = -_UPVALUE5_
            end
          end
          _ARG_0_:MoveRight_Left(_UPVALUE6_ * _ARG_0_.speedAdd, 0.09, _ARG_0_.moveType)
        elseif _ARG_0_.step == 1 then
        end
      end
    },
    MovePlayerChack = {
      OnBeginState = function(_ARG_0_)
        print(Entity.GetName(_ARG_0_.myHandle) .. ":MovePlayerChack\n")
        _ARG_0_.step = 0
        _ARG_0_.moveType = 0
        _ARG_0_.time = 0
        Entity.SetTimer(_ARG_0_.myHandle, 30)
        _ARG_0_.HeightFlag = 2
        _ARG_0_.moveTimer = 300
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        debugPrint(0, 30, "step    = " .. _ARG_0_.step .. "\n")
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "470")
        if _ARG_0_:Defense() then
          return
        end
        _ARG_0_.moveTimer = _ARG_0_.moveTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.moveTimer then
          _ARG_0_:GotoState("StopState")
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsTargetRight(_ARG_0_.myHandle, _ARG_0_.targetHandle) == true then
            _ARG_0_.moveType = _UPVALUE0_
            _ARG_0_.SpeedX = 0.2
            _UPVALUE1_:set(5, 0, 0)
          else
            _ARG_0_.moveType = _UPVALUE2_
            _ARG_0_.SpeedX = -0.2
            _UPVALUE1_:set(-5, 0, 0)
          end
          _ARG_0_.step = 1
          if _ARG_0_.HeightFlag == 0 then
            _ARG_0_.SpeedY = _ARG_0_.SpeedY + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY > _UPVALUE3_ then
              _ARG_0_.SpeedY = _UPVALUE3_
            end
          elseif _ARG_0_.HeightFlag == 1 then
            _ARG_0_.SpeedY = _ARG_0_.SpeedY - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY < -_UPVALUE3_ then
              _ARG_0_.SpeedY = -_UPVALUE3_
            end
          end
          Entity.SetTimer(_ARG_0_.myHandle, 30)
          Entity.GetWorldPos2(_UPVALUE1_, _ARG_0_.myHandle, _UPVALUE1_)
          if _UPVALUE1_:getx() > _UPVALUE4_ - 1 then
            _ARG_0_.moveType = _UPVALUE2_
            print("\130\177\130\234\136\200\143\227\130\205\147\166\130\176\130\234\130\200\130\162!1\n")
            _ARG_0_.step = 3
            Entity.SetTimer(_ARG_0_.myHandle, 40)
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 9 and _UPVALUE1_:getx() < -(_UPVALUE4_ - 1) then
            _ARG_0_.moveType = _UPVALUE0_
            print("\130\177\130\234\136\200\143\227\130\205\147\166\130\176\130\234\130\200\130\162!2\n")
            _ARG_0_.step = 3
            Entity.SetTimer(_ARG_0_.myHandle, 40)
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 9 then
            end
          end
          _ARG_0_.speedAdd = 2 + Script.Random() * 2
        elseif _ARG_0_.step == 1 then
          _ARG_0_:MoveRight_Left2(_UPVALUE5_ * _ARG_0_.speedAdd, 0.09, _ARG_0_.moveType)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 2
            print("Next step = 2\n")
            Entity.SetTimer(_ARG_0_.myHandle, 6)
            return
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_:MoveStop()
          Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
          if _UPVALUE1_:getx() > _UPVALUE4_ - 1 then
            _ARG_0_:MoveStop()
          elseif _UPVALUE1_:getx() < -(_UPVALUE4_ - 1) then
            _ARG_0_:MoveStop()
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
              print("Next step = 0\n")
              _ARG_0_.step = 0
              _ARG_0_.HeightFlag = 1
            end
            return
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_:MoveStop()
          if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE6_ then
            print("\131v\131\140\131C\131\132\129[\130\170\139\223\130\195\130\162\130\196\130\171\130\189\129I\129I\n")
            if Entity.GetFloorDistance(_ARG_0_.myHandle) > _UPVALUE7_ then
              _ARG_0_.HeightFlag = 1
            else
              _ARG_0_.HeightFlag = 0
            end
            Entity.SetTimer(_ARG_0_.myHandle, 40)
            if Script.Random() < 0.5 then
              _ARG_0_.step = 4
            else
              _ARG_0_:GotoState("StopState")
            end
            return
          end
        elseif _ARG_0_.step == 4 then
          if _ARG_0_.HeightFlag == 0 then
            _ARG_0_.SpeedY = _ARG_0_.SpeedY + 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY > _UPVALUE3_ then
              _ARG_0_.SpeedY = _UPVALUE3_
            end
          elseif _ARG_0_.HeightFlag == 1 then
            _ARG_0_.SpeedY = _ARG_0_.SpeedY - 0.1 * Entity.GetFrameRate(_ARG_0_.myHandle)
            if _ARG_0_.SpeedY < -_UPVALUE3_ then
              _ARG_0_.SpeedY = -_UPVALUE3_
            end
          end
          _ARG_0_.speedAdd = 2 + Script.Random() * 2
          _ARG_0_:MoveRight_Left(_UPVALUE5_ * _ARG_0_.speedAdd, 0.09, _ARG_0_.moveType)
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            if Script.Random() < 0.5 then
              _ARG_0_.step = 1
            else
              _ARG_0_:GotoState("StopState")
            end
            return
          end
        end
      end
    },
    DamageState = {
      OnBeginState = function(_ARG_0_)
        if Entity.IsTargetRight(_ARG_0_.myHandle, (Entity.GetAttacker(_ARG_0_.myHandle))) then
          _ARG_0_.moveType = _UPVALUE0_
          _ARG_0_.SpeedX = 0.2
        else
          _ARG_0_.moveType = _UPVALUE1_
          _ARG_0_.SpeedX = -0.2
        end
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState("StopState")
            return
          end
          _ARG_0_:MoveRight_Left2(_UPVALUE0_ * _ARG_0_.speedAdd, 0.09, _ARG_0_.moveType)
        elseif _ARG_0_.step == 1 then
        elseif _ARG_0_.step == 2 then
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        if Entity.GetCurrentMotion(Player.GetHandle()) == Entity.GetMotionIndex(Player.GetHandle(), "801") then
          Player.SetDamage(Player.GetHandle(), 0, ATK_KIND_DMG_SMALL)
        end
        Player.SetTrgFlagCancel(_ARG_0_.myHandle, 1)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  MoveStop = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.SpeedY = HomingDegree(_ARG_0_.SpeedY, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
  end,
  MoveRight_Left = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_3_ == _UPVALUE0_ then
      _ARG_0_.SpeedX = _ARG_0_.SpeedX + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_1_ < _ARG_0_.SpeedX then
        _ARG_0_.SpeedX = _ARG_1_
      end
      _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    elseif _ARG_3_ == _UPVALUE1_ then
      _ARG_0_.SpeedX = _ARG_0_.SpeedX - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.SpeedX < -_ARG_1_ then
        _ARG_0_.SpeedX = -_ARG_1_
      end
      _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    elseif _ARG_3_ == _UPVALUE2_ then
      _ARG_0_.SpeedZ = _ARG_0_.SpeedZ + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_1_ < _ARG_0_.SpeedZ then
        _ARG_0_.SpeedZ = _ARG_1_
      end
      _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.05, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    end
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE4_:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
  end,
  MoveRight_Left2 = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_3_ == _UPVALUE0_ then
      _ARG_0_.SpeedX = _ARG_0_.SpeedX - _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_1_ > _ARG_0_.SpeedX then
        _ARG_0_.SpeedX = _ARG_1_
      end
      _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    elseif _ARG_3_ == _UPVALUE1_ then
      _ARG_0_.SpeedX = _ARG_0_.SpeedX + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_0_.SpeedX > -_ARG_1_ then
        _ARG_0_.SpeedX = -_ARG_1_
      end
      _ARG_0_.SpeedZ = HomingDegree(_ARG_0_.SpeedZ, 0, 0.1, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    elseif _ARG_3_ == _UPVALUE2_ then
      _ARG_0_.SpeedZ = _ARG_0_.SpeedZ + _ARG_1_ * _ARG_2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
      if _ARG_1_ > _ARG_0_.SpeedZ then
        _ARG_0_.SpeedZ = _ARG_1_
      end
      _ARG_0_.SpeedX = HomingDegree(_ARG_0_.SpeedX, 0, 0.05, (Entity.GetFrameRate(_ARG_0_.myHandle)))
    end
    Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
    _UPVALUE4_:set(_ARG_0_.SpeedX, _ARG_0_.SpeedY, 0)
    Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE4_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.SpeedX = 0
    _ARG_0_.SpeedY = 0
    _ARG_0_.SpeedZ = 0
    _ARG_0_.time = 0
    _ARG_0_.moveType = 0
    _ARG_0_.HeightFlag = 0
    _ARG_0_.time2 = 0
    _ARG_0_.time3 = 0
    _ARG_0_.speedAdd = 0
    _ARG_0_.moveStep = 0
    _ARG_0_.evadeTimer = 0
    _ARG_0_.evadeFlag = false
    _ARG_0_.moveTimer = 0
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _ARG_0_.startZ = _UPVALUE0_:getz()
    print("Start Z = " .. _ARG_0_.startZ .. "\n")
    Entity.SetLockOnBoneNum(_ARG_1_, 0)
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
    Entity.SetMovementCollRadius(_ARG_1_, 0.5)
    Entity.SetLowerHalf(_ARG_0_.myHandle, -0.5)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    _ARG_0_.targetVec = FVECTOR3.new(0, 0, 0)
    if Enemy.IsAllEnemyWaiting() then
      print("IsAllEnemyWaiting == true\n")
      _ARG_0_:GotoState("Waiting")
    else
      print("IsAllEnemyWaiting == flase\n")
      _ARG_0_:GotoState("Appear")
    end
  end,
  Defense = function(_ARG_0_)
    if _ARG_0_.evadeTimer > 0 then
      return
    end
    if _ARG_0_.evadeFlag == false then
      if Entity.IsAttacking(_ARG_0_.targetHandle) then
        print("Entity.IsAttacking(self.targetHandle)!!\n")
        _ARG_0_.evadeFlag = true
        _ARG_0_.evadeTimer = -1
      end
    else
      print("Defense!!\n")
      if not (Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16) or Script.Random() < 0.5 then
      else
      end
      _ARG_0_.evadeTimer = 300
      _ARG_0_.evadeFlag = false
      return true
    end
    return false
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_1_ == ATK_KIND_DMG_SMALL then
    elseif _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
    end
    return 1
  end,
  OnDead = function(_ARG_0_)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
    Mission.SetArenaRoundEnd()
    _ARG_0_:GotoStateSub("Dead")
    Entity.ClearSpeed(_ARG_0_.myHandle)
    _UPVALUE0_ = 1
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    if _UPVALUE0_:getx() > _UPVALUE1_ - 1 then
      _UPVALUE0_:setx(_UPVALUE1_ - 1)
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    elseif _UPVALUE0_:getx() < -(_UPVALUE1_ - 1) then
      _UPVALUE0_:setx(-(_UPVALUE1_ - 1))
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    end
    if _UPVALUE0_:getz() ~= -4.5 then
      _UPVALUE0_:setz(-4.5)
      Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    end
    if _ARG_0_.evadeTimer <= 0 then
      _ARG_0_.evadeTimer = 0
    else
      _ARG_0_.evadeTimer = _ARG_0_.evadeTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    end
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
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b84vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs10", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs20", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs30", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs40", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs50", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs60", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs70", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs80", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Balazs90", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("Volley", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
b86vs00 = {}
b86vs00_mt = {__index = b86vs00}
function b86vs00.new(_ARG_0_)
  return setmetatable({}, b86vs00_mt)
end
function b86vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.SetAlpha(_ARG_0_.myHandle, 0)
end
function b86vs00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Exusia.IsExistenceSchedule() then
      Entity.SetAlpha(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 and Enemy.IsAllEnemyWaiting() == false then
    Entity.SetAlpha(_ARG_0_.myHandle, 1)
  end
end
EntityFactory:Add("b86vs00", function(_ARG_0_)
  return (b86vs00:new())
end)
b87vs00 = {}
b87vs00_mt = {__index = b87vs00}
function b87vs00.new(_ARG_0_)
  return setmetatable({}, b87vs00_mt)
end
function b87vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
  Entity.SetAlpha(_ARG_0_.myHandle, 0)
end
function b87vs00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Exusia.IsExistenceSchedule() then
      Entity.SetAlpha(_ARG_0_.myHandle, 1)
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 and Enemy.IsAllEnemyWaiting() == false then
    Entity.SetAlpha(_ARG_0_.myHandle, 1)
  end
end
EntityFactory:Add("b87vs00", function(_ARG_0_)
  return (b87vs00:new())
end)
