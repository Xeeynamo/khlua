G10JB_RECODING = 1
FAST_GIMMICK = 0
G10JB_UID_GIMMICK_DATA_A = {
  uid = 110,
  moya = "g12jb00",
  katamari = "g17jb00"
}
G10JB_UID_GIMMICK_DATA_B = {
  uid = 111,
  moya = "g13jb00",
  katamari = "g18jb00"
}
G10JB_UID_GIMMICK_DATA_C = {
  uid = 112,
  moya = "g14jb00",
  katamari = "g19jb00"
}
FAST_GIMMIC = 0
setmetatable({
  new = function(_ARG_0_)
    return setmetatable(__StateMachine:new(), _UPVALUE0_)
  end,
  states = {
    Idling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.damageStep = 0
        Entity.SetModelOfsZ(_ARG_0_.myHandle, 10)
        print("UID = " .. _ARG_0_.uniqueID .. " : \140\130\148j\144\148 = " .. _ARG_0_:GetnowNoAliveNum() .. "\n")
        if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum then
          _ARG_0_.damageStep = 5
          print("\130\183\130\197\130\201\140\130\148j\141\207\130\221")
        elseif _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum / 2 then
          _ARG_0_:crateSecondEffect("G_JB_010_LT2_0")
          _ARG_0_:crateFastEffect("G_JB_010_LT1_0")
          _ARG_0_.damageStep = 2
          _ARG_0_:crateEnemyEffect("G_JB_010_FWL_0")
          print("2\146i\138K\150\218\130\220\130\197\151\136\130\196\130\233.")
        elseif _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum / 3 then
          _ARG_0_:crateFastEffect("G_JB_010_LT1_0")
          _ARG_0_.damageStep = 1
          _ARG_0_:crateEnemyEffect("G_JB_010_FWL_0")
          print("1\146i\138K\150\218\130\220\130\197\151\136\130\196\130\233.")
        else
          _ARG_0_:crateEnemyEffect("G_JB_010_FWL_0")
          print("\150\179\143\157\130\220\130\197\151\136\130\196\130\233.")
        end
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.damageStep < 4 then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < 256 then
            _ARG_0_:crateStartEffect("G_JB_010_SMK_0")
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) > 289 then
          end
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < _UPVALUE0_ then
          if _ARG_0_.step == 0 then
            if Enemy.IsAllEnemyWaiting() == false and _ARG_0_:GetSoldierNoAliveId() ~= -1 then
              print("\144\182\144\172 id = " .. _ARG_0_:GetSoldierNoAliveId() .. "\n")
              _ARG_0_:CreateSoldier((_ARG_0_:GetSoldierNoAliveId()))
              _ARG_0_.nowSummonsNum = _ARG_0_.nowSummonsNum + 1
              _ARG_0_.step = 1
              _ARG_0_.summonTimer = _ARG_0_.summonWait
            end
          elseif _ARG_0_.step == 1 then
            if 0 > _ARG_0_.summonTimer then
              if _ARG_0_.nowSummonsNum >= _ARG_0_.summonsMaxNum then
                print("\143o\140\187\138\174\151\1851\n")
                _ARG_0_.step = 2
              elseif _ARG_0_:GetnowAliveNum() <= _ARG_0_.summonsEnemyMaxNum then
                _ARG_0_.step = 0
              end
            end
          elseif _ARG_0_.step == 2 then
            if _ARG_0_.nowSummonsNum < _ARG_0_.summonsMaxNum then
              _ARG_0_.step = 0
            end
            if _ARG_0_:IsSoldierAlive() == true then
              print("\142\169\149\170\130\170\143o\140\187\130\179\130\185\130\189\147G\130\204\145S\150\197\130\240\138m\148F\n")
              _ARG_0_.step = 3
            end
          elseif _ARG_0_.step == 3 then
          end
        end
        _ARG_0_.summonTimer = _ARG_0_.summonTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      end
    },
    MissionIdling = {
      OnBeginState = function(_ARG_0_)
        _ARG_0_.step = 0
        _ARG_0_.damageStep = 0
        _ARG_0_.wallStep = 0
        Entity.SetModelOfsZ(_ARG_0_.myHandle, 10)
        _ARG_0_:crateEnemyEffect("G_JB_010_FWL_0")
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.wallStep == 0 then
        elseif _ARG_0_.wallStep == 1 then
          Script.StartFadeOut(20, false)
          _ARG_0_.wallStep = 2
          Player.NotifyEventStart(Player.GetHandle())
        elseif _ARG_0_.wallStep == 2 then
          if Script.IsEndFadeOut() then
            Script.StartFadeIn(20, false)
            if _ARG_0_.uniqueID == 100 then
              _UPVALUE0_:set(61.142, -1.951, 35.667)
              _UPVALUE1_:set(0, 0, 0)
              Entity.SetLocalPos(Player.GetHandle(), _UPVALUE0_)
              Entity.SetOldLocalPos(Player.GetHandle(), _UPVALUE0_)
              _UPVALUE1_:sety(RoundPI(DegToRad(230)))
              Entity.SetRot(Player.GetHandle(), _UPVALUE1_)
              _ARG_0_:StartCamera(_UPVALUE2_)
              _ARG_0_.createTime = _UPVALUE3_
            elseif _ARG_0_.uniqueID == 110 then
              _UPVALUE0_:set(-9.821, -13.5, 0.854)
              _UPVALUE1_:set(0, 0, 0)
              Entity.SetLocalPos(Player.GetHandle(), _UPVALUE0_)
              Entity.SetOldLocalPos(Player.GetHandle(), _UPVALUE0_)
              _UPVALUE1_:sety(RoundPI(DegToRad(220)))
              Entity.SetRot(Player.GetHandle(), _UPVALUE1_)
              _ARG_0_:StartCamera(_UPVALUE4_)
              _ARG_0_.createTime = 230
            end
            _ARG_0_.wallStep = 3
          end
        elseif _ARG_0_.wallStep == 3 then
          _ARG_0_.createTime = _ARG_0_.createTime - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.createTime then
            _ARG_0_:closeDoor(_ARG_0_.uniqueID)
            _ARG_0_.wallStep = 4
            _ARG_0_.createTime = _UPVALUE5_
          end
        elseif _ARG_0_.wallStep == 4 then
          _ARG_0_.createTime = _ARG_0_.createTime - Entity.GetFrameRate(_ARG_0_.myHandle)
          if 0 > _ARG_0_.createTime then
            _ARG_0_:closeDoorEffect2()
            _ARG_0_.wallStep = 5
          end
        elseif _ARG_0_.wallStep == 5 then
          if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
            _ARG_0_.wallStep = 6
            Script.StartFadeOut(20, false)
          end
        elseif _ARG_0_.wallStep == 6 then
          if Script.IsEndFadeOut() then
            Script.OutTask(_ARG_0_.camera)
            _ARG_0_.camera = NULL_HANDLE
            _ARG_0_.cameraStep = 1
            _ARG_0_.cameraFlag = 0
            Script.SetObjStart(OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
            Script.SetSceneColor(1, 1, 1, 1, 1, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
            Script.EnablePauseChecker()
            Effect.LoopEnd(_ARG_0_.effectMass2Handle)
            Player.NotifyEventEnd(Player.GetHandle())
            Script.StartFadeIn(20, false)
            _ARG_0_.wallStep = 7
          end
        elseif _ARG_0_.wallStep == 7 and Script.IsEndFadeIn() then
          _ARG_0_.wallStep = 99
        end
        if _ARG_0_.wallStep ~= 99 then
          return
        end
        if 4 > _ARG_0_.damageStep then
          if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < 256 then
            _ARG_0_:crateStartEffect("G_JB_010_SMK_0")
          elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) > 289 then
          end
        end
        if Entity.CalcDistanceSq(_ARG_0_.myHandle, Player.GetHandle()) < _UPVALUE6_ then
          if _ARG_0_.step == 0 then
            if Enemy.IsAllEnemyWaiting() == false and _ARG_0_:GetSoldierNoAliveId() ~= -1 then
              print("\144\182\144\172 id = " .. _ARG_0_:GetSoldierNoAliveId() .. "\n")
              _ARG_0_:CreateSoldier((_ARG_0_:GetSoldierNoAliveId()))
              _ARG_0_.nowSummonsNum = _ARG_0_.nowSummonsNum + 1
              _ARG_0_.step = 1
              _ARG_0_.summonTimer = _ARG_0_.summonWait
            end
          elseif _ARG_0_.step == 1 then
            if 0 > _ARG_0_.summonTimer then
              if _ARG_0_.nowSummonsNum >= _ARG_0_.summonsMaxNum then
                print("\143o\140\187\138\174\151\1852\n")
                _ARG_0_.step = 2
              elseif _ARG_0_:GetnowAliveNum() <= _ARG_0_.summonsEnemyMaxNum then
                _ARG_0_.step = 0
              end
            end
          elseif _ARG_0_.step == 2 then
            if _ARG_0_.nowSummonsNum < _ARG_0_.summonsMaxNum then
              _ARG_0_.step = 0
            end
            if _ARG_0_:IsSoldierAlive() == true then
              print("\142\169\149\170\130\170\143o\140\187\130\179\130\185\130\189\147G\130\204\145S\150\197\130\240\138m\148F\n")
              _ARG_0_.step = 3
            end
          elseif _ARG_0_.step == 3 then
          end
        end
        _ARG_0_.summonTimer = _ARG_0_.summonTimer - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      end
    },
    MissionEndState = {
      OnBeginState = function(_ARG_0_)
        print("MissionEndState\n")
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum then
          _ARG_0_.damageStep = 4
        end
        _ARG_0_:openDoor(_ARG_0_.uniqueID)
        _ARG_0_.step = 0
        _ARG_0_.wallStep = 0
        _ARG_0_.createTime = _UPVALUE0_
      end,
      OnEndState = function(_ARG_0_)
        Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.uniqueID == 100 then
          if _ARG_0_.wallStep == 0 then
            if Gimmick.GetBitFlag(_ARG_0_.myHandle) == false then
              _ARG_0_.wallStep = 1
            end
          elseif _ARG_0_.wallStep == 1 then
            _ARG_0_.createTime = _ARG_0_.createTime - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 > _ARG_0_.createTime then
              _ARG_0_:changeDorkJumpGimmick(2010)
              _ARG_0_.wallStep = 2
            end
          elseif _ARG_0_.wallStep == 2 then
            if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
              _ARG_0_.wallStep = 3
              Script.StartFadeOut(20, false)
            end
          elseif _ARG_0_.wallStep == 3 then
            if Script.IsEndFadeOut() then
              Script.OutTask(_ARG_0_.camera)
              _ARG_0_.camera = NULL_HANDLE
              _ARG_0_.cameraStep = 1
              _ARG_0_.cameraFlag = 0
              Script.SetObjStart(OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
              Script.SetSceneColor(1, 1, 1, 1, 1, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
              Script.EnablePauseChecker()
              Effect.LoopEnd(_ARG_0_.effectMass2Handle)
              Player.NotifyEventEnd(Player.GetHandle())
              Script.StartFadeIn(20, false)
              _ARG_0_.wallStep = 7
            end
          elseif _ARG_0_.wallStep == 4 then
            _ARG_0_.wallStep = 5
          elseif _ARG_0_.wallStep == 5 then
            if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
              _ARG_0_.wallStep = 6
            end
          elseif _ARG_0_.wallStep == 6 then
            if Script.IsEndFadeOut() then
              _ARG_0_.wallStep = 7
            end
          elseif _ARG_0_.wallStep == 7 then
            if Script.IsEndFadeIn() then
              _ARG_0_.wallStep = 8
            end
          elseif _ARG_0_.wallStep == 8 then
            _ARG_0_:GotoState("OutState")
          end
        end
      end
    },
    MoyaEndState = {
      OnBeginState = function(_ARG_0_)
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum then
          _ARG_0_.damageStep = 4
        end
        _ARG_0_:openDoor(_ARG_0_.uniqueID)
        _ARG_0_.step = 0
        _ARG_0_.wallStep = 0
      end,
      OnEndState = function(_ARG_0_)
        Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.uniqueID == 110 then
          if _ARG_0_.wallStep == 0 then
            _ARG_0_.wallStep = 1
          elseif _ARG_0_.wallStep == 1 then
            if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
              _ARG_0_.wallStep = 2
              _ARG_0_.createTime = 200
            end
          elseif _ARG_0_.wallStep == 2 then
            Script.OutTask(_ARG_0_.camera)
            _ARG_0_.camera = NULL_HANDLE
            _ARG_0_.cameraStep = 1
            _ARG_0_.cameraFlag = 0
            Script.SetObjStart(OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
            Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
            Script.EnablePauseChecker()
            _ARG_0_:StartCamera(_UPVALUE0_)
            _ARG_0_.wallStep = 3
          elseif _ARG_0_.wallStep == 3 then
            _ARG_0_.wallStep = 4
          elseif _ARG_0_.wallStep == 4 then
            _ARG_0_.createTime = _ARG_0_.createTime - Entity.GetFrameRate(_ARG_0_.myHandle)
            if 0 > _ARG_0_.createTime then
              _ARG_0_:changeDorkJumpGimmick(2010)
              _ARG_0_:changeDorkJumpGimmick(51)
              _ARG_0_:changeDorkJumpGimmick(52)
              _ARG_0_.wallStep = 5
            end
          elseif _ARG_0_.wallStep == 5 then
            if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
              _ARG_0_.wallStep = 6
              Script.StartFadeOut(20, false)
            end
          elseif _ARG_0_.wallStep == 6 then
            if Script.IsEndFadeOut() then
              Script.OutTask(_ARG_0_.camera)
              _ARG_0_.camera = NULL_HANDLE
              _ARG_0_.cameraStep = 1
              _ARG_0_.cameraFlag = 0
              Script.SetObjStart(OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
              Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
              Script.EnablePauseChecker()
              Effect.LoopEnd(_ARG_0_.effectMass2Handle)
              Player.NotifyEventEnd(Player.GetHandle())
              Script.StartFadeIn(20, false)
              _ARG_0_.wallStep = 7
            end
          elseif _ARG_0_.wallStep == 7 then
            if Script.IsEndFadeIn() then
              _ARG_0_.wallStep = 8
            end
          elseif _ARG_0_.wallStep == 8 then
            _ARG_0_:GotoState("OutState")
          end
        end
      end
    },
    OutState = {
      OnBeginState = function(_ARG_0_)
        print("OutState\n")
        Entity.SetAlpha(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        print("UID = " .. _ARG_0_.uniqueID .. " : \140\130\148j\144\148 = " .. _ARG_0_:GetnowNoAliveNum() .. "\n")
        if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum then
          _ARG_0_.damageStep = 4
        end
        _ARG_0_:openDoor(_ARG_0_.uniqueID)
        _ARG_0_.step = 0
        _ARG_0_.triggerFlag = 1
        _ARG_0_:changeDorkJumpGimmick(2010)
        _ARG_0_:changeDorkJumpGimmick(50)
        _ARG_0_:changeDorkJumpGimmick(51)
        _ARG_0_:changeDorkJumpGimmick(52)
        Gimmick.SetAppPointNumber(_ARG_0_.uniqueID, _ARG_0_.nowSummonsNum)
        Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
      end,
      OnEndState = function(_ARG_0_)
      end,
      OnUpdate = function(_ARG_0_)
        if _ARG_0_.step == 0 then
          _ARG_0_:changeDorkJumpGimmick(2010)
          _ARG_0_:changeDorkJumpGimmick(50)
          _ARG_0_:changeDorkJumpGimmick(51)
          _ARG_0_:changeDorkJumpGimmick(52)
          _ARG_0_.step = 1
        elseif _ARG_0_.step == 1 then
        end
        _ARG_0_:checkCameraOut(0)
      end
    }
  },
  CheckEnemyDead = function(_ARG_0_)
    _ARG_0_:SetEnemyDeadEffect()
    if _ARG_0_.damageStep == 0 then
      if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum / 3 then
        print("1\146i\138K\150\218")
        _ARG_0_:crateFastEffect("G_JB_010_LT1_0")
        _ARG_0_.damageStep = 1
      end
    elseif _ARG_0_.damageStep == 1 then
      if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum / 2 then
        print("2\146i\138K\150\218")
        _ARG_0_:crateSecondEffect("G_JB_010_LT2_0")
        _ARG_0_.damageStep = 2
        if _ARG_0_.uniqueID == 100 then
          _ARG_0_.deleteTimer = 100
          _ARG_0_.fadeStep = 0
        elseif _ARG_0_.uniqueID == 110 then
          _ARG_0_.deleteTimer = 100
          _ARG_0_.fadeStep = 0
        end
      end
    elseif _ARG_0_.damageStep == 2 then
      if _ARG_0_:GetnowNoAliveNum() >= _ARG_0_.summonsMaxNum then
        if _ARG_0_.uniqueID == 100 then
          if _ARG_0_.fadeStep == 0 then
            Script.StartFadeOut(20, false)
            _ARG_0_.fadeStep = 1
          elseif _ARG_0_.fadeStep == 1 then
            if Script.IsEndFadeOut() then
              _ARG_0_.fadeStep = 2
              Script.StartFadeIn(20, false)
              _ARG_0_:StartCamera(_UPVALUE0_)
            end
          elseif _ARG_0_.fadeStep == 2 then
            _ARG_0_.createTime = _ARG_0_.createTime - Entity.GetFrameRate(_ARG_0_.myHandle)
            if Script.IsEndFadeIn() then
              _ARG_0_.fadeStep = 3
            end
          elseif _ARG_0_.fadeStep == 3 then
          else
          end
        elseif _ARG_0_.fadeStep == 4 and _ARG_0_.uniqueID == 110 then
          if _ARG_0_.fadeStep == 0 then
            Script.StartFadeOut(20, false)
            _ARG_0_.fadeStep = 1
          elseif _ARG_0_.fadeStep == 1 then
            if Script.IsEndFadeOut() then
              _ARG_0_.fadeStep = 2
              Script.StartFadeIn(20, false)
              _UPVALUE1_:set(-9.544, -13.5, -0.225)
              _UPVALUE2_:set(0, 0, 0)
              Entity.SetLocalPos(Player.GetHandle(), _UPVALUE1_)
              Entity.SetOldLocalPos(Player.GetHandle(), _UPVALUE1_)
              _UPVALUE2_:sety(RoundPI(DegToRad(220)))
              Entity.SetRot(Player.GetHandle(), _UPVALUE2_)
              _ARG_0_:StartCamera(_UPVALUE3_)
            end
          elseif _ARG_0_.fadeStep == 2 then
            if Script.IsEndFadeIn() then
              _ARG_0_.fadeStep = 3
            end
          elseif _ARG_0_.fadeStep == 3 then
          end
        end
        _ARG_0_.deleteTimer = _ARG_0_.deleteTimer - Entity.GetFrameRate(_ARG_0_.myHandle)
        if 0 > _ARG_0_.deleteTimer then
          _ARG_0_:crateFinalEffect("G_JB_010_LT3_0")
          _ARG_0_.damageStep = 3
          _ARG_0_:crateEndEffect("G_JB_010_DSP_0")
          _ARG_0_:loopEndEffect(_ARG_0_.effecgtFastHandle)
          _ARG_0_:loopEndEffect(_ARG_0_.effecgtSecondHandle)
          _ARG_0_:loopEndEffect(_ARG_0_.effecgtFinalHandle)
          _ARG_0_:loopEndEffect(_ARG_0_.effecgtMainHandle)
          _ARG_0_:loopEndEffect(_ARG_0_.effecgtStartHandle)
          Entity.SetupModelFade(_ARG_0_.myHandle, 1, 0, 20)
          Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
          _ARG_0_.isChange = _ARG_0_:changeHazeToMass(_ARG_0_.uniqueID)
        end
      end
    elseif _ARG_0_.damageStep == 3 then
      if Entity.IsModelFade(_ARG_0_.myHandle) == false then
        _ARG_0_.damageStep = 4
        if _ARG_0_.uniqueID == 100 then
          _ARG_0_:GotoState("MissionEndState")
        elseif _ARG_0_.uniqueID == 110 then
          _ARG_0_:GotoState("MoyaEndState")
        else
          _ARG_0_:GotoState("OutState")
        end
      end
    elseif _ARG_0_.damageStep == 4 then
    elseif _ARG_0_.damageStep == 5 and Entity.IsTimeOver(_ARG_0_.myHandle) then
      _ARG_0_.damageStep = 3
      Effect.LoopEnd(_ARG_0_.effectMassHandle)
      _ARG_0_.isChange = _ARG_0_:changeModelHazeToMass(_ARG_0_.uniqueID)
    end
    _ARG_0_:IsDeadCheck()
  end,
  openDoor = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 100 then
      Entity.EnableRideColl(Gimmick.SearchGimmick("g20jb00"), 0, 0)
    elseif _ARG_1_ == 110 then
      Entity.EnableRideColl(Gimmick.SearchGimmick("g22jb00"), 0, 0)
    end
  end,
  closeDoorEffect2 = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.doorEffHandle2 == NULL_HANDLE then
      Entity.EnableRideColl(Gimmick.SearchGimmick("g20jb00"), 1, 0)
      print("\130\170\130\215\144\221\146\2322\n")
      Entity.GetWorldPos(_UPVALUE0_, Gimmick.SearchGimmick("g20jb00"), 3)
      Entity.GetRot(_UPVALUE1_, (Gimmick.SearchGimmick("g20jb00")))
      _UPVALUE0_:set(0, 0, 0)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.doorEffHandle2 = Entity.AttachEffect(Gimmick.SearchGimmick("g20jb00"), "g_jb_020", "G_JB_020_WA2_0", "bone_02", _UPVALUE0_, _UPVALUE1_)
    end
  end,
  closeDoor = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 100 then
      print("\130\170\130\215\144\221\146\2321\n")
      _ARG_0_.doorEffHandle1 = NULL_HANDLE
      _ARG_0_.doorEffHandle2 = NULL_HANDLE
      Entity.EnableRideColl(Gimmick.SearchGimmick("g20jb00"), 1, 0)
      Entity.GetWorldPos(_UPVALUE0_, Gimmick.SearchGimmick("g20jb00"), 2)
      Entity.GetRot(_UPVALUE1_, (Gimmick.SearchGimmick("g20jb00")))
      _UPVALUE0_:set(0, 0, 0)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.doorEffHandle1 = Entity.AttachEffect(Gimmick.SearchGimmick("g20jb00"), "g_jb_020", "G_JB_020_WAL_0", "bone_01", _UPVALUE0_, _UPVALUE1_)
    elseif _ARG_1_ == 110 then
      _ARG_0_.doorEffHandle1 = NULL_HANDLE
      Entity.EnableRideColl(Gimmick.SearchGimmick("g22jb00"), 1, 0)
      Entity.GetWorldPos(_UPVALUE0_, Gimmick.SearchGimmick("g22jb00"), 2)
      Entity.GetRot(_UPVALUE1_, (Gimmick.SearchGimmick("g22jb00")))
      _UPVALUE0_:set(0, 0, 0)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.doorEffHandle1 = Entity.AttachEffect(Gimmick.SearchGimmick("g22jb00"), "g_jb_021", "G_JB_021_WAL_0", "bone_01", _UPVALUE0_, _UPVALUE1_)
    end
  end,
  StartCamera = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.camera ~= NULL_HANDLE then
      return
    end
    if _ARG_1_ == _UPVALUE0_ then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jb20_cam01")
    elseif _ARG_1_ == _UPVALUE1_ then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jb20_cam02")
    elseif _ARG_1_ == _UPVALUE2_ then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jb20_cam03")
    elseif _ARG_1_ == _UPVALUE3_ then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jb21_cam01")
    elseif _ARG_1_ == _UPVALUE4_ then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jb21_cam02")
    elseif _ARG_1_ == _UPVALUE5_ then
      _ARG_0_.camera = Camera.CreateExusiaCamera("jb21_cam03")
    end
    Camera.StartExusiaCamera(_ARG_0_.camera)
    Script.SetObjStop(OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
    if _ARG_1_ == _UPVALUE3_ then
      Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
    elseif _ARG_1_ == _UPVALUE4_ then
      Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
    elseif _ARG_1_ == _UPVALUE5_ then
      Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
    elseif _ARG_1_ == _UPVALUE0_ then
      Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
    else
      Script.SetSceneColor(1, 1, 1, 1, 0, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
    end
    Player.NotifyEventStart(Player.GetHandle())
    _ARG_0_.cameraFlag = 1
    _ARG_0_.cameraStep = 0
    Script.DisablePauseChecker()
  end,
  checkCameraOut = function(_ARG_0_, _ARG_1_)
    if Player.IsBattleFlagPlayerDead() == true and _ARG_0_.camera ~= NULL_HANDLE then
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.cameraStep = 1
      _ARG_0_.cameraFlag = 0
      Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
      Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_BULLET)
      Script.EnablePauseChecker()
      Player.NotifyEventEnd(Player.GetHandle())
    end
    if _ARG_0_.cameraFlag == 1 and _ARG_0_.cameraStep == 0 and Camera.IsEndExusiaCamera(_ARG_0_.camera) then
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.cameraStep = 1
      _ARG_0_.cameraFlag = 0
      Script.SetObjStart(OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
      Script.SetSceneColor(1, 1, 1, 1, 1, 4, OBJ_BIT_PLAYER, OBJ_BIT_BULLET, OBJ_BIT_ENEMY, OBJ_BIT_PRIZE)
      Script.EnablePauseChecker()
      Effect.LoopEnd(_ARG_0_.effectMass2Handle)
      Player.NotifyEventEnd(Player.GetHandle())
      _ARG_0_.wallStep = _ARG_1_
    end
  end,
  changeHazeToMass = function(_ARG_0_, _ARG_1_)
    if G10JB_UID_GIMMICK_DATA_A.uid == _ARG_1_ then
      _ARG_0_:StartCamera(_UPVALUE0_)
      Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
      _UPVALUE2_:set(0, 0, 0)
      _ARG_0_.effectMass2Handle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_017", "G_JB_017_MK2_0", _UPVALUE1_, _UPVALUE2_)
    elseif G10JB_UID_GIMMICK_DATA_B.uid == _ARG_1_ then
      Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
    elseif G10JB_UID_GIMMICK_DATA_C.uid == _ARG_1_ then
      Gimmick.SetGimmckBitFlag(_ARG_0_.myHandle, true)
    else
      return 1
    end
    if Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.moya) == NULL_HANDLE then
      return 0
    end
    Entity.GetWorldPos(_UPVALUE1_, _ARG_0_.myHandle)
    _UPVALUE2_:set(0, 0, 0)
    _ARG_0_.effectMassHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_017", "G_JB_017_SMK_0", _UPVALUE1_, _UPVALUE2_)
    Entity.SetTimer(_ARG_0_.myHandle, 30)
    _ARG_0_.damageStep = 5
    return 1
  end,
  changeModelHazeToMass = function(_ARG_0_, _ARG_1_)
    if G10JB_UID_GIMMICK_DATA_A.uid == _ARG_1_ then
      _ARG_0_:changeDorkJumpGimmick(50)
    elseif G10JB_UID_GIMMICK_DATA_B.uid == _ARG_1_ then
    elseif G10JB_UID_GIMMICK_DATA_C.uid == _ARG_1_ then
    else
      return 1
    end
    if Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.moya) == NULL_HANDLE then
      return 0
    end
    Entity.SetupModelFade(Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.moya), 1, 0, 40)
    Entity.SetModelOfsZ(Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.moya), 100)
    if Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.katamari) == nil then
      return 0
    end
    Entity.SetupModelFade(Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.katamari), 0, 1, 10)
    Entity.EnableRideColl(Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.katamari), 1, 0)
    Entity.SetModelOfsZ(Gimmick.SearchGimmick(G10JB_UID_GIMMICK_DATA_C.katamari), 10)
  end,
  initHassModel = function(_ARG_0_)
    Entity.SetupModelFade(Gimmick.SearchGimmick("g17jb00"), 1, 0, 1)
    Entity.EnableRideColl(Gimmick.SearchGimmick("g17jb00"), 0, 0)
    Entity.EnableBgColl(Gimmick.SearchGimmick("g17jb00"), 0)
    Entity.SetupModelFade(Gimmick.SearchGimmick("g18jb00"), 1, 0, 1)
    Entity.EnableRideColl(Gimmick.SearchGimmick("g18jb00"), 0, 0)
    Entity.EnableBgColl(Gimmick.SearchGimmick("g18jb00"), 0)
    Entity.SetupModelFade(Gimmick.SearchGimmick("g19jb00"), 1, 0, 1)
    Entity.EnableRideColl(Gimmick.SearchGimmick("g19jb00"), 0, 0)
    Entity.EnableBgColl(Gimmick.SearchGimmick("g19jb00"), 0)
  end,
  changeDorkJumpGimmick = function(_ARG_0_, _ARG_1_)
    if _ARG_1_ == 2010 then
      if _ARG_0_.uniqueID ~= 100 then
        return 0
      end
    elseif _ARG_1_ == 50 then
      if _ARG_0_.uniqueID ~= G10JB_UID_GIMMICK_DATA_A.uid then
        return 0
      end
    elseif _ARG_1_ == 51 then
      if _ARG_0_.uniqueID ~= G10JB_UID_GIMMICK_DATA_A.uid then
        return 0
      end
    elseif _ARG_1_ == 52 and _ARG_0_.uniqueID ~= G10JB_UID_GIMMICK_DATA_A.uid then
      return 0
    end
    print("\131W\131\131\131\147\131v\148\173\144\182\n")
    if EntityManager:GetEntity((Gimmick.SearchGimmick(_ARG_1_))) == nil then
      return 0
    end
    EntityManager:GetEntity((Gimmick.SearchGimmick(_ARG_1_))):GotoState("Idling")
    return 1
  end,
  CreateSoldier = function(_ARG_0_, _ARG_1_)
    _UPVALUE0_:set(0, 0, 0)
    _UPVALUE0_:setx(2 * Script.Random() * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
    _UPVALUE0_:setz(2 * Script.Random() * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
    Entity.GetWorldPos(_UPVALUE1_, Player.GetHandle())
    _UPVALUE2_:set(0, 0, 0.1)
    _UPVALUE3_:set(0, Entity.CalcDirection(_ARG_0_.myHandle, Player.GetHandle()) + RoundPI(DegToRad(Script.Random() * 180 - 90)), 0)
    Math.RotateVectorXYZ(_UPVALUE2_, _UPVALUE3_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    FVECTOR3.Add(_UPVALUE0_, _UPVALUE2_, _UPVALUE0_)
    if Script.Random() < _ARG_0_.summonsShadowRate then
      _ARG_0_.enemyHandleList[_ARG_1_].handle = Entity.CreateEntity("m40ex00", _UPVALUE0_, _UPVALUE3_)
    elseif Script.Random() < _ARG_0_.summonsShadowRate + _ARG_0_.summonsNeoShadowRate then
      _ARG_0_.enemyHandleList[_ARG_1_].handle = Entity.CreateEntity("m41ex00", _UPVALUE0_, _UPVALUE3_)
    else
      _ARG_0_.enemyHandleList[_ARG_1_].handle = Entity.CreateEntity("m42ex00", _UPVALUE0_, _UPVALUE3_)
    end
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.5)
    Entity.GetWorldPos(WorkVec, _ARG_0_.enemyHandleList[_ARG_1_].handle, 1)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE0_:sety(_UPVALUE0_:gety() + 0.5)
    FVECTOR3.Sub(_UPVALUE2_, WorkVec, _UPVALUE0_)
    FVECTOR3.normalize(_UPVALUE2_)
    _UPVALUE3_:set(DegToRad(90) + -Math.Atan2(_UPVALUE2_:gety(), Math.Sqrt(_UPVALUE2_:getz() * _UPVALUE2_:getz() + _UPVALUE2_:getx() * _UPVALUE2_:getx())), Math.Atan2(_UPVALUE2_:getx(), _UPVALUE2_:getz()), 0)
    Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", "G_JB_010_UAP_0", _UPVALUE0_, _UPVALUE3_)
    _UPVALUE2_:set(0, 0, 0)
    _ARG_0_.enemyHandleList[_ARG_1_].effectHandle = Entity.AttachEffect(_ARG_0_.enemyHandleList[_ARG_1_].handle, "g_jb_010", "G_JB_010_UAS_0", "center", _UPVALUE2_, _UPVALUE3_)
    _UPVALUE3_:set(0, _UPVALUE3_:gety(), 0)
    Entity.SetRot(_ARG_0_.enemyHandleList[_ARG_1_].handle, _UPVALUE3_)
    _UPVALUE0_:set(0, 1.5, 1.5)
    _UPVALUE0_:scale(_UPVALUE4_)
    Math.RotateVectorXYZ(_UPVALUE0_, _UPVALUE3_)
    Entity.SetVelocity(_ARG_0_.enemyHandleList[_ARG_1_].handle, _UPVALUE0_)
    Entity.EnableGravity(_ARG_0_.enemyHandleList[_ARG_1_].handle, 1)
    EntityManager:GetEntity(_ARG_0_.enemyHandleList[_ARG_1_].handle):GotoState("Fly")
    if G10JB_RECODING == 1 then
      SetEnemyHandle(_ARG_0_.myHandle, _ARG_0_.enemyHandleList[_ARG_1_].handle, _ARG_1_)
      SetEffectHandle(_ARG_0_.myHandle, _ARG_0_.enemyHandleList[_ARG_1_].effectHandle, _ARG_1_)
    end
  end,
  crateStartEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtStartHandle == NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtStartHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateEnemyEffect = function(_ARG_0_, _ARG_1_)
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
    _UPVALUE1_:set(0, 0, 0)
    _ARG_0_.effecgtMainHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
  end,
  crateDeadGroupEffect = function(_ARG_0_, _ARG_1_)
    if Effect.IsAlive(_ARG_0_.effecgtDeadHandle) then
    else
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtDeadHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
      if _ARG_0_.stepColor == 0 then
        _ARG_0_.stepColor = 1
      end
    end
  end,
  crateFastEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtFastHandle == NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtFastHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateSecondEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtSecondHandle == NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtSecondHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateFinalEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtFinalHandle == NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtFinalHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  crateEndEffect = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.effecgtEndHandle == NULL_HANDLE then
      Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
      _UPVALUE1_:set(0, 0, 0)
      _ARG_0_.effecgtEndHandle = Entity.SetEffect(_ARG_0_.myHandle, "g_jb_010", _ARG_1_, _UPVALUE0_, _UPVALUE1_)
    end
  end,
  loopEndEffect = function(_ARG_0_, _ARG_1_)
    Effect.LoopEnd(_ARG_1_)
    _ARG_1_ = NULL_HANDLE
  end,
  SetEnemyDeadEffect = function(_ARG_0_)
    if G10JB_RECODING == 1 then
    else
      for _FORV_4_ = 0, _ARG_0_.summonsMaxNum do
        if _ARG_0_.enemyHandleList[_FORV_4_].handle ~= NULL_HANDLE and Enemy.IsDead(_ARG_0_.enemyHandleList[_FORV_4_].handle) == 1 and _ARG_0_.enemyHandleList[_FORV_4_].deadFlag == 0 then
          _ARG_0_:crateDeadGroupEffect("G_JB_010_RCT_0")
        end
      end
    end
  end,
  GetSoldierNoAliveId = function(_ARG_0_)
    if G10JB_RECODING == 1 then
      return (GetSoldierNoAliveId(_ARG_0_.myHandle))
    else
      for _FORV_5_ = 0, _ARG_0_.summonsMaxNum do
        if _ARG_0_.enemyHandleList[_FORV_5_].handle == NULL_HANDLE and _ARG_0_.enemyHandleList[_FORV_5_].deadFlag == 0 then
          return _FORV_5_
        end
      end
    end
    return _FOR_
  end,
  IsSoldierAlive = function(_ARG_0_)
    if G10JB_RECODING == 1 then
      return (IsSoldierAlive(_ARG_0_.myHandle))
    else
      for _FORV_5_ = 0, _ARG_0_.summonsMaxNum do
      end
      if IsSoldierAlive(_ARG_0_.myHandle) + 1 >= _FOR_ then
        return true, cnt
      end
      return false, cnt
    end
  end,
  GetnowNoAliveNum = function(_ARG_0_)
    if G10JB_RECODING == 1 then
    else
      for _FORV_5_ = 0, _ARG_0_.summonsMaxNum do
      end
    end
    return GetnowNoAliveNum(_ARG_0_.myHandle) + 1
  end,
  GetnowAliveNum = function(_ARG_0_)
    if G10JB_RECODING == 1 then
    else
      for _FORV_5_ = 0, _ARG_0_.summonsMaxNum do
      end
    end
    return GetnowAliveNum(_ARG_0_.myHandle) + 1
  end,
  IsDeadCheck = function(_ARG_0_)
    if G10JB_RECODING == 1 then
      _ARG_0_.nowSummonsNum = GetNowSummonsEnemyNum(_ARG_0_.myHandle)
    else
      for _FORV_5_ = 0, _ARG_0_.summonsMaxNum do
        if _ARG_0_.enemyHandleList[_FORV_5_].handle ~= NULL_HANDLE then
          if Entity.IsGround(_ARG_0_.enemyHandleList[_FORV_5_].handle) then
            _ARG_0_:loopEndEffect(_ARG_0_.enemyHandleList[_FORV_5_].effectHandle)
            _ARG_0_.enemyHandleList[_FORV_5_].effectHandle = NULL_HANDLE
          end
          if Enemy.IsDead(_ARG_0_.enemyHandleList[_FORV_5_].handle) == 1 then
            _ARG_0_.enemyHandleList[_FORV_5_].deadFlag = 1
          end
          if Entity.IsAlive(_ARG_0_.enemyHandleList[_FORV_5_].handle) == false and _ARG_0_.enemyHandleList[_FORV_5_].deadFlag == 0 then
            print("\130\189\130\212\130\241\137\147\130\173\130\201\151\163\130\234\130\196\143\193\130\166\130\189\n")
            _ARG_0_.enemyHandleList[_FORV_5_].handle = NULL_HANDLE
            _ARG_0_.enemyHandleList[_FORV_5_].deadFlag = 0
            _ARG_0_.nowSummonsNum = _ARG_0_.nowSummonsNum - 1
            if 0 > _ARG_0_.nowSummonsNum then
              _ARG_0_.nowSummonsNum = 0
            end
          end
        end
      end
    end
    return IsDeadCheck(_ARG_0_.myHandle) + 1
  end,
  OnTrigger = function(_ARG_0_, _ARG_1_)
    if _ARG_0_.uniqueID == 100 then
      if _ARG_0_.triggerFlag == 0 and Gimmick.GetBitFlag(_ARG_0_.myHandle) == false then
        _ARG_0_.wallStep = 1
        _ARG_0_.triggerFlag = 1
      end
    elseif _ARG_0_.uniqueID == 110 and _ARG_0_.triggerFlag == 0 and Gimmick.GetBitFlag(_ARG_0_.myHandle) == false then
      _ARG_0_.wallStep = 1
      _ARG_0_.triggerFlag = 1
    end
    if _ARG_1_ == 0 then
    end
  end,
  OnInit = function(_ARG_0_, _ARG_1_)
    if FAST_GIMMICK == 0 then
      _ARG_0_:initHassModel()
    end
    FAST_GIMMICK = FAST_GIMMICK + 1
    _ARG_0_.myHandle = _ARG_1_
    _ARG_0_.effecgtMainHandle = NULL_HANDLE
    _ARG_0_.targetHandle = NULL_HANDLE
    _ARG_0_.effecgtDeadHandle = NULL_HANDLE
    _ARG_0_.effecgtFastHandle = NULL_HANDLE
    _ARG_0_.effecgtSecondHandle = NULL_HANDLE
    _ARG_0_.effecgtFinalHandle = NULL_HANDLE
    _ARG_0_.effecgtEndHandle = NULL_HANDLE
    _ARG_0_.effecgtStartHandle = NULL_HANDLE
    _ARG_0_.effectMassHandle = NULL_HANDLE
    _ARG_0_.effectMass2Handle = NULL_HANDLE
    _ARG_0_.step = 0
    _ARG_0_.damageStep = 0
    _ARG_0_.isChange = 0
    _ARG_0_.camera = NULL_HANDLE
    _ARG_0_.cameraStep = 0
    _ARG_0_.cameraFlag = 0
    _ARG_0_.deleteTimer = 0
    _ARG_0_.createTimer = 0
    _ARG_0_.wallStep = 0
    _ARG_0_.fadeStep = 0
    _ARG_0_.triggerFlag = 0
    _ARG_0_.fastMainStep = 0
    _ARG_0_.uniqueID = Entity.GetLayoutParam(_ARG_1_, 9)
    print("self.uniqueID = " .. _ARG_0_.uniqueID .. "\n")
    _ARG_0_.nowSummonsNum = Gimmick.GetAppPointNumber(_ARG_0_.uniqueID)
    _ARG_0_.nowDeadNum = 0
    print("self.nowSummonsNum = " .. _ARG_0_.nowSummonsNum .. "\n")
    _ARG_0_.summonTimer = 0
    _ARG_0_.summonWait = 0
    if _ARG_0_.summonWait == 0 then
      _ARG_0_.summonWait = 80
    end
    _ARG_0_.summonsEnemyMaxNum = 1
    _ARG_0_.summonsEnemyMaxNum = Entity.GetLayoutParam(_ARG_0_.myHandle, 1)
    if _ARG_0_.summonsEnemyMaxNum == 0 then
      _ARG_0_.summonsEnemyMaxNum = 2
    end
    _ARG_0_.summonsEnemyMaxNum = _ARG_0_.summonsEnemyMaxNum - 1
    _ARG_0_.summonsMaxNum = 5
    _ARG_0_.summonsMaxNum = Entity.GetLayoutParam(_ARG_0_.myHandle, 2)
    if _ARG_0_.summonsMaxNum == 0 then
      _ARG_0_.summonsMaxNum = 5
    end
    _ARG_0_.summonsShadowRate = 0
    _ARG_0_.summonsNeoShadowRate = 0
    _ARG_0_.summonsShadowRate = Entity.GetLayoutParam(_ARG_0_.myHandle, 5) * 0.01
    _ARG_0_.summonsNeoShadowRate = Entity.GetLayoutParam(_ARG_0_.myHandle, 6) * 0.01
    _ARG_0_.summonsNeoShadowRate = Entity.GetLayoutParam(_ARG_0_.myHandle, 6) * 0.01
    if _ARG_0_.summonsNeoShadowRate == 0 then
      _ARG_0_.summonsNeoShadowRate = 0.33
    end
    _ARG_0_.enemyHandleList = {}
    for _FORV_5_ = 0, _ARG_0_.summonsMaxNum + 1 do
      if _FORV_5_ < _ARG_0_.nowSummonsNum then
      end
      _ARG_0_.enemyHandleList[_FORV_5_] = {
        handle = _ARG_1_,
        deadFlag = 1,
        effectHandle = NULL_HANDLE
      }
    end
    _FOR_.EnableBgColl(_ARG_0_.myHandle, 0)
    Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
    _ARG_0_.ScaleVec = FVECTOR3.new(1, 1, 1)
    if _ARG_0_.nowSummonsNum >= _ARG_0_.summonsMaxNum or Gimmick.GetBitFlag(_ARG_0_.myHandle) == true then
      _ARG_0_:GotoState("OutState")
    elseif _ARG_0_.uniqueID == 100 and Gimmick.GetBitFlag(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoState("MissionIdling")
    elseif _ARG_0_.uniqueID == 110 and Gimmick.GetBitFlag(_ARG_0_.myHandle) == false then
      _ARG_0_:GotoState("MissionIdling")
    else
      _ARG_0_:GotoState("Idling")
    end
  end,
  OnDestroy = function(_ARG_0_)
    Gimmick.SetAppPointNumber(_ARG_0_.uniqueID, _ARG_0_.nowSummonsNum)
    print("\131\134\131j\129[\131NID" .. _ARG_0_.uniqueID .. "\n")
    print("\130\177\130\234\130\190\130\175\130\204\147G\130\170\142\128\150S\130\181\130\196\130\220\130\181\130\189\129\129\130R\129\129 = " .. _ARG_0_:GetnowNoAliveNum() .. "\n")
    _ARG_0_:loopEndEffect(_ARG_0_.effecgtFastHandle)
    _ARG_0_:loopEndEffect(_ARG_0_.effecgtSecondHandle)
    _ARG_0_:loopEndEffect(_ARG_0_.effecgtFinalHandle)
  end,
  OnUpdate = function(_ARG_0_)
    _ARG_0_:Update()
  end,
  CanMainSkip = function(_ARG_0_)
    _ARG_0_:CheckEnemyDead()
    if _ARG_0_.fastMainStep == 0 then
      _ARG_0_.fastMainStep = 1
      return false
    elseif _ARG_0_.fastMainStep == 1 then
      _ARG_0_.fastMainStep = 2
      return false
    elseif _ARG_0_.fastMainStep == 2 then
    end
    if Entity.CalcDistanceSq(_ARG_0_.myHandle, (Player.GetHandle())) < 400 then
      return false
    end
    if _ARG_0_:GetState() == "OutState" and _ARG_0_.isChange == 0 then
      _ARG_0_.isChange = _ARG_0_:changeModelHazeToMass(_ARG_0_.uniqueID)
    end
    return true
  end
}, {__index = __StateMachine})
EntityFactory:Add("g10jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g20jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g21jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g22jb00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
