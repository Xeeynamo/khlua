setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.step = 0
    _ARG_0_.startPosFlag = 0
    _ARG_0_.maxSummonNumber = 10
    _ARG_0_.summonWait = 80
    _ARG_0_.clearNumber = 20
    _ARG_0_.maxSummonNumber = Entity.GetLayoutParam(_ARG_1_, 1)
    if _ARG_0_.maxSummonNumber == 0 then
      _ARG_0_.maxSummonNumber = 10
    end
    print("maxSummonNumber = " .. _ARG_0_.maxSummonNumber .. "\n")
    _ARG_0_.maxSummonNumber = _ARG_0_.maxSummonNumber - 1
    _ARG_0_.summonWait = Entity.GetLayoutParam(_ARG_1_, 2)
    if _ARG_0_.summonWait == 0 then
      _ARG_0_.summonWait = 80
    end
    print("summonWait = " .. _ARG_0_.summonWait .. "\n")
    _ARG_0_.clearNumber = Entity.GetLayoutParam(_ARG_1_, 3)
    if _ARG_0_.clearNumber == 0 then
      _ARG_0_.clearNumber = 20
    end
    print("summonWait = " .. _ARG_0_.clearNumber .. "\n")
    _UPVALUE0_ = Entity.GetLayoutParam(_ARG_1_, 5) * 0.01
    if _UPVALUE0_ == 0 then
      _UPVALUE0_ = 0.5
    end
    print("summonWait = " .. _UPVALUE0_ .. "\n")
    _UPVALUE1_ = Entity.GetLayoutParam(_ARG_1_, 6) * 0.01
    if _UPVALUE1_ == 0 then
      _UPVALUE1_ = 0.5
    end
    print("summonWait = " .. _UPVALUE1_ .. "\n")
    _ARG_0_.summonTimer = 0
    _ARG_0_.summonCnt = 0
    _ARG_0_.soldierHandle = {}
    for _FORV_5_ = 0, _ARG_0_.maxSummonNumber do
      _ARG_0_.soldierHandle[_FORV_5_] = {handle = NULL_HANDLE}
    end
    _ARG_0_.cnt = 0
  end,
  CreateSoldier = function(_ARG_0_, _ARG_1_)
    if Script.Random() < _UPVALUE0_ then
      _UPVALUE1_:set(-48.933, 2.1, 15.8151)
      _ARG_0_.startPosFlag = _UPVALUE2_
    else
      _UPVALUE1_:set(32.977, 2.1, 2.286)
      _ARG_0_.startPosFlag = _UPVALUE3_
    end
    if Script.Random() < _UPVALUE4_ then
      _ARG_0_.soldierHandle[_ARG_1_].handle = Entity.CreateEntity("m01sb00", _UPVALUE1_, _UPVALUE1_)
    else
      _ARG_0_.soldierHandle[_ARG_1_].handle = Entity.CreateEntity("m02sb00", _UPVALUE1_, _UPVALUE1_)
    end
    if _ARG_0_.startPosFlag == _UPVALUE2_ then
      EntityManager:GetEntity(_ARG_0_.soldierHandle[_ARG_1_].handle):GotoState("TargetPosMove")
    else
      EntityManager:GetEntity(_ARG_0_.soldierHandle[_ARG_1_].handle):GotoState("TargetPosLeftMove")
    end
  end,
  GetSoldierNoAliveId = function(_ARG_0_)
    for _FORV_5_ = 0, _ARG_0_.maxSummonNumber do
      if Entity.IsAlive(_ARG_0_.soldierHandle[_FORV_5_].handle) == false then
        return _FORV_5_
      end
    end
    return _FOR_
  end,
  IsSoldierAlive = function(_ARG_0_)
    for _FORV_5_ = 0, _ARG_0_.maxSummonNumber do
    end
    if 0 + 1 > _FOR_ then
      return true
    end
    return false
  end,
  OnUpdate = function(_ARG_0_)
    if _ARG_0_.step == 0 then
      if Enemy.IsAllEnemyWaiting() == false and _ARG_0_:GetSoldierNoAliveId() ~= -1 then
        _ARG_0_:CreateSoldier((_ARG_0_:GetSoldierNoAliveId()))
        _ARG_0_.summonCnt = _ARG_0_.summonCnt + 1
        _ARG_0_.step = 1
        print("\144\182\144\172\n")
        _ARG_0_.summonTimer = _ARG_0_.summonWait
      end
    elseif _ARG_0_.step == 1 then
      if 0 > _ARG_0_.summonTimer then
        _ARG_0_.step = 0
        if _ARG_0_.summonCnt >= _ARG_0_.clearNumber then
          _ARG_0_.step = 2
        end
      end
    elseif _ARG_0_.step == 2 and _ARG_0_:IsSoldierAlive() == true then
      Mission.CompleteMission()
      _ARG_0_.step = 99
    end
    _ARG_0_.summonTimer = _ARG_0_.summonTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  end
}, {__index = __StateMachine})
EntityFactory:Add("m10sb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
