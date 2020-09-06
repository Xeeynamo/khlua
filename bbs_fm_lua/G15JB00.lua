B15EX_CAMERA_FLAG = 0
B15EX_HANDLE_1 = 0
B15EX_ENEMY_TABLE = {}
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
        _ARG_0_:GotoState("Idling")
      end
    },
    Idling = {
      OnBeginState = function(_ARG_0_)
        print("Idling\n")
        _ARG_0_.step = 0
        print("flag = " .. Gimmick.IsDestroyedGroup(0) .. "\n")
        print("max = " .. Gimmick.IsDestroyedGroup(0) .. "\n")
        print("dnow = " .. Gimmick.IsDestroyedGroup(0) .. "\n")
        if Gimmick.IsDestroyedGroup(0) >= Gimmick.IsDestroyedGroup(0) / _UPVALUE0_ then
          print("\130\183\130\197\130\201\137\243\150\197\146\134\n")
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 50)
          Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
          _ARG_0_.step = 4
          print("Step = " .. _ARG_0_.step .. "\n")
          Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
        elseif Gimmick.IsDestroyedGroup(0) >= Gimmick.IsDestroyedGroup(0) / _UPVALUE1_ then
          print("\130\183\130\197\130\2012\146i\138K\150\218\n")
          _ARG_0_:crateFastEffect("G_JB_015_LT1_0")
          _ARG_0_:crateSecondEffect("G_JB_015_LT2_0")
          _ARG_0_.step = 2
        elseif Gimmick.IsDestroyedGroup(0) >= Gimmick.IsDestroyedGroup(0) / _UPVALUE2_ then
          print("\130\183\130\197\130\2011\146i\138K\150\218\n")
          _ARG_0_:crateFastEffect("G_JB_015_LT1_0")
          _ARG_0_.step = 1
        end
        print("Step = " .. _ARG_0_.step .. "\n")
        _ARG_0_.targetHandle = Player.GetHandle()
        _ARG_0_.workStep = 0
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if Player.IsBattleFlagPlayerDead() == true and _ARG_0_.camera ~= NULL_HANDLE then
          Script.OutTask(_ARG_0_.camera)
          _ARG_0_.camera = NULL_HANDLE
          _ARG_0_.cameraStep = 0
          _ARG_0_.cameraStep = 1
          _ARG_0_.cameraFlag = 0
          Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
          Script.SetSceneColor(1, 1, 1, 1, 1, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
          Script.EnablePauseChecker()
        end
        if _ARG_0_.cameraFlag == 1 then
          debugPrint(0, 30, "createEffectTimer     = " .. _ARG_0_.createEffectTimer .. "\n")
          _ARG_0_.createEffectTimer = _ARG_0_.createEffectTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.createEffectTimer then
            if _ARG_0_.step == 1 then
              _ARG_0_:crateFastEffect("G_JB_015_LT1_0")
              _ARG_0_:crateFastEffect2("G_JB_015_FLS_0")
            elseif _ARG_0_.step == 3 then
            elseif _ARG_0_.step == 4 then
              _ARG_0_:crateEndEffect("G_JB_015_DSP_0")
              _ARG_0_:crateFinalEffect("G_JB_015_LT3_0")
              _ARG_0_:loopEndEffect(_ARG_0_.effecgtFastHandle)
              _ARG_0_:loopEndEffect(_ARG_0_.effecgtSecondHandle)
              _ARG_0_:loopEndEffect(_ARG_0_.effecgtFinalHandle)
              _ARG_0_.step = 5
              _ARG_0_.createEffectTimer = _UPVALUE0_
            elseif _ARG_0_.step == 5 then
              Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
              Entity.SetAlpha(_ARG_0_.myHandle, _ARG_0_.alphaColor)
              _ARG_0_.alphaColor = _ARG_0_.alphaColor - 0.05 * Entity.GetFrameRate(_ARG_0_.myHandle)
              if 0 > _ARG_0_.alphaColor then
                _ARG_0_.alphaColor = 0
              end
            end
          end
          if _ARG_0_.cameraStep == 0 then
            if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
              print("\131J\131\129\131\137\141\237\143\156\143\136\151\157\n")
              Script.OutTask(_ARG_0_.camera)
              _ARG_0_.camera = NULL_HANDLE
              _ARG_0_.cameraStep = 1
              _ARG_0_.cameraFlag = 0
              Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_BULLET)
              Script.SetSceneColor(1, 1, 1, 1, 1, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
              Script.EnablePauseChecker()
            end
          elseif _ARG_0_.cameraStep == 1 and Camera.IsEndExusiaCamera(_ARG_0_.camera) then
            print("\131J\131\129\131\137\141\237\143\156\143\136\151\157\n")
            Script.OutTask(_ARG_0_.camera)
            _ARG_0_.camera = NULL_HANDLE
            _ARG_0_.cameraStep = 2
            _ARG_0_.cameraFlag = 0
            Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_BULLET)
            Script.SetSceneColor(1, 1, 1, 1, 1, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
            Script.EnablePauseChecker()
          end
        end
        if _ARG_0_.step == 4 or _ARG_0_.step == 5 then
          return
        end
        for _FORV_8_, _FORV_9_ in pairs(EntityManager.entities) do
          if Enemy.IsDead(_FORV_8_) == 1 then
            _ARG_0_:crateDeadGroupEffect("G_JB_015_RCT_0")
            if _ARG_0_.fastStep == 0 then
              _ARG_0_.fastStep = 1
            end
          end
        end
        if _ARG_0_.step == 0 then
          if _ARG_0_.workStep == 0 then
            if Gimmick.IsDestroyedGroup(0) >= Gimmick.IsDestroyedGroup(0) / _UPVALUE1_ then
              Entity.SetTimer(_ARG_0_.myHandle, 40)
              _ARG_0_.workStep = 1
            end
          elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
            _ARG_0_.step = 1
            _ARG_0_:StartCamera(0)
            _ARG_0_.createEffectTimer = _UPVALUE2_
            _ARG_0_.workStep = 0
            print("Step = " .. _ARG_0_.step .. "\n")
          end
        elseif _ARG_0_.step == 1 then
          if Gimmick.IsDestroyedGroup(0) >= Gimmick.IsDestroyedGroup(0) / _UPVALUE3_ then
            _ARG_0_:crateSecondEffect("G_JB_015_LT2_0")
            _ARG_0_.step = 2
            print("Step = " .. _ARG_0_.step .. "\n")
          end
        elseif _ARG_0_.step == 2 then
          if _ARG_0_.workStep == 0 then
            if Gimmick.IsDestroyedGroup(0) >= Gimmick.IsDestroyedGroup(0) / _UPVALUE4_ then
              Entity.SetTimer(_ARG_0_.myHandle, 40)
              _ARG_0_.workStep = 1
            end
          else
            _ARG_0_.createEffectTimer = _UPVALUE5_
            _ARG_0_.step = 3
            _ARG_0_:StartCamera(1)
            _ARG_0_.workStep = 0
            print("Step = " .. _ARG_0_.step .. "\n")
          end
        elseif _ARG_0_.step == 3 then
          _ARG_0_.step = 4
          print("Step = " .. _ARG_0_.step .. "\n")
          Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
          Gimmick.EnableTriggerBox(1, 50)
        elseif _ARG_0_.step == 4 then
        end
      end
    },
    EndIdling = {
      OnBeginState = function(_ARG_0_)
        print("EndIdling\n")
        _ARG_0_.step = 0
        Gimmick.EnableTriggerBox(1, 50)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          Gimmick.IsMiasmaGimmickFlag(0)
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, 1)
          Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
          Gimmick.IsMiasmaGimmickFlag(0)
          Entity.SetupModelFade(_ARG_0_.myHandle, 0, 0, 1)
          Entity.EnableRideColl(_ARG_0_.myHandle, 0, 0)
          _ARG_0_.step = 2
        end
      end
    }
  },
  StartCamera = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.camera == NULL_HANDLE then
      if _ARG_1_ == 1 then
        _ARG_0_.camera = Camera.CreateExusiaCamera("fieldcam01")
      else
        _ARG_0_.camera = Camera.CreateExusiaCamera("fieldcam02")
      end
      Camera.StartExusiaCamera(_ARG_0_.camera)
      Script.SetObjStop(OBJ_BIT_PLAYER, OBJ_BIT_BULLET)
      Script.SetSceneColor(1, 1, 1, 1, 0, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
      _ARG_0_.cameraFlag = 1
      Script.DisablePauseChecker()
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    Gimmick.IsMiasmaGimmickFlag(0)
    Gimmick.EnableTriggerBox(0, 50)
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.stepColor = 0
    _ARG_0_.timerColor = 0
    _ARG_0_.alphaColor = 1
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraStep = 0
    _ARG_0_.fastStep = 0
    _ARG_0_.finalStep = 0
    _ARG_0_.createEffectTimer = 0
    _ARG_0_.nagorihandle = Gimmick.SearchGimmick("g16jb00")
    _ARG_0_.effecgtDeadHandle = NULL_HANDLE
    _ARG_0_.effecgtFastHandle = NULL_HANDLE
    _ARG_0_.effecgtFastHandle2 = NULL_HANDLE
    _ARG_0_.effecgtSecondHandle = NULL_HANDLE
    _ARG_0_.effecgtFinalHandle = NULL_HANDLE
    _ARG_0_.effecgtEndHandle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.workStep = 0
    _ARG_0_.GroupNum = 0
    for _FORV_5_ = 0, 40 do
      B15EX_ENEMY_TABLE[_FORV_5_] = {handle = NULL_HANDLE, deadFlag = 0}
    end
    _FOR_.EnableBgColl(_ARG_0_.myHandle, 0)
    _UPVALUE0_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
    if _UPVALUE0_ == 0 then
      _UPVALUE0_ = 3
    end
    print("B15EX_FAST_LIGHT" .. _UPVALUE0_ .. "\n")
    _UPVALUE1_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
    if _UPVALUE1_ == 0 then
      _UPVALUE1_ = 2
    end
    print("B15EX_SECOND_LIGHT" .. _UPVALUE1_ .. "\n")
    _UPVALUE2_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 3)
    if _UPVALUE2_ == 0 then
      _UPVALUE2_ = 1
    end
    print("B15EX_FAINAL_LIGHT" .. _UPVALUE2_ .. "\n")
    _UPVALUE3_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * 2
    _UPVALUE4_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 6) * 2
    _UPVALUE5_ = Entity.GetLayoutParam(_ARG_0_.myHandle, 6) * 2
    _UPVALUE5_ = 55
    if Gimmick.GetBitFlag(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoState("Waiting")
    else
      _ARG_0_:GotoState("EndIdling")
    end
  end,
  crateDeadGroupEffect = function(_ARG_0_, _ARG_1_)
    if Effect.IsAlive(_ARG_0_.effecgtDeadHandle) == false then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      _UPVALUE0_:set(18, -3.7, -30)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtDeadHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_015", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateFastEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtFastHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      _UPVALUE0_:set(18, -3.7, -30)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtFastHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_015", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateFastEffect2 = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtFastHandle2 == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      _UPVALUE0_:set(18, -3.7, -30)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtFastHandle2 = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_015", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateSecondEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtSecondHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      _UPVALUE0_:set(18, -3.7, -30)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtSecondHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_015", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateFinalEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtFinalHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      _UPVALUE0_:set(18, -3.7, -30)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtFinalHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_015", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateEndEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtEndHandle == NULL_HANDLE then
      print("\131G\131t\131F\131N\131g\144\182\144\172<" .. _ARG_1_ .. ">\n")
      _UPVALUE0_:set(18, -3.7, -30)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtEndHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_015", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
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
  OnDestroy = function(_ARG_0_)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end
}, {__index = __StateMachine})
EntityFactory:Add("g15jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g23jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
