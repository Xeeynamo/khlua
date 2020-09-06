g15sw00 = {}
g15sw00.__index = g15sw00
function g15sw00.new(_ARG_0_)
  return setmetatable({}, g15sw00)
end
function g15sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  Entity.SetMotion(_ARG_0_.myHandle, 1)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
  Entity.SetModelFixZ(_ARG_0_.myHandle, DISPLAYER_3D_OT_CHRLAST)
  Entity.SetDispOffCameraDistance(_ARG_0_.myHandle, 20)
end
function g15sw00.OnUpdate(_ARG_0_)
end
function g15sw00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if Entity.GetDamagePoint(_ARG_0_.myHandle) > 0 then
    Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle, 1)
    Entity.SetEffect(_ARG_0_.myHandle, "g_sw_bin_b0", "G_SW_BIN_BRK0_0", _ARG_0_.workVec0, _ARG_0_.workVec1)
    Gimmick.Delete(_ARG_0_.myHandle)
  end
  return 1
end
function g15sw00.OnStartModelClipFar(_ARG_0_)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
end
function g15sw00.OnEndModelClipFar(_ARG_0_)
  Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
end
EntityFactory:Add("g15sw00", function(_ARG_0_)
  return (g15sw00:new())
end)
