g12sw00 = {}
g12sw00.__index = g12sw00
function g12sw00.new(_ARG_0_)
  return setmetatable({}, g12sw00)
end
function g12sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.step = 0
  _ARG_0_.setparam = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
  _ARG_0_.mobmax = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableShooton(_ARG_0_.myHandle, 1)
  Entity.SetUserGroundColor(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, 15)
end
function g12sw00.OnUpdate(_ARG_0_)
end
function g12sw00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 then
    return 0
  end
  if Entity.GetName(_ARG_0_.myHandle) == "g12sw00" then
    if _ARG_1_ == ATK_KIND_DMG_SMALL then
    else
      if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW or _ARG_1_ == ATK_KIND_DMG_TOSS or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_BEAT or _ARG_1_ == ATK_KIND_DMG_FLICK then
        Gimmick.Delete(_ARG_0_.myHandle)
        Gimmick.AddHp(_ARG_0_.myHandle, -10000)
      else
      end
    end
  else
    Gimmick.Delete(_ARG_0_.myHandle)
    Gimmick.AddHp(_ARG_0_.myHandle, -10000)
  end
  return 1
end
function g12sw00.OnDestroy(_ARG_0_)
end
function g12sw00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_0_.workVec1, _ARG_0_.workVec0)
end
function g12sw00.OnDead(_ARG_0_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) <= 0 then
    return 0
  end
  if _ARG_0_.setparam == 1 then
    for _FORV_5_ = 0, 360, 360 / (Script.Random() * (_ARG_0_.mobmax - 1) + 1) do
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
      _ARG_0_.workVec1:setx(_ARG_0_.workVec1:getx() + (1 * Script.Random() + 1) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
      _ARG_0_.workVec1:sety(_ARG_0_.workVec1:gety())
      _ARG_0_.workVec1:setz(_ARG_0_.workVec1:getz() + (1 * Script.Random() + 1) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
      Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
      Entity.EnableDamageColl(Entity.CreateEntity("m01ex00", _ARG_0_.workVec1, _ARG_0_.workVec0), 0)
    end
  end
  _ARG_0_:createEffect("g_sw_018_00", "G_SW_BOX_BOM0_0")
end
EntityFactory:Add("g12sw00", function(_ARG_0_)
  return (g12sw00:new())
end)
EntityFactory:Add("g18sw00", function(_ARG_0_)
  return (g12sw00:new())
end)
