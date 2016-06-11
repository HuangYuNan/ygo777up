--Z1级驱逐舰3号舰—舒尔沃
if not colle then local io=require('io') local chk=io.open("expansions/script/c1001252","r") if chk then chk:close() require "expansions/script/c1001252" else require "script/c1001252" end end
function c1001231.initial_effect(c)
	colle.sum(c,2)
	colle.atkup(c,110)
	colle.cnb(c)
	colle.th(c)
	colle.defwd(c)
end
