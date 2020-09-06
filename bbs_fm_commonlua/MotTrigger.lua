MotionTrigger = {current = 1, old_no = 0}
MotionTrigger.__index = MotionTrigger
function MotionTrigger.new(_ARG_0_)
  return setmetatable({}, MotionTrigger)
end
function MotionTrigger.Update(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  if _ARG_0_.old_no ~= _ARG_2_ then
    _ARG_0_.current = 1
    _ARG_0_.old_no = _ARG_2_
  end
  if _ARG_0_[_ARG_2_] ~= nil and _ARG_0_[_ARG_2_][_ARG_0_.current] ~= nil and _ARG_3_ >= _ARG_0_[_ARG_2_][_ARG_0_.current].frame then
    _ARG_0_[_ARG_2_][_ARG_0_.current].func(_ARG_1_)
    _ARG_0_.current = _ARG_0_.current + 1
  end
end
