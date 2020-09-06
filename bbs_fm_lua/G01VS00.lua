G01VS_HANDLE = 0
g11vs00 = {}
g11vs00_base_mt = {__index = __StateMachine}
setmetatable(g11vs00, g11vs00_base_mt)
g11vs00_mt = {__index = g11vs00}
function g11vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g11vs00_mt)
end
function g11vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.effectHandle = NULL_HANDLE
  Entity.EnableMarkon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  Entity.SetCommandReply(_ARG_1_, 1)
  _ARG_0_:NotifyLobbyLightingOfCenter(false)
end
function g11vs00.NotifyLobbyLightingOfCenter(_ARG_0_, _ARG_1_)
  if _ARG_1_ == false then
    _ARG_0_:ChangeTexAnim(0)
    if Effect.IsAlive(_ARG_0_.effectHandle) then
      Effect.LoopEnd(_ARG_0_.effectHandle)
    end
    _ARG_0_.effectHandle = NULL_HANDLE
  elseif _ARG_1_ == true then
    _ARG_0_:ChangeTexAnim(1)
    if not Effect.IsAlive(_ARG_0_.effectHandle) then
      _ARG_0_:createEffect("g_vs_xxx_00", "G_VS_NEW_GAM0_0")
    end
  end
end
function g11vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(0, 0.01, 0)
  _UPVALUE1_:set(0, 0.01, 0)
  _ARG_0_.effectHandle = Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g11vs00.ChangeTexAnim(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 0 then
    Entity.SetMapTexAnim("baseI", "Off")
    Entity.SetMapTexAnim("naka", "Off")
    Entity.SetMapTexAnim("naka2", "Off")
    Entity.SetMapTexAnim("naka3", "Off")
  else
    Entity.SetMapTexAnim("baseI", "pp")
    Entity.SetMapTexAnim("naka", "pp")
    Entity.SetMapTexAnim("naka2", "pp")
    Entity.SetMapTexAnim("naka3", "pp")
  end
end
function g11vs00.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g11vs00", function(_ARG_0_)
  return (g11vs00:new())
end)
