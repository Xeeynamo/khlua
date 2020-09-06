g13kg00 = {}
g13kg00_mt = {__index = g13kg00}
function g13kg00.new(_ARG_0_)
  return setmetatable({}, g13kg00_mt)
end
function g13kg00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.nextWait = 75
  _ARG_0_.nextWait2 = 105
  Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.nextWait)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec1 = FVECTOR3.new(0, 0, 0)
end
function g13kg00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.nextWait2)
      if Script.Random() < 0.5 then
        _ARG_0_:PlayVoice(1)
      else
        _ARG_0_:PlayVoice(2)
      end
      _ARG_0_.step = 1
    end
  elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
    Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.nextWait)
    if Script.Random() < 0.5 then
      _ARG_0_:PlayVoice(1)
    else
      _ARG_0_:PlayVoice(2)
    end
    _ARG_0_.step = 0
  end
end
function g13kg00.PlayVoice(_ARG_0_, _ARG_1_)
  _ARG_0_.WorkVec:set(0, 0, 0)
  Entity.GetWorldPos(_ARG_0_.WorkVec, Player.GetHandle())
  _ARG_0_.WorkVec:setx(_ARG_0_.WorkVec:getx() + (Script.Random() * 5 + 1) * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
  _ARG_0_.WorkVec:setz(_ARG_0_.WorkVec:getz() + (Script.Random() * 5 + 1) * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
  Sound.PlaySe(284, _ARG_1_, 1, _ARG_0_.WorkVec, 1)
end
EntityFactory:Add("g13kg00", function(_ARG_0_)
  return (g13kg00:new())
end)
