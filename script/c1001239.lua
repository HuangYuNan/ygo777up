--川内级轻巡洋舰3号舰—那珂
if not senya then local io=require('io') local chk=io.open("expansions/script/c1001252","r") if chk then chk:close() require "expansions/script/c1001252" else require "script/c1001252" end end
function c1001239.initial_effect(c)
	colle.sum(c,2)
	colle.atkup(c,100)
	colle.thc(c)
	colle.defwd1(c)
end
