dctds=dctds or {}
function dctds.defe()
if Card.GetDefense then
Card.GetDefence=Card.GetDefense
Card.GetBaseDefence=Card.GetBaseDefense
Card.GetTextDefence=Card.GetTextDefense
Card.GetPreviousDefenceOnField=Card.GetPreviousDefenseOnField
Card.IsDefencePos=Card.IsDefensePos
Card.IsDefenceBelow=Card.IsDefenseBelow
Card.IsDefenceAbove=Card.IsDefenseAbove
else
Card.GetDefense=Card.GetDefence
Card.GetBaseDefense=Card.GetBaseDefence
Card.GetTextDefense=Card.GetTextDefence
Card.GetPreviousDefenseOnField=Card.GetPreviousDefenceOnField
Card.IsDefensePos=Card.IsDefencePos
Card.IsDefenseBelow=Card.IsDefenceBelow
Card.IsDefenseAbove=Card.IsDefenceAbove
end
--DEFENCE=DEFENSE
POS_FACEUP_DEFENCE  =0x4  --表侧守备
POS_FACEDOWN_DEFENCE	=0x8	--里侧守备
POS_DEFENCE =0xc   --守备表示
ASSUME_DEFENCE  =8
EFFECT_UPDATE_DEFENCE	  =104 --改变防御力
EFFECT_SET_DEFENCE	=105  --设置防御力
EFFECT_SET_DEFENCE_FINAL		=106	--设置最终防御力
EFFECT_SET_BASE_DEFENCE   =107   --设置原本防御力
EFFECT_DEFENCE_ATTACK	  =190 --可以守备表示攻击
HINTMSG_DEFENCE   =517   --请选择守备表示的怪兽
HINTMSG_FACEUPDEFENCE   =523	--请选择表侧守备表示的怪兽
HINTMSG_FACEDOWNDEFENCE =525	--请选择里侧守备表示的怪兽
end