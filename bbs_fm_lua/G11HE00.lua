g11he00 = {}
g11he00_mt = {__index = g11he00}
function g11he00.new(_ARG_0_)
  return setmetatable({}, g11he00_mt)
end
function g11he00.OnInit(_ARG_0_, _ARG_1_)
  _ARG_0_.myHandle = _ARG_1_
  _ARG_0_.step = 0
  _ARG_0_.hp = 5
  if _UPVALUE0_ == 0 then
    _UPVALUE1_ = Gimmick.GetExtraParam(_ARG_0_.myHandle, "Scale")
    _UPVALUE0_ = 1
  end
  _ARG_0_.attaker = NULL_HANDLE
  _ARG_0_.workVec = FVECTOR3.new(0, 0, 0)
  _ARG_0_.workVec1 = FVECTOR3.new(0, 0, 0)
  Gimmick.SetGimmickKind(_ARG_0_.myHandle, GIMMICK_KIND_BIG_JAR)
  Entity.SetMovementCollRadius(_ARG_0_.myHandle, 0.64)
  Entity.SetLowerHalf(_ARG_0_.myHandle, 0.65)
  Entity.EnableGravity(_ARG_0_.myHandle, 1)
  Entity.EnableBgColl(_ARG_0_.myHandle, 1)
  Entity.EnableDamageColl(_ARG_0_.myHandle, 1)
  Entity.EnableLockon(_ARG_0_.myHandle, 1)
  Entity.EnableShooton(_ARG_0_.myHandle, 1)
  Entity.SetMotion(_ARG_0_.myHandle, 0)
end
function g11he00.Destruction(_ARG_0_)
  _ARG_0_:createEffect("g_he_011_00", "G_HE_TUB_10_0")
end
function g11he00.createEffect(_ARG_0_, _ARG_1_, _ARG_2_)
  Entity.GetWorldPos(_ARG_0_.workVec, _ARG_0_.myHandle)
  Entity.GetRot(_ARG_0_.workVec1, _ARG_0_.myHandle)
  Entity.SetEffect(_ARG_0_.myHandle, _ARG_1_, _ARG_2_, _ARG_0_.workVec, _ARG_0_.workVec1)
end
function g11he00.CheckAttaker(_ARG_0_, _ARG_1_)
  print("Call CheckAttaker\n")
  _ARG_0_.step = 1
  if Entity.IsAlive(_ARG_1_) == true then
    if Entity.GetName(_ARG_1_) == "b21he00" then
      print("\131w\131\137\131N\131\140\131X\130\169\130\231\130\204\141U\140\130\130\197\130\183\129B\n")
      return 1
    elseif Entity.GetName(_ARG_1_):sub(1, 1) == "w" or Entity.GetName(_ARG_1_):sub(1, 1) == "p" then
      print("\131v\131\140\131C\131\132\129[\130\169\130\231\130\204\141U\140\130\130\197\130\183\129B\n")
      return 0
    elseif Entity.GetName(_ARG_1_) == "g13heExplode" then
      print("g13heExplode\130\169\130\231\130\204\141U\140\130\130\197\130\183\129B\n")
      if Entity.IsAlive(_ARG_1_) == true then
        if Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker) == true then
          if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
            print("\131v\131\140\131C\131\132\129[\130\170\148j\137\243\130\181\130\189\148\154\146e\130\197\137\243\130\234\130\220\130\181\130\189\129B\n")
            return 0
          else
            print("\131w\131\137\131N\131\140\131X\130\170\148j\137\243\130\181\130\189\148\154\146e\130\197\137\243\130\234\130\220\130\181\130\189\129B\n")
            return 1
          end
        elseif Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker2) == true then
          if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
            print("\131v\131\140\131C\131\132\129[\130\170\148j\137\243\130\181\130\189\148\154\146e\130\197\137\243\130\234\130\220\130\181\130\189\129B\n")
            return 0
          else
            print("\131w\131\137\131N\131\140\131X\130\170\148j\137\243\130\181\130\189\148\154\146e\130\197\137\243\130\234\130\220\130\181\130\189\129B\n")
            return 1
          end
        end
      end
    elseif Entity.GetName(_ARG_1_):sub(1, 1) == "g" then
      print("\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\129\171\n")
      print("\131M\131~\131b\131N\130\169\130\231\130\204\141U\140\130\130\197\130\183\129B\n")
      if Entity.IsAlive(_ARG_1_) == true then
        if Gimmick.IsScript(_ARG_1_) == true then
          if Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker) == true then
            if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
              print("\131v\131\140\131C\131\132\129[\130\204\131|\131C\131\147\131g\130\197\130\183\129B\n")
              return 0
            elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker) == "b21he00" then
              print("\131w\131\137\131N\131\140\131X\130\204\131|\131C\131\147\131g\130\197\130\183\129B\n")
              return 1
            end
            if Gimmick.IsScript(EntityManager:GetEntity(_ARG_1_).attaker) == true then
              print("\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\129\170\n")
              if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
                return 0
              else
                return 1
              end
            else
              print("\130P\145\206\143\219\130\205\144\182\130\171\130\196\130\162\130\233\130\170\129A\131X\131N\131\138\131v\131g\130\204\131C\131\147\131X\131^\131\147\131X\130\170\150\179\130\173\130\200\130\193\130\196\130\162\130\220\130\183\129B\n")
              return 1
            end
          else
            print("\130P\145\206\143\219\130\170\144\182\130\171\130\196\130\162\130\220\130\185\130\241\129B\n")
            return 1
          end
        else
          print("\130Q\145\206\143\219\130\205\144\182\130\171\130\196\130\162\130\233\130\170\129A\131X\131N\131\138\131v\131g\130\204\131C\131\147\131X\131^\131\147\131X\130\170\150\179\130\173\130\200\130\193\130\196\130\162\130\220\130\183\129B\n")
          return 1
        end
      else
        print("\130Q\145\206\143\219\130\170\144\182\130\171\130\196\130\162\130\220\130\185\130\241\129B\n")
        return 1
      end
    elseif Entity.GetName(_ARG_1_) == "b21he00" then
      print("\131w\131\137\131N\131\140\131X\130\169\130\231\130\204\141U\140\130\130\197\130\183\129B\n")
      return 1
    else
      print("\131v\131\140\131C\131\132\129[\130\169\130\231\130\204\141U\140\130\130\197\130\183\129B\n")
      return 0
    end
  else
    return 1
  end
end
function g11he00.GetAttakerHandle(_ARG_0_, _ARG_1_)
  print("g11he00 :GetAttakerHandle\n")
  if Entity.IsAlive(_ARG_1_) == true then
    print("\130\177\130\204\131n\131\147\131h\131\139\130\205\144\182\130\171\130\196\130\220\130\183\129B\n")
  else
    print("\130\177\130\204\131n\131\147\131h\131\139\130\205\142\128\130\241\130\197\130\220\130\183\129B\n")
  end
  print("g10he00 :local AttakerName = " .. Entity.GetName(_ARG_1_) .. "\n")
  if Entity.GetName(_ARG_1_):sub(1, 1) == "w" or Entity.GetName(_ARG_1_):sub(1, 1) == "p" or Entity.GetName(_ARG_1_):sub(1, 1) == "b" then
    return _ARG_1_
  end
  for _FORV_7_ = 0, 100 do
    if Entity.IsAlive(_ARG_1_) == true then
      if Gimmick.IsScript(_ARG_1_) == true or Entity.GetName(_ARG_1_) == "g13heExplode" then
        if Entity.IsAlive(EntityManager:GetEntity(_ARG_1_).attaker) == true then
          if Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "w" or Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "p" then
            return EntityManager:GetEntity(_ARG_1_).attaker
          elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "b" then
            return EntityManager:GetEntity(_ARG_1_).attaker
          elseif Entity.GetName(EntityManager:GetEntity(_ARG_1_).attaker):sub(1, 1) == "g" then
          end
        else
          return _ARG_1_
        end
      else
        print("\130\177\130\204\131M\131~\131b\131N\130\204\131X\131N\131\138\131v\131g\130\205\141\237\143\156\141\207\130\221\129I\129I\129I\n")
        return _ARG_1_
      end
      return _ARG_1_
    end
  end
  return _ARG_1_
end
function g11he00.OnDamage(_ARG_0_)
  if Entity.IsAlive((_ARG_0_:GetAttakerHandle(Entity.GetAttacker(_ARG_0_.myHandle)))) == true then
    _ARG_0_.attaker = _ARG_0_:GetAttakerHandle(Entity.GetAttacker(_ARG_0_.myHandle))
    print("g11he00 call On Damage = " .. Entity.GetName(Entity.GetAttacker(_ARG_0_.myHandle)) .. "\n")
    if Entity.GetName(Entity.GetAttacker(_ARG_0_.myHandle)):sub(1, 1) == "g" then
      if _ARG_0_.step == 0 then
        Gimmick.Delete(_ARG_0_.myHandle)
        Gimmick.AddHp(_ARG_0_.myHandle, -10000)
      end
      return 1
    end
  else
  end
  return 1
end
function g11he00.OnDestroy(_ARG_0_)
  if Mission.IsMissionNow() == true then
    Mission.SendMissonMessagePod(_ARG_0_:CheckAttaker(_ARG_0_.attaker), GIMMICK_KIND_BIG_JAR)
  end
end
function g11he00.OnDead(_ARG_0_)
  if _ARG_0_.step == 0 then
    _ARG_0_:Destruction()
  end
end
function g11he00.OnUpdate(_ARG_0_)
  Entity.EnableCameraBodyColl(_ARG_0_.myHandle, 1)
  Entity.SetUserGroundColor(_ARG_0_.myHandle, 1)
end
EntityFactory:Add("g11he00", function(_ARG_0_)
  return (g11he00:new())
end)
