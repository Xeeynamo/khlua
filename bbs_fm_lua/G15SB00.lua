g15sb00 = {}
g15sb00_mt = {__index = g15sb00}
function g15sb00.new(_ARG_0_)
  return setmetatable({}, g15sb00_mt)
end
function g15sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.trigger = 0
  _ARG_0_.param = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  print("self.param = " .. _ARG_0_.param .. "\n")
  _ARG_0_.frame = 0
  _ARG_0_.markonFrame = 60
  _ARG_0_.inEffectHandle = NULL_HANDLE
  _ARG_0_.EffectHandle = NULL_HANDLE
  if _ARG_0_.param == 1 then
    _ARG_0_.EffectHandle = Entity.AttachEffect(_ARG_0_.myHandle, "g_sb_warp_0", "G_SB_WARP_Y_P_0", "Root")
  end
  Entity.EnableMarkon(_ARG_1_, 0)
  Entity.SetReplyDistSq(_ARG_1_, DISTSQ_CHECK)
  Entity.SetCommandReply(_ARG_1_, COMMAND_KIND_Check)
  if _UPVALUE0_ == 0 then
    _UPVALUE0_ = 1
  end
end
function g15sb00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g15sb00.OnUpdate(_ARG_0_)
  _ARG_0_.markonFrame = _ARG_0_.markonFrame - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.markonFrame < 0 then
    Entity.EnableMarkon(_ARG_0_.myHandle, 1)
  end
  if _ARG_0_.step == 0 then
    if _ARG_0_.frame < 40 then
      _ARG_0_.frame = _ARG_0_.frame + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      _ARG_0_.markonFrame = _ARG_0_.markonFrame + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < 9 then
        print("\131\143\129[\131v\131A\131E\131g\n")
        _ARG_0_:createEffect("g_sb_warp_0", "G_SB_WARP_OUT_0")
        _ARG_0_.step = 2
      end
    else
      _ARG_0_.step = 2
    end
  elseif _ARG_0_.step == 1 then
    _ARG_0_.frame = _ARG_0_.frame + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.frame > 38 then
      if _ARG_0_.param == 1 then
        Gimmick.TriggerFire(_ARG_0_.myHandle, _ARG_0_.trigger)
      else
        Gimmick.TriggerFire(_ARG_0_.myHandle)
      end
      Entity.OnCommandCheck(_ARG_0_.myHandle)
    end
  elseif _ARG_0_.step == 2 then
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < 4 then
      _ARG_0_:createEffect("g_sb_warp_0", "G_SB_WARP_TCH_0")
      _ARG_0_.step = 3
    end
  elseif _ARG_0_.step == 3 then
  end
end
function g15sb00.OnCommand(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle())
  Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
  _ARG_0_.inEffectHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_sb_warp_0", "G_SB_WARP_IN_0", _UPVALUE0_, _UPVALUE1_)
  _ARG_0_.step = 1
  _ARG_0_.frame = 0
  if 0 <= Math.Mod(Effect.GetNowFrame(_ARG_0_.EffectHandle), 480) and Math.Mod(Effect.GetNowFrame(_ARG_0_.EffectHandle), 480) < 240 then
    print("Effect frame = " .. Math.Mod(Effect.GetNowFrame(_ARG_0_.EffectHandle), 480) .. "\n")
    print("GAMETRG_GIMMICK_1 = " .. GAMETRG_GIMMICK_1 .. "\n")
    _ARG_0_.trigger = GAMETRG_GIMMICK_1
  else
    print("Effect frame = " .. Math.Mod(Effect.GetNowFrame(_ARG_0_.EffectHandle), 480) .. "\n")
    print("GAMETRG_GIMMICK_2 = " .. GAMETRG_GIMMICK_2 .. "\n")
    _ARG_0_.trigger = GAMETRG_GIMMICK_2
  end
end
EntityFactory:Add("g15sb00", function(_ARG_0_)
  return (g15sb00:new())
end)
