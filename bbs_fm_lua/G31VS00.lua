g31vs00 = {}
g31vs00_base_mt = {__index = __StateMachine}
setmetatable(g31vs00, g31vs00_base_mt)
g31vs00_mt = {__index = g31vs00}
function g31vs00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), g31vs00_mt)
end
g31vs00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_:GotoState("Idling")
    end
  },
  Waiting = {
    OnBeginState = function(_ARG_0_)
      print("g31vs00 :: Waiting\n")
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
      print("g31vs00 :: Idling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = _ARG_0_:getShortPlayerHandle()
      if Entity.IsTimeOver(_ARG_0_.myHandle) and Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        _ARG_0_:GotoState("AttackIdling")
      end
    end
  },
  AttackIdling = {
    OnBeginState = function(_ARG_0_)
      print("g31vs00 :: AttackIdling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Bullet.DeleteBullet(_ARG_0_.bullethandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 50 then
          _ARG_0_:CreateShoot(_ARG_0_.myHandle)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
        end
      elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Attack")
      end
    end
  },
  Attack = {
    OnBeginState = function(_ARG_0_)
      print("AttackIdling\n")
      _ARG_0_:setMotion(_UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      print("Damage\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.damageSave = _ARG_0_.damageSave + 1
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Faint = {
    OnBeginState = function(_ARG_0_)
      print("Faint\n")
      _ARG_0_:setMotion(_UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 1
          _ARG_0_:setMotion(_UPVALUE0_)
        end
      elseif _ARG_0_.step == 1 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  }
}
function g31vs00.setMotion(_ARG_0_, _ARG_1_)
  Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _ARG_1_)
end
function g31vs00.getShortPlayerHandle(_ARG_0_)
  if Player.GetPlayers() ~= NULL_HANDLE then
  end
  if Player.GetPlayers() ~= NULL_HANDLE then
  end
  if Player.GetPlayers() ~= NULL_HANDLE then
  end
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) > Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) then
  end
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) then
  end
  if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) < Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetPlayers()) then
  end
  return Player.GetPlayers()
end
function g31vs00.OnInit(_ARG_0_, _ARG_1_)
  _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "001")
  _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "002")
  _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "003")
  _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "004")
  _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "005")
  _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "006")
  Gimmick.EnableNetwork(_ARG_1_, 1)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.effectHandle = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.bullethandle = NULL_HANDLE
  _ARG_0_.damageSave = 0
  Entity.SetReplyDistSq(_ARG_1_, 9)
  _UPVALUE6_ = Gimmick.GetExtraParam(_ARG_1_, "AttDist")
  _UPVALUE6_ = _UPVALUE6_ * _UPVALUE6_
  _UPVALUE7_ = Gimmick.GetExtraParam(_ARG_1_, "FaintT") * 60
  _UPVALUE8_ = Gimmick.GetExtraParam(_ARG_1_, "AttckT") * 60
  _UPVALUE9_ = Gimmick.GetExtraParam(_ARG_1_, "IdlingT") * 60
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  _UPVALUE6_ = 81
  _ARG_0_:GotoState("Waiting")
end
function g31vs00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_.damageSave >= _UPVALUE0_ then
    _ARG_0_.damageSave = 0
    if _ARG_0_:GetState() ~= "Faint" then
      _ARG_0_:GotoState("Faint")
      return 1
    end
  end
  if _ARG_0_:GetState() == "Faint" then
  else
    _ARG_0_:GotoState("Damage")
  end
  return 1
end
function g31vs00.CreateShoot(_ARG_0_, _ARG_1_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  Entity.GetRot(_UPVALUE1_, _ARG_1_)
  Bullet.SetCollision(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.5, 0, _ARG_1_)
  Bullet.SetAttackParam(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), Gimmick.GetAttackKind(_ARG_0_.myHandle, 0), Gimmick.GetAttackAttr(_ARG_0_.myHandle, 0), Gimmick.GetAttackPoint(_ARG_0_.myHandle, 0), Gimmick.GetAttackPowerCorrection(_ARG_0_.myHandle, 0), 0, Enemy.GetDifficultyCorrection())
  Bullet.SetAttacker(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), _ARG_0_.myHandle)
  Bullet.SetCollKind(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), COLL_KIND_ENEMY)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), "g_vs_031_00", "G_VS_031_HIT0_0")
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), 14400)
  EntityManager:GetEntity((Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_))).targetHandle = _ARG_0_.targetHandle
  Bullet.EnableNoCheckHitBg(Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_), 1)
  _ARG_0_.bullethandle = Bullet.CreateBullet("bubbleBullet", _UPVALUE0_, _UPVALUE1_)
end
function g31vs00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(0, 0.01, 0)
  _UPVALUE1_:set(0, 0.01, 0)
  _ARG_0_.effectHandle = Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _UPVALUE0_, _UPVALUE1_)
end
function g31vs00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
EntityFactory:Add("g31vs00", function(_ARG_0_)
  return (g31vs00:new())
end)
EntityFactory:Add("bubbleBullet", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
