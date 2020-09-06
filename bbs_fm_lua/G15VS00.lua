g15vs00 = {}
g15vs00_base_mt = {__index = __StateMachine}
setmetatable(g15vs00, g15vs00_base_mt)
g15vs00_mt = {__index = g15vs00}
function g15vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g15vs00_mt)
end
g15vs00.states = {
  Waiting = {
    OnBeginState = function(_ARG_0_)
      print("Waiting\n")
      _ARG_0_:SetDisp(1)
      _ARG_0_:SetFadeDisp(1)
      Entity.SetTimer(_ARG_0_.myHandle, 60)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting2")
      end
    end
  },
  Waiting2 = {
    OnBeginState = function(_ARG_0_)
      print("Waiting2\n")
      _ARG_0_:SetDisp(1)
      _ARG_0_:SetFadeDisp(1)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  WaitingEx = {
    OnBeginState = function(_ARG_0_)
      print("WaitingEx\n")
      _ARG_0_:SetDisp(1)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
      end
    end
  },
  DropAfter = {
    OnBeginState = function(_ARG_0_)
      print("DropAfter\n")
      _ARG_0_.retSetDropCommandG = 0
      _ARG_0_:SetDisp(0)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true then
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _ARG_0_.retSetDropCommandG = Gimmick.SetDropCommandG(_UPVALUE0_)
      end
      Entity.SetTimer(_ARG_0_.myHandle, 30)
      print("SetDropCommandG retrun parame " .. _ARG_0_.retSetDropCommandG .. "\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true then
        if _ARG_0_.retSetDropCommandG == 0 then
          _ARG_0_:GotoState("PraizeDropAfter")
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if 0 < Script.GetDebugGimmcikTimeFlag() then
            _ARG_0_:GotoState("WaitingEx")
          else
            _ARG_0_:GotoState("OffDisp")
          end
        end
      end
    end
  },
  PraizeDropAfter = {
    OnBeginState = function(_ARG_0_)
      print("PraizeDropAfter\n")
      _ARG_0_:SetDisp(0)
      if Entity.IsAlive(_ARG_0_.attacker) == true then
        if _ARG_0_.attacker == Player.GetHandleForNet() then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          Gimmick.MakePraize(_ARG_0_.myHandle, _UPVALUE0_)
        elseif (Entity.GetName(_ARG_0_.attacker):sub(1, 1) == "w" or Entity.GetName(_ARG_0_.attacker):sub(1, 1) == "m") and Entity.GetParent(_ARG_0_.attacker) == Player.GetHandleForNet() then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          Gimmick.MakePraize(_ARG_0_.myHandle, _UPVALUE0_)
        end
      end
      Entity.SetTimer(_ARG_0_.myHandle, 120)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        if Script.GetDebugGimmcikTimeFlag() > 0 then
          _ARG_0_:GotoState("WaitingEx")
        else
          _ARG_0_:GotoState("OffDisp")
        end
      end
    end
  },
  OffDisp = {
    OnBeginState = function(_ARG_0_)
      print("OffDisp\n")
      _ARG_0_:SetFadeDisp(0)
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.ReturnTime)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Gimmick.IsNetworkMaster(_ARG_0_.myHandle) == true and Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Waiting")
      end
    end
  }
}
function g15vs00.GetAttakerHandle(_ARG_0_, _ARG_1_)
  print("g11he00 :GetAttakerHandle\n")
  if Entity.IsAlive(_ARG_1_) == true then
    print("\130\177\130\204\131n\131\147\131h\131\139\130\205\144\182\130\171\130\196\130\220\130\183\129B\n")
  else
    print("\130\177\130\204\131n\131\147\131h\131\139\130\205\142\128\130\241\130\197\130\220\130\183\129B\n")
  end
  print("g15vs00 :local AttakerName = " .. Entity.GetName(_ARG_1_) .. "\n")
  if Entity.GetName(_ARG_1_):sub(1, 1) == "w" or Entity.GetName(_ARG_1_):sub(1, 1) == "p" or Entity.GetName(_ARG_1_):sub(1, 1) == "b" or Entity.GetName(_ARG_1_):sub(1, 1) == "m" then
    return _ARG_1_
  end
  for _FORV_7_ = 0, 100 do
    if Entity.IsAlive(_ARG_1_) == true then
      if Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker) == true then
        if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
          return EntityManager:GetEntity(_ARG_1_).attaker
        elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "b" then
          return EntityManager:GetEntity(_ARG_1_).attaker
        elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "m" then
          return EntityManager:GetEntity(_ARG_1_).attaker
        elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "g" then
        end
      else
        return _ARG_1_
      end
    end
  end
  return _ARG_1_
end
function g15vs00.OnInit(_ARG_0_, _ARG_1_)
  print("\131p\131P\131b\131g\130\240\143\137\138\250\137\187\130\181\130\220\130\183.\n")
  Gimmick.ResetPacket()
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.attacker = NULL_HANDLE
  _ARG_0_.retSetDropCommandG = 0
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.SetLockOnBoneNum(_ARG_0_.myHandle, 1)
  Gimmick.EnableNetwork(_ARG_0_.myHandle, 1)
  _ARG_0_.retTime = Gimmick.GetExtraParam(_ARG_0_.myHandle, "retTime")
  _ARG_0_.ReturnTime = _ARG_0_.retTime - Entity.GetLayoutParam(_ARG_1_, 1)
  if 0 >= _ARG_0_.ReturnTime then
    _ARG_0_.ReturnTime = 7200
  end
  print("retrun Time = " .. _ARG_0_.ReturnTime .. "\n")
  _ARG_0_:GotoState("Waiting")
end
function g15vs00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 or _ARG_3_ == ATK_ATTR_SPECIAL then
    return 1
  end
  print("OnDamage\n")
  _ARG_0_.attacker = _ARG_0_:GetAttakerHandle(Entity.GetAttacker(_ARG_0_.myHandle))
  if _ARG_0_:GetState() == "Waiting" or _ARG_0_:GetState() == "Waiting2" or _ARG_0_:GetState() == "WaitingEx" then
    _ARG_0_:GotoState("DropAfter")
  end
  return 1
end
function g15vs00.OnUpdatePositionAfter(_ARG_0_)
  _UPVALUE0_:set(0, DegToRad(1.1), 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 3, _UPVALUE0_)
  _UPVALUE0_:set(0, DegToRad(-1.1), 0)
  Entity.RotateBoneXYZ(_ARG_0_.myHandle, 2, _UPVALUE0_)
end
function g15vs00.SetDisp(_ARG_0_, _ARG_1_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 1)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 1, _ARG_1_)
  Entity.EnableModelDisp(_ARG_0_.myHandle, 2, _ARG_1_)
end
function g15vs00.OnDestroy(_ARG_0_)
  _ARG_0_:GotoState("Waiting")
  print("\131p\131P\131b\131g\130\240\143\137\138\250\137\187\130\181\130\220\130\183.\n")
  Gimmick.ResetPacket()
end
function g15vs00.SetFadeDisp(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 0 then
    Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 60)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
  else
    Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 60)
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  end
end
function g15vs00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  Gimmick.EnableNetwork(_ARG_0_.myHandle, 1)
end
EntityFactory:Add("g15vs00", function(_ARG_0_)
  return (g15vs00:new())
end)
