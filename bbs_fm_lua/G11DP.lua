g11dp = {}
g11dp_mt = {__index = g11dp}
function g11dp.new(_ARG_0_)
  return setmetatable({}, g11dp_mt)
end
function g11dp.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.lingHandle = Entity.CreateEntity("g13dp00", _ARG_0_.WorkVec, _ARG_0_.WorkVec, _ARG_1_)
  Entity.AttachCoord(_ARG_1_, "bone_02", _ARG_0_.lingHandle, "Root")
end
function g11dp.OnUpdate(_ARG_0_)
end
EntityFactory:Add("g11dp00", function(_ARG_0_)
  return (g11dp:new())
end)
g13dp00 = {}
g13dp00_mt = {__index = g13dp00}
function g13dp00.new(_ARG_0_)
  return setmetatable({}, g13dp00_mt)
end
function g13dp00.OnDamage(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_ARG_0_.hitpos, Entity.GetAttacker(_ARG_0_.myHandle))
  _ARG_0_.step = 1
  if 1 == Entity.GetDamageCommandKind(_ARG_0_.myHandle) then
    if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW then
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      if _UPVALUE1_ == 0 then
        _UPVALUE1_ = 1
        Entity.CreatePrizeNoTimeLost(_ARG_0_.myHandle, 0, true, "X_marker")
      end
      if Mission.IsMissionNow() == true then
        Mission.SendMissonMessage(MES_TUTORIAL_ATK_FINISH_TO_RING)
      end
    else
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
    end
  else
    Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    if _UPVALUE1_ == 0 then
      _UPVALUE1_ = 1
      Entity.CreatePrizeNoTimeLost(_ARG_0_.myHandle, 0, true, "X_marker")
    end
    if Mission.IsMissionNow() == true then
      Mission.SendMissonMessage(MES_TUTORIAL_ATK_FINISH_TO_RING)
    end
  end
  Entity.GetWorldPos(_ARG_0_.workvec1, _ARG_0_.myHandle, 2)
  FVECTOR3.Sub(_ARG_0_.workvec, _ARG_0_.hitpos, _ARG_0_.workvec1)
  FVECTOR3.normalize(_ARG_0_.workvec)
  _ARG_0_.workvec:set(0, RoundPI((Math.Atan2(_ARG_0_.workvec:getx(), _ARG_0_.workvec:getz()))), 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workvec)
end
function g13dp00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  _ARG_0_.prized = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workvec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.hitpos = FVECTOR3.new(0, 0, 0)
  Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
end
function g13dp00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
    _ARG_0_.step = 0
  end
end
EntityFactory:Add("g13dp00", function(_ARG_0_)
  return (g13dp00:new())
end)
