OPENDAMGE_ON_FLAG_A = 0
g12sb00 = {}
g12sb00_mt = {__index = g12sb00}
function g12sb00.new(_ARG_0_)
  return setmetatable({}, g12sb00_mt)
end
function g12sb00.GetCameraTargetPos(_ARG_0_)
  _ARG_0_.lockOnPos:set(0, 0, 0)
  Entity.ApplyBoneMatrix(_ARG_0_.myHandle, "X_marker", _ARG_0_.lockOnPos)
  return _ARG_0_.lockOnPos
end
function g12sb00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.camera = NULL_HANDLE
  _ARG_0_.step = 0
  _ARG_0_.OpenPoint = 0
  _ARG_0_.Openflag = 0
  _ARG_0_.lockOnPos = FVECTOR3.new(0, 0, 0)
  _ARG_0_.WorkVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.rot = FVECTOR3.new(0, 0, 0)
  _ARG_0_.GridHandle = Entity.CreateEntity("g13sb00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
  Entity.AttachRideCollision(_ARG_0_.GridHandle, 0, 2)
  Entity.EnableBgColl(_ARG_0_.GridHandle, 0)
  Entity.EnableLockon(_ARG_0_.GridHandle, 0)
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
    _ARG_0_.step = 99
    _ARG_0_.GridHandle2 = Entity.CreateEntity("g24sb00", _ARG_0_.WorkVec, _ARG_0_.rot, _ARG_0_.myHandle)
    Entity.AttachRideCollision(_ARG_0_.GridHandle2, 0, 2)
    Entity.EnableBgColl(_ARG_0_.GridHandle2, 0)
    Entity.EnableLockon(_ARG_0_.GridHandle2, 0)
    Entity.EnableLockon(_ARG_0_.GridHandle2, 0)
    Entity.SetMotionWithSameCheck(_ARG_0_.GridHandle2, 2)
    Entity.SetMotionWithSameCheck(_ARG_0_.GridHandle, 2)
  end
end
function g12sb00.OnDamage(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if OPENDAMGE_ON_FLAG_A == 0 then
    return 1
  end
  if _ARG_0_.step == 0 then
    _ARG_0_.OpenPoint = _ARG_0_.OpenPoint + 1
    Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 3)
    _ARG_0_.step = 1
  end
  return 1
end
function g12sb00.OnUpdate(_ARG_0_)
  if Player.IsBattleFlagPlayerDead() == true then
    if _ARG_0_.camera ~= NULL_HANDLE then
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.step = 0
      Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
    end
    return
  end
  _ARG_0_.WorkVec:set(0, 1, 0)
  if Entity.IsTargetWithinFOV(_ARG_0_.myHandle, Player.GetHandle(), DegToRad(190), 4, _ARG_0_.WorkVec) == true then
    Entity.EnableLockon(_ARG_0_.myHandle, 1)
  else
    Entity.EnableLockon(_ARG_0_.myHandle, 0)
  end
  if _ARG_0_.step == 0 then
  elseif _ARG_0_.step == 1 then
    if Entity.IsMotionEnd(_ARG_0_.myHandle) then
      _ARG_0_.step = 0
      if _ARG_0_.Openflag == 0 then
        if _ARG_0_.OpenPoint >= _UPVALUE0_ then
          if Mission.IsMissionNow() == true then
            Mission.SendMissonMessage(MES_OPENED_GRID)
            _ARG_0_.Openflag = 1
            _ARG_0_.step = 3
            _ARG_0_.camera = Camera.CreateExusiaCamera("camera1")
            Camera.StartExusiaCamera(_ARG_0_.camera)
            Script.SetObjStop(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
            Script.SetSceneColor(1, 1, 1, 1, 0, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
            Entity.SetTimer(_ARG_0_.myHandle, 15)
          end
        else
          Entity.SetMotionWithSameCheck(_ARG_0_.myHandle, 1)
          _ARG_0_.step = 0
        end
      end
    end
  elseif _ARG_0_.step == 2 then
    if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
      print("\131C\131x\131\147\131g\131J\131\129\131\137\143I\151\185\n")
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.step = 3
      Entity.SetMotion(_ARG_0_.myHandle, 4)
    end
  elseif _ARG_0_.step == 3 then
    if Entity.IsTimeOver(_ARG_0_.myHandle) then
      Entity.SetMotionWithSameCheck(_ARG_0_.GridHandle, 3)
      _ARG_0_.step = 4
    end
  elseif _ARG_0_.step == 4 then
    if Camera.IsEndExusiaCamera(_ARG_0_.camera) then
      Script.OutTask(_ARG_0_.camera)
      _ARG_0_.camera = NULL_HANDLE
      _ARG_0_.step = 5
      Script.SetObjStart(OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      Script.SetSceneColor(1, 1, 1, 1, 1, 3, OBJ_BIT_PLAYER, OBJ_BIT_ENEMY, OBJ_BIT_BULLET)
      Entity.SetMotion(_ARG_0_.myHandle, 4)
    end
  elseif _ARG_0_.step == 5 then
  end
end
EntityFactory:Add("g12sb00", function(_ARG_0_)
  EntityManager:Add(g12sb00:new(), _ARG_0_)
  return (g12sb00:new())
end)
