setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        print("Appear\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        print("Waiting\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("Idling\n")
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Mission = {
      OnBeginState = function(_ARG_0_)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Hit = {
      OnBeginState = function(_ARG_0_)
        print("Hit\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.step = 0
  end,
  loopEndEffect = function(_ARG_0_, _ARG_1_)
    Effect.LoopEnd(_ARG_1_)
    _ARG_1_ = NULL_HANDLE
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("g12jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g13jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g14jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
