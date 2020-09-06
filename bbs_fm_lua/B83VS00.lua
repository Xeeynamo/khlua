setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Appear = {
      OnBeginState = function(_ARG_0_)
        Sound.PlaySe(291, 17)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Appear\n")
      end,
      OnEndState = function(_ARG_0_)
        if Mission.IsFlagFinalRound() == 0 then
          Wnd.CreateInfoWnd("vs00500")
          TimeCounter.Create(_UPVALUE0_, 0, 0, -1, -1, "num_11")
          TimeCounter.Start()
          _ARG_0_.eventTimerStep = 1
          print("TimeCounter.Create()\n")
        end
        _UPVALUE1_:set(0, 0, -_UPVALUE2_)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE1_)
        Entity.SetRot(_ARG_0_.myHandle, 0, PI * 0.5, 0)
      end,
      OnUpdate = function(_ARG_0_)
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        print("Idling\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        if _ARG_0_.angryFlag then
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("Angry")
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
          return
        end
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.stack:clear()
          _ARG_0_.stack:push("Idling")
          if Script.Random() < 0.1 then
            _ARG_0_:GotoStateSneeze()
          elseif Script.Random() >= 0.1 and Script.Random() < 0.5 then
            _ARG_0_.stack:push("BehaviorNormal")
            _ARG_0_.stack:push("Search")
            _ARG_0_.stack:push("MoveMiddle")
            _ARG_0_.stack:push("Dive")
          elseif Script.Random() >= 0.5 and Script.Random() < 0.8 then
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveNear")
            if _ARG_0_:CanInhale() then
              _ARG_0_.stack:push("Dive")
              _ARG_0_.stack:push("Inhale")
              _ARG_0_.stack:push("Surfacing")
              _ARG_0_.stack:push("MoveFar")
            end
            if Script.Random() < 0.4 then
              _ARG_0_.stack:push("RushEnd")
              _ARG_0_.stack:push("Rush")
              _ARG_0_.stack:push("Drift")
            else
              _ARG_0_.stack:push("RushEnd")
            end
            _ARG_0_.stack:push("Rush")
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveFar")
            _ARG_0_.stack:push("Dive")
          elseif Script.Random() >= 0.8 then
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveNear")
            if _ARG_0_:CanInhale() then
              _ARG_0_.stack:push("Dive")
              _ARG_0_.stack:push("Inhale")
              _ARG_0_.stack:push("Surfacing")
              _ARG_0_.stack:push("MoveFar")
            end
            _ARG_0_.stack:push("Dive")
          end
          _ARG_0_.stack:push("Turn")
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Angry = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 120)
        _ARG_0_.angryTimer = _UPVALUE1_
        print("Angry\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.stack:push("AngryBehaviorA")
          _ARG_0_.stack:push("SearchDive")
          _ARG_0_.stack:push("Search")
          _ARG_0_.stack:push("MoveMiddle")
          _ARG_0_.stack:push("Dive")
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Search = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.accDmgPoint = 0
        print("Search\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 2.5)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    BehaviorNormal = {
      OnBeginState = function(_ARG_0_)
        print("BehaviorNormal\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push("Surfacing")
        _ARG_0_.stack:push("MoveNear")
        if _ARG_0_:CanInhale() then
          _ARG_0_.stack:push("Dive")
          _ARG_0_.stack:push("Inhale")
          _ARG_0_.stack:push("Surfacing")
          _ARG_0_.stack:push("MoveFar")
        end
        if _ARG_0_:IsTargetCenterLand() then
          if Script.Random() < 0.5 then
            _ARG_0_.stack:push("Breaching")
          else
            _ARG_0_.stack:push("FinAttack")
          end
        elseif Script.Random() < 0.5 then
          _ARG_0_.stack:push("Dive")
          _ARG_0_.stack:push("Swallow")
        else
          _ARG_0_.stack:push("Bodypress")
        end
        _ARG_0_.stack:push("SearchDive")
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    AngryBehaviorA = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.stack:clear()
        print("AngryBehaviorA\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.angryTimer <= 0 then
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Surfacing")
          _ARG_0_.stack:push("MoveNear")
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
          return
        end
        if _ARG_0_:IsTargetCenterLand() then
          _ARG_0_.stack:push("AngryBehaviorA")
          if Script.Random() < 0.2 then
            _ARG_0_.stack:push("SearchDive")
            _ARG_0_.stack:push("Search")
            _ARG_0_.stack:push("MoveMiddle")
          end
          if Script.Random() < 0.2 then
            _ARG_0_.stack:push("Dive")
            _ARG_0_.stack:push("SneezeSign")
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveFar")
          elseif Script.Random() >= 0.2 and Script.Random() < 0.4 then
            _ARG_0_.stack:push("FinAttack2")
          elseif Script.Random() >= 0.4 and Script.Random() < 0.7 then
            _ARG_0_.stack:push("Breaching")
          elseif Script.Random() >= 0.7 then
            _ARG_0_.stack:push("RushEnd")
            if Script.Random() < 0.3 then
              _ARG_0_.stack:push("Rush")
              _ARG_0_.stack:push("Drift")
            end
            _ARG_0_.stack:push("Rush")
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveFar")
          end
        else
          _ARG_0_.stack:push("AngryBehaviorA")
          if Script.Random() < 0.2 then
            _ARG_0_.stack:push("SearchDive")
            _ARG_0_.stack:push("Search")
            _ARG_0_.stack:push("MoveMiddle")
          end
          if Script.Random() < 0.2 then
            _ARG_0_.stack:push("Dive")
            _ARG_0_.stack:push("SneezeSign")
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveFar")
          elseif Script.Random() >= 0.2 and Script.Random() < 0.6 then
            _ARG_0_.stack:push("Bodypress")
          elseif Script.Random() >= 0.6 then
            _ARG_0_.stack:push("Dive")
            _ARG_0_.stack:push("Swallow")
          end
        end
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    AngryBehaviorB = {
      OnBeginState = function(_ARG_0_)
        print("AngryBehaviorB\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.stack:push("AngryBehaviorA")
        _ARG_0_.stack:push("SearchDive")
        _ARG_0_.stack:push("Search")
        _ARG_0_.stack:push("MoveMiddle")
        _ARG_0_.stack:push("Dive")
        if Script.Random() < 0.5 then
          _ARG_0_.stack:push("SneezeSign")
        else
          _ARG_0_.stack:push("Inhale")
        end
        _ARG_0_.stack:push("Surfacing")
        _ARG_0_.stack:push("MoveFar")
        _ARG_0_:GotoState(_ARG_0_.stack:pop())
      end
    },
    Turn = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetLocalPos(_UPVALUE1_, _ARG_0_.myHandle)
        _UPVALUE1_:normalize()
        _ARG_0_.theta = Math.Atan2(_UPVALUE1_:getx(), _UPVALUE1_:getz())
        _ARG_0_.targetPos:set(Math.Sin((RoundPI(_ARG_0_.theta + _UPVALUE2_ * _ARG_0_.turnDir))) * _UPVALUE3_, _UPVALUE1_:gety(), Math.Cos((RoundPI(_ARG_0_.theta + _UPVALUE2_ * _ARG_0_.turnDir))) * _UPVALUE3_)
        _ARG_0_.step = 0
        _ARG_0_.step2 = 0
        _ARG_0_.turnHitBarrelCount = 0
        print("Turn\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 5) == false then
            if 0 > _ARG_0_.turnDir then
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            else
              Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            end
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
          _UPVALUE3_:sety(RoundPI(_UPVALUE3_:gety() + _UPVALUE4_ * Entity.GetFrameRate(_ARG_0_.myHandle) * _ARG_0_.turnDir))
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE3_)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 50 then
            Entity.GetLocalPos(_UPVALUE3_, _ARG_0_.myHandle)
            _ARG_0_.theta = Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz())
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_.theta = RoundPI(_ARG_0_.theta + DegToRad(_UPVALUE5_ * Entity.GetFrameRate(_ARG_0_.myHandle) * _ARG_0_.turnDir))
          Entity.GetLocalPos(_UPVALUE3_, _ARG_0_.myHandle)
          _UPVALUE6_:set(Math.Sin(_ARG_0_.theta) * _UPVALUE7_, _UPVALUE3_:gety(), Math.Cos(_ARG_0_.theta) * _UPVALUE7_)
          Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE6_)
          FVECTOR3.Sub(_UPVALUE6_, _UPVALUE6_, _UPVALUE3_)
          if _ARG_0_.step2 == 0 then
            _ARG_0_.step2 = 1
          else
            Entity.GetRot(_UPVALUE3_, _ARG_0_.myHandle)
            Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE6_:getx(), _UPVALUE6_:getz()), 0)
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    Dive = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("Dive\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
          end
        elseif Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    SearchDive = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("SearchDive\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
          end
        elseif Entity.IsModelFade(_ARG_0_.myHandle) == false then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MoveNear = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        if Script.Random() < 0.5 then
          _ARG_0_.turnDir = -1
        else
          _ARG_0_.turnDir = 1
        end
        _UPVALUE3_:set(Math.Sin((RoundPI(Math.Atan2(_UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1]:getx(), _UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1]:getz()) + _UPVALUE2_ * _ARG_0_.turnDir))) * _UPVALUE4_, 0, Math.Cos((RoundPI(Math.Atan2(_UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1]:getx(), _UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1]:getz()) + _UPVALUE2_ * _ARG_0_.turnDir))) * _UPVALUE4_)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE3_, _UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1])
        Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1])
        print("MoveNear\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MoveMiddle = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE3_:set(0, 0, 0)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE3_, _UPVALUE1_[Script.RandomInteger(#_UPVALUE2_) + 1])
        Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE1_[Script.RandomInteger(#_UPVALUE2_) + 1])
        print("MoveMiddle\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    MoveFar = {
      OnBeginState = function(_ARG_0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE3_:set(0, 0, 0)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE3_, _UPVALUE1_[Script.RandomInteger(#_UPVALUE2_) + 1])
        Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE1_[Script.RandomInteger(#_UPVALUE2_) + 1])
        print("MoveFar\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Surfacing = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
        print("Surfacing\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Drift = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        print("Turnabout\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:sety(RoundPI(_UPVALUE0_:gety() + DegToRad(180 / (Entity.GetMotionTotalFrame(_ARG_0_.myHandle) * 2)) * Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.SetRot(_ARG_0_.myHandle, _UPVALUE0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Rush = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE1_), 0)
        _ARG_0_.step = 0
        _ARG_0_.accDmgPoint = 0
        print("Rush\n")
      end,
      OnEndState = function(_ARG_0_)
        Camera.SetPlayerCameraZoom(-1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 28 then
            Camera.SetPlayerCameraZoom(8)
            Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
            _UPVALUE1_:set(0, 0, 0)
            FVECTOR3.Sub(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
            _UPVALUE1_:sety(0)
            _UPVALUE1_:normalize()
            _UPVALUE1_:scale(_UPVALUE2_)
            Entity.SetVelocity(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE3_ / _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    RushEnd = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("RushEnd\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        _ARG_0_.faintFlag = false
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.faintFlag then
            _ARG_0_.stack:clear()
            _ARG_0_.stack:push("Angry")
            _ARG_0_.stack:push("Faint")
            _ARG_0_.stack:push("Surfacing")
            _ARG_0_.stack:push("MoveNear")
          end
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Breaching = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _UPVALUE1_:set(0, 0, 0)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        Camera.SetPlayerCameraZoom(30)
        print("Breaching\n")
      end,
      OnEndState = function(_ARG_0_)
        Camera.SetPlayerCameraZoom(-1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Camera.SetPlayerCameraZoom(-1)
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 2
          end
        elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Swallow = {
      OnBeginState = function(_ARG_0_)
        print("Swallow\n")
        _ARG_0_:EnableNoSetTargetHandle(true)
        Camera.SetPlayerCameraZoom(30)
        _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
        _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
        _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
        for _FORV_7_ = 1, 3 do
          if _ARG_0_.tmpTargetHandles[_FORV_7_] == _ARG_0_.targetHandle then
            _ARG_0_.tmpTargetHandles[1] = _ARG_0_.tmpTargetHandles[_FORV_7_]
            _ARG_0_.tmpTargetHandles[_FORV_7_] = _ARG_0_.tmpTargetHandles[1]
            break
          end
        end
        for _FORV_8_, _FORV_9_ in pairs(_ARG_0_.tmpTargetHandles) do
          if _ARG_0_:CanSwallow(_FORV_9_) then
            _ARG_0_.targetHandle = _FORV_9_
            break
          end
        end
        if true then
          Entity.GetLocalPos(_UPVALUE0_, _ARG_0_.myHandle)
        else
          _UPVALUE0_:set(Math.Sin((Script.RandomInRange(-PI, PI))) * 110, 0, Math.Cos((Script.RandomInRange(-PI, PI))) * 110)
          Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(-_UPVALUE0_:getx(), -_UPVALUE0_:getz()), 0)
        end
        _UPVALUE1_:copy(_UPVALUE0_)
        _UPVALUE0_:sety(5)
        _UPVALUE1_:sety(-5)
        Collision.IntersectRayBg(_UPVALUE0_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
        _ARG_0_.shadowHandle = Entity.CreateEntity("g42vs00", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle)
        Entity.SetModelFixZ(_ARG_0_.shadowHandle, DISPLAYER_3D_OT_START)
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
        Camera.SetPlayerCameraZoom(-1)
        _ARG_0_:EnableNoSetTargetHandle(false)
        Entity.Out(_ARG_0_.shadowHandle)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:IsTargetSwallow() then
          _ARG_0_:GotoState("SwallowSuccess")
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.IsModelFade(_ARG_0_.shadowHandle) == false then
            Entity.SetTimer(_ARG_0_.myHandle, 30)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 3
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    SwallowSuccess = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
        Camera.SetPlayerCameraZoom(30)
        _ARG_0_.step = 0
        _ARG_0_:EnableNoSetTargetHandle(true)
        print("SwallowSuccess\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:TargetSpouting(30)
        _ARG_0_:EnableNoSetTargetHandle(false)
        Camera.SetPlayerCameraZoom(-1)
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:SetNostrilPos(0)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_:SetNostrilPos(10)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 16.5 then
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          _ARG_0_:TargetSpouting(30)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    Bodypress = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Camera.SetPlayerCameraZoom(30)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE1_[Script.RandomInteger(#_UPVALUE1_) + 1])
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.targetHandle)
        _UPVALUE2_:sety(0)
        if _UPVALUE2_:dot(_UPVALUE2_) >= 400 and _UPVALUE2_:dot(_UPVALUE2_) <= 32400 then
          Entity.SetRootMoveScale(_ARG_0_.myHandle, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / _UPVALUE3_, 1, Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) / _UPVALUE3_)
          Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        else
          Entity.SetRootMoveScale(_ARG_0_.myHandle, 0, 1, 0)
          _UPVALUE2_:set(0, 0, 0)
          Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE2_), 0)
        end
        _ARG_0_.step = 0
        _ARG_0_.delay = 0
        _ARG_0_.targetCount = 1
        _ARG_0_.targetHandles[1] = NULL_HANDLE
        _ARG_0_.targetHandles[2] = NULL_HANDLE
        _ARG_0_.targetHandles[3] = NULL_HANDLE
        print("Bodypress\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.SetRootMoveScale(_ARG_0_.myHandle, 1, 1, 1)
        Entity.EnableGravity(_ARG_0_.myHandle, 1)
        Camera.SetPlayerCameraZoom(-1)
      end,
      OnUpdate = function(_ARG_0_)
        _ARG_0_.delay = _ARG_0_.delay - Entity.GetFrameRate(_ARG_0_.myHandle)
        if _ARG_0_.delay <= 0 then
          for _FORV_4_, _FORV_5_ in pairs(_ARG_0_.targetHandles) do
            if _FORV_5_ ~= NULL_HANDLE then
              Entity.GetWorldPos(_UPVALUE0_, _FORV_5_)
              Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
              FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE1_)
              _UPVALUE0_:sety(0)
              _UPVALUE0_:normalize()
              _UPVALUE0_:scale(60)
              _UPVALUE0_:sety(60)
              Player.SetDamage(_FORV_5_, 0, ATK_KIND_DMG_TOSS, "", 0, _UPVALUE0_)
              _ARG_0_.targetHandles[_FORV_4_] = NULL_HANDLE
              _ARG_0_.targetCount = _ARG_0_.targetCount - 1
            end
          end
          _ARG_0_.delay = 0
        end
        if _ARG_0_.step == 0 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 1
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    FinAttack = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:set(Math.Sin((Script.RandomInRange(-PI, PI))) * _UPVALUE1_, _UPVALUE0_:gety(), Math.Cos((Script.RandomInRange(-PI, PI))) * _UPVALUE1_)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        _ARG_0_.step = 0
        print("FinAttack\n")
      end,
      OnEndState = function(_ARG_0_)
        Camera.SetPlayerCameraZoom(-1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Camera.SetPlayerCameraZoom(30)
            _ARG_0_.step = 1
          end
        else
          _UPVALUE1_:set(0, 0, 0)
          _UPVALUE2_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE1_), 0)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            _ARG_0_:GotoState(_ARG_0_.stack:pop())
          end
        end
      end
    },
    FinAttack2 = {
      OnBeginState = function(_ARG_0_)
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
        _UPVALUE0_:set(Math.Sin((Script.RandomInRange(-PI, PI))) * _UPVALUE1_, _UPVALUE0_:gety(), Math.Cos((Script.RandomInRange(-PI, PI))) * _UPVALUE1_)
        Entity.Warp(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        _ARG_0_.step = 0
        print("FinAttack2\n")
      end,
      OnEndState = function(_ARG_0_)
        Camera.SetPlayerCameraZoom(-1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Camera.SetPlayerCameraZoom(30)
            _ARG_0_.step = 1
          end
        else
          _UPVALUE1_:set(0, 0, 0)
          _UPVALUE2_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, _UPVALUE1_), 0)
          Entity.SetRot(_ARG_0_.myHandle, _UPVALUE2_)
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            if Script.Random() < _ARG_0_.finAtkRate then
              _ARG_0_.finAtkRate = _ARG_0_.finAtkRate - _UPVALUE3_
              _ARG_0_:GotoState("FinAttack2")
            else
              _ARG_0_.finAtkRate = _UPVALUE4_
              _ARG_0_:GotoState(_ARG_0_.stack:pop())
            end
          end
        end
      end
    },
    SneezeSign = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("SneezeSign\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 42 then
          _ARG_0_:GotoState("Sneeze")
        end
      end
    },
    Sneeze = {
      OnBeginState = function(_ARG_0_)
        Entity.GetRot(_UPVALUE0_, _ARG_0_.myHandle)
        if RoundPI(Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle) - _UPVALUE0_:gety()) < -DegToRad(30) then
        elseif DegToRad(30) < RoundPI(_UPVALUE0_:gety() - DegToRad(30)) then
        else
        end
        Entity.SetRot(_ARG_0_.myHandle, 0, Entity.CalcDirection(_ARG_0_.myHandle, _ARG_0_.targetHandle), 0)
        print("Sneeze\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState("SneezeEnd")
        end
      end
    },
    SneezeEnd = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("SneezeEnd\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Inhale = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.inhaleRate = 0
        _ARG_0_.inhalePowerSea = 0
        _ARG_0_.inhalePowerGround = 0
        _ARG_0_.step = 0
        _ARG_0_.barrelHitCount = 0
        print("Inhale\n")
      end,
      OnEndState = function(_ARG_0_)
        _ARG_0_:EndInhale()
        Camera.SetPlayerCameraZoom(-1)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:IsTargetSwallow() then
          _ARG_0_:GotoState("SwallowSuccess")
          return
        end
        if _ARG_0_.step == 0 then
          _UPVALUE0_:set(0, 0, 0)
          Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE0_, 5)
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 76 then
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          _ARG_0_.inhalePowerSea = _ARG_0_.inhalePowerSea + _UPVALUE2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.inhalePowerSea >= _UPVALUE3_ then
            _ARG_0_.inhalePowerSea = _UPVALUE3_
          end
          _ARG_0_.inhalePowerGround = _ARG_0_.inhalePowerGround + _UPVALUE2_ * Entity.GetFrameRate(_ARG_0_.myHandle)
          if _ARG_0_.inhalePowerGround >= _UPVALUE4_ then
            _ARG_0_.inhalePowerGround = _UPVALUE4_
          end
          _ARG_0_:InhaleForPlayer((Player.GetHandleForNet()))
          for _FORV_7_, _FORV_8_ in pairs(EntityManager.entities) do
            if Entity.GetName(_FORV_7_) == "g36vs00" and _FORV_8_:CanInhale() then
              Entity.EnableGravity(_FORV_7_, 0)
              Entity.ClearSpeed(_FORV_7_)
              _ARG_0_:InhaleForGimmick(_FORV_7_)
            end
          end
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_:EndInhale()
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_)
            Camera.SetPlayerCameraZoom(30)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.step = 3
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Explode = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        print("Explode\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Faint = {
      OnBeginState = function(_ARG_0_)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 0
        _ARG_0_.angryFlag = true
        Wnd.CreateInfoWnd("vs00400")
        print("Faint\n")
      end,
      OnEndState = function(_ARG_0_)
        Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0, 16)
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0, 16)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_:IsTargetSwallow() then
          _ARG_0_:GotoState("SwallowSuccess")
          return
        end
        if _ARG_0_.step == 0 then
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= 97 then
            Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
            Entity.EnableBodyColl(_ARG_0_.myHandle, 1, 16)
            Entity.EnableDamageColl(_ARG_0_.myHandle, 1, 16)
            _ARG_0_.step = 1
          end
        elseif _ARG_0_.step == 1 then
          if Entity.IsTimeOver(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
            Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
            _ARG_0_.step = 2
          end
        elseif _ARG_0_.step == 2 then
          if Entity.IsMotionEnd(_ARG_0_.myHandle) then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.step = 3
          end
        elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop())
        end
      end
    },
    Event = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_:EnableBodyAndDamageColl(0)
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        Entity.EnableGravity(_ARG_0_.myHandle, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
        Entity.EnableBgColl(_ARG_0_.myHandle, 0)
        Entity.ClearSpeed(_ARG_0_.myHandle)
        Camera.SetPlayerCameraZoom(-1)
        TimeCounter.OutDestroy()
        Mission.SetArenaRoundEnd(Entity.GetHp(_ARG_0_.myHandle))
        print("Event\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    },
    Dead = {
      OnBeginState = function(_ARG_0_)
        SetupBossDead(_ARG_0_.myHandle)
        Entity.SetMotionSpeed(_ARG_0_.myHandle, 0)
        Entity.SetupModelFade(_ARG_0_.myHandle, 0, 1, 1)
        TimeCounter.OutDestroy()
        Camera.SetPlayerCameraZoom(-1)
        _ARG_0_.eventTimerStep = 2
        print("Dead\n")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  CanSwallow = function(_ARG_0_, _ARG_1_)
    if NULL_HANDLE == _ARG_1_ then
      return false
    end
    if Entity.GetHp(_ARG_1_) <= 0 then
      return false
    end
    Entity.GetLocalPos(_UPVALUE0_, _ARG_1_)
    _UPVALUE0_:sety(0)
    if _UPVALUE0_:dot(_UPVALUE0_) < 400 or _UPVALUE0_:dot(_UPVALUE0_) > 32400 then
      return false
    end
    _UPVALUE0_:sety(-0.5)
    for _FORV_7_ = 0, 360, 15 do
      _UPVALUE1_:set(Math.Sin((RoundPI(DegToRad(_FORV_7_)))) * 200, -0.5, Math.Cos((RoundPI(DegToRad(_FORV_7_)))) * 200)
      FVECTOR3.Add(_UPVALUE1_, _UPVALUE1_, _UPVALUE0_)
      Collision.IntersectRayBg(_UPVALUE1_, COLL_KIND_ENEMY, _UPVALUE0_, _UPVALUE1_, _UPVALUE2_, 1)
      FVECTOR3.Sub(_UPVALUE2_, _UPVALUE1_, _UPVALUE0_)
      if 0 < _UPVALUE2_:dot(_UPVALUE2_) then
        _UPVALUE3_:copy(_UPVALUE1_)
      end
    end
    _FOR_.Sub(_UPVALUE2_, _UPVALUE3_, _UPVALUE0_)
    Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
    Entity.SetLocalPos(_ARG_0_.myHandle, _UPVALUE0_)
    return true
  end,
  IsTargetSwallow = function(_ARG_0_)
    _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
    for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.tmpTargetHandles) do
      if Player.IsDamageFlagEat(_FORV_8_) then
        return true
      end
    end
    return false
  end,
  SetNostrilPos = function(_ARG_0_, _ARG_1_)
    _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
    for _FORV_8_, _FORV_9_ in pairs(_ARG_0_.tmpTargetHandles) do
      if Player.IsDamageFlagEat(_FORV_9_) then
        Player.DispOff(_FORV_9_)
        if Player.GetNetworkID(_FORV_9_) == 0 then
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 10)
          _UPVALUE0_:sety(_UPVALUE0_:gety() + _ARG_1_)
          Entity.Warp(_FORV_9_, _UPVALUE0_)
        end
      end
    end
  end,
  TargetSpouting = function(_ARG_0_, _ARG_1_)
    _ARG_0_.tmpTargetHandles[1] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[2] = Player.GetPlayers()
    _ARG_0_.tmpTargetHandles[3] = Player.GetPlayers()
    for _FORV_8_, _FORV_9_ in pairs(_ARG_0_.tmpTargetHandles) do
      Player.DispOn(_FORV_9_)
      if Player.IsDamageFlagEat(_FORV_9_) and Player.GetNetworkID(_FORV_9_) == 0 then
        Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 10)
        _UPVALUE0_:sety(_UPVALUE0_:gety() + 10)
        Entity.Warp(_FORV_9_, _UPVALUE0_)
        _UPVALUE0_:set(0, _ARG_1_, 0)
        Player.SetDamage(_FORV_9_, 0, ATK_KIND_DMG_TOSS, "", 0, _UPVALUE0_)
      end
    end
  end,
  CanInhale = function(_ARG_0_)
    _ARG_0_.inhaleRate = _ARG_0_.inhaleRate + 0.2
    if Script.Random() < _ARG_0_.inhaleRate then
      _ARG_0_.inhaleRate = 1
      return true
    end
    return false
  end,
  InhaleForPlayer = function(_ARG_0_, _ARG_1_)
    for _FORV_7_, _FORV_8_ in pairs(EntityManager.entities) do
      if (Entity.GetName(_FORV_7_) == "m91ex00" or Entity.GetName(_FORV_7_) == "m92ex00" or Entity.GetName(_FORV_7_) == "m93ex00" or Entity.GetName(_FORV_7_) == "m94ex00" or Entity.GetName(_FORV_7_) == "m95ex00") and Player.GetNetworkID(Entity.GetParent(_FORV_7_)) == 0 and Enemy.IsIllusionGroundIn(_FORV_7_) == false then
        break
      end
    end
    if _FORV_7_ == NULL_HANDLE then
      if Player.IsMuteki(_ARG_1_) then
        _UPVALUE0_:set(0, 0, 0)
        Entity.SetForce(_ARG_1_, _UPVALUE0_)
        return false
      end
    else
      _ARG_1_ = _FORV_7_
    end
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 24)
    if Entity.CalcDistanceSq(_ARG_1_, _UPVALUE0_) <= _UPVALUE1_ then
      if Entity.CalcDistanceSq(_ARG_1_, _UPVALUE0_) <= 25 then
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 0)
      else
        Entity.EnableLockonAndShooton(_ARG_0_.myHandle, 1)
      end
      Entity.GetWorldPos(_UPVALUE2_, _ARG_1_)
      _UPVALUE3_:set(1, 0, 0)
      Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "ago", _UPVALUE3_)
      FVECTOR3.Sub(_UPVALUE4_, _UPVALUE2_, _UPVALUE0_)
      _UPVALUE4_:normalize()
      if _UPVALUE4_:dot(_UPVALUE3_) >= Math.Cos(DegToRad(_UPVALUE5_)) then
        if Entity.IsSwim(_ARG_1_) then
        else
        end
        _UPVALUE0_:set(0, -5, 0)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "ago", _UPVALUE0_)
        FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
        _UPVALUE0_:sety(0)
        _UPVALUE0_:normalize()
        _UPVALUE0_:scale(Entity.GetFrameRate(_ARG_0_.myHandle) * _ARG_0_.inhalePowerSea * _ARG_0_.inhalePowerGround)
        Entity.SetForce(_ARG_1_, _UPVALUE0_)
        return true
      end
    end
    return false
  end,
  InhaleForGimmick = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 24)
    if Entity.CalcDistanceSq(_ARG_1_, _UPVALUE0_) <= _UPVALUE1_ then
      Entity.GetWorldPos(_UPVALUE2_, _ARG_1_)
      _UPVALUE3_:set(1, 0, 0)
      Entity.ApplyBoneMatrix33(_ARG_0_.myHandle, "ago", _UPVALUE3_)
      FVECTOR3.Sub(_UPVALUE4_, _UPVALUE2_, _UPVALUE0_)
      _UPVALUE4_:normalize()
      if _UPVALUE4_:dot(_UPVALUE3_) >= Math.Cos(DegToRad(_UPVALUE5_)) then
        _UPVALUE0_:set(0, -5, 0)
        Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "ago", _UPVALUE0_)
        FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
        _UPVALUE0_:normalize()
        _UPVALUE0_:scale(Entity.GetFrameRate(_ARG_0_.myHandle) * _ARG_0_.inhalePowerSea * 2)
        Entity.GetLocalPos(_UPVALUE2_, _ARG_1_)
        FVECTOR3.Add(_UPVALUE2_, _UPVALUE2_, _UPVALUE0_)
        Entity.SetLocalPos(_ARG_1_, _UPVALUE2_)
        return true
      end
    end
    return false
  end,
  EndInhale = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    Entity.SetForce(Player.GetHandleForNet(), _UPVALUE0_)
    for _FORV_6_, _FORV_7_ in pairs(EntityManager.entities) do
      if Entity.GetName(_FORV_6_) == "m91ex00" or Entity.GetName(_FORV_6_) == "m92ex00" or Entity.GetName(_FORV_6_) == "m93ex00" or Entity.GetName(_FORV_6_) == "m94ex00" or Entity.GetName(_FORV_6_) == "m95ex00" then
        Entity.SetForce(_FORV_6_, _UPVALUE0_)
        break
      elseif Entity.GetName(_FORV_6_) == "g36vs00" and _FORV_7_:CanInhale() then
        Entity.EnableGravity(_FORV_6_, 1)
      end
    end
  end,
  CanFaint = function(_ARG_0_)
    if _ARG_0_.angryFlag then
      return false
    end
    if Entity.GetName((Entity.GetAttacker(_ARG_0_.myHandle))) ~= "g36vs00" then
      return false
    end
    if _ARG_0_:GetState() == "Inhale" then
      _ARG_0_.barrelHitCount = _ARG_0_.barrelHitCount + 1
      if _ARG_0_.barrelHitCount >= _UPVALUE0_[_UPVALUE1_()] then
        _ARG_0_.barrelHitCount = 0
        return true
      end
    elseif _ARG_0_:GetState() == "Rush" then
      _ARG_0_.faintFlag = true
      return false
    elseif _ARG_0_:GetState() == "Turn" then
      _ARG_0_.turnHitBarrelCount = _ARG_0_.turnHitBarrelCount + 1
      if _ARG_0_.turnHitBarrelCount >= _UPVALUE2_ then
        return true
      end
    end
    return false
  end,
  CanSneeze = function(_ARG_0_)
    if _ARG_0_.angryFlag then
      return false
    end
    if _ARG_0_:GetState() ~= "Search" and _ARG_0_:GetState() ~= "Turn" then
      return false
    end
    _ARG_0_.accDmgPointForSneeze = _ARG_0_.accDmgPointForSneeze + Entity.GetDamagePoint(_ARG_0_.myHandle)
    if _ARG_0_.accDmgPointForSneeze >= _UPVALUE0_ then
      return true
    end
    return false
  end,
  GotoStateSneeze = function(_ARG_0_)
    _ARG_0_.stack:push("Surfacing")
    _ARG_0_.stack:push("MoveNear")
    _ARG_0_.stack:push("Dive")
    _ARG_0_.stack:push("SneezeSign")
    _ARG_0_.stack:push("Surfacing")
    _ARG_0_.stack:push("MoveFar")
    _ARG_0_.stack:push("Dive")
  end,
  CreateWave = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
    if _ARG_4_ == nil then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      Entity.GetRot(_UPVALUE1_, _ARG_0_.myHandle)
    else
      _UPVALUE0_:set(0, 0, 0)
      _UPVALUE1_:set(0, 0, 0)
    end
    _UPVALUE1_:sety(RoundPI(_UPVALUE1_:gety() + DegToRad(_ARG_3_)))
    if EntityManager:GetEntity((Entity.CreateEntity(_ARG_1_, _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))) ~= nil then
      EntityManager:GetEntity((Entity.CreateEntity(_ARG_1_, _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))):Setup(_ARG_2_)
    end
    if _ARG_4_ ~= nil then
      Entity.AttachCoord(_ARG_4_, "Root", Entity.CreateEntity(_ARG_1_, _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle), "Root")
    end
    return (Entity.CreateEntity(_ARG_1_, _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle))
  end,
  EnableBodyAndDamageColl = function(_ARG_0_, _ARG_1_)
    Entity.EnableLockonAndShooton(_ARG_0_.myHandle, _ARG_1_)
    Entity.EnableBodyColl(_ARG_0_.myHandle, _ARG_1_)
    Entity.EnableDamageColl(_ARG_0_.myHandle, _ARG_1_)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 0, 16)
    Entity.EnableDamageColl(_ARG_0_.myHandle, 0, 16)
  end,
  IsExistLand = function(_ARG_0_)
    for _FORV_5_, _FORV_6_ in pairs(EntityManager.entities) do
      if (Entity.GetName(_FORV_5_) == "g28vs00" or Entity.GetName(_FORV_5_) == "g29vs00") and _FORV_6_:CanDestroy() == false then
        return true
      end
    end
    return false
  end,
  IsTargetCenterLand = function(_ARG_0_)
    _UPVALUE0_:set(0, 0, 0)
    if Entity.CalcDistanceXZSq(_ARG_0_.targetHandle, _UPVALUE0_) <= _UPVALUE1_ then
      return true
    end
    return false
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_ = Entity.GetMotionIndex(_ARG_1_, "001")
    _UPVALUE1_ = Entity.GetMotionIndex(_ARG_1_, "010")
    _UPVALUE2_ = Entity.GetMotionIndex(_ARG_1_, "020")
    _UPVALUE3_ = Entity.GetMotionIndex(_ARG_1_, "011")
    _UPVALUE4_ = Entity.GetMotionIndex(_ARG_1_, "021")
    _UPVALUE5_ = Entity.GetMotionIndex(_ARG_1_, "012")
    _UPVALUE6_ = Entity.GetMotionIndex(_ARG_1_, "030")
    _UPVALUE7_ = Entity.GetMotionIndex(_ARG_1_, "031")
    _UPVALUE8_ = Entity.GetMotionIndex(_ARG_1_, "040")
    _UPVALUE9_ = Entity.GetMotionIndex(_ARG_1_, "050")
    _UPVALUE10_ = Entity.GetMotionIndex(_ARG_1_, "060")
    _UPVALUE11_ = Entity.GetMotionIndex(_ARG_1_, "070")
    _UPVALUE12_ = Entity.GetMotionIndex(_ARG_1_, "200")
    _UPVALUE13_ = Entity.GetMotionIndex(_ARG_1_, "230")
    _UPVALUE14_ = Entity.GetMotionIndex(_ARG_1_, "231")
    _UPVALUE15_ = Entity.GetMotionIndex(_ARG_1_, "300")
    _UPVALUE16_ = Entity.GetMotionIndex(_ARG_1_, "301")
    _UPVALUE17_ = Entity.GetMotionIndex(_ARG_1_, "310")
    _UPVALUE18_ = Entity.GetMotionIndex(_ARG_1_, "311")
    _UPVALUE19_ = Entity.GetMotionIndex(_ARG_1_, "312")
    _UPVALUE20_ = Entity.GetMotionIndex(_ARG_1_, "320")
    _UPVALUE21_ = Entity.GetMotionIndex(_ARG_1_, "330")
    _UPVALUE22_ = Entity.GetMotionIndex(_ARG_1_, "340")
    _UPVALUE23_ = Entity.GetMotionIndex(_ARG_1_, "350")
    _UPVALUE24_ = Entity.GetMotionIndex(_ARG_1_, "351")
    _UPVALUE25_ = Entity.GetMotionIndex(_ARG_1_, "400")
    _UPVALUE26_ = Entity.GetMotionIndex(_ARG_1_, "410")
    _UPVALUE27_ = Entity.GetMotionIndex(_ARG_1_, "411")
    _UPVALUE28_ = Enemy.GetExtraParam(_ARG_1_, "IDLING_TIME") * 60
    _UPVALUE29_ = Enemy.GetExtraParam(_ARG_1_, "SEARCH_TIME") * 60
    _UPVALUE30_ = Enemy.GetExtraParam(_ARG_1_, "TURN_TIME") * 60
    _UPVALUE31_ = Enemy.GetExtraParam(_ARG_1_, "INHALE_SEA")
    _UPVALUE32_ = Enemy.GetExtraParam(_ARG_1_, "INHALE_GD")
    _UPVALUE33_ = Enemy.GetExtraParam(_ARG_1_, "INHALE_TIME") * 60
    _UPVALUE34_ = Enemy.GetExtraParam(_ARG_1_, "ROUND_TIME") * 60
    _UPVALUE35_ = Enemy.GetExtraParam(_ARG_1_, "FAINT_TIME") * 60
    _UPVALUE36_ = Enemy.GetExtraParam(_ARG_1_, "TSUNAMI_SPD")
    _UPVALUE37_ = Enemy.GetExtraParam(_ARG_1_, "TSUNAMI_TM") * 60
    _UPVALUE38_ = Enemy.GetExtraParam(_ARG_1_, "ANGRY_DMG_P")
    _UPVALUE39_ = Enemy.GetExtraParam(_ARG_1_, "ANGRY_TIME") * 60
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.shadowHandle = NULL_HANDLE
    _ARG_0_.targetHandles = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.tmpTargetHandles = {
      NULL_HANDLE,
      NULL_HANDLE,
      NULL_HANDLE
    }
    _ARG_0_.targetCount = 1
    _ARG_0_.step = 0
    _ARG_0_.step2 = 0
    _ARG_0_.theta = 0
    _ARG_0_.eventTimerStep = 0
    _ARG_0_.accDmgPoint = 0
    _ARG_0_.accDmgPointForSneeze = 0
    _ARG_0_.inhaleRate = 0
    _ARG_0_.turnDir = -1
    _ARG_0_.hitBarrelCount = 0
    _ARG_0_.turnHitBarrelCount = 0
    _ARG_0_.inhalePowerSea = 0
    _ARG_0_.inhalePowerGround = 0
    _ARG_0_.angryTimer = 0
    _ARG_0_.atkAngryTimer = _UPVALUE40_
    _ARG_0_.atkHitAngryDmgPoint = 0
    _ARG_0_.barrelHitCount = 0
    _ARG_0_.finAtkRate = _UPVALUE41_
    _ARG_0_.count = 0
    _ARG_0_.roty = 0
    _ARG_0_.delay = 0
    _ARG_0_.faintFlag = false
    _ARG_0_.angryFlag = false
    _ARG_0_.motTrgPtr = 1
    _ARG_0_.motTrg = nil
    _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
    _ARG_0_.stack = Stack:Create()
    Entity.SetMovementCollRadius(_ARG_1_, 5)
    Entity.SetLowerHalf(_ARG_1_, 7.5)
    Entity.EnableGravity(_ARG_1_, 1)
    Entity.EnableCameraBodyColl(_ARG_1_, 1)
    Entity.SetModelFixZ(_ARG_1_, DISPLAYER_3D_OT_START)
    Entity.SetLockLimitSq(_ARG_1_, 2500)
    if 0 < Mission.GetBossHp() then
      Enemy.SetHP(_ARG_1_, (Mission.GetBossHp()))
    end
    if Enemy.IsAllEnemyWaiting() == false then
      _UPVALUE42_:set(0, 0, _UPVALUE43_)
      Entity.Warp(_ARG_1_, _UPVALUE42_)
    end
    Entity.SetMotion(_ARG_1_, _UPVALUE0_)
    Entity.InitRideCollision(_ARG_1_, "b83vs0a", 24)
    Entity.EnableRideColl(_ARG_1_, 0, 0)
    Player.SetBossCamera("b83vs")
    _UPVALUE42_:set(0, 1, 0)
    _UPVALUE44_:set(0, 0, 0)
    Entity.CreateEntity("g36vs00", _UPVALUE42_, _UPVALUE44_)
    if Script.GetDebugTestParam() >= 10 then
      _UPVALUE34_ = 1800
    end
    _ARG_0_:GotoState("Appear")
  end,
  OnDestroy = function(_ARG_0_)
    if Player.IsDamageFlagEat((Player.GetHandleForNet())) then
      Player.SetTrgFlagCancel(Player.GetHandleForNet(), 1)
    end
    TimeCounter.OutDestroy()
  end,
  OnSetMotion = function(_ARG_0_, _ARG_1_)
    _ARG_0_.motTrg = _UPVALUE0_[Entity.GetMotionName(_ARG_0_.myHandle, _ARG_1_)]
    _ARG_0_.motTrgPtr = 1
  end,
  OnHitBody = function(_ARG_0_)
    return 1
  end,
  OnHitAttack = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE0_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE1_ or Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE2_ then
      Player.SetDamage(_ARG_1_, _ARG_2_, ATK_KIND_EAT)
    elseif Entity.GetCurrentMotion(_ARG_0_.myHandle) == _UPVALUE3_ and Player.GetNetworkID(_ARG_1_) == 0 then
      _ARG_0_.targetHandles[_ARG_0_.targetCount] = _ARG_1_
      _ARG_0_.targetCount = _ARG_0_.targetCount + 1
      _ARG_0_.delay = 4
    end
  end,
  OnDamageBefore = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if Entity.GetDamageCommandKind(_ARG_0_.myHandle) == COMMAND_KIND_ReflectRaid then
      Entity.SetDamagePoint(_ARG_0_.myHandle, 1)
    end
    return 0
  end,
  OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
    if _ARG_0_:GetState() == "Event" then
      return 1
    end
    if _ARG_0_.angryFlag == false then
      _ARG_0_.atkHitAngryDmgPoint = _ARG_0_.atkHitAngryDmgPoint + Entity.GetDamagePoint(_ARG_0_.myHandle)
      if _ARG_0_.atkHitAngryDmgPoint >= _UPVALUE0_ then
        _ARG_0_.angryFlag = true
        _ARG_0_.atkHitAngryDmgPoint = 0
      end
    end
    if _ARG_0_:CanSneeze() then
      _ARG_0_:GotoStateSneeze()
      _ARG_0_:GotoState(_ARG_0_.stack:pop())
      return 1
    end
    if _ARG_0_:CanFaint() then
      _ARG_0_.stack:clear()
      if _ARG_0_.angryFlag then
        _ARG_0_.stack:push("AngryBehaviorA")
        _ARG_0_.stack:push("SearchDive")
        _ARG_0_.stack:push("Search")
        _ARG_0_.stack:push("MoveMiddle")
        _ARG_0_.stack:push("Dive")
      else
        _ARG_0_.stack:push("Angry")
      end
      _ARG_0_.stack:push("Faint")
      if _ARG_0_:GetState() == "Inhale" then
        _ARG_0_.stack:push("Explode")
      end
      _ARG_0_:GotoState(_ARG_0_.stack:pop())
      return 1
    end
    return 1
  end,
  OnDead = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_:GotoStateSub("Dead")
    return 1
  end,
  OnReturnDamage = function(_ARG_0_)
    _ARG_0_.stack:clear()
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Surfacing")
    _ARG_0_.stack:push("MoveNear")
    _ARG_0_:GotoState("Dive")
  end,
  OnUpdateLast = function(_ARG_0_)
    _ARG_0_.atkAngryTimer = _ARG_0_.atkAngryTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.atkAngryTimer <= 0 then
      _ARG_0_.atkHitAngryDmgPoint = 0
      _ARG_0_.atkAngryTimer = _UPVALUE0_
    end
    if 0 < _ARG_0_.angryTimer then
      _ARG_0_.angryTimer = _ARG_0_.angryTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
      if 0 >= _ARG_0_.angryTimer then
        _ARG_0_.angryFlag = false
      end
    end
    if _ARG_0_.eventTimerStep == 1 and (0 >= Script.GetDebugTestParam() or Script.GetDebugTestParam() >= 10) and TimeCounter.IsTimeEnd() then
      _ARG_0_.stack:clear()
      _ARG_0_:GotoStateSub("Event")
      _ARG_0_.eventTimerStep = 2
    end
    if Script.IsDebugEntityNum() then
      debugPrint(0, 160, "Lua = " .. EntityManager:GetSize() .. ", CurrentFrame = " .. Entity.GetMotionNowFrame(_ARG_0_.myHandle) .. "")
    end
    if _ARG_0_:GetState() == "Dead" then
      return
    end
    if _ARG_0_.motTrg ~= nil then
      if _ARG_0_.motTrg[_ARG_0_.motTrgPtr] ~= nil then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) >= _ARG_0_.motTrg[_ARG_0_.motTrgPtr].frame then
          _ARG_0_.motTrg[_ARG_0_.motTrgPtr].func(_ARG_0_)
          _ARG_0_.motTrgPtr = _ARG_0_.motTrgPtr + 1
        end
      else
        for _FORV_7_, _FORV_8_ in pairs(_ARG_0_.motTrg) do
          if Entity.GetMotionNowFrame(_ARG_0_.myHandle) <= _FORV_8_.frame then
            _ARG_0_.motTrgPtr = _FORV_7_
            break
          end
        end
      end
    end
  end,
  GetLockOnPos = function(_ARG_0_)
    if Entity.IsUserPermissionLockOn(_ARG_0_.myHandle) == false then
      _UPVALUE0_:set(0, 3, 0)
      return _UPVALUE0_
    end
    if _ARG_0_:GetState() ~= "Faint" then
      Entity.GetWorldPos(_UPVALUE0_, Player.GetHandleForNet())
      for _FORV_6_, _FORV_7_ in pairs(_UPVALUE1_) do
        Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, _FORV_7_)
        FVECTOR3.Sub(_UPVALUE3_, _UPVALUE2_, _UPVALUE0_)
        if 100000000 > _UPVALUE3_:dot(_UPVALUE3_) then
          _UPVALUE4_:copy(_UPVALUE2_)
        end
      end
      return _UPVALUE4_
    else
      _UPVALUE0_:set(0, 0, 0)
      Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "shita3", _UPVALUE0_)
      return _UPVALUE0_
    end
  end,
  GetCameraTargetPos = function(_ARG_0_)
    return _ARG_0_:GetLockOnPos()
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
    _ARG_0_:Debug()
  end,
  Debug = function(_ARG_0_)
    if Script.IsDebugCheckAttack() then
      for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
        if _FORV_6_ == _ARG_0_:GetState() then
          return
        end
      end
      if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
        Entity.SetAlpha(_ARG_0_.myHandle, 1)
        _ARG_0_:EnableBodyAndDamageColl(1)
        if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] == "Inhale" or _UPVALUE0_[Script.GetDebugAttackNumber() + 1] == "SneezeSign" then
          pos = _UPVALUE1_[Script.RandomInteger(#_UPVALUE2_) + 1]
          _UPVALUE3_:set(0, 0, 0)
          FVECTOR3.Sub(_UPVALUE3_, _UPVALUE3_, pos)
          Entity.SetRot(_ARG_0_.myHandle, 0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
          Entity.SetLocalPos(_ARG_0_.myHandle, pos)
          Entity.SetOldLocalPos(_ARG_0_.myHandle, pos)
        end
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
        _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
      end
    end
  end
}, {__index = __StateMachine})
EntityFactory:Add("b83vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g43vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g45vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g46vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g44vs00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
