OPENDAMGE_ON_FLAG_B = 0
g23sb00 = {}
g23sb00_mt = {__index = g23sb00}
function g23sb00.new(_ARG_0_)
  return setmetatable({}, g23sb00_mt)
end
function g23sb00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g23sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.OpenPoint = 0
  _ARG_0_.Openflag = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  Entity.SetLockOnBoneNum(_ARG_1_, 4)
  Entity.EnableBgColl(_ARG_1_, 0)
  Entity.EnableLockon(_ARG_1_, 1)
  Entity.SetReplyDistSq(_ARG_1_, 12.25)
  Entity.SetMotion(_ARG_1_, 1)
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_1_, "OpenPoint")
    _UPVALUE0_ = 1
  end
  print("param = " .. Entity.GetLayoutParam(_ARG_0_.myHandle, 1) .. "\n")
  if Entity.GetLayoutParam(_ARG_0_.myHandle, 1) ~= 0 then
    Entity.SetMotion(_ARG_0_.myHandle, 4)
    _ARG_0_.Openflag = 1
    _ARG_0_.step = 2
  end
end
function g23sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if OPENDAMGE_ON_FLAG_B == 0 then
    return 1
  end
  if _ARG_0_.step == 0 then
    _ARG_0_.OpenPoint = _ARG_0_.OpenPoint + 1
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 3)
    _ARG_0_.step = 1
  end
  return 1
end
function g23sb00.OnUpdate(_ARG_0_)
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_.step = 0
      if _ARG_0_.Openflag == 0 then
        if _ARG_0_.OpenPoint >= _UPVALUE0_ then
          Entity.SetMotion(_ARG_0_.myHandle, 4)
          if Mission.IsMissionNow() == true then
            Mission.SendMissonMessage(MES_OPENED_GRID)
            _ARG_0_.Openflag = 1
            _ARG_0_.step = 2
          end
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 0
        end
      end
    end
  elseif _ARG_0_.step == 2 then
  end
end
EntityFactory:Add("g23sb00", function(_ARG_0_)
  EntityManager:Add(g23sb00:new(), _ARG_0_)
  return (g23sb00:new())
end)
