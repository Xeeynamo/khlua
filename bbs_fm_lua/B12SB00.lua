b12sb00 = {}
b12sb00_base_mt = {__index = __StateMachine}
setmetatable(b12sb00, b12sb00_base_mt)
b12sb00_mt = {__index = b12sb00}
function b12sb00.new(_ARG_0_)
  return setmetatable(__StateMachine:new(), b12sb00_mt)
end
b12sb00.states = {
  Wait = {
    OnBeginState = function(_ARG_0_)
      print("Wait ... OnBeginState\n")
    end,
    OnEndState = function(_ARG_0_)
    end,
    OnUpdate = function(_ARG_0_)
    end
  },
  CutOff = {
    OnBeginState = function(_ARG_0_)
      _ARG_0_.targetHandle = Enemy.SearchAttackEntity(_ARG_0_.myHandle, SEARCH_TYPE_NEAR)
      Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.myHandle)
      Entity.SetOldLocalPos(_ARG_0_.myHandle, _ARG_0_.workVec0)
      Entity.SetLocalPos(_ARG_0_.myHandle, _ARG_0_.workVec1)
      Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.myHandle, "Root")
      Entity.GetWorldPos(_ARG_0_.targetPos, _ARG_0_.targetHandle, 2)
      FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.targetPos, _ARG_0_.workVec1)
      _ARG_0_.workVec1:normalize()
      _ARG_0_.workVec1:scale(_UPVALUE0_)
      Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec1)
      Entity.EnableBgColl(_ARG_0_.myHandle, 1)
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
      Entity.EnableLockon(_ARG_0_.myHandle, 1)
      Entity.SetMotion(_ARG_0_.myHandle, _UPVALUE1_)
      Entity.EnableHeavy(_ARG_0_.myHandle, 0)
      _ARG_0_.step = 0
      _ARG_0_.count = 0
    end,
    OnEndState = function(_ARG_0_)
      Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
      _ARG_0_.workVec0:setx(0)
      Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec0)
      Entity.ClearSpeed(_ARG_0_.myHandle)
      Entity.EnableGravity(_ARG_0_.myHandle, 0)
      Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 0)
      Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 30)
      print("CutOff ... OnEndState\n")
    end,
    OnUpdate = function(_ARG_0_)
      if Entity.HasNetGameHandle(_ARG_0_.myHandle) and Enemy.IsNetworkMaster(_ARG_0_.myHandle) == false then
        return
      end
      if _ARG_0_.step == 0 then
        if Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.EnableGravity(_ARG_0_.myHandle, 1)
          Entity.EnableAttackBodyColl(_ARG_0_.myHandle, 1)
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 29)
          Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
          if _ARG_0_.workVec0:length() <= 0.2 then
            Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
            _ARG_0_.workVec1:set(0, 0, -30)
            FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
            _ARG_0_.workVec1:normalize()
            _ARG_0_.step = 1
          elseif Entity.IsWall(_ARG_0_.myHandle) then
            if Script.Random() > 0.5 then
              Entity.CalcReflectionVector(_ARG_0_.workVec1, _ARG_0_.myHandle)
            else
              Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
              Entity.GetWorldPos(_ARG_0_.workVec1, _ARG_0_.targetHandle)
              FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
              _ARG_0_.workVec1:normalize()
            end
          else
            Entity.CalcReflectionVector(_ARG_0_.workVec1, _ARG_0_.myHandle)
          end
          _ARG_0_.workVec1:scale(_ARG_0_.workVec0:length() * Math.Pow(0.93, Entity.GetFrameRate(_ARG_0_.myHandle)))
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec1)
        end
      elseif _ARG_0_.step == 1 then
        if Entity.IsGround(_ARG_0_.myHandle) then
          _ARG_0_.step = 2
        elseif Entity.IsWall(_ARG_0_.myHandle) then
          Entity.GetWorldPos(_ARG_0_.workVec0, _ARG_0_.myHandle)
          _ARG_0_.workVec1:set(0, 0, -30)
          FVECTOR3.Sub(_ARG_0_.workVec1, _ARG_0_.workVec1, _ARG_0_.workVec0)
          _ARG_0_.workVec1:normalize()
          Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
          _ARG_0_.workVec1:scale(_ARG_0_.workVec0:length())
          Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec1)
        end
      elseif _ARG_0_.step == 2 then
        Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
        if Entity.IsGround(_ARG_0_.myHandle) or Entity.IsWall(_ARG_0_.myHandle) then
          Entity.CalcReflectionVector(_ARG_0_.workVec0, _ARG_0_.myHandle)
        end
        _ARG_0_.workVec0:scale(_ARG_0_.workVec0:length() * Math.Pow(0.3, Entity.GetFrameRate(_ARG_0_.myHandle)))
        Entity.SetVelocity(_ARG_0_.myHandle, _ARG_0_.workVec0)
        if _ARG_0_.workVec0:length() <= 0.05 and Entity.IsGround(_ARG_0_.myHandle) then
          Entity.GetRot(_ARG_0_.workVec0, _ARG_0_.myHandle)
          _ARG_0_.workVec0:setx(0)
          Entity.SetRot(_ARG_0_.myHandle, _ARG_0_.workVec0)
          Entity.SetMotion(_ARG_0_.myHandle, 30)
          Entity.EnableGravity(_ARG_0_.myHandle, 0)
          Entity.ClearSpeed(_ARG_0_.myHandle)
          _ARG_0_.step = 3
        end
      elseif _ARG_0_.step == 3 and Entity.IsMotionEnd(_ARG_0_.myHandle) then
        _ARG_0_:GotoState("Wait")
      end
    end
  }
}
function b12sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.targetHandle = NULL_HANDLE
  _ARG_0_.workVec0 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec2 = FVECTOR3.new(0, 0, 0)
  _ARG_0_.cameraTargetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.targetPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.angle = 0
  _ARG_0_.step = 0
  _ARG_0_.count = 0
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.EnableCheckUnderFoot(_ARG_1_, 0)
  Entity.SetMovementCollRadius(_ARG_1_, 1.5)
  Entity.SetMovementCollKind(_ARG_1_, COLL_KIND_PRIZE)
  Entity.SetLowerHalf(_ARG_1_, 1.5)
  Entity.SetDropShadowDistance(_ARG_1_, 10)
  Enemy.SetNoNetworkRecvRot(_ARG_1_, 1)
  _ARG_0_:GotoState("Wait")
end
function b12sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_)
  return 1
end
function b12sb00.OnUpdate(_ARG_0_)
  _ARG_0_:Update()
  Entity.SetAlpha(_ARG_0_.myHandle, (Entity.GetAlpha(Entity.GetParent(_ARG_0_.myHandle))))
end
function b12sb00.OnUpdatePositionAfter(_ARG_0_)
  Entity.GetVelocity(_ARG_0_.workVec0, _ARG_0_.myHandle)
  if _ARG_0_.workVec0:getx() == 0 and _ARG_0_.workVec0:gety() == 0 and _ARG_0_.workVec0:getz() == 0 then
    return
  end
  _ARG_0_.angle = RoundPI(_ARG_0_.angle - _ARG_0_.workVec0:length() / 1.5 * Entity.GetFrameRate(_ARG_0_.myHandle))
  _ARG_0_.workVec1:set(-Math.Atan2(_ARG_0_.workVec0:gety(), Math.Sqrt(_ARG_0_.workVec0:getx() * _ARG_0_.workVec0:getx() + _ARG_0_.workVec0:getz() * _ARG_0_.workVec0:getz())), Math.Atan2(_ARG_0_.workVec0:getx(), _ARG_0_.workVec0:getz()), 0)
  _ARG_0_.workVec2:set(0, 1, 0)
  Math.RotateVectorXYZ(_ARG_0_.workVec2, _ARG_0_.workVec1)
  FVECTOR3.Cross(_ARG_0_.workVec0, _ARG_0_.workVec0, _ARG_0_.workVec2)
  Entity.RotateBoneAxis(_ARG_0_.myHandle, 1, _ARG_0_.workVec0, _ARG_0_.angle)
end
function b12sb00.GetCameraTargetPos(_ARG_0_)
  if Entity.IsAttachCoord(_ARG_0_.myHandle) and EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)) ~= nil then
    return EntityManager:GetEntity(Entity.GetParent(_ARG_0_.myHandle)).cameraTargetPos
  end
  Entity.GetWorldPos(_ARG_0_.cameraTargetPos, _ARG_0_.myHandle, 1)
  return _ARG_0_.cameraTargetPos
end
EntityFactory:Add("b12sb00", function(_ARG_0_)
  return (b12sb00:new())
end)
EntityFactory:Add("b52vs00", function(_ARG_0_)
  return (b12sb00:new())
end)
