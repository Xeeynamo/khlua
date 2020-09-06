g13_14cd_mt = {
  __index = {
    new = function(_ARG_0_)
      return setmetatable({}, g13_14cd_mt)
    end,
    OnInit = function(_ARG_0_, _ARG_1_)
      _ARG_0_.myHandle = _ARG_1_
      Entity.SetMotion(_ARG_1_, 1)
      Entity.AttachRideCollision(_ARG_1_, 0, 2)
      Entity.EnableRideColl(_ARG_1_, 0, 0)
      Entity.EnableLockon(_ARG_1_, 1)
      Entity.InitCollision(_ARG_1_, "g13_14cd")
    end,
    OnUpdate = function(_ARG_0_)
    end,
    OnDamage = function(_ARG_0_, _ARG_1_, _ARG_2_)
      if _ARG_1_ == ATK_KIND_DMG_BIG or _ARG_1_ == ATK_KIND_DMG_BLOW then
        Entity.EnableDamageColl(_ARG_0_.myHandle, 0)
        Entity.EnableBodyColl(_ARG_0_.myHandle, 0)
        Entity.EnableRideColl(_ARG_0_.myHandle, 1, 0)
        Entity.EnableLockon(_ARG_0_.myHandle, 0)
        Entity.AttachCoord(NULL_HANDLE, "", _ARG_0_.myHandle, "Root")
        Entity.SetMotion(_ARG_0_.myHandle, 2)
        print("\131`\129[\131Y = " .. Entity.GetName(_ARG_0_.myHandle) .. "\n")
      end
      Entity.SetMotion(Entity.GetParent(_ARG_0_.myHandle), 2)
      return 1
    end
  }
}
EntityFactory:Add("g13cd00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
EntityFactory:Add("g14cd00", function(_ARG_0_)
  return (_UPVALUE0_:new())
end)
