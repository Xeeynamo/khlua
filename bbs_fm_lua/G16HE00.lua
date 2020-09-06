workVec = FVECTOR3.new(0, 0, 0)
workVec1 = FVECTOR3.new(0, 0, 0)
g16he00 = {}
g16he00_mt = {__index = g16he00}
function g16he00.new(_ARG_0_)
  return setmetatable({}, g16he00_mt)
end
function g16he00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetMotion(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableHeavy(_ARG_0_.myHandle, 1)
end
function g16he00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    Entity.SetMotion(_ARG_0_.myHandle, 0)
    _ARG_0_.step = 0
  end
end
function g16he00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(workVec, _ARG_0_.myHandle)
  Entity.GetRot(workVec1, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, workVec, workVec1)
end
function g16he00.OnDead(_ARG_0_)
  _ARG_0_:createEffect("g_he_010_00", "G_HE_TUB_00_0")
  if _ARG_0_.step == 0 then
    Entity.GetDamageCrossPos(workVec, _ARG_0_.myHandle)
    Gimmick.MakeDropPrize(_ARG_0_.myHandle, workVec)
    Entity.SetMotion(_ARG_0_.myHandle, 1)
    _ARG_0_.step = 1
  end
end
function g16he00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
end
EntityFactory:Add("g16he00", function(_ARG_0_)
  return (g16he00:new())
end)
