g50vs00 = {}
g50vs00_mt = {__index = g50vs00}
function g50vs00.new(_ARG_0_)
  return setmetatable({}, g50vs00_mt)
end
function g50vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
  if _UPVALUE1_ == 0 then
    _UPVALUE1_ = 1
  end
  _ARG_0_.attachFlag = 0
  _ARG_0_.vRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.vRot:set(DegToRad((Gimmick.GetExtraParam(_ARG_1_, "RndRotX"))), DegToRad((Gimmick.GetExtraParam(_ARG_1_, "RndRotY"))), DegToRad((Gimmick.GetExtraParam(_ARG_1_, "RndRotZ"))))
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  Entity.SetModelOfsZ(_ARG_1_, -1000)
end
function g50vs00.OnUpdate(_ARG_0_)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.workVec:set(0, 0, 0)
  FVECTOR3.Scale(_ARG_0_.workVec, _ARG_0_.vRot, 1 * Entity.GetFrameRate(_ARG_0_.myHandle))
  FVECTOR3.Add(_ARG_0_.rot, _ARG_0_.rot, _ARG_0_.workVec)
  _ARG_0_.rot:setx(0)
  _ARG_0_.rot:sety(0)
  _ARG_0_.rot:setz(RoundPI(_ARG_0_.rot:getz()))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
end
EntityFactory:Add("g50vs00", function(_ARG_0_)
  return (g50vs00:new())
end)
g51vs00 = {}
g51vs00_mt = {__index = g51vs00}
function g51vs00.new(_ARG_0_)
  return setmetatable({}, g51vs00_mt)
end
function g51vs00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _UPVALUE0_ = _ARG_1_
  if G51VS_PARAM_FLAG == 0 then
    g51vs_PARAM_FLAG = 1
  end
  _ARG_0_.attachFlag = 0
  _ARG_0_.vRot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.vRot:set(DegToRad(Gimmick.GetExtraParam(_ARG_1_, "RndRotX")), DegToRad((Gimmick.GetExtraParam(_ARG_1_, "RndRotY"))), DegToRad((Gimmick.GetExtraParam(_ARG_1_, "RndRotZ"))))
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  Entity.SetModelOfsZ(_ARG_1_, -1000)
end
function g51vs00.OnUpdate(_ARG_0_)
  if _ARG_0_.attachFlag == 0 then
    Entity.AttachCoord(_ARG_0_.myHandle, "Root", _UPVALUE0_, "Root")
    _ARG_0_.attachFlag = 1
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.workVec:set(0, 0, 0)
  FVECTOR3.Scale(_ARG_0_.workVec, _ARG_0_.vRot, 1 * Entity.GetFrameRate(_ARG_0_.myHandle))
  FVECTOR3.Add(_ARG_0_.rot, _ARG_0_.rot, _ARG_0_.workVec)
  _ARG_0_.rot:setx(RoundPI(_ARG_0_.rot:getx()))
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety()))
  _ARG_0_.rot:setz(RoundPI(_ARG_0_.rot:getz()))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
end
EntityFactory:Add("g51vs00", function(_ARG_0_)
  return (g51vs00:new())
end)
