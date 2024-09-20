local framework = "ox";

funtion gm_bridge_itemLabel(itemname)
    if(framework == "ox")then
        return exports.ox_inventory:Items()[item].label
    end
end