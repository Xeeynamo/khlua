EntityFactory = {}
function EntityFactory.Add(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_[_ARG_1_] == nil then
    _ARG_0_[_ARG_1_] = {Create = _ARG_2_}
    print(" " .. _ARG_1_ .. " \130\204\144\182\144\172\138\214\144\148\147o\152^\129B\n")
  end
end
function EntityFactory.Create(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_[_ARG_1_] == nil then
    print(" " .. _ARG_1_ .. " \130\170\140\169\130\194\130\169\130\232\130\220\130\185\130\241\129B\n")
    return false
  end
  if _ARG_0_[_ARG_1_].Create(_ARG_2_) ~= nil then
    if _ARG_0_[_ARG_1_].Create(_ARG_2_).OnInit ~= nil then
      EntityManager:Add(_ARG_0_[_ARG_1_].Create(_ARG_2_), _ARG_2_)
      _ARG_0_[_ARG_1_].Create(_ARG_2_):OnInit(_ARG_2_)
      return true
    else
      print(" OnInit\130\170\140\169\130\194\130\169\130\232\130\220\130\185\130\241\129B\n")
    end
  else
    print(" \144\182\144\172\138\214\144\148\130\170\140\169\130\194\130\169\130\232\130\220\130\185\130\241\129B\n")
  end
  return false
end
