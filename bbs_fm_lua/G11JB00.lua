setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        print("Appear\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_:GotoState("Idling")
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        print("Waiting\n")
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
        print("Idling\n")
        Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
        Entity.SetMovementCollRadius(_ARG_0_.myHandle, 1)
        Entity.SetLowerHalf(_ARG_0_.myHandle, 1.1)
        _ARG_0_.step = 0
        _ARG_0_:crateMainEffect()
        _ARG_0_.targetHandle = Player.GetHandle()
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.EnableMarkon(_ARG_0_.myHandle, 1)
        Entity.SetReplyDistSq(_ARG_0_.myHandle, 20.25)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
        if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
          _ARG_0_:setHitDistAngle()
          _ARG_0_:setPLHitDistAngle()
          _ARG_0_:setMainEffectAngle()
          _ARG_0_:updateCenterEffect()
        end
        if _ARG_0_.step == 0 then
          _ARG_0_:crateMainEffect()
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) < _UPVALUE1_ and Player.GetPlayerState(_ARG_0_.targetHandle) ~= 6 then
            _ARG_0_:crateHitDistEffect()
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) > _UPVALUE1_ + 1 then
            _ARG_0_:loopEndEffect(_ARG_0_.hitDistEffHandle)
            _ARG_0_.hitDistEffHandle = NULL_HANDLE
            _ARG_0_:loopEndEffect(_ARG_0_.hitPLDistEffHandle)
            _ARG_0_.hitPLDistEffHandle = NULL_HANDLE
          end
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) < _UPVALUE2_ and Player.GetPlayerState(_ARG_0_.targetHandle) ~= 6 then
            _ARG_0_:crateShortDistEffect()
            _ARG_0_:crateCenterEffect()
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) > _UPVALUE2_ + 1 then
            _ARG_0_:loopEndEffect(_ARG_0_.hitShortEffHandle)
            _ARG_0_.hitShortEffHandle = NULL_HANDLE
            _ARG_0_:loopEndEffect(_ARG_0_.hitPLShortEffHandle)
            _ARG_0_.hitPLShortEffHandle = NULL_HANDLE
            _ARG_0_:loopEndEffect(_ARG_0_.hitCenterEffHandle)
            _ARG_0_.hitCenterEffHandle = NULL_HANDLE
          end
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
          Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) < _UPVALUE4_ then
            _ARG_0_:crateHitDistEffect()
            _ARG_0_.step = 1
            if _ARG_0_.uniqueID == 50 then
              Entity.SetTimer(_ARG_0_.myHandle, 2)
            else
              Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
            end
            _ARG_0_:loopEndEffect(_ARG_0_.effecgtHandle)
            _ARG_0_.effecgtHandle = NULL_HANDLE
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
            if _UPVALUE0_:gety() > _UPVALUE3_:gety() + 1 then
              _UPVALUE3_:setx(_UPVALUE0_:getx())
              _UPVALUE3_:setz(_UPVALUE0_:getz())
            end
            FVECTOR3.Sub(_UPVALUE6_, _UPVALUE0_, _UPVALUE3_)
            FVECTOR3.normalize(_UPVALUE6_)
            _UPVALUE6_:scale(Gimmick.GetJumpStandPower(_ARG_0_.myHandle))
            _ARG_0_.JumpVec:set(_UPVALUE6_:getx(), _UPVALUE6_:gety(), _UPVALUE6_:getz())
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
            Entity.GetWorldPos(_UPVALUE3_, _ARG_0_.myHandle)
            if _UPVALUE0_:gety() > _UPVALUE3_:gety() + 1 then
              print("\149\226\144\179\130\181\130\220\130\183\n")
              Entity.GetRot(_UPVALUE7_, _ARG_0_.myHandle)
              _UPVALUE3_:set(0, _UPVALUE8_, _UPVALUE9_)
              Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE7_)
              FVECTOR3.Add(_ARG_0_.JumpVec, _ARG_0_.JumpVec, _UPVALUE3_)
            end
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:setHitEffect()
            _ARG_0_:loopEndEffect(_ARG_0_.hitDistEffHandle)
            _ARG_0_.hitDistEffHandle = NULL_HANDLE
            Effect.KillEffect(_ARG_0_.hitPLDistEffHandle)
            _ARG_0_.hitPLDistEffHandle = NULL_HANDLE
            _ARG_0_:loopEndEffect(_ARG_0_.hitShortEffHandle)
            _ARG_0_.hitShortEffHandle = NULL_HANDLE
            Effect.KillEffect(_ARG_0_.hitPLShortEffHandle)
            _ARG_0_.hitPLShortEffHandle = NULL_HANDLE
            _ARG_0_:loopEndEffect(_ARG_0_.hitCenterEffHandle)
            _ARG_0_.hitCenterEffHandle = NULL_HANDLE
            Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 2)
            FVECTOR3.Sub(_UPVALUE6_, _UPVALUE0_, _ARG_0_.JumpVec)
            if Entity.CalcDistanceSq(_ARG_0_.myHandle, _UPVALUE0_) < _UPVALUE1_ + 0.5 then
              _ARG_0_.JumpVec:sety(_ARG_0_.JumpVec:gety() + 2.25)
              Player.SetGimmicBlow(_ARG_0_.targetHandle, _ARG_0_.JumpVec)
            end
            _ARG_0_.step = 2
            Entity.SetTimer(_ARG_0_.myHandle, 60)
          end
        elseif _ARG_0_.step == 2 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = 0
        end
      end
    },
    NoVisibleIdling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:crateMainEffect()
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    NoVisibleIdling2 = {
      OnBeginState = function(_ARG_0_)
        print("NoVisibleIdling2\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Hit = {
      OnBeginState = function(_ARG_0_)
        print("Hit\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.effecgtHandle = NULL_HANDLE
    _ARG_0_.hitDistEffHandle = NULL_HANDLE
    _ARG_0_.hitShortEffHandle = NULL_HANDLE
    _ARG_0_.hitPLDistEffHandle = NULL_HANDLE
    _ARG_0_.hitPLShortEffHandle = NULL_HANDLE
    _ARG_0_.hitCenterEffHandle = NULL_HANDLE
    _ARG_0_.uniqueID = Entity.GetLayoutParam(_ARG_1_, 9)
    print("self.uniqueID = " .. _ARG_0_.uniqueID .. "\n")
    _ARG_0_.locae = NULL_HANDLE
    _ARG_0_.hitPowUpY = 0
    _ARG_0_.hitPowUpX = 0
    hitdist = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
    if hitdist ~= 0 then
      _UPVALUE0_ = hitdist
    end
    _UPVALUE1_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 6)
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    if _UPVALUE1_ == 0 then
      _UPVALUE1_ = 36
    end
    _UPVALUE2_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 7)
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    if _UPVALUE1_ == 0 then
      _UPVALUE1_ = 9
    end
    _UPVALUE0_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 8)
    _UPVALUE0_ = _UPVALUE0_ * _UPVALUE0_
    if _UPVALUE0_ == 0 then
      _UPVALUE0_ = 4
    end
    _UPVALUE3_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
    if _UPVALUE3_ == 0 then
      _UPVALUE3_ = 10
    end
    _UPVALUE4_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
    if _UPVALUE4_ == 0 then
      _UPVALUE4_ = 1
    end
    _UPVALUE5_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
    print(_UPVALUE5_ .. "\n")
    if _UPVALUE5_ == 0 then
      _UPVALUE5_ = 3
    end
    print(_UPVALUE5_ .. "\n")
    Entity.EnableBgColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
    Entity.SetLockOnBoneNum(_ARG_1_, 0)
    _ARG_0_.JumpVec = FVECTOR3.new(0, 0, 0)
    if _ARG_0_.uniqueID == 50 or _ARG_0_.uniqueID == 51 or _ARG_0_.uniqueID == 52 or _ARG_0_.uniqueID == 2010 then
      _ARG_0_:GotoState("NoVisibleIdling2")
    else
      _ARG_0_:GotoState("Idling")
    end
  end,
  crateMainEffect = function(_ARG_0_)
    if _ARG_0_.effecgtHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172\n")
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_011", "G_JB_011_GMN_0", _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateCenterEffect = function(_ARG_0_)
    if _ARG_0_.hitCenterEffHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172\n")
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE0_:set(0, 0, 0)
      _ARG_0_.hitCenterEffHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_011", "G_JB_011_SPP_0", _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateHitDistEffect = function(_ARG_0_)
    if _ARG_0_.hitDistEffHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172 \144\218\144G\148\187\146\232\137\147\130\162\n")
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.hitDistEffHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_011", "G_JB_011_HG0_0", _UPVALUE0_, _UPVALUE1_)
      Effect.SetAttachNoRot(_ARG_0_.hitDistEffHandle, true)
    end
    if _ARG_0_.hitPLDistEffHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172 \144\218\144G\148\187\146\232\137\147\130\162\n")
      _UPVALUE0_:set(0, 0, 0)
      _ARG_0_.hitPLDistEffHandle = Entity.AttachEffect(_ARG_0_.targetHandle, "g_jb_011", "G_JB_011_HP0_0", "center", _UPVALUE0_, _UPVALUE1_)
      Effect.SetAttachNoRot(_ARG_0_.hitPLDistEffHandle, true)
    end
  end,
  crateShortDistEffect = function(_ARG_0_)
    if _ARG_0_.hitShortEffHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172 \144\218\144G\148\187\146\232\139\223\130\162\n")
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.hitShortEffHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_011", "G_JB_011_HG1_0", _UPVALUE0_, _UPVALUE1_)
      Effect.SetAttachNoRot(_ARG_0_.hitShortEffHandle, true)
    end
    if _ARG_0_.hitPLShortEffHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172 \144\218\144G\148\187\146\232\137\147\130\162\n")
      _UPVALUE0_:set(0, 0, 0)
      _ARG_0_.hitPLShortEffHandle = Entity.AttachEffect(_ARG_0_.targetHandle, "g_jb_011", "G_JB_011_HP1_0", "center", _UPVALUE0_, _UPVALUE1_)
      Effect.SetAttachNoRot(_ARG_0_.hitPLShortEffHandle, true)
    end
  end,
  setHitDistAngle = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle(), 1)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
    FVECTOR3.normalize(_UPVALUE1_)
    _UPVALUE2_:set(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx())), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    if _ARG_0_.hitDistEffHandle ~= NULL_HANDLE then
      Effect.UpdateCoord(_ARG_0_.hitDistEffHandle, _UPVALUE1_, _UPVALUE2_)
    end
    if _ARG_0_.hitShortEffHandle ~= NULL_HANDLE then
      Effect.UpdateCoord(_ARG_0_.hitShortEffHandle, _UPVALUE1_, _UPVALUE2_)
    end
  end,
  setPLHitDistAngle = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle(), 1)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
    FVECTOR3.normalize(_UPVALUE1_)
    _UPVALUE2_:set(RoundPI(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx()))), RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()))), 0)
    _UPVALUE0_:set(0, 0, 0)
    if _ARG_0_.hitPLDistEffHandle ~= NULL_HANDLE then
      _UPVALUE2_:set(RoundPI(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx()))), RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()))), 0)
      Effect.UpdateCoord(_ARG_0_.hitPLDistEffHandle, _UPVALUE0_, _UPVALUE2_)
    end
    if _ARG_0_.hitPLShortEffHandle ~= NULL_HANDLE then
      _UPVALUE2_:set(RoundPI(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx()))), RoundPI((Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()))), 0)
      Effect.UpdateCoord(_ARG_0_.hitPLShortEffHandle, _UPVALUE0_, _UPVALUE2_)
    end
  end,
  setMainEffectAngle = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle(), 1)
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE1_, _UPVALUE0_, _UPVALUE1_)
    FVECTOR3.normalize(_UPVALUE1_)
    _UPVALUE2_:set(-Math.Atan2(_UPVALUE1_:gety(), Math.Sqrt(_UPVALUE1_:getz() * _UPVALUE1_:getz() + _UPVALUE1_:getx() * _UPVALUE1_:getx())), Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz()), 0)
    if _ARG_0_.effecgtHandle ~= NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
      Effect.UpdateCoord(_ARG_0_.effecgtHandle, _UPVALUE1_, _UPVALUE2_)
    end
  end,
  updateCenterEffect = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    _UPVALUE1_:set(0, 0, 0)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 1)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
    Math.VectorLerp(_UPVALUE3_, _UPVALUE2_, _UPVALUE0_, 0.5)
    if _ARG_0_.hitCenterEffHandle ~= NULL_HANDLE then
      Effect.UpdateCoord(_ARG_0_.hitCenterEffHandle, _UPVALUE3_, _UPVALUE1_)
    end
  end,
  setHitEffect = function(_ARG_0_)
    if 1 == 1 then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle, 1)
      _UPVALUE1_:set(0, 0, 0)
      Entity.SetEffect(_ARG_0_.myHandle, "g_jb_011", "G_JB_011_SPG_0", _UPVALUE2_, _UPVALUE1_)
      print("\144\218\144G\131G\131t\131F\131N\129@\131M\131~\131b\131N\145\164\n")
    end
    if 1 == 0 then
      Entity.GetWorldPos(_UPVALUE0_, Player.GetHandle(), 1)
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle)
      FVECTOR3.Sub(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
      FVECTOR3.normalize(_UPVALUE2_)
      _UPVALUE1_:set(-Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getz() * _UPVALUE2_:getz() + _UPVALUE2_:getx() * _UPVALUE2_:getx())), Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
      _UPVALUE3_:set(0, 0, 1.5)
      Math.RotateVectorXYZ(_UPVALUE3_, _UPVALUE1_)
      Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle, 1)
      FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE3_)
      Entity.SetEffect(_ARG_0_.myHandle, "g_jb_011", "G_JB_011_SPP_0", _UPVALUE2_, _UPVALUE1_)
      print("\144\218\144G\131G\131t\131F\131N \131v\131\140\131C\131\132\129[\145\164\n")
    end
  end,
  loopEndEffect = function(_ARG_0_, _ARG_1_)
    Effect.LoopEnd(_ARG_1_)
    _ARG_1_ = NULL_HANDLE
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
    return 0
  end,
  OnDead = function(_ARG_0_)
    return 0
  end,
  OnReturnDamage = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end,
  CanMainSkip = function(_ARG_0_)
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Player.GetHandle())) < 100 then
      if _ARG_0_:GetState() == "NoVisibleIdling" then
        _ARG_0_:GotoState("Idling")
      end
      return false
    end
    if _ARG_0_:GetState() == "Idling" then
      _ARG_0_:GotoState("NoVisibleIdling")
    end
    _ARG_0_:loopEndEffect(_ARG_0_.hitDistEffHandle)
    _ARG_0_.hitDistEffHandle = NULL_HANDLE
    Effect.KillEffect(_ARG_0_.hitPLDistEffHandle)
    _ARG_0_.hitPLDistEffHandle = NULL_HANDLE
    _ARG_0_:loopEndEffect(_ARG_0_.hitShortEffHandle)
    _ARG_0_.hitShortEffHandle = NULL_HANDLE
    Effect.KillEffect(_ARG_0_.hitPLShortEffHandle)
    _ARG_0_.hitPLShortEffHandle = NULL_HANDLE
    _ARG_0_:loopEndEffect(_ARG_0_.hitCenterEffHandle)
    _ARG_0_.hitCenterEffHandle = NULL_HANDLE
    return true
  end
}, {__index = __StateMachine})
EntityFactory:Add("g11jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
