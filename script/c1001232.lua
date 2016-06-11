--西北风级驱逐舰3号舰—西南风
if not senya then local io=require('io') local chk=io.open("expansions/script/c1001252","r") if chk then chk:close() require "expansions/script/c1001252" else require "script/c1001252" end end
function c1001232.initial_effect(c)
	colle.sum(c,3)
	colle.atkup(c,200)
	colle.cnb(c)
	colle.th(c)
	colle.defwd(c)
end