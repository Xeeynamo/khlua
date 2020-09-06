setmetatable({
  new = function(_ARG_0_)
    return setmetatable({}, _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "001", _UPVALUE0_, _UPVALUE1_)
        Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE2_, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE3_, 1)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 10)
        print("g36vs00 ... Appear\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "001", _UPVALUE0_, _UPVALUE1_)
        print("g36vs00 ... Idling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsSwim(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("Wait")
        end
      end
    },
    Fly = {
      OnBeginState = function(_ARG_0_)
        if Entity.IsPlayer((Entity.GetParent(Entity.GetAttacker(_ARG_0_.myHandle)))) == false then
          for _FORV_10_, _FORV_11_ in pairs({
            Player.GetPlayers()
          }) do
            if Entity.IsPlayer(_FORV_11_) and 100000000 > Entity.CalcDistanceSq(_ARG_0_.myHandle, _FORV_11_) then
            end
          end
        end
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        Entity.GetWorldPos(_UPVALUE1_, _FORV_11_)
        FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
        Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz()), 0)
        Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.25, _UPVALUE2_)
        Entity.SetMotion(_ARG_0_.myHandle, "001", _UPVALUE3_, _UPVALUE4_)
        Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE5_, 0)
        Entity.SetTimer(_ARG_0_.myHandle, 4)
        _ARG_0_.step = 0
        print("g36vs00 ... Fly\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
          end
        elseif Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_:Explode()
          _ARG_0_:GotoState("Explode")
        end
      end
    },
    Explode = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:Explode()
        _ARG_0_.step = 0
        print("g36vs00 ... Explode\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_.effHandle = NULL_HANDLE
      end,
      OnUpdate = function(_ARG_0_)
        if Effect.GetNowFrame(_ARG_0_.effHandle) >= 60 then
          _ARG_0_:GotoState("Wait")
        end
      end
    },
    Wait = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, "001", _UPVALUE0_, _UPVALUE1_)
        Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE2_, 0)
        Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE3_, 0)
        Entity.GetStartPos(_UPVALUE4_, _ARG_0_.myHandle)
        Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE4_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        print("g36vs00 ... Wait\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          if Entity.IsSwim(_ARG_0_.myHandle) == false then
            _ARG_0_:GotoState("Appear")
          else
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.GetStartPos(_UPVALUE1_, _ARG_0_.myHandle)
            Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetOldLocalPos(_ARG_0_.myHandle, _UPVALUE1_)
          end
        end
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    if _UPVALUE0_ == false then
      _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "B_APP_TIME") * 60
      _UPVALUE2_ = Gimmick.GetExtraParam(_ARG_1_, "B_FLY_DIST")
      _UPVALUE3_ = Gimmick.GetExtraParam(_ARG_1_, "B_MAX")
      _UPVALUE0_ = true
    end
    if Entity.GetLayoutParam(Entity.GetParent(_ARG_1_), 1) <= 0 then
      _ARG_0_.myHandle = _ARG_1_
      _ARG_0_.step = 0
      _ARG_0_.effHandle = NULL_HANDLE
      Entity.EnableBgColl(_ARG_1_, 1)
      Entity.EnableGravity(_ARG_1_, 1)
      Entity.EnableLockon(_ARG_1_, 1)
      Entity.SetLockOnBoneNum(_ARG_1_, 3)
      Entity.SetLockLimitSq(_ARG_1_, 4)
      Gimmick.SetHp(_ARG_1_, 0)
      Gimmick.EnableNetwork(_ARG_1_, 1)
      _ARG_0_:GotoState("Idling")
    else
      Entity.Out(_ARG_1_)
    end
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if (Entity.IsPlayer((Entity.GetAttacker(_ARG_0_.myHandle))) or Entity.IsPlayer((Entity.GetParent((Entity.GetAttacker(_ARG_0_.myHandle)))))) and _ARG_2_ == COMMAND_CATEGORY_ATTACK then
      _ARG_0_:GotoState("Fly")
    end
  end,
  OnHitBody = function(_ARG_0_)
    if _ARG_0_:GetState() == "Fly" then
      _ARG_0_:GotoState("Explode")
    end
  end,
  Explode = function(_ARG_0_)
    if _ARG_0_.effHandle ~= NULL_HANDLE then
      return
    end
    Entity.SetMotion(_ARG_0_.myHandle, "001", _UPVALUE0_, _UPVALUE1_)
    Entity.EnableModelDisp(_ARG_0_.myHandle, _UPVALUE2_, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
    Entity.EnableGravity(_ARG_0_.myHandle, 0)
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
    _UPVALUE3_:set(0, 0, 0)
    _UPVALUE4_:set(0, 0, 0)
    _ARG_0_.effHandle = Entity.AttachEffect(_ARG_0_.myHandle, "g_vs_036_00", "G_VS_036_EXP0_0", "bone_01", _UPVALUE3_, _UPVALUE4_)
    Effect.SetAttachNoRot(_ARG_0_.effHandle, true)
  end,
  CanInhale = function(_ARG_0_)
    if _ARG_0_:GetState() == "Fly" then
      return true
    end
    return false
  end,
  GetBarrelNum = function(_ARG_0_)
    for _FORV_6_, _FORV_7_ in pairs(EntityManager.entities) do
      if Entity.GetName(_FORV_6_) == "g36vs00" then
        if _FORV_7_:GetState() ~= "Wait" then
        else
        end
      end
    end
    return 0 + 1 + 1
  end
}, {__index = __StateMachine})
EntityFactory:Add("g36vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
