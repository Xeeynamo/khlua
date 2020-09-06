setmetatable({
  new = function(_ARG_0_)
    return setmetatable({}, _UPVALUE0_)
  end,
  states = {
    Wait = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "001", 0)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Destruction = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "001", 1)
        Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Surfacing")
        end
      end
    },
    Surfacing = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE0_[Entity.GetName(_ARG_0_.myHandle)], 0)
        Entity.SetMotion(_ARG_0_.myHandle, "002")
        Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE0_[Entity.GetName(_ARG_0_.myHandle)], 1)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.SetModelPartsAlpha(_ARG_0_.myHandle, _UPVALUE0_[Entity.GetName(_ARG_0_.myHandle)], Entity.GetMotionNowFrame(_ARG_0_.myHandle) / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wait")
        end
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    Gimmick.EnableNetwork(_ARG_1_, 1)
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "REVIVALTIME") * 60
      _UPVALUE0_ = true
    end
    Entity.GetStartPos(_UPVALUE2_, _ARG_1_)
    _UPVALUE2_:sety(_UPVALUE2_:gety() + 1.5)
    _UPVALUE3_:set(0, 0, 0)
    Entity.CreateEntity("g36vs00", _UPVALUE2_, _UPVALUE3_, _ARG_1_)
    Entity.EnableBgColl(_ARG_1_, 0)
    _ARG_0_:GotoState("Wait")
  end,
  OnDestroy = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    print("\138\162\226I\147\135\148j\137\243\129I\129I\129I\129I\129I\129I\129I\129I\n")
    _ARG_0_:GotoState("Destruction")
  end,
  CanDestroy = function(_ARG_0_)
    if _ARG_0_:GetState() == "Wait" then
      return true
    end
    return false
  end
}, {__index = __StateMachine})
EntityFactory:Add("g28vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g29vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
