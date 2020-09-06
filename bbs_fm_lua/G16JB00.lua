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
      end
    },
    Waiting = {
      OnBeginState = function(_ARG_0_)
        print("Waiting\n")
        _ARG_0_.effectTimaer = 80
        _ARG_0_.effectStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.effectStep == 0 then
          _ARG_0_.effectTimaer = _ARG_0_.effectTimaer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
          print("self.effectTimaer = " .. _ARG_0_.effectTimaer .. "\n")
          if 0 > _ARG_0_.effectTimaer then
            _ARG_0_.effectStep = 1
          end
        end
        if Enemy.IsAllEnemyWaiting() == false then
          _ARG_0_:GotoState("Idling")
        end
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("Idling\n")
        _ARG_0_.step = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          if Enemy.IsAllEnemyWaiting() == false then
            for _FORV_7_, _FORV_8_ in pairs(EntityManager.entities) do
            end
            if -1 + 1 < _ARG_0_.maxSummonNumber then
              _ARG_0_:CreateSoldier(-1 + 1)
              _ARG_0_.summonCnt = _ARG_0_.summonCnt + 1
              _ARG_0_.step = 1
              print("\144\182\144\172 = " .. _ARG_0_.summonCnt .. "\n")
              _ARG_0_.summonTimer = _ARG_0_.summonWait
            end
            return
          end
        elseif _ARG_0_.step == 1 then
          if 0 > _ARG_0_.summonTimer then
            _ARG_0_.step = 0
            if _ARG_0_.summonCnt >= _ARG_0_.clearNumber then
              _ARG_0_.step = 2
            end
          end
        elseif _ARG_0_.step == 2 and _ARG_0_:IsSoldierAlive() == true then
          print("\131~\131b\131V\131\135\131\147\131R\131\147\131v\131\138\129[\131g\129I\129I\129I\n")
          Mission.CompleteMission()
          _ARG_0_.step = 99
        end
        _ARG_0_.summonTimer = _ARG_0_.summonTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      end
    },
    Mission = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 0, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 11, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 12, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 13, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 4, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 6, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 8, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 10, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 15, 1)
        Entity.EnableModelDisp(_ARG_0_.myHandle, 17, 1)
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
    },
    EventState = {
      OnBeginState = function(_ARG_0_)
        print("EventState\n")
        _ARG_0_:StartCamera()
        Player.NotifyEventStart(_ARG_0_.targetHandle)
        Entity.SetTimer(_ARG_0_.myHandle, 60)
        _ARG_0_.step = 0
        Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
        Gimmick.WriteNoClearFlag(_ARG_0_.myHandle)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
          print("\131G\131t\131F\131N\131g\144\182\144\172\n")
          Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
          _UPVALUE1_:set(0, 0, 0)
          Entity.SetEffect(_ARG_0_.myHandle, "g_jb_016", "G_JB_016_END_0", _UPVALUE0_, _UPVALUE1_)
          _ARG_0_.step = 1
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
        end
        if Player.IsBattleFlagPlayerDead() == true and _ARG_0_.camera ~= NULL_HANDLE then
          Script.OutTask(_ARG_0_.camera)
          _ARG_0_.camera = NULL_HANDLE
          _ARG_0_.cameraStep = 0
          _ARG_0_.cameraStep = 1
          _ARG_0_.cameraFlag = 0
          Player.NotifyEventEnd(Player.GetHandle())
          Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET, OBJ_BIT_GIMMICK)
          Script.EnablePauseChecker()
        end
        if _ARG_0_.cameraFlag == 1 and _ARG_0_.cameraStep == 0 and Camera.IsEndExusiaCamera(_ARG_0_.camera) then
          print("\131J\131\129\131\137\141\237\143\156\143\136\151\157\n")
          Script.OutTask(_ARG_0_.camera)
          _ARG_0_.camera = NULL_HANDLE
          _ARG_0_.cameraStep = 1
          _ARG_0_.cameraFlag = 0
          Player.NotifyEventEnd(Player.GetHandle())
          Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET, OBJ_BIT_GIMMICK)
          Script.EnablePauseChecker()
          Player.NotifyEventEnd(_ARG_0_.targetHandle)
        end
      end
    },
    EndState = {
      OnBeginState = function(_ARG_0_)
        Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
        for _FORV_4_ = 0, 30 do
          Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_4_, 0)
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
      end
    }
  },
  crateEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, 2)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_016", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  StartCamera = function(_ARG_0_)
    _ARG_0_.camera = Camera.CreateExusiaCamera("ms_clear")
    Camera.StartExusiaCamera(_ARG_0_.camera)
    Player.NotifyEventStart(Player.GetHandle())
    Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET, OBJ_BIT_GIMMICK)
    _ARG_0_.cameraFlag = 1
    Script.DisablePauseChecker()
  end,
  CreateSoldier = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(18.5, -1, -32)
    _UPVALUE0_:setx(_UPVALUE0_:getx() + 9 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE0_:setz(_UPVALUE0_:getz() + 9 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE1_:set(0, 0, 0)
    if Script.Random() < 0.8 then
      _ARG_0_.soldierHandle[_ARG_1_].handle = Entity.CreateEntity("m40ex00", _UPVALUE0_, _UPVALUE1_)
    else
      _ARG_0_.soldierHandle[_ARG_1_].handle = Entity.CreateEntity("m41ex00", _UPVALUE0_, _UPVALUE1_)
    end
    _UPVALUE0_:set(18.5, -3.5, -33)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.soldierHandle[_ARG_1_].handle, 1)
    FVECTOR3.Sub(_UPVALUE3_, _UPVALUE0_, _UPVALUE2_)
    FVECTOR3.normalize(_UPVALUE3_)
    _UPVALUE1_:set(0, Math.Atan2(_UPVALUE3_:getx(), _UPVALUE3_:getz()), 0)
    Entity.SetRot(_ARG_0_.soldierHandle[_ARG_1_].handle, _UPVALUE1_)
    _UPVALUE0_:set(0, 1, 1)
    _UPVALUE0_:scale(_UPVALUE4_)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE1_)
    Entity.SetVelocity(_ARG_0_.soldierHandle[_ARG_1_].handle, _UPVALUE0_)
    Entity.EnableGravity(_ARG_0_.soldierHandle[_ARG_1_].handle, 1)
    EntityManager:GetEntity(_ARG_0_.soldierHandle[_ARG_1_].handle):GotoState("Fly")
  end,
  GetSoldierNoAliveId = function(_ARG_0_)
    for _FORV_4_ = 0, _ARG_0_.maxSummonNumber - 1 do
      if Entity.IsAlive(_ARG_0_.soldierHandle[_FORV_4_].handle) == false then
        return id
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
  OnInit = function(_ARG_0_, _ARG_1_)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.startPosFlag = 0
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraStep = 0
    _ARG_0_.effecgtHandle = NULL_HANDLE
    _ARG_0_.effectTimaer = 0
    _ARG_0_.effectStep = 0
    _ARG_0_.maxSummonNumber = 15
    _ARG_0_.summonWait = 1
    _ARG_0_.clearNumber = 100
    _ARG_0_.maxSummonNumber = Entity.GetLayoutParam(_ARG_1_, 1)
    if _ARG_0_.maxSummonNumber == 0 then
      _ARG_0_.maxSummonNumber = 15
    end
    print("maxSummonNumber = " .. _ARG_0_.maxSummonNumber .. "\n")
    _ARG_0_.maxSummonNumber = _ARG_0_.maxSummonNumber - 1
    _ARG_0_.summonWait = Entity.GetLayoutParam(_ARG_1_, 2)
    if _ARG_0_.summonWait == 0 then
      _ARG_0_.summonWait = 10
    end
    print("summonWait = " .. _ARG_0_.summonWait .. "\n")
    _ARG_0_.clearNumber = Entity.GetLayoutParam(_ARG_1_, 3)
    if _ARG_0_.clearNumber == 0 then
      _ARG_0_.clearNumber = 100
    end
    print("clearNumber = " .. _ARG_0_.clearNumber .. "\n")
    Entity.EnableBgColl(_ARG_0_.myHandle, 0)
    M10SB_TYPE_RND = Entity.GetLayoutParam(_ARG_1_, 5) * 0.01
    if M10SB_TYPE_RND == 0 then
      M10SB_TYPE_RND = 0.5
    end
    print("summonWait = " .. M10SB_TYPE_RND .. "\n")
    M10SB_POS_RND = Entity.GetLayoutParam(_ARG_1_, 6) * 0.01
    if M10SB_POS_RND == 0 then
      M10SB_POS_RND = 0.5
    end
    print("summonWait = " .. M10SB_POS_RND .. "\n")
    _ARG_0_.summonTimer = 0
    _ARG_0_.summonCnt = 0
    _ARG_0_.soldierHandle = {}
    for _FORV_5_ = 0, _ARG_0_.maxSummonNumber do
      _ARG_0_.soldierHandle[_FORV_5_] = {handle = NULL_HANDLE}
    end
    _ARG_0_.uniqueID = _FOR_.GetLayoutParam(_ARG_1_, 9)
    if _ARG_0_.uniqueID == 100 then
      Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
      for _FORV_5_ = 0, 30 do
        Entity.EnableModelDisp(_ARG_1_, _FORV_5_, 0)
      end
    else
      for _FORV_5_ = 0, 30 do
        Entity.EnableModelDisp(_ARG_1_, _FORV_5_, 0)
      end
      _FOR_.EnableModelDisp(_ARG_0_.myHandle, 0, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 1, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 2, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 11, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 12, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 13, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 3, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 5, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 7, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 9, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 14, 1)
      Entity.EnableModelDisp(_ARG_0_.myHandle, 16, 1)
    end
    if _ARG_0_.uniqueID == 101 then
      if Gimmick.IsNoClearFlag(_ARG_0_.myHandle) == false then
        _ARG_0_:GotoState("EventState")
      else
        _ARG_0_:GotoState("EndState")
      end
      return
    end
    if Enemy.IsAllEnemyWaiting() then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("Appear")
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
  end
}, {__index = __StateMachine})
EntityFactory:Add("g16jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
