setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Action0 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action0 ~= nil then
          _ARG_0_.funcTbl.Action0.OnBeginState(_ARG_0_)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, "010")
        end
        print("Action0\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action0 ~= nil then
          _ARG_0_.funcTbl.Action0.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action0 ~= nil then
          _ARG_0_.funcTbl.Action0.OnUpdate(_ARG_0_)
        end
      end
    },
    Action1 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action1 ~= nil then
          _ARG_0_.funcTbl.Action1.OnBeginState(_ARG_0_)
        end
        print("Action1\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action1 ~= nil then
          _ARG_0_.funcTbl.Action1.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action1 ~= nil then
          _ARG_0_.funcTbl.Action1.OnUpdate(_ARG_0_)
        end
      end
    },
    Action2 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action2 ~= nil then
          _ARG_0_.funcTbl.Action2.OnBeginState(_ARG_0_)
        end
        print("Action2\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action2 ~= nil then
          _ARG_0_.funcTbl.Action2.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action2 ~= nil then
          _ARG_0_.funcTbl.Action2.OnUpdate(_ARG_0_)
        end
      end
    },
    Action3 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action3 ~= nil then
          _ARG_0_.funcTbl.Action3.OnBeginState(_ARG_0_)
        end
        print("Action3\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action3 ~= nil then
          _ARG_0_.funcTbl.Action3.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action3 ~= nil then
          _ARG_0_.funcTbl.Action3.OnUpdate(_ARG_0_)
        end
      end
    },
    Action4 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action4 ~= nil then
          _ARG_0_.funcTbl.Action4.OnBeginState(_ARG_0_)
        end
        print("Action4\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action4 ~= nil then
          _ARG_0_.funcTbl.Action4.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action4 ~= nil then
          _ARG_0_.funcTbl.Action4.OnUpdate(_ARG_0_)
        end
      end
    },
    Action5 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action5 ~= nil then
          _ARG_0_.funcTbl.Action5.OnBeginState(_ARG_0_)
        end
        print("Action5\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action5 ~= nil then
          _ARG_0_.funcTbl.Action5.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action5 ~= nil then
          _ARG_0_.funcTbl.Action5.OnUpdate(_ARG_0_)
        end
      end
    },
    Action6 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action6 ~= nil then
          _ARG_0_.funcTbl.Action6.OnBeginState(_ARG_0_)
        end
        print("Action6\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action6 ~= nil then
          _ARG_0_.funcTbl.Action6.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action6 ~= nil then
          _ARG_0_.funcTbl.Action6.OnUpdate(_ARG_0_)
        end
      end
    },
    Action7 = {
      OnBeginState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action7 ~= nil then
          _ARG_0_.funcTbl.Action7.OnBeginState(_ARG_0_)
        end
        print("Action7\n")
      end,
      OnEndState = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action7 ~= nil then
          _ARG_0_.funcTbl.Action7.OnEndState(_ARG_0_)
        end
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.funcTbl.Action7 ~= nil then
          _ARG_0_.funcTbl.Action7.OnUpdate(_ARG_0_)
        end
      end
    }
  },
  GetEffectSeExternalId = function(_ARG_0_)
    if Player.IsPlayerFlagNetPlayer((Entity.GetParent(_ARG_0_.myHandle))) == false then
      return 0
    end
    return Player.GetNetworkID((Entity.GetParent(_ARG_0_.myHandle))) + 1
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    Enemy.SetSeFileID(_ARG_1_, _UPVALUE0_[Entity.GetName(_ARG_1_)])
    _ARG_0_.funcTbl = _UPVALUE1_[Entity.GetName(_ARG_1_)]
    if _ARG_0_.funcTbl.OnInit ~= nil then
      _ARG_0_.funcTbl.OnInit(_ARG_0_, _ARG_1_)
    end
    Entity.SetEffectAttachSeExternalId(_ARG_1_, (_ARG_0_:GetEffectSeExternalId()))
    Entity.SetSeAttachExternalId(_ARG_1_, (_ARG_0_:GetEffectSeExternalId()))
    Entity.SetMovementCollKind(_ARG_1_, COLL_KIND_PLAYER)
    Enemy.SetNoNetwork(_ARG_1_, 1)
  end,
  OnDestroy = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnDestroy ~= nil then
      _ARG_0_.funcTbl.OnDestroy(_ARG_0_)
    end
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_)
    if _ARG_0_.funcTbl.OnHitAttack ~= nil then
      _ARG_0_.funcTbl.OnHitAttack(_ARG_0_, _ARG_1_, _ARG_2_)
    end
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_.funcTbl.OnDamageBefore ~= nil then
      return _ARG_0_.funcTbl.OnDamageBefore(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("OnDamage() ... kind = " .. _ARG_1_ .. "\n")
    if _ARG_0_.funcTbl.OnDamage ~= nil then
      return _ARG_0_.funcTbl.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    end
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnReturnDamage ~= nil then
      _ARG_0_.funcTbl.OnReturnDamage(_ARG_0_)
    else
      _ARG_0_:GotoStateSub("Action0")
    end
  end,
  OnGuard = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnGuard ~= nil then
      return _ARG_0_.funcTbl.OnGuard(_ARG_0_)
    end
  end,
  OnReflect = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnReflect ~= nil then
      return _ARG_0_.funcTbl.OnReflect(_ARG_0_)
    end
    return 0
  end,
  OnBeginDamageReaction = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnBeginDamageReaction ~= nil then
      _ARG_0_.funcTbl.OnBeginDamageReaction(_ARG_0_)
    end
  end,
  OnEndReaction = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnEndReaction ~= nil then
      _ARG_0_.funcTbl.OnEndReaction(_ARG_0_)
    end
  end,
  OnDead = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnDead ~= nil then
      _ARG_0_.funcTbl.OnDead(_ARG_0_)
    end
    return 2
  end,
  OnUpdatePositionAfter = function(_ARG_0_)
    if _ARG_0_.funcTbl.OnUpdatePositionAfter ~= nil then
      _ARG_0_.funcTbl.OnUpdatePositionAfter(_ARG_0_)
    end
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("m91ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m92ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m93ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m94ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m95ex00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("m95exExplode", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
