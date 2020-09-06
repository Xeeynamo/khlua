WorkVec = FVECTOR3.new(0, 0, 0)
setmetatable({
  new = function(_ARG_0_)
    print("b06rg00:new()\n")
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Idling\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotion(_UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
      end
    },
    Move = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Move\n")
        Entity.SetTimer(_ARG_0_.myHandle, 80)
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) == false then
          return
        end
        _ARG_0_:GotoState("Transform_Out")
      end
    },
    Transform_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Transform_Idling\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 1 then
          PartsAttack(_ARG_0_.myHandle)
        end
      end
    },
    Transform_Start = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Transform_Start\n")
        TRINITY_TRANSFORM_STEP = TRINITY_TRANSFORM_START
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = TRINITY_TRANSFORM_START
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0)
        if _ARG_0_.step == TRINITY_TRANSFORM_START then
          _ARG_0_.step = TRINITY_TRANSFORM_CHANGE
          changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 0)
          changeSet(_ARG_0_, _ARG_0_.myHandle, 1)
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Transform_Idling")
        end
      end
    },
    Transform_Out = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Transform_Out\n")
        TRINITY_TRANSFORM_STEP = TRINITY_TRANSFORM_OUT
        _ARG_0_.step = TRINITY_TRANSFORM_OUT
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        WorkVec:set(0, 0, 0)
        if _ARG_0_.step == TRINITY_TRANSFORM_OUT then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = TRINITY_TRANSFORM_CHANGE
        elseif _ARG_0_.step == TRINITY_TRANSFORM_CHANGE and Entity.IsMotionEnd(_ARG_0_.myHandle) then
          EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM):GotoState("Transform_Out")
          changeSet(_ARG_0_, B04RG_HANDLE_NOMAL_ARM, 1)
          changeSet(_ARG_0_, _ARG_0_.myHandle, 0)
          _ARG_0_:GotoState("Transform_Out_Idling")
        end
      end
    },
    Transform_Out_Idling = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Transform_Out_Idling\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        PartsAttack(_ARG_0_.myHandle)
      end
    },
    Standby = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Standby\n")
        _ARG_0_:SetMotion(_UPVALUE0_)
        _ARG_0_.step = 1
        if Entity.GetName(_ARG_0_.myHandle) == "b76vs00" and Mission.IsFlagFinalRound() == 1 then
          _ARG_0_.step = 0
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 1)
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetName(_ARG_0_.myHandle) == "b76vs00" and Mission.IsFlagFinalRound() == 1 then
          if _ARG_0_.step == 0 then
            if Exusia.IsExistenceSchedule() == true then
              _ARG_0_.step = 1
              Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
            else
            end
          elseif _ARG_0_.step == 1 then
          end
        end
        PartsAttack(_ARG_0_.myHandle)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Transform_Idling")
          Entity.EnableLockon(_ARG_0_.myHandle, 1)
        end
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        print("b06rg00:Dead\n")
        if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
          _ARG_0_:SetMotion(_UPVALUE0_)
          _ARG_0_.step = 0
        else
          _ARG_0_:SetMotion(_UPVALUE1_)
          _ARG_0_.step = 2
        end
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.EnableShooton(_ARG_0_.myHandle, 0)
        if B01RG_MODE == B01RG_NOMAL_MODE then
        else
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 60)
        end
        B06RG_HANDLE_ROBOT_RIGHTARM = NULL_HANDLE
        if Entity.IsAlive(B07RG_HANDLE_ROBOT_LEFTARM) and EntityManager:GetEntity(B07RG_HANDLE_ROBOT_LEFTARM):GetState() ~= "Dead" then
          EntityManager:GetEntity(B07RG_HANDLE_ROBOT_LEFTARM):GotoState("Dead")
        end
        if Entity.IsAlive(B04RG_HANDLE_NOMAL_ARM) and _ARG_0_:GetState() ~= "Dead" then
          EntityManager:GetEntity(B04RG_HANDLE_NOMAL_ARM):GotoState("Dead")
        end
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Enemy.Dead(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Enemy.Dead(_ARG_0_.myHandle)
          end
        elseif _ARG_0_.step ~= 3 or Entity.IsMotionEnd(_ARG_0_.myHandle) then
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
  },
  SetMotion = function(_ARG_0_, _ARG_1_)
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    print("b06rg00:: OnInit\n")
    _ARG_0_.myHandle = _ARG_1_
    B06RG_HANDLE_ROBOT_RIGHTARM = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.isDead = 0
    _ARG_0_.WorkTime = 0
    if B06RG_INIT_PARAM == false then
      B06RG_INIT_PARAM = true
    end
    _ARG_0_.stack = Stack:Create()
    Entity.SetLockOnBoneNum(_ARG_0_.myHandle, _UPVALUE0_)
    Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1.7)
    Entity.SetLowerHalf(_ARG_0_.myHandle, 2)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 1)
    Player.SetBossCamera("b06rg00")
    Enemy.IsAllEnemyWaiting()
    Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
    Entity.SetDrawParentShadow(_ARG_0_.myHandle, B01RG_HANDLE_HEAD)
    if Enemy.IsAllEnemyWaiting() == true then
      _ARG_0_:GotoStateSub("Standby")
    else
      _ARG_0_:GotoState("Appear")
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end
  end,
  OnDamage = function(_ARG_0_, _ARG_1_)
    print("OnDamage\n")
    Enemy.SetHP(B04RG_HANDLE_NOMAL_ARM, (Enemy.GetHp(_ARG_0_.myHandle)))
    Enemy.SetHP(B07RG_HANDLE_ROBOT_LEFTARM, (Enemy.GetHp(_ARG_0_.myHandle)))
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnHitAttack = function(_ARG_0_)
  end,
  OnDead = function(_ARG_0_)
    print("b06rg00: OnDead()\n")
    if Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoStateSub("Dead")
    else
      _ARG_0_:GotoState("Dead")
    end
    if Entity.GetAlpha(_ARG_0_.myHandle) > 0.1 then
      Entity.GetWorldPos(WorkVec, _ARG_0_.myHandle, 2)
      Enemy.MakePrize(_ARG_0_.myHandle, WorkVec)
    end
    return 1
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
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    if B01RG_MODE == B01RG_NOMAL_MODE then
      _ARG_0_:Debug()
    end
    if Enemy.GetHp(_ARG_0_.myHandle) <= 0 and _ARG_0_.isDead == 0 then
      _ARG_0_:OnDead()
      _ARG_0_.isDead = 1
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b06rg00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("b76vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
