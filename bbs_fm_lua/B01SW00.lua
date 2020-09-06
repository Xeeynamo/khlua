b01sw00 = {}
b01sw00_base_mt = {__index = __StateMachine}
setmetatable(b01sw00, b01sw00_base_mt)
b01sw00_mt = {__index = b01sw00}
function b01sw00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b01sw00_mt)
end
b01sw00.states = {
  Appear = {
    OnBeginState = function(_ARG_0_)
      SetupAppearBegin2(_ARG_0_.myHandle, 1, _UPVALUE0_, 0)
    end,
    OnEndState = function(_ARG_0_)
      SetupAppearEnd(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Idling")
      end
    end
  },
  Idling = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Idling\n")
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.shakesFrame = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.shakesFrame = _ARG_0_.shakesFrame + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if Math.Mod(_ARG_0_.shakesFrame, 80) >= 0 and Math.Mod(_ARG_0_.shakesFrame, 80) < 40 then
        if _ARG_0_.shakes == 0 then
          _ARG_0_.shakes = 1
          _ARG_0_:ItAppleshakes()
        end
      else
        _ARG_0_.shakes = 0
      end
      if _ARG_0_.FeelingsFlag == 1 then
        _ARG_0_.FeelingsFlag = 2
        _ARG_0_.stack:clear()
        _ARG_0_.stack:push("Idling")
        _ARG_0_.stack:push("Anger")
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        return
      end
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      _ARG_0_.stack:push("Search")
      _ARG_0_.stack:push("RandomMove")
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  },
  Move = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Move\n")
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Approach = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Approach\n")
      _ARG_0_.step = _UPVALUE0_
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (1 * Script.Random() + 1) * 2 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (1 * Script.Random() + 1) * 2 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.notCheckTime = 60
        _ARG_0_.maxMoveNum = Script.Random() * 5
        _ARG_0_.count = 0
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_:Rotation(-1)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_.step = _UPVALUE6_
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1)
        _ARG_0_:Advancement(_UPVALUE7_)
        _ARG_0_.notCheckTime = _ARG_0_.notCheckTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_.notCheckTime = -999
        end
        if _ARG_0_.notCheckTime < 0 and (Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16) then
          _ARG_0_:GotoState(Search)
        end
      end
    end
  },
  RandomMove = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:RandomMove\n")
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _UPVALUE0_
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      _ARG_0_.shakesFrame = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      _ARG_0_.shakesFrame = _ARG_0_.shakesFrame + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      if Math.Mod(_ARG_0_.shakesFrame, 80) >= 0 and Math.Mod(_ARG_0_.shakesFrame, 80) < 40 then
        if _ARG_0_.shakes == 0 then
          _ARG_0_.shakes = 1
          _ARG_0_:ItAppleshakes()
        end
      else
        _ARG_0_.shakes = 0
      end
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle)
        _ARG_0_.targetPos:setx(_ARG_0_.targetPos:getx() + (3 * Script.Random() + 3) * 2 * Math.Cos((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.targetPos:setz(_ARG_0_.targetPos:getz() + (3 * Script.Random() + 3) * 2 * Math.Sin((RoundPI(Script.Random() * 2 * PI))))
        _ARG_0_.step = _UPVALUE1_
        _ARG_0_.notCheckTime = 60
        _ARG_0_.maxMoveNum = Script.Random() * 1
        _ARG_0_.count = 0
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
        _ARG_0_.workVec0:set(1, 0, 0)
        Math.RotateVectorXYZ(_ARG_0_.workVec0, _ARG_0_.rot)
        Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
        FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.myPos, _ARG_0_.targetPos)
        _ARG_0_.workVec1:normalize()
        if _ARG_0_.workVec0:dot(_ARG_0_.workVec1) < -0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_:Rotation(1)
        elseif _ARG_0_.workVec0:dot(_ARG_0_.workVec1) > 0.1 then
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_:Rotation(-1)
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE4_)
          Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_)
          _ARG_0_.step = _UPVALUE6_
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetPos, 1)
        _ARG_0_:Advancement(_UPVALUE7_)
        _ARG_0_.notCheckTime = _ARG_0_.notCheckTime - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or 1 > Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          _ARG_0_.notCheckTime = -999
        end
        if 0 > _ARG_0_.notCheckTime and (Entity.IsTimeOver(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetPos) < 4 or Entity.CalcDistanceXZSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < 16) then
          _ARG_0_.count = _ARG_0_.count + 1
          if _ARG_0_.count > _ARG_0_.maxMoveNum then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          else
            _ARG_0_.notCheckTime = 120
            Entity.ClearSpeed(_ARG_0_.myHandle)
            if Entity.IsWall(_ARG_0_.myHandle) then
              _ARG_0_.step = _UPVALUE0_
            else
              _ARG_0_.step = _UPVALUE0_
            end
          end
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
      end
    end
  },
  Search = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Search\n")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE0_ then
        if _ARG_0_:CheckHP(0.5) == 1 then
          _ARG_0_.stack:push("EscapeJumping")
          for _FORV_5_ = 0, _UPVALUE1_ do
            _ARG_0_.stack:push("Attack1")
          end
        else
          for _FORV_5_ = 0, _UPVALUE2_ do
            _ARG_0_.stack:push("Attack1")
          end
        end
      elseif Entity.CalcDistanceSq(_ARG_0_.myHandle, _ARG_0_.targetHandle) < _UPVALUE3_ then
        if _ARG_0_:CheckHP(0.5) == 1 then
          if _ARG_0_.bombFlag == 1 and _ARG_0_.appleFlag == 1 then
            if Script.Random() < _UPVALUE4_ then
              _ARG_0_.stack:push("SpinBonber")
            else
              _ARG_0_.stack:push("JumpingPoison")
            end
          elseif _ARG_0_.bombFlag == 1 then
            _ARG_0_.stack:push("SpinBonber")
          elseif _ARG_0_.appleFlag == 1 then
            _ARG_0_.stack:push("JumpingPoison")
          else
            _ARG_0_.stack:push("Idling")
            _ARG_0_.stack:push("Ground_diver")
            _ARG_0_.stack:push("MeteorCannon")
          end
        elseif _ARG_0_.bombFlag == 1 then
          _ARG_0_.stack:push("SpinBonber")
        else
          _ARG_0_.stack:push("Idling")
          _ARG_0_.stack:push("Ground_diver")
          _ARG_0_.stack:push("JumpingPoison")
        end
      end
      _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
    end
  },
  Ground_diver = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Ground_diver\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.attackCnt = 0
      _ARG_0_.jumpCnt = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_:CheckHP(0.5) == 1 then
            _ARG_0_.step = _UPVALUE1_
            Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE2_)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = _UPVALUE4_
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_ * Script.Random() + _UPVALUE5_ / 2)
          end
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          _ARG_0_.step = _UPVALUE6_
        end
        if _ARG_0_.wait < 0 then
          _ARG_0_:CreateSpier()
          _ARG_0_.wait = _UPVALUE7_ * Script.Random() + _UPVALUE7_
        end
        _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
      elseif _ARG_0_.step == _UPVALUE1_ then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 30 then
          _ARG_0_:CreateSpier()
          _ARG_0_.step = _UPVALUE8_
        end
      elseif _ARG_0_.step == _UPVALUE8_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.attackCnt >= _UPVALUE9_ - 1 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
            _ARG_0_.step = _UPVALUE4_
            Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE5_ * Script.Random() + _UPVALUE5_ / 2)
          else
            _ARG_0_.step = _UPVALUE1_
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            _ARG_0_.attackCnt = _ARG_0_.attackCnt + 1
          end
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        _ARG_0_.step = _UPVALUE10_
        _ARG_0_:createApple()
        _ARG_0_:controlBomb(1)
        _ARG_0_:deletePoson()
        Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE11_)
      elseif _ARG_0_.step == _UPVALUE10_ and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Counter = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Counter\n")
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.CounterDamage = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Attack1 = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:Attack1\n")
      Entity.SetTimer(_ARG_0_.myHandle, 0)
      if _ARG_0_:WhichRightandLeft() == 1 then
        if Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        else
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        end
      elseif Entity.IsTargetFront(_ARG_0_.myHandle, _ARG_0_.targetHandle) then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
      end
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  EscapeJumping = {
    OnBeginState = function(_ARG_0_)
      print("b01sw00:EscapeJumping\n")
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
      _ARG_0_.jumpCnt = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        _UPVALUE1_:set(0, 0, 0)
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _UPVALUE1_, 10)
        if 10 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
          Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.4, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          _ARG_0_.step = _UPVALUE2_
        end
      elseif _ARG_0_.step == _UPVALUE2_ then
        Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if 0 > _ARG_0_.workVec0:gety() then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE3_)
          _ARG_0_.step = _UPVALUE4_
        end
      elseif _ARG_0_.step == _UPVALUE4_ then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE5_, 1)
          Camera.QuakeV(50, 0.5, 12)
          _ARG_0_.step = _UPVALUE6_
        end
      elseif _ARG_0_.step == _UPVALUE6_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _UPVALUE1_:set(0, 0, 0)
          _ARG_0_.jumpCnt = _ARG_0_.jumpCnt + 1
          if _ARG_0_.jumpCnt > 3 then
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
            return
          end
          if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 36 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
            _ARG_0_.step = _UPVALUE0_
          else
            _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          end
        end
      elseif Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _UPVALUE1_:set(0, 0, 0)
        _ARG_0_.jumpCnt = _ARG_0_.jumpCnt + 1
        if _ARG_0_.jumpCnt > 3 then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
          return
        end
        if Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle) > 36 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE7_)
          _ARG_0_.step = _UPVALUE0_
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  JumpingPoison = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = _UPVALUE1_
    end,
    OnEndState = function(_ARG_0_)
      Entity.ClearSpeed(_ARG_0_.myHandle)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == _UPVALUE0_ then
        Entity.TurnTargetYDegree(_ARG_0_.myHandle, _ARG_0_.targetHandle, 10)
        if 10 <= Entity.GetMotionNowFrame(_ARG_0_.myHandle) then
          Entity.CalcOrbitVelocityFromSpeedY(_ARG_0_.myHandle, 0.4, (Entity.CalcDistanceXZ(_ARG_0_.myHandle, _ARG_0_.targetHandle)))
          _ARG_0_.step = _UPVALUE1_
        end
      elseif _ARG_0_.step == _UPVALUE1_ then
        Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if _ARG_0_.workVec0:gety() < 0 then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
          _ARG_0_.step = _UPVALUE3_
        end
      elseif _ARG_0_.step == _UPVALUE3_ then
        if Entity.IsGround(_ARG_0_.myHandle) then
          Entity.ClearSpeed(_ARG_0_.myHandle)
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE4_, 2)
          _ARG_0_:CreateShockwave()
          Camera.QuakeV(50, 0.5, 12)
          _ARG_0_.step = _UPVALUE5_
          _ARG_0_:dorpApple(_ARG_0_.jumpCnt + 1)
          _ARG_0_.nextJumpWait = 0
          if _ARG_0_.jumpCnt == 0 then
            _ARG_0_.nextJumpWait = B01SW_NEXTJUMPWAIT1
          elseif _ARG_0_.jumpCnt == 1 then
            _ARG_0_.nextJumpWait = B01SW_NEXTJUMPWAIT2
          elseif _ARG_0_.jumpCnt == 2 then
            _ARG_0_.nextJumpWait = B01SW_NEXTJUMPWAIT3
          end
          _ARG_0_.jumpCnt = _ARG_0_.jumpCnt + 1
        end
      elseif _ARG_0_.step == _UPVALUE5_ then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_.step = 99
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE6_)
          Entity.SetTimer(_ARG_0_.myHandle, _ARG_0_.nextJumpWait)
        end
      elseif Entity.IsTimeOver(_ARG_0_.myHandle) then
        if _ARG_0_.jumpCnt <= _UPVALUE7_ then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE8_)
          _ARG_0_.step = _UPVALUE0_
        else
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  SpinBonber = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      _ARG_0_.wait = 0
      _ARG_0_.bombcont = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.wait = _ARG_0_.wait - 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 30 and Entity.GetMotionNowFrame(_ARG_0_.myHandle) < 60 then
          _ARG_0_:controlBomb(0)
          if 0 > _ARG_0_.wait then
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 49 + _ARG_0_.bombcont, 0)
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 45 + _ARG_0_.bombcont, 0)
            _ARG_0_:CreateShot(_ARG_0_.myHandle, 55 + _ARG_0_.bombcont, 0)
            if Script.Random() < 0.5 then
              _ARG_0_:CreateShot(_ARG_0_.myHandle, 3, 1)
            end
            _ARG_0_.bombcont = _ARG_0_.bombcont + 1
            _ARG_0_.wait = _UPVALUE0_
          end
        end
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
        end
      end
    end
  },
  MeteorCannon = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
      Entity.SetTimer(_ARG_0_.myHandle, _UPVALUE1_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.IsTimeOver(_ARG_0_.myHandle) then
          Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          _ARG_0_.step = 1
          return
        end
      elseif _ARG_0_.step == 1 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 12 then
          _ARG_0_:CreateMeteor()
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 34 then
          _ARG_0_:CreateMeteor()
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 57 then
          _ARG_0_:CreateMeteor()
          _ARG_0_.step = 4
        end
      elseif _ARG_0_.step == 4 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  RoootSpier = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        if Entity.GetMotionNowFrame(_ARG_0_.myHandle) > 30 then
          _ARG_0_:CreateSpier()
          _ARG_0_.step = 1
        end
      elseif _ARG_0_.step == 1 then
        _ARG_0_.step = 2
      elseif _ARG_0_.step == 2 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Anger = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
      _ARG_0_.dmageNoFlag = 1
    end,
    OnEndState = function(_ARG_0_)
      _ARG_0_.dmageNoFlag = 0
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
      end
    end
  },
  Damage = {
    OnBeginState = function(_ARG_0_)
      if Enemy.IsAttackerFront(_ARG_0_.myHandle) == true then
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
        _ARG_0_.step = 0
      else
        Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
        _ARG_0_.step = 1
      end
      _ARG_0_.SavingsDamage = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 or _ARG_0_.step == 1 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if _ARG_0_.step == 0 then
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
          else
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
          end
          _ARG_0_.step = 2
        end
      elseif _ARG_0_.step == 2 then
        if Entity.IsMotionEnd(_ARG_0_.myHandle) then
          if Script.Random() < 0.5 then
            _ARG_0_.step = 3
            Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE2_)
            return
          end
          if _ARG_0_:CheckHP(0.5) == 1 then
            _ARG_0_:GotoState("Idling")
          else
            _ARG_0_:GotoState(_ARG_0_.oldState)
          end
        end
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        if _ARG_0_:CheckHP(0.5) == 1 then
          _ARG_0_:GotoState("Idling")
        else
          _ARG_0_:GotoState(_ARG_0_.oldState)
        end
      end
    end
  },
  Standby = {
    OnBeginState = function(_ARG_0_)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE0_)
    end,
    OnEndState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
    end,
    OnUpdate = function(_ARG_0_)
      if Enemy.IsAllEnemyWaiting() == false then
        _ARG_0_:GotoState("Idling")
        Entity.EnableLockon(_ARG_0_.myHandle, 1)
      end
    end
  },
  Dead = {
    OnBeginState = function(_ARG_0_)
      Entity.EnableLockon(_ARG_0_.myHandle, 0)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  Disappear = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  }
}
function b01sw00.WhichRightandLeft(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.plPos, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.myPos, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  FVECTOR3.Sub(_ARG_0_.workVec, _ARG_0_.plPos, _ARG_0_.myPos)
  FVECTOR3.normalize(_ARG_0_.workVec)
  if RoundPI((Math.Atan2(_ARG_0_.workVec:getx(), _ARG_0_.workVec:getz()) - _ARG_0_.rot:gety()) * -1) < 0 then
    return 1
  else
    return 0
  end
end
function b01sw00.RotationSet(_ARG_0_, _ARG_1_)
  Entity.GetRot(_ARG_0_.WorkVec, _ARG_0_.myHandle)
  _ARG_0_.WorkVec:set(0, _ARG_0_.WorkVec:gety() + _ARG_1_, 0)
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.WorkVec)
end
function b01sw00.Rotation(_ARG_0_, _ARG_1_)
  if Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle) < 0 then
  else
  end
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:sety(RoundPI(_ARG_0_.rot:gety() + DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_))
  Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.rot)
  return DegToRad((Entity.GetMotionNowFrame(_ARG_0_.myHandle) - Entity.GetMotionOldFrame(_ARG_0_.myHandle)) * (90 / Entity.GetMotionTotalFrame(_ARG_0_.myHandle))) * _ARG_1_
end
function b01sw00.Advancement(_ARG_0_, _ARG_1_)
  _ARG_0_.Speed = _ARG_0_.Speed + _ARG_1_ * 0.1 / 2 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_1_ < _ARG_0_.Speed then
    _ARG_0_.Speed = _ARG_1_
  end
  FVECTOR3.set(_ARG_0_.workVec, 0, 0, _ARG_0_.Speed)
  Entity.CalcVelocityXZ(_ARG_0_.myHandle, _ARG_0_.workVec)
end
function b01sw00.CheckHP(_ARG_0_, _ARG_1_)
  if Enemy.GetHp(_ARG_0_.myHandle) < Enemy.GetHpMax(_ARG_0_.myHandle) * _ARG_1_ then
    return 1
  end
  return 0
end
function b01sw00.controlBomb(_ARG_0_, _ARG_1_)
  _ARG_0_.bombFlag = _ARG_1_
  for _FORV_5_ = 2, 15 do
    Entity.EnableModelDisp(_ARG_0_.myHandle, _FORV_5_, _ARG_1_)
  end
end
function b01sw00.noAttackApple(_ARG_0_, _ARG_1_, _ARG_2_)
  print("noAttackApple\n")
  if Entity.IsAlive(_ARG_0_.appleData[_ARG_1_].handle) then
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.appleData[_ARG_1_].handle)
    Entity.SetOldLocalPos(_ARG_0_.appleData[_ARG_1_].handle, _UPVALUE0_)
    Entity.SetLocalPos(_ARG_0_.appleData[_ARG_1_].handle, _UPVALUE0_)
    _ARG_0_.rot:set(0, 0, 0)
    Entity.SetRot(_ARG_0_.appleData[_ARG_1_].handle, _ARG_0_.rot)
    Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.appleData[_ARG_1_].handle, "Root")
    Entity.EnableGravity(_ARG_0_.appleData[_ARG_1_].handle, 1)
    EntityManager:GetEntity(_ARG_0_.appleData[_ARG_1_].handle):GotoState("dorop")
    EntityManager:GetEntity(_ARG_0_.appleData[_ARG_1_].handle).owner = _ARG_0_.myHandle
    Entity.TurnTargetYDegree(_ARG_0_.appleData[_ARG_1_].handle, _ARG_0_.myHandle, 180)
    Entity.GetRot(_ARG_0_.workVec, _ARG_0_.appleData[_ARG_1_].handle)
    _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() + DegToRad(180 + (Script.Random() * 60 - 30)))
    Entity.SetRot(_ARG_0_.appleData[_ARG_1_].handle, _ARG_0_.workVec)
    FVECTOR3.set(_ARG_0_.workVec, 0, 0, 0.12)
    Entity.CalcVelocityXZ(_ARG_0_.appleData[_ARG_1_].handle, _ARG_0_.workVec)
  end
  _ARG_0_.appleData[_ARG_1_].handle = NULL_HANDLE
end
function b01sw00.ItAppleshakes(_ARG_0_)
  for _FORV_4_ = 0, 11 do
    if Entity.IsAlive(_ARG_0_.appleData[_FORV_4_].handle) == true and EntityManager:GetEntity(_ARG_0_.appleData[_FORV_4_].handle).exec == false then
      EntityManager:GetEntity(_ARG_0_.appleData[_FORV_4_].handle).exec = true
      EntityManager:GetEntity(_ARG_0_.appleData[_FORV_4_].handle).c = 0.4
      EntityManager:GetEntity(_ARG_0_.appleData[_FORV_4_].handle).theta = 0
    end
  end
end
function b01sw00.dorpApple(_ARG_0_, _ARG_1_)
  _ARG_0_.appleFlag = 0
  if _ARG_1_ == 0 then
    for _FORV_5_ = 0, 15 do
      _ARG_0_:noAttackApple(_FORV_5_)
    end
  elseif _ARG_1_ == 1 then
    _ARG_0_:noAttackApple(0)
    _ARG_0_:noAttackApple(4)
    _ARG_0_:noAttackApple(8)
  elseif _ARG_1_ == 2 then
    _ARG_0_:noAttackApple(1)
    _ARG_0_:noAttackApple(5)
    _ARG_0_:noAttackApple(9)
  elseif _ARG_1_ == 3 then
    _ARG_0_:noAttackApple(2)
    _ARG_0_:noAttackApple(6)
    _ARG_0_:noAttackApple(10)
    _ARG_0_:noAttackApple(3)
    _ARG_0_:noAttackApple(7)
    _ARG_0_:noAttackApple(11)
  end
end
function b01sw00.createApple(_ARG_0_)
  for _FORV_7_ = 0, 11 do
    if _FORV_7_ <= 3 then
      if 0 == 0 then
        _UPVALUE0_:set(2.4, -0.4, 1)
      elseif 0 == 1 then
        _UPVALUE0_:set(2, -0.2, -1)
      elseif 0 == 2 then
        _UPVALUE0_:set(1.7, -0.2, 1)
      elseif 0 == 3 then
        _UPVALUE0_:set(0.5, 0.5, 0.5)
      end
    elseif _FORV_7_ <= 7 then
      if 0 == 0 then
        _UPVALUE0_:set(2.4, -0.4, 1)
      elseif 0 == 1 then
        _UPVALUE0_:set(2, -0.2, -1)
      elseif 0 == 2 then
        _UPVALUE0_:set(1.7, -0.2, 1)
      elseif 0 == 3 then
        _UPVALUE0_:set(0.5, 0.5, 0.5)
      end
    elseif _FORV_7_ <= 11 then
      if 0 == 0 then
        _UPVALUE0_:set(2.4, -0.4, 1)
      elseif 0 == 1 then
        _UPVALUE0_:set(2, -0.2, -1)
      elseif 0 == 2 then
        _UPVALUE0_:set(1.7, -0.2, 1)
      elseif 0 == 3 then
        _UPVALUE0_:set(0.5, 0.5, 0.5)
      end
    end
    _UPVALUE1_:set(0, 0, DegToRad(0))
    if _ARG_0_.appleData[_FORV_7_].handle == NULL_HANDLE then
      _ARG_0_.appleData[_FORV_7_].handle = Entity.CreateEntity("b02sw00", _UPVALUE0_, _UPVALUE1_, _ARG_0_.myHandle)
      Entity.AttachCoord(_ARG_0_.myHandle, "R_eda2", _ARG_0_.appleData[_FORV_7_].handle, "Root")
      if Entity.IsAlive(_ARG_0_.appleData[_FORV_7_].handle) == true then
        EntityManager:GetEntity(_ARG_0_.appleData[_FORV_7_].handle).index = _FORV_7_
      end
      _ARG_0_.appleFlag = 1
    end
  end
end
function b01sw00.deletePoson(_ARG_0_)
  for _FORV_4_ = 0, 13 do
    print("Delterequest = " .. _FORV_4_ .. "\n")
    if Entity.IsAlive(_ARG_0_.appleData[_FORV_4_].poisonBulletHandle) == true then
      EntityManager:GetEntity(_ARG_0_.appleData[_FORV_4_].poisonBulletHandle).step = 1
    end
    _ARG_0_.appleData[_FORV_4_].poisonBulletHandle = NULL_HANDLE
  end
end
function b01sw00.CreateShockwave(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  SetBulletAttackParam(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, 10)
  Bullet.SetAttacker(Bullet.CreateBullet("waveb", _ARG_0_.workVec, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle)
end
function b01sw00.CreateSpier(_ARG_0_)
  Entity.GetVelocity(_ARG_0_.workVec, _ARG_0_.targetHandle)
  Entity.GetWorldPos(_ARG_0_.centerPos, _ARG_0_.targetHandle)
  _ARG_0_.workVec:scale(Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) * 1.7)
  FVECTOR3.Add(_ARG_0_.centerPos, _ARG_0_.centerPos, _ARG_0_.workVec)
  _ARG_0_.centerPos:sety(0.001)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  _ARG_0_.workVec:sety(_UPVALUE0_:gety())
  _ARG_0_.workVec:sety()
  _ARG_0_.rot:set(0, 0, 0)
  EntityManager:GetEntity((Bullet.CreateBullet("spier", _ARG_0_.centerPos, _ARG_0_.rot, _ARG_0_.myHandle))).effHandle = Bullet.CreateEffectBullet(Bullet.CreateBullet("spier", _ARG_0_.centerPos, _ARG_0_.rot, _ARG_0_.myHandle), "b01sw00", "B018_NES_SPR0_0")
  Bullet.SetCollision(Bullet.CreateBullet("spier", _ARG_0_.centerPos, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 0.3, 1.8, _ARG_0_.myHandle)
  SetBulletAttackParam(Bullet.CreateBullet("spier", _ARG_0_.centerPos, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, 9)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("spier", _ARG_0_.centerPos, _ARG_0_.rot, _ARG_0_.myHandle), "b01sw00", "B018_NES_HIT0_0")
  Bullet.EnableAttackCollision(Bullet.CreateBullet("spier", _ARG_0_.centerPos, _ARG_0_.rot, _ARG_0_.myHandle), 0)
end
function b01sw00.CreateMeteor(_ARG_0_)
  _UPVALUE0_:set(-2, 0, 0)
  Entity.GetWorldPos2(_UPVALUE0_, _ARG_0_.myHandle, _UPVALUE0_, 2)
  Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
  _ARG_0_.rot:set(DegToRad(-90), 0, 0)
  Bullet.CreateEffectBullet(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), "b01sw00", "B018_MET_BLT0_0")
  Bullet.SetCollision(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 1.5, 0, _ARG_0_.myHandle)
  SetBulletAttackParam(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), _ARG_0_.myHandle, 8)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), "b01sw00", "B018_MET_HIT0_0")
  Bullet.SetHitBgEffectName(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), "b01sw00", "B018_MET_HIT1_0")
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), 1000000)
  Entity.CalcVelocity(Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot), 0.5)
  EntityManager:GetEntity((Bullet.CreateBullet("meteor", _UPVALUE0_, _ARG_0_.rot))).targetHandle = _ARG_0_.targetHandle
end
function b01sw00.CreateShot(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_3_ == 0 then
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle, _ARG_2_)
    _UPVALUE1_:set(1, 0, 0)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_0_.myHandle, 3)
    Entity.GetRot(_ARG_0_.rot, _ARG_0_.myHandle)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
    FVECTOR3.normalize(_UPVALUE0_)
    _ARG_0_.rot:set(0, 0, 0)
    _ARG_0_.rot:setx(-Math.Atan2(_UPVALUE0_:gety(), Math.Sqrt(_UPVALUE0_:getz() * _UPVALUE0_:getz() + _UPVALUE0_:getx() * _UPVALUE0_:getx())))
    _ARG_0_.rot:sety((Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz())))
  else
    _ARG_0_.rot:set(0, 0, 0)
    print("\131v\131\140\131C\131\132\129[\130\240\145_\130\164\n")
    Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.targetHandle)
    Entity.GetWorldPos(_UPVALUE2_, _ARG_1_, 3)
    Entity.GetRot(_ARG_0_.rot, _ARG_1_)
    FVECTOR3.Sub(_UPVALUE0_, _UPVALUE0_, _UPVALUE2_)
    FVECTOR3.normalize(_UPVALUE0_)
    _ARG_0_.rot:setx(-Math.Atan2(_UPVALUE0_:gety(), Math.Sqrt(_UPVALUE0_:getz() * _UPVALUE0_:getz() + _UPVALUE0_:getx() * _UPVALUE0_:getx())))
    _ARG_0_.rot:sety((Math.Atan2(_UPVALUE0_:getx(), _UPVALUE0_:getz())))
  end
  Entity.GetWorldPos(_UPVALUE0_, _ARG_1_, _ARG_2_)
  _UPVALUE0_:set(DegToRad(90), 0, 0)
  Entity.RotateBoneXYZ(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), 2, _UPVALUE0_)
  if Enemy.IsConfuse(_ARG_0_.myHandle) then
    Bullet.SetCollision(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_NO_CHECK, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  else
    Bullet.SetCollision(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 0.5, 0, _ARG_1_)
  end
  SetBulletAttackParam(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), _ARG_0_.myHandle, 7)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), "b01sw00", "B018_SPB_HIT0_0")
  Bullet.EnableReflect(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), Enemy.GetAttackReflect(_ARG_0_.myHandle, 0))
  Entity.CalcVelocity(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), Script.Random() * 0.25 + 0.08)
  if _ARG_3_ == 0 then
    Entity.EnableGravity(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), 1)
  else
    Entity.EnableGravity(Bullet.CreateBullet("b03sw00", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.myHandle), 1)
  end
end
function b01sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.RandomMoveAng = 0
  _ARG_0_.notCheckTime = 0
  _ARG_0_.oldState = 0
  _ARG_0_.WorkTime = 0
  _ARG_0_.Speed = 0
  _ARG_0_.count = 0
  _ARG_0_.maxMoveNum = 0
  _ARG_0_.jumpCnt = 0
  _ARG_0_.appleFlag = 1
  _ARG_0_.bombFlag = 1
  _ARG_0_.wait = 0
  _ARG_0_.bombcont = 0
  _ARG_0_.SavingsDamage = 0
  _ARG_0_.CounterDamage = 0
  _ARG_0_.shakes = 0
  _ARG_0_.shakesFrame = 0
  _ARG_0_.attackCnt = 0
  _ARG_0_.FeelingsFlag = 0
  _ARG_0_.dmageNoFlag = 0
  _ARG_0_.nextJumpWait = 0
  _ARG_0_.appleData = {}
  for _FORV_5_ = 0, 13 do
    _ARG_0_.appleData[_FORV_5_] = {
      handle = NULL_HANDLE,
      poisonHandle = NULL_HANDLE,
      poisonBulletHandle = NULL_HANDLE,
      Index = 0,
      Angle = 0,
      AttackFlag = 0,
      AttackDelay = 0,
      MotRandFlag = 0
    }
  end
  _FOR_(_FOR_)
  _ARG_0_.plPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.myPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.velocity = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.centerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraPos = FVECTOR3.new(0, 0, 0)
  if _UPVALUE0_ == false then
    _UPVALUE1_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Act1Dist")
    _UPVALUE1_ = _UPVALUE1_ * _UPVALUE1_
    _UPVALUE2_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "Act2Dist")
    _UPVALUE2_ = _UPVALUE2_ * _UPVALUE2_
    _UPVALUE3_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DamageMax")
    _UPVALUE4_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "CounterD")
    _UPVALUE5_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpierCnt")
    _UPVALUE6_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "IdlingTime") * 60
    _UPVALUE7_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MoveTime") * 60
    _UPVALUE8_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "GroundTime") * 60
    _UPVALUE9_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "BonPoiRat") * 0.01
    _UPVALUE10_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "CouDamSbu")
    _UPVALUE11_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "MeteorShT")
    _UPVALUE12_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpinWait")
    _UPVALUE13_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "DelPoiFra")
    _UPVALUE14_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "SpiAttFra")
    _UPVALUE15_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PoOutFram1")
    _UPVALUE16_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PoOutFram2")
    _UPVALUE17_ = Enemy.GetExtraParam(_ARG_0_.myHandle, "PoOutFram3")
    B01SW_NEXTJUMPWAIT1 = Enemy.GetExtraParam(_ARG_0_.myHandle, "PJumpWait1")
    B01SW_NEXTJUMPWAIT2 = Enemy.GetExtraParam(_ARG_0_.myHandle, "PJumpWait2")
    B01SW_NEXTJUMPWAIT3 = Enemy.GetExtraParam(_ARG_0_.myHandle, "PJumpWait3")
    _UPVALUE18_ = true
  end
  _ARG_0_.stack = Stack:Create()
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 5.5)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 5.8)
  Entity.EnableBodyColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Enemy.IsAllEnemyWaiting()
  Entity.SetDropShadowDistance(_ARG_0_.myHandle, 80)
  Player.SetBossCamera("b01sw")
  if Enemy.IsAllEnemyWaiting() == true then
    _ARG_0_:GotoState("Standby")
  else
    _ARG_0_:GotoState("Appear")
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  end
end
function b01sw00.OnDamageBefore(_ARG_0_, _ARG_1_)
  if _ARG_0_.dmageNoFlag == 1 then
    return 1
  end
  return 0
end
function b01sw00.OnDamage(_ARG_0_, _ARG_1_)
  if _ARG_0_:GetState() == "Ground_diver" then
    return 1
  end
  if _ARG_0_:GetState() ~= "Damage" and _ARG_0_:GetState() ~= "Ground_diver" then
    _ARG_0_.oldState = _ARG_0_:GetState()
  else
    return 1
  end
  _ARG_0_.SavingsDamage = _ARG_0_.SavingsDamage + Entity.GetDamagePoint(_ARG_0_.myHandle)
  _ARG_0_.CounterDamage = _ARG_0_.CounterDamage + Entity.GetDamagePoint(_ARG_0_.myHandle)
  print("Damage = " .. Entity.GetDamagePoint(_ARG_0_.myHandle) .. [[

Now CounterDamage = ]] .. _ARG_0_.CounterDamage .. "\n")
  if _ARG_0_.CounterDamage > _UPVALUE0_ then
    _ARG_0_.stack:push("Idling")
    _ARG_0_.stack:push("Counter")
    _ARG_0_:GotoState(_ARG_0_.stack:pop(1))
  end
  if _ARG_0_.SavingsDamage > _UPVALUE1_ then
    _ARG_0_:GotoState("Damage")
    Entity.GetDamageCrossPos(_ARG_0_.workVec, _ARG_0_.myHandle)
    Enemy.MakePrize(_ARG_0_.myHandle, _ARG_0_.workVec)
  end
  return 1
end
function b01sw00.OnReturnDamage(_ARG_0_)
  _ARG_0_:GotoState("Idling")
end
function b01sw00.OnHitAttack(_ARG_0_)
end
function b01sw00.OnDead(_ARG_0_)
  _ARG_0_:GotoState("Dead")
  SetupBossDead(_ARG_0_.myHandle)
  if Enemy.IsAttackerFront(_ARG_0_.myHandle) then
  else
  end
  return 1
end
function b01sw00.Debug(_ARG_0_)
  if Script.IsDebugCheckAttack() then
    for _FORV_5_, _FORV_6_ in pairs(_UPVALUE0_) do
      if _FORV_6_ == _ARG_0_:GetState() then
        return
      end
    end
    if _UPVALUE0_[Script.GetDebugAttackNumber() + 1] ~= nil then
      _ARG_0_.stack:clear()
      _ARG_0_.stack:push("Idling")
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      _ARG_0_:GotoState(_UPVALUE0_[Script.GetDebugAttackNumber() + 1])
    end
  end
end
function b01sw00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  _ARG_0_:Debug()
  _ARG_0_.CounterDamage = _ARG_0_.CounterDamage - _UPVALUE0_ * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.CounterDamage < 0 then
    _ARG_0_.CounterDamage = 0
  end
  if _ARG_0_:CheckHP(0.5) == 1 and _ARG_0_.FeelingsFlag == 0 then
    _ARG_0_.FeelingsFlag = 1
  end
end
EntityFactory:Add("b01sw00", function(_ARG_0_)
  return (b01sw00:new())
end)
b02sw00 = {}
b02sw00_base_mt = {__index = __StateMachine}
setmetatable(b02sw00, b02sw00_base_mt)
b02sw00_mt = {__index = b02sw00}
function b02sw00.new(_ARG_0_)
  print("b02sw00:new()\n")
  return setmetatable(__StateMachine:new(), b02sw00_mt)
end
b02sw00.states = {
  update = {
    OnBeginState = function(_ARG_0_)
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  dorop = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.step = 0
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
      if _ARG_0_.step == 0 then
        _ARG_0_.step = 1
        Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      elseif Entity.IsGround(_ARG_0_.myHandle) then
        _ARG_0_:CreatePoison()
        Entity.Out(_ARG_0_.myHandle)
      end
    end
  }
}
function b02sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.owner = 0
  _ARG_0_.index = 0
  _ARG_0_.shakes = 0
  _ARG_0_.exec = false
  _ARG_0_.c = 0.15
  _ARG_0_.theta = 0
  _ARG_0_.smallDamageCount = 0
  Entity.EnableLockon(_ARG_0_.myHandle, 0)
  Entity.EnableShooton(_ARG_0_.myHandle, 0)
  Entity.EnableBgColl(_ARG_0_.myHandle, 0)
  _ARG_0_.pos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_:GotoState("update")
end
function b02sw00.CreatePoison(_ARG_0_)
  Entity.GetWorldPos(_UPVALUE0_, _ARG_0_.myHandle)
  _ARG_0_.rot:set(0, 0, 0)
  EntityManager:GetEntity(_ARG_0_.owner).appleData[_ARG_0_.index].poisonBulletHandle = Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner)
  EntityManager:GetEntity(_ARG_0_.owner).appleData[_ARG_0_.index].poisonHandle = Bullet.CreateEffectBullet(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), "b01sw00", "B018_JDR_NUM0_0")
  Bullet.SetCollision(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 0.5, _ARG_0_.owner)
  SetBulletAttackParam(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), _ARG_0_.owner, 5)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), "b01sw00", "B018_JDR_HIT1_0")
  if _ARG_0_.index == 0 or _ARG_0_.index == 4 or _ARG_0_.index == 8 then
    Entity.SetTimer(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), _UPVALUE1_ + Script.Random() * 20)
  elseif _ARG_0_.index == 1 or _ARG_0_.index == 5 or _ARG_0_.index == 9 then
    Entity.SetTimer(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), _UPVALUE2_ + Script.Random() * 20)
  elseif _ARG_0_.index == 2 or _ARG_0_.index == 6 or _ARG_0_.index == 10 or _ARG_0_.index == 3 or _ARG_0_.index == 7 or _ARG_0_.index == 11 then
    Entity.SetTimer(Bullet.CreateBullet("poison", _UPVALUE0_, _ARG_0_.rot, _ARG_0_.owner), _UPVALUE3_ + Script.Random() * 20)
  end
end
function b02sw00.OnUpdatePositionAfter(_ARG_0_)
  if _ARG_0_.exec then
    _ARG_0_.theta = RoundPI(_ARG_0_.theta + Entity.GetFrameRate(_ARG_0_.myHandle) * DegToRad(32))
    _ARG_0_.c = _ARG_0_.c - Entity.GetFrameRate(_ARG_0_.myHandle) * 0.01
    if _ARG_0_.c < 0 then
      _ARG_0_.exec = false
      _UPVALUE0_:set(0, 0, 0)
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
      return
    end
    Entity.GetRot(_ARG_0_.workVec, _ARG_0_.myHandle)
    _ARG_0_.workVec:set(Math.Cos(_ARG_0_.theta) * _ARG_0_.c, 0, Math.Sin(_ARG_0_.theta) * _ARG_0_.c)
    Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec)
  end
end
function b02sw00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
end
EntityFactory:Add("b02sw00", function(_ARG_0_)
  return (b02sw00:new())
end)
poison = {}
poison_base_mt = {__index = __StateMachine}
setmetatable(poison, poison_base_mt)
poison_mt = {__index = poison}
function poison.new(_ARG_0_)
  print("poison:new()\n")
  return setmetatable(__StateMachine:new(), poison_mt)
end
function poison.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
end
function poison.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
      _ARG_0_.step = 1
    end
  elseif _ARG_0_.step == 1 then
  elseif _ARG_0_.step == 2 then
  elseif _ARG_0_.step == 3 then
  end
end
function poison.OnHitAttack(_ARG_0_)
  Effect.LoopEnd(Bullet.GetEffectHandle(_ARG_0_.myHandle))
  return 1
end
EntityFactory:Add("poison", function(_ARG_0_)
  return (poison:new())
end)
b03sw00 = {}
b03sw00_base_mt = {__index = __StateMachine}
setmetatable(b03sw00, b03sw00_base_mt)
b03sw00_mt = {__index = b03sw00}
function b03sw00.new(_ARG_0_)
  print("b03sw00:new()\n")
  return setmetatable(__StateMachine:new(), b03sw00_mt)
end
function b03sw00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
end
function b03sw00.OnUpdate(_ARG_0_)
end
function b03sw00.OnHitBg(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle, 0)
  _ARG_0_.workVec:sety(_ARG_0_.workVec:gety() - Entity.GetFloorDistance(_ARG_0_.myHandle))
  _ARG_0_.workVec1:setx(DegToRad(-90))
  Bullet.CreateEffectBullet(Bullet.CreateBullet("b03sw00b", _ARG_0_.workVec, _ARG_0_.workVec1, (Entity.GetParent(_ARG_0_.myHandle))), "b01sw00", "B018_SPB_HIT1_0")
  Bullet.SetCollision(Bullet.CreateBullet("b03sw00b", _ARG_0_.workVec, _ARG_0_.workVec1, (Entity.GetParent(_ARG_0_.myHandle))), COLL_KIND_ENEMY, COLL_SHAPE_SPHERE, 1.5, 0, (Entity.GetParent(_ARG_0_.myHandle)))
  SetBulletAttackParam(Bullet.CreateBullet("b03sw00b", _ARG_0_.workVec, _ARG_0_.workVec1, (Entity.GetParent(_ARG_0_.myHandle))), Entity.GetParent(_ARG_0_.myHandle), 7)
  Bullet.SetHitAttackEffectName(Bullet.CreateBullet("b03sw00b", _ARG_0_.workVec, _ARG_0_.workVec1, (Entity.GetParent(_ARG_0_.myHandle))), "b01sw00", "B018_SPB_HIT1_0")
  Bullet.SetMaxMoveDist(Bullet.CreateBullet("b03sw00b", _ARG_0_.workVec, _ARG_0_.workVec1, (Entity.GetParent(_ARG_0_.myHandle))), 1000000)
  Entity.CalcVelocity(Bullet.CreateBullet("b03sw00b", _ARG_0_.workVec, _ARG_0_.workVec1, (Entity.GetParent(_ARG_0_.myHandle))), 0)
  Entity.Out(_ARG_0_.myHandle)
end
EntityFactory:Add("b03sw00", function(_ARG_0_)
  return (b03sw00:new())
end)
b03sw00b = {}
b03sw00b_base_mt = {__index = __StateMachine}
setmetatable(b03sw00b, b03sw00b_base_mt)
b03sw00b_mt = {__index = b03sw00b}
function b03sw00b.new(_ARG_0_)
  print("b03sw00b:new()\n")
  return setmetatable(__StateMachine:new(), b03sw00b_mt)
end
function b03sw00b.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  Entity.SetTimer(_ARG_0_.myHandle, 30)
end
function b03sw00b.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 and Entity.IsTimeOver(_ARG_0_.myHandle) then
    _ARG_0_.step = 1
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
  end
end
EntityFactory:Add("b03sw00b", function(_ARG_0_)
  return (b03sw00b:new())
end)
meteor = {}
meteor_base_mt = {__index = __StateMachine}
setmetatable(meteor, meteor_base_mt)
meteor_mt = {__index = meteor}
function meteor.new(_ARG_0_)
  print("meteor:new()\n")
  return setmetatable(__StateMachine:new(), meteor_mt)
end
function meteor.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.speed = 1
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.shadowpos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.centerPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1:set(DegToRad(90))
  _ARG_0_.myshadowHandle = Entity.SetEffect(_ARG_0_.myHandle, "b01sw00", "B018_MET_SDW0_0", _ARG_0_.shadowpos, _ARG_0_.workVec1)
end
function meteor.OnDestroy(_ARG_0_)
  Effect.KillEffect(_ARG_0_.myshadowHandle)
end
function meteor.OnUpdate(_ARG_0_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle, 0)
  Entity.GetRot(_ARG_0_.workVec1, _ARG_0_.myHandle)
  _ARG_0_.workVec:set(_ARG_0_.workVec:getx(), 0.01, _ARG_0_.workVec:getz())
  _ARG_0_.workVec1:set(0)
  Effect.UpdateCoord(_ARG_0_.myshadowHandle, _ARG_0_.workVec, _ARG_0_.workVec1)
  if _ARG_0_.step == 0 then
    _ARG_0_.speed = _ARG_0_.speed - 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
    if 0 > _ARG_0_.speed then
      _ARG_0_.speed = 0
      _ARG_0_.step = 1
      Entity.GetVelocity(_ARG_0_.workVec, _ARG_0_.targetHandle)
      Entity.GetWorldPos(_ARG_0_.centerPos, _ARG_0_.targetHandle)
      _ARG_0_.workVec:scale(Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 2)
      FVECTOR3.Add(_ARG_0_.centerPos, _ARG_0_.centerPos, _ARG_0_.workVec)
      _ARG_0_.centerPos:sety(0.5)
      Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.centerPos, 180)
    end
  else
    Entity.GetVelocity(_ARG_0_.workVec, _ARG_0_.targetHandle)
    Entity.GetWorldPos(_ARG_0_.centerPos, _ARG_0_.targetHandle)
    _ARG_0_.workVec:scale(Entity.CalcDistance(_ARG_0_.myHandle, _ARG_0_.targetHandle) / 2)
    FVECTOR3.Add(_ARG_0_.centerPos, _ARG_0_.centerPos, _ARG_0_.workVec)
    _ARG_0_.centerPos:sety(0.5)
    Entity.TurnTargetDegree(_ARG_0_.myHandle, _ARG_0_.centerPos, 0.8)
    _ARG_0_.speed = _ARG_0_.speed + 0.01 * Entity.GetFrameRate(_ARG_0_.myHandle)
    if _ARG_0_.speed > 0.6 then
      _ARG_0_.speed = 0.6
    end
    Entity.CalcVelocity(_ARG_0_.myHandle, _ARG_0_.speed)
  end
end
EntityFactory:Add("meteor", function(_ARG_0_)
  return (meteor:new())
end)
spier = {}
spier_base_mt = {__index = __StateMachine}
setmetatable(spier, spier_base_mt)
spier_mt = {__index = spier}
function spier.new(_ARG_0_)
  print("spier:new()\n")
  return setmetatable(__StateMachine:new(), spier_mt)
end
function spier.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.effHandle = _ARG_1_
  _ARG_0_.step = 0
  Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
end
function spier.OnHitAttack(_ARG_0_)
  return 1
end
function spier.OnUpdate(_ARG_0_)
  if Effect.GetNowFrame(_ARG_0_.effHandle) > _UPVALUE0_ then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 1)
  end
end
EntityFactory:Add("spier", function(_ARG_0_)
  return (spier:new())
end)
waveb = {}
waveb_mt = {__index = waveb}
function waveb.new(_ARG_0_)
  return setmetatable({}, waveb_mt)
end
function waveb.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.masterHandle = NULL_HANDLE
  _ARG_0_.step = 0
  Bullet.SetHitAttackEffectName(_ARG_1_, "b01sw00", "B018_JDR_HIT0_0")
  Bullet.EnableNoCheckHitBg(_ARG_1_, 0)
  Bullet.SetCollision(_ARG_1_, COLL_KIND_ENEMY, COLL_SHAPE_CYLINDER, 1, 1)
  Bullet.SetAddCollRadius(_ARG_1_, 0.3)
  _ARG_0_.Time = 0
end
function waveb.OnReflect(_ARG_0_)
end
function waveb.OnUpdate(_ARG_0_)
  _ARG_0_.Time = _ARG_0_.Time + 1 * Entity.GetFrameRate(_ARG_0_.myHandle)
  if _ARG_0_.step == 0 then
    if _ARG_0_.Time >= 20 then
      Bullet.SetAddCollRadius(_ARG_0_.myHandle, 0)
      _ARG_0_.step = _ARG_0_.step + 1
    end
  elseif _ARG_0_.step == 1 and _ARG_0_.Time >= 45 then
    Bullet.EnableAttackCollision(_ARG_0_.myHandle, 0)
    _ARG_0_.step = _ARG_0_.step + 1
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Bullet.DeleteBullet(_ARG_0_.myHandle)
    end
  end
end
EntityFactory:Add("waveb", function(_ARG_0_)
  return (waveb:new())
end)
